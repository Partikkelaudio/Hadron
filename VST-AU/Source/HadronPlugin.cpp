#include "HadronPlugin.h"
#include "GUI/HadronComponent.h"


#ifdef JUCE_MSVC
#define NOMINMAX
#include "windows.h"
#pragma warning (disable: 4996)
#endif

namespace {

	const String chunk_tag = "PARTIKKELSETTINGS";

#ifdef WIN32

	void loadHadronDll() {

#ifdef _WIN64 
		const char* dllname = "csound64_hadron64.dll";
#else
		const char* dllname = "csound64_hadron32.dll";
#endif

		if (GetModuleHandle(dllname) == NULL) {
			char fullpath[255];
			const char* hadron_path = getenv("HADRONPATH");
			strcpy(fullpath, hadron_path);
			strcat(fullpath, "/Csound_Hadron/bin/");
			strcat(fullpath, dllname);
			LoadLibrary(fullpath);
		}

	}

#endif

}

//==============================================================================

AudioProcessor* JUCE_CALLTYPE createPluginFilter()
{

	// On Windows we need to load the Hadron DLL from a specific location
#ifdef WIN32
	loadHadronDll();
#endif

	AudioProcessor* processor = new HadronPlugin();
	return processor;
}

//==============================================================================

HadronPlugin::HadronPlugin()
: interface_()
, has_loaded_hadron_(false)
, log_file_(nullptr)
, states_()
, sounds_()
, update_flag_()
, current_program_(0)
, hadron_path_(String())
, csound_log_path_(String())
{

	// Set up the Hadron path
#ifdef WIN32
	const char* env_char = getenv("HADRONPATH");
#else	
	const char* env_char = "/Applications/Hadron";
#endif

	hadron_path_ = env_char != NULL ? String(env_char) : String();
	if (hadron_path_.isEmpty()) {
		createCriticalLog("No Hadron directory found. Please reinstall.");
		return;
	}

	File root_directory(hadron_path_);
	if (!root_directory.exists()) {
		String message = String("The Hadron directory \"") + hadron_path_ + ("\" does not exist. Please reinstall.");
		createCriticalLog(message);
		return;
	}

	hadron_path_ = root_directory.getFullPathName();    // Ensure full path
	configureLogging(root_directory);

	// Initialize with 16 default programs
	// TODO: We should consider loading presets from internal preset files (variable number of presets)
	for (int i = 0; i < 16; ++i) {
		programs_.add(new HadronProgram());
	}

	for (int i = 0; i < 4; ++i) {
		sampling_state_[i] = false;
	}

	readDefaultPresetFile(root_directory);

	initializeCsound();

	writeToLog("Hadron is loaded.");
	reloadSelections();
	has_loaded_hadron_ = true;

	update_flag_.set();

}

HadronPlugin::~HadronPlugin()
{
	writeToLog("Plugin is closing down.");
	Logger::setCurrentLogger(nullptr);
}

//==============================================================================
const String HadronPlugin::getName() const
{
	return "Hadron";
}

const String HadronPlugin::getPath() const
{
	return hadron_path_;
}

int HadronPlugin::getNumParameters() {

	return Hadron::getNumParameters();
}

float
HadronPlugin::getParameter(int index) {

	float value = 0.0f;
	if (index >= 0 && index < Hadron::getNumParameters()) {
		if (index < Hadron::getNumProgramParameters()) {
			value = interface_.getParameter(index);
			if (has_loaded_hadron_) {
				// If not loaded, the correct state is in HadronPlugin
				// and must not be overwritten by value from CsoundInterface
				programs_[current_program_]->params_[index] = value;
			}
		}
	}
	else {
		value = sampling_state_[index - Hadron::SAMPLING_1];
	}
	return value;
}

float
HadronPlugin::getParameterDenormalized(int index) {
	const float value = getParameter(index);
	return (index >= 0 && index < Hadron::getNumParameters()) ?
		static_cast<float>(Hadron::denormalize(index, value)) : 0.0f;
}

