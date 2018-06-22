#include "CSoundInterface.h"

#ifdef _MSC_VER
#pragma warning (disable: 4996 4706)
typedef __int32 int32;
typedef unsigned __int32 uint32;
#endif


#include "csound.hpp"

#include <sstream>



	static void my_callback(CSOUND *csound, int, const char *format, va_list valist) {

		static const int message_size = 1024;
    static char message_data[message_size];

		void *myHostData = csoundGetHostData(csound);
		if (myHostData != nullptr) {
			CSoundInterface* interface = static_cast<CSoundInterface*>(myHostData);
			std::ofstream& logfile = interface->getLogFile();

			if (logfile.is_open()) {
				message_data[message_size-1] = 0;
				vsnprintf(message_data, message_size-1, format, valist);
				va_end(valist);
				logfile << message_data;
			}
		}
	}

namespace {

  static const int s_max_increment = 10000;
  static const float s_increment_factor = static_cast<float>(1.0 / s_max_increment);

  static const double s_outscale = 1.0;//32767.0;
  static const double s_inscale = 1.0; //32767.0;

  inline float MidiToFloat(int midi_value) {

    return static_cast<float>(midi_value/127.0);
  }
}


CSoundInterface::CSoundInterface() 
: csound_(NULL)
, initialized_(false)
, running_(false)
, csound_position_(0)
, note_increment_(0)
, note_counter_(0)
{
    for (int i=0;i<NOTE_NUMBERS; ++i) {
        note_table_[i] = s_max_increment;
    }
}

CSoundInterface::~CSoundInterface() {
  terminate();
}

inline bool 
CSoundInterface::initialized() const {

  return csound_ && initialized_;
}

inline bool 
CSoundInterface::processing() const {

  return initialized() && csound_->GetSpin() && csound_->GetSpout();
}

inline void    
CSoundInterface::setChannel(const std::string& name, double value) {

    if (initialized()) csound_->SetChannel(name.c_str(), value);
}

inline double  
CSoundInterface::getChannel(const std::string& name) const {
  return initialized() ? csound_->GetChannel(name.c_str()) : 0.0f;
}

bool 
CSoundInterface::initialize(const std::string& root_path, const std::string& orc_sco, const std::string& csound_log_path, int block_size) {

  initialized_ = false;

	csound_log_.open(csound_log_path.c_str(), std::fstream::out);
	if (csound_log_.is_open()) {
      csound_log_ << "HADRON: DEBUG OUTPUT FROM CSOUND" << std::endl;
			csound_log_ << "--------------------------------" << std::endl;
			csound_log_ << "With root_path = " << root_path.c_str() << std::endl;
  }

#ifdef WIN32 
  std::string opcode_path = root_path + std::string("/Csound_Hadron/plugins64");
#else
  std::string opcode_path = root_path + std::string("/Contents/Frameworks/CsoundLib64.framework/Versions/6.0/Resources/Opcodes64");
#endif	

//  std::string inc_path = root_path + std::string("/inc");

  std::string root = root_path + std::string("/");
  std::string orc_file = root + orc_sco + std::string(".orc");
  std::string sco_file = root + orc_sco + std::string(".sco");

  try {
	int result = csoundSetGlobalEnv("INCDIR", root_path.c_str());
    result = csoundSetGlobalEnv("OPCODE6DIR64", opcode_path.c_str());

    csound_ = new Csound();
    if (csound_) {
			if (csound_log_.is_open()) {
				csound_->SetHostData(this);
        csound_->SetMessageCallback(my_callback);
      }
      csound_->SetHostImplementedAudioIO(1, block_size);

      // The char* arguments are not const, but I assume they will not be modified
      // If the assumption is wrong, this is a bad cast
      initialized_ = (csound_->Compile((char*)"-d", (char*)"-f", (char*)"--expression-opt", (char*)orc_file.c_str(), (char*)sco_file.c_str()) == CSOUND_SUCCESS);

      setRootPath(root);
    }
  }
  catch (...) {
    initialized_ = false;
  }

  return initialized_;
}

void
CSoundInterface::run() {

    if (initialized()) {
        running_ = true;
        csound_->Perform();
    }
}

void
CSoundInterface::stop() {

    if (initialized()) {
        csound_->Stop();
        running_ = false;
    }
}