void
HadronPlugin::setParameter(int index, float newValue) {

	if (index >= Hadron::SAMPLING_1 && index <= Hadron::SAMPLING_4) {
		setSampling(index - Hadron::SAMPLING_1, newValue);
	}
	else if (index >= 0 && index < Hadron::getNumParameters() && newValue != interface_.getParameter(index)) {
		interface_.setParameter(index, newValue);
		update_flag_.set(UPDATE_PARAMETERS);
		sendChangeMessage();
	}
}

void
HadronPlugin::setParameterDenormalized(int index, float value, bool notify_host) {
	if (index >= 0 && index < Hadron::getNumParameters()) {
		float norm_value = jlimit(0.0f, 1.0f, static_cast<float>(Hadron::normalize(index, value)));
		notify_host ? setParameterNotifyingHost(index, norm_value) : setParameter(index, norm_value);
	}
}

const String HadronPlugin::getParameterName(int index) {
	return (index >= 0 && index < Hadron::getNumParameters()) ?
		String(Hadron::getParameter(index).ui_name.c_str()) : String();
}

const String HadronPlugin::getParameterText(int index) {
	return (index >= 0 && index < Hadron::getNumParameters()) ?
		String(getParameter(index), 2) : String();
}

bool HadronPlugin::acceptsMidi() const
{
	return true;
}

bool HadronPlugin::producesMidi() const
{
	return false;
}

void HadronPlugin::setCurrentProgram(int index) {

	if (index >= 0 && index < getNumPrograms()) {
		current_program_ = index;
		if (has_loaded_hadron_)
			reloadSelections();
	}
}

void HadronPlugin::changeProgramName(int index, const String& newName) {

	if (index >= 0 && index < getNumPrograms()) {
		programs_[current_program_]->name_ = newName;
	}
}

void HadronPlugin::prepareToPlay(double, int) {

}

void HadronPlugin::releaseResources()
{
	// Do not terminate the interface here.
}

void HadronPlugin::processBlock(AudioSampleBuffer& buffer, MidiBuffer& midiMessages) {

	if (isSuspended())
		return;

	// Convert MIDI messages to something CSound can handle
	CSoundInterface::MidiVector midi_vector;

	MidiMessage message(MidiMessage::allNotesOff(1));
	int sample_position;
	MidiBuffer::Iterator iter(midiMessages);

	while (iter.getNextEvent(message, sample_position)) {

		if (message.isNoteOn()) {
			midi_vector.push_back(CSoundInterface::Midi(sample_position,
				CSoundInterface::MIDI_ON,
				message.getNoteNumber(),
				message.getVelocity()));
		}
		else if (message.isNoteOff()) {
			midi_vector.push_back(CSoundInterface::Midi(sample_position,
				CSoundInterface::MIDI_OFF,
				message.getNoteNumber(),
				message.getVelocity()));
		}
	}

	interface_.process(buffer.getArrayOfWritePointers(), buffer.getNumChannels(), buffer.getNumSamples(), midi_vector);

	AudioPlayHead::CurrentPositionInfo pos;
	if (getPlayHead() != 0 && getPlayHead()->getCurrentPosition(pos)) {
		interface_.setBPM(pos.bpm);
	}

	if (!midi_vector.empty()) {
		update_flag_.set(UPDATE_PARAMETERS);
	}

	sendChangeMessage();
}

//==============================================================================
AudioProcessorEditor* HadronPlugin::createEditor()
{
	writeToLog("Create Hadron editor.");

	update_flag_.set();
	return new HadronComponent(this);
}

//==============================================================================
void HadronPlugin::getStateInformation(MemoryBlock& destData)
{
	XmlElement xmlState(chunk_tag);
	xmlState.setAttribute("pluginVersion", 3);
	xmlState.setAttribute("numPrograms", getNumPrograms());

	for (int i = 0; i < getNumPrograms(); ++i) {
		String child_tag = String("Program") + String(i);
		XmlElement* program = xmlState.createNewChildElement(child_tag);
		getProgramInformation(program, i);
	}

	copyXmlToBinary(xmlState, destData);

	writeToLog("Exported plugin state.");
}

void
HadronPlugin::setStateInformation(const void* data, int sizeInBytes)
{
	auto xmlState = getXmlFromBinary(data, sizeInBytes);

	if (xmlState != 0) {
		if (xmlState->hasTagName(chunk_tag)) {

			int version = xmlState->getIntAttribute("pluginVersion", 2);
			if (version < 3) {
				setProgramInformation(xmlState.get(), 0); // Just a single state here
			}
			else {
				int num_programs = xmlState->getIntAttribute("numPrograms", 0);
				num_programs = std::min(num_programs, getNumPrograms());
				for (int i = 0; i < num_programs; ++i) {
					String child_tag = String("Program") + String(i);
					XmlElement* program = xmlState->getChildByName(child_tag);
					if (program != nullptr) {
						setProgramInformation(program, i);
					}
				}
			}

			if (has_loaded_hadron_)
				reloadSelections();

			writeToLog("Imported program bank.");
		}
		else {
			writeToLog("Error: Wrong tag name for imported program bank.");
		}
	}
	else {
		writeToLog("No program bank found.");
	}
}

void
HadronPlugin::getCurrentProgramStateInformation(MemoryBlock& destData)
{
	XmlElement xmlState(chunk_tag);
	xmlState.setAttribute("pluginVersion", 3);
	getProgramInformation(&xmlState, current_program_);

	copyXmlToBinary(xmlState, destData);

	writeToLog("Exported plugin state.");
}

void
HadronPlugin::setCurrentProgramStateInformation(const void* data, int sizeInBytes)
{
	auto xmlState = getXmlFromBinary(data, sizeInBytes);

	if (xmlState != 0) {
		if (xmlState->hasTagName(chunk_tag)) {

			setProgramInformation(xmlState.get(), current_program_);
			if (has_loaded_hadron_)
				reloadSelections();

			writeToLog("Imported program.");
		}
		else {
			writeToLog("Error: Wrong tag name for imported program.");
		}
	}
	else {
		writeToLog("No program found.");
	}
}

void
HadronPlugin::setSourceSound(unsigned int slot, const String& label, bool force) {

	String sound = sounds_[label];
	HadronProgram* current = programs_[current_program_];

	if (slot < 4 && !sound.isEmpty() && (force || sound != current->selected_sound_[slot])) {

		current->selected_sound_[slot] = label;

		if (sound.startsWithChar('*')) {
			if (sound.containsChar('i')) {
				interface_.setLiveFollow(slot + 1);
			}
			else {
				int value = sound.getTrailingIntValue();
				interface_.setLiveSampler(slot + 1, value);
			}
		}
		else {
			interface_.setSourceSound(std::string(sound.toUTF8()), slot + 1);
		}
	}
}

void
HadronPlugin::setState(unsigned int slot, const String& label, bool force) {

	HadronProgram* current = programs_[current_program_];
	if (slot < 4 && (force || label != current->selected_state_[slot]) && states_.contains(label)) {

		current->selected_state_[slot] = label;
		std::string name = std::string(label.toUTF8()) + std::string(".spst");
		interface_.loadSinglePreset(name, slot);
	}
}

void
HadronPlugin::setSampling(unsigned int slot, float value) {

	bool new_state = (value >= 0.5);
	bool toggle = (getSamplingState(slot) != new_state);

	if (toggle) {
		// Always turn off previous sampling first
		for (unsigned int i = 0; i < 4; ++i) {
			if (getSamplingState(i))  {
				interface_.doSampling(false);
				if (i != slot) {
					sampling_state_[i] = 0.0f;
					sendParamChangeMessageToListeners(Hadron::SAMPLING_1 + i, 0.0f);
				}
				break;
			}
		}

		// Then turn on (if necessary)
		if (new_state) {
			interface_.doSampling(true);
			int last_segment = interface_.getLastRecordedSegment();
			interface_.setLiveSampler(slot + 1, last_segment);
			String new_label = String("Live segment ") + String(last_segment);
			String new_sound = String("*") + String(last_segment);
			sounds_.set(new_label, new_sound);
			programs_[current_program_]->selected_sound_[slot] = new_label;
			update_flag_.set(UPDATE_SOUNDLIST);
		}
	}

	sampling_state_[slot] = value;
	update_flag_.set(UPDATE_SAMPLING);
	sendChangeMessage();
}