void 
CSoundInterface::terminate() {

    try {
        if (initialized()) {
            running_ = false;
            initialized_ = false;
            csound_->Cleanup();
            csound_->Reset();
            delete csound_;
            csound_ = NULL;
        }
    }
    catch (...) {
        csound_ = NULL;
    }

		if (csound_log_.is_open()) {
			csound_log_.close();
    }
}

void 
CSoundInterface::enableInstrument(bool enable) {
    if (!initialized()) return;

    if (enable)
        csound_->InputMessage("i 251 0 -1");
    else
        csound_->InputMessage("i -251 0 1");
}

void 
CSoundInterface::enablePresetInterpolate(bool enable) {
    if (!initialized()) return;

    if (enable)
        csound_->InputMessage("i 74 0 -1");
    else
        csound_->InputMessage("i -74 0 1");
}

void 
CSoundInterface::setRootPath(const std::string& path) {
  if (initialized() && !path.empty()) {
    std::stringstream path_stream;
    path_stream << "i 1 0 1 \"" << path << "\"";
    csound_->InputMessage(path_stream.str().c_str());
    csound_->PerformKsmps();
  }
}

void 
CSoundInterface::loadMasterPreset(const std::string& name) {
  if (initialized() && !name.empty()) {
    std::stringstream master;
    master << "i 73 0 1 \"" << name << "\" 1";
    csound_->InputMessage(master.str().c_str());
  }
}

void 
CSoundInterface::saveMasterPreset(const std::string& name) {
  if (initialized() && !name.empty()) {
    std::stringstream master;
    master << "i 73 0 1 \"" << name << "\" 0";
    csound_->InputMessage(master.str().c_str());
  }
}

void 
CSoundInterface::loadSinglePreset(const std::string& name, int slot_num) {

  bool interpolate = (slot_num >= 0 && slot_num <= 3);
  if (initialized() && !name.empty()) {
    std::stringstream preset;
    if (interpolate) {
      preset << "i 72 0 1 \"" << name << "\" " << slot_num;
    }
    else {
      preset << "i 70 0 1 \"" << name << "\"";
    }
    csound_->InputMessage(preset.str().c_str());
  }
}

void 
CSoundInterface::saveSinglePreset(const std::string& name) {
  if (initialized() && !name.empty()) {
    std::stringstream preset;
    preset << "i 71 0 1 \"" << name << "\"";
    csound_->InputMessage(preset.str().c_str());
  }
}

void 
CSoundInterface::loadSourceSound(const std::string& name) {
  if (initialized() && !name.empty()) {
    std::stringstream source, analysis;
    source << "i 60 0 1 \"" << name << "\"";
    analysis << "i 61 0 1 \"" << name << "\"";
    csound_->InputMessage(source.str().c_str());
    csound_->InputMessage(analysis.str().c_str());
    csound_->PerformKsmps();
  }
}

void 
CSoundInterface::setSourceSound(const std::string& name, int slot_num) {
  if (initialized() && !name.empty()) {
    std::stringstream source;
    source << "i 20 0 1 1 " << slot_num << " \"" << name << "\"";
    csound_->InputMessage(source.str().c_str()); 
  }
}

void 
CSoundInterface::setLiveFollow(int slot_num) {
  setSourceSound(std::string("audioInput"), slot_num);
}

void 
CSoundInterface::setLiveSampler(int slot_num, int segment_num) {
  
  std::stringstream source;
  source << "segment " << segment_num;
  setSourceSound(source.str().c_str(), slot_num);
}

void 
CSoundInterface::doSampling(bool on) {
    if (!initialized()) return;

    if (on)
        csound_->InputMessage("i 51 0 -1");
    else
        csound_->InputMessage("i -51 0 1");
}

void 
CSoundInterface::performKsmps() {
  if (initialized()) {
    csound_->PerformKsmps();
  }
}


void 
CSoundInterface::setParameter(int index, float norm_value) {
  if (index >= 0 && index < Hadron::getNumParameters()) {
    double value = Hadron::denormalize(index, norm_value);
    setChannel(Hadron::getParameter(index).cs_name, value);
  }
}