void
HadronPlugin::createCriticalLog(const String& message)
{
	// Set up a default desktop logger to catch critical errors
	File root = File::getSpecialLocation(File::userDesktopDirectory);
	log_file_.reset(new FileLogger(root.getChildFile(String("hadron_vst.log")), String("Hadron critical error"), 0));
	Logger::setCurrentLogger(log_file_.get());
	Logger::writeToLog(message);
}

void
HadronPlugin::createConfigFile(const File& config_file, const String& hadron_path) {

	XmlElement hadronConfig("Hadron_properties");
	XmlElement* logProps = hadronConfig.createNewChildElement("Logging");
	logProps->setAttribute("Hadron", false);
	logProps->setAttribute("Csound", false);
	XmlElement* fileProps = hadronConfig.createNewChildElement("Filename");
	fileProps->setAttribute("Folder", hadron_path + "/logs");
	fileProps->setAttribute("Name", "hadron_vst");
	fileProps->setAttribute("Timestamp", false);
	fileProps->setAttribute("Extension", "log");

	hadronConfig.writeToFile(config_file, String());
}

void
HadronPlugin::readConfigFile(const File& config_file, String& logfile, String& csound_logfile) {

	bool hadron_log = false, csound_log = false;

	auto hadronConfig = XmlDocument::parse(config_file);
	if (hadronConfig != nullptr && hadronConfig->hasTagName("Hadron_properties")) {

		XmlElement* logProps = hadronConfig->getChildByName("Logging");
		if (logProps != nullptr) {
			hadron_log = logProps->getBoolAttribute("Hadron", false);
			csound_log = logProps->getBoolAttribute("Csound", false);
		}
		XmlElement* fileProps = hadronConfig->getChildByName("Filename");
		if (fileProps != nullptr) {
			String filename = fileProps->getStringAttribute("Folder", String()) + "/";
			filename += fileProps->getStringAttribute("Name", String());
			String extension = fileProps->getStringAttribute("Extension", String());
			bool should_timestamp = fileProps->getBoolAttribute("Timestamp", false);
			String stamp = String();
			if (should_timestamp) {
				stamp += "_" + Time::getCurrentTime().formatted("%M%S");
				Uuid unique;
				stamp += "_" + unique.toString();
			}
			logfile = hadron_log ? filename + stamp + "." + extension : String();
			csound_logfile = csound_log ? filename + "_csound" + stamp + "." + extension : String();
		}
	}
}

void
HadronPlugin::loadStateFiles(const File& directory) {

	Array<File> state_files;
	directory.findChildFiles(state_files, File::findFiles, false, JUCE_T("*.spst"));

	for (int i = 0; i < state_files.size(); ++i) {
		states_.add(state_files[i].getFileNameWithoutExtension());
	}

	String message = "Loaded " + String(state_files.size()) + " state files.";
	writeToLog(message);

	update_flag_.set(UPDATE_STATELIST);
}

void
HadronPlugin::loadSoundFiles(const File& directory) {

	Array<File> sound_files;
	directory.findChildFiles(sound_files, File::findFiles, false, JUCE_T("*.wav"));

	for (int i = 0; i < sound_files.size(); ++i) {
		sounds_.set(sound_files[i].getFileNameWithoutExtension(), sound_files[i].getFileName());
	}

	sounds_.set(JUCE_T("-1"), JUCE_T(""));
	sounds_.set(JUCE_T("Sine"), JUCE_T("Sine"));
	sounds_.set(JUCE_T("Triangle"), JUCE_T("Triangle"));
	sounds_.set(JUCE_T("Saw"), JUCE_T("Saw"));
	sounds_.set(JUCE_T("Square"), JUCE_T("Square"));
	sounds_.set(JUCE_T("Pulse"), JUCE_T("Pulse"));
	sounds_.set(JUCE_T("-2"), JUCE_T(""));
	sounds_.set(JUCE_T("Audio input"), JUCE_T("*i"));

	String message = "Loaded " + String(sound_files.size()) + " sound files.";
	writeToLog(message);

	update_flag_.set(UPDATE_SOUNDLIST);
}

void
HadronPlugin::reloadSelections() {

	HadronProgram* current = programs_[current_program_];
	float* params = current->params_;

	setState(0, current->selected_state_[0], true);
	setState(1, current->selected_state_[1], true);
	setState(2, current->selected_state_[2], true);
	setState(3, current->selected_state_[3], true);
	update_flag_.set(UPDATE_STATESELECT);

	setSourceSound(0, current->selected_sound_[0], true);
	setSourceSound(1, current->selected_sound_[1], true);
	setSourceSound(2, current->selected_sound_[2], true);
	setSourceSound(3, current->selected_sound_[3], true);
	update_flag_.set(UPDATE_SOUNDSELECT);

	setParameterNotifyingHost(Hadron::EXPR_1, params[Hadron::EXPR_1]);
	setParameterNotifyingHost(Hadron::EXPR_2, params[Hadron::EXPR_2]);
	setParameterNotifyingHost(Hadron::EXPR_3, params[Hadron::EXPR_3]);
	setParameterNotifyingHost(Hadron::EXPR_4, params[Hadron::EXPR_4]);
	setParameterNotifyingHost(Hadron::PRESET_X, params[Hadron::PRESET_X]);
	setParameterNotifyingHost(Hadron::PRESET_Y, params[Hadron::PRESET_Y]);
	setParameterNotifyingHost(Hadron::VOLUME, params[Hadron::VOLUME]);

	writeToLog("Reloaded the settings after Csound initialization.");

	update_flag_.set(UPDATE_PARAMETERS);
	sendChangeMessage();
}

void
HadronPlugin::setProgramInformation(const XmlElement* element, int program_number)
{
	HadronProgram* current = programs_[program_number];

	current->name_ = element->getStringAttribute("name", current->name_);

	float* params = current->params_;
	params[Hadron::EXPR_1] = static_cast<float>(element->getDoubleAttribute("expression1", params[Hadron::EXPR_1]));
	params[Hadron::EXPR_2] = static_cast<float>(element->getDoubleAttribute("expression2", params[Hadron::EXPR_2]));
	params[Hadron::EXPR_3] = static_cast<float>(element->getDoubleAttribute("expression3", params[Hadron::EXPR_3]));
	params[Hadron::EXPR_4] = static_cast<float>(element->getDoubleAttribute("expression4", params[Hadron::EXPR_4]));
	params[Hadron::PRESET_X] = static_cast<float>(element->getDoubleAttribute("presetX", params[Hadron::PRESET_X]));
	params[Hadron::PRESET_Y] = static_cast<float>(element->getDoubleAttribute("presetY", params[Hadron::PRESET_Y]));
	params[Hadron::VOLUME] = static_cast<float>(element->getDoubleAttribute("masterLevel", params[Hadron::VOLUME]));

	String select = current->selected_state_[0];
	select = element->getStringAttribute("state1", select);
	current->selected_state_[0] = select;

	select = current->selected_state_[1];
	select = element->getStringAttribute("state2", select);
	current->selected_state_[1] = select;

	select = current->selected_state_[2];
	select = element->getStringAttribute("state3", select);
	current->selected_state_[2] = select;

	select = current->selected_state_[3];
	select = element->getStringAttribute("state4", select);
	current->selected_state_[3] = select;

	select = current->selected_sound_[0];
	select = element->getStringAttribute("sound1", select);
	if (select.startsWith("Live segment ")) select = "MUTE";
	current->selected_sound_[0] = select;

	select = current->selected_sound_[1];
	select = element->getStringAttribute("sound2", select);
	if (select.startsWith("Live segment ")) select = "MUTE";
	current->selected_sound_[1] = select;

	select = current->selected_sound_[2];
	select = element->getStringAttribute("sound3", select);
	if (select.startsWith("Live segment ")) select = "MUTE";
	current->selected_sound_[2] = select;

	select = current->selected_sound_[3];
	select = element->getStringAttribute("sound4", select);
	if (select.startsWith("Live segment ")) select = "MUTE";
	current->selected_sound_[3] = select;
}