float
CSoundInterface::getParameter(int index) const {
  if (index >= 0 && index < Hadron::getNumParameters()) {
    double value = getChannel(Hadron::getParameter(index).cs_name);
    return static_cast<float>(Hadron::normalize(index, value));
  }
  else
    return 0.0f;
}

inline float 
CSoundInterface::midiNoteInstrument(int increment) {
    return 89.0f + s_increment_factor * increment;
}

inline bool  
CSoundInterface::midiNotePlaying(int note_num) {
    return note_table_[note_num] < s_max_increment;
}

inline float 
CSoundInterface::noteOnInstrument(int note_num) {

    ++note_counter_;
    ++note_increment_;
    if (note_increment_ >= s_max_increment)
        note_increment_ = 0;
    note_table_[note_num] = note_increment_;

    return midiNoteInstrument(note_increment_);
}

inline float 
CSoundInterface::noteOffInstrument(int note_num) {

    if (note_counter_ <= 1) {
        note_increment_ = 0;
        note_counter_ = 0;
    }
    else {
        --note_counter_;
    }

    float instr_number = midiNoteInstrument(note_table_[note_num]);
    note_table_[note_num] = s_max_increment;
    return instr_number;
}

void 
CSoundInterface::setMIDInoteOn(int note_num, int velocity) {
    if (!initialized() || midiNotePlaying(note_num)) 
        return;

    std::stringstream note;
    note << "i " << noteOnInstrument(note_num) << " 0 -1 " << note_num << " " << velocity;
    csound_->InputMessage(note.str().c_str());
}

void 
CSoundInterface::setMIDInoteOff(int note_num, int velocity) {
    if (!initialized() || !midiNotePlaying(note_num)) 
        return;

    std::stringstream note;
    note << "i -" << noteOffInstrument(note_num) << " 0 1 " << note_num << " " << velocity;
    csound_->InputMessage(note.str().c_str());
}

int 
CSoundInterface::getLastRecordedSegment() const {
  return static_cast<int>(getChannel("lastRecordedSegment"));
}

double 
CSoundInterface::getAmountOfRecordBufferUsed() const {
  return getChannel("AmountOfRecordBufferUsed");
}

int 
CSoundInterface::getNumberOfSoundFilesLoaded() const {
  return static_cast<int>(getChannel("numberOfSoundFilesLoaded"));
}

bool 
CSoundInterface::isHadronLoaded() const {
  return (getChannel("HadronLoaded") > 0.5);
}

void 
CSoundInterface::setBPM(double value) {
  setChannel("hostTempoBpm", value);
}

double 
CSoundInterface::getVolumeIndicator(unsigned int index) const {

  if (index < 5) {
    std::stringstream ch_name;
    ch_name << "displayAmpWave" << index+1;
    return getChannel(ch_name.str().c_str());
  }
  else 
    return 0.0;
}

inline void    
CSoundInterface::processMidiMessage(const Midi& message) {
  switch (message.type) {
    case MIDI_ON:
      setMIDInoteOn(message.data1, message.data2);
      break;
    case MIDI_OFF:
      setMIDInoteOff(message.data1, message.data2);
      break;
    case CTRL:
      setParameter(message.data1-1, MidiToFloat(message.data2));
      break;
    default:
      break;
  }
}

void 
CSoundInterface::process(float** data, int num_channels, int num_samples, const MidiVector& midi) {

  if (processing()) {

    MYFLT *csound_input = csound_->GetSpin();
    MYFLT *csound_output = csound_->GetSpout();

    int csound_last_sample = csound_->GetKsmps()-1;

    MidiVector::const_iterator midi_msg = midi.begin();
    for(int host_sample = 0; host_sample < num_samples; ++host_sample) {

      for(int channel = 0; channel < num_channels; ++channel) {
        csound_input[(csound_position_ * num_channels) + channel] = data[channel][host_sample];
        data[channel][host_sample] = static_cast<float>(csound_output[(csound_position_ * num_channels) + channel] * s_outscale);
        csound_output[(csound_position_ * num_channels) + channel] = 0.0;
      }
      while (midi_msg != midi.end() && midi_msg->sample_position <= host_sample){
        processMidiMessage(*(midi_msg++));
      }
      csound_position_++;
      if(csound_position_ > csound_last_sample) {
        csound_->PerformKsmps();
        csound_position_ = 0;
      }
    }
  }
}