void
HadronPlugin::getProgramInformation(XmlElement* element, int program_number) const
{
	HadronProgram* current = programs_[program_number];
	float* params = current->params_;

	element->setAttribute("name", current->name_);

	element->setAttribute("expression1", params[Hadron::EXPR_1]);
	element->setAttribute("expression2", params[Hadron::EXPR_2]);
	element->setAttribute("expression3", params[Hadron::EXPR_3]);
	element->setAttribute("expression4", params[Hadron::EXPR_4]);
	element->setAttribute("presetX", params[Hadron::PRESET_X]);
	element->setAttribute("presetY", params[Hadron::PRESET_Y]);
	element->setAttribute("masterLevel", params[Hadron::VOLUME]);

	element->setAttribute("state1", current->selected_state_[0]);
	element->setAttribute("state2", current->selected_state_[1]);
	element->setAttribute("state3", current->selected_state_[2]);
	element->setAttribute("state4", current->selected_state_[3]);

	element->setAttribute("sound1", current->selected_sound_[0]);
	element->setAttribute("sound2", current->selected_sound_[1]);
	element->setAttribute("sound3", current->selected_sound_[2]);
	element->setAttribute("sound4", current->selected_sound_[3]);
}

void
HadronPlugin::configureLogging(const File& directory)
{
	File config_file = directory.getChildFile(String("hadron_vst.config"));
	if (!config_file.exists()) {
		createConfigFile(config_file, directory.getFullPathName());
	}

	csound_log_path_ = String();
	String logfile_name = String();
	readConfigFile(config_file, logfile_name, csound_log_path_);

	// Create log files (if necessary)
	if (logfile_name.isNotEmpty()) {
		File log_file(logfile_name);
		if (!log_file.existsAsFile())
			log_file.create();

		log_file_.reset(new FileLogger(log_file, String("Hadron VST log!"), 0));
	}
	else {
		// Disable logging
	}

	if (csound_log_path_.isNotEmpty()) {
		File csound_logfile(csound_log_path_);
		if (!csound_logfile.existsAsFile())
			csound_logfile.create();
		writeToLog("Csound logging enabled.");
	}
}

void 
HadronPlugin::writeToLog(String log_text)
{
	if (log_file_ != nullptr)
		log_file_->logMessage(log_text);
}


void
HadronPlugin::initializeCsound()
{
	if (interface_.initialize(std::string(hadron_path_.toUTF8()), std::string("Hadron"), std::string(csound_log_path_.toUTF8()), -1)) {

		File root_directory(hadron_path_);
		loadStateFiles(root_directory.getChildFile(String("states")));
		loadSoundFiles(root_directory.getChildFile(String("samples")));
		writeToLog("Csound initialized successfully.");
	}
	else {
		writeToLog("Error: Csound failed to initialize.");
	}
}

void HadronPlugin::readDefaultPresetFile(const File& directory)
{
	File vst_preset = directory.getChildFile(String("HadronFree.fxb"));
	if (!vst_preset.existsAsFile())
		return;


	FileInputStream preset_stream(vst_preset);
	int64 length = preset_stream.getTotalLength();
	int64 start = length;
	int size = 0;

	for (; !preset_stream.isExhausted();) {
		const char character = preset_stream.readByte();
		if (character == '<') {
			start = preset_stream.getPosition() - 1;
			String xml_block = preset_stream.readEntireStreamAsString();
			if (xml_block.startsWith(chunk_tag)) {
				xml_block.trimEnd();
				size = xml_block.length() + 1;  // Add the '<' char
				break;
			}
			else {
				preset_stream.setPosition(start);
			}
		}
	}

	if (size > 0) {

		MemoryBlock stream_buffer;
		preset_stream.setPosition(start - 8);   // Backtrack the 8-byte prefix
		preset_stream.readIntoMemoryBlock(stream_buffer, size + 8);
		setStateInformation(stream_buffer.getData(), size + 8);
	}

}

double HadronPlugin::getTailLengthSeconds() const
{
	return 0.0;
}
