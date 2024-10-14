#pragma once

#include "JuceHeader.h"

#include "CSoundInterface.h"
#include "HadronProgram.h"

#include <bitset>


class HadronPlugin : public AudioProcessor,
	public ChangeBroadcaster
{
public:

	HadronPlugin();
	~HadronPlugin();

	virtual void prepareToPlay(double sampleRate, int samplesPerBlock);
	virtual void releaseResources();
	virtual void processBlock(AudioSampleBuffer& buffer, MidiBuffer& midiMessages);
	virtual bool hasEditor() const { return true; }

	AudioProcessorEditor* createEditor();

	const String getName() const;
	const String getPath() const;

	int getNumParameters();

	float getParameter(int index);
	float getParameterDenormalized(int index);

	void setParameter(int index, float newValue);
	void setParameterDenormalized(int index, float value, bool notify_host);

	const String getParameterName(int index);
	const String getParameterText(int index);

	bool acceptsMidi() const;
	bool producesMidi() const;
	double getTailLengthSeconds() const override;

	int getNumPrograms()                                        { return programs_.size(); }
	int getCurrentProgram()                                     { return current_program_; }
	const String getProgramName(int index)                     { return programs_[index]->name_; }

	void setCurrentProgram(int index);
	void changeProgramName(int index, const String& newName);

	void getStateInformation(MemoryBlock& destData);
	void setStateInformation(const void* data, int	sizeInBytes);

	void getCurrentProgramStateInformation(MemoryBlock& destData);
	void setCurrentProgramStateInformation(const void* data, int sizeInBytes);

	//==============================================================================
	// Local methods used by the UI component to access plugin state

	double getVolumeIndicator(unsigned int slot) const { return interface_.getVolumeIndicator(slot); }

	void setSourceSound(unsigned int slot, const String& label, bool force = false);
	void setState(unsigned int slot, const String& label, bool force = false);

	const StringArray& getStateLabels() const { return states_; }
	const StringArray& getSoundLabels() const { return sounds_.getAllKeys(); }

	bool getSamplingState(unsigned int slot) const { return sampling_state_[slot] >= 0.5f; }
	const String& getSoundSelection(unsigned int slot) const { return programs_[current_program_]->selected_sound_[slot]; }
	const String& getStateSelection(unsigned int slot) const { return programs_[current_program_]->selected_state_[slot]; }

	bool hasLoadedHadron() const { return has_loaded_hadron_; }

	enum UpdateEnum { UPDATE_SOUNDLIST, UPDATE_STATELIST, UPDATE_SOUNDSELECT, UPDATE_STATESELECT, UPDATE_SAMPLING, UPDATE_PARAMETERS, NUM_UPDATES };
	bool checkUpdate(UpdateEnum bit) const { return update_flag_.test(bit); }
	void doneUpdate(UpdateEnum bit) { update_flag_.reset(bit); }

	void writeToLog(String log_text);

	juce_UseDebuggingNewOperator

private:
	void setSampling(unsigned int slot, float value);
	void createCriticalLog(const String& message);
	void createConfigFile(const File& config_file, const String& hadron_path);
	void readConfigFile(const File& config_file, String& logfile, String& csound_logfile);
	void readDefaultPresetFile(const File& directory);

	void loadStateFiles(const File& directory);
	void loadSoundFiles(const File& directory);

	void configureLogging(const File& directory);
	void initializeCsound();

	void setProgramInformation(const XmlElement* element, int program_number);
	void getProgramInformation(XmlElement* element, int program_number) const;

	bool has_loaded_hadron_;
	void reloadSelections();

	CSoundInterface interface_;

	String hadron_path_;
	String csound_log_path_;
	std::unique_ptr<FileLogger> log_file_;

	StringArray states_;
	StringPairArray sounds_;

	float sampling_state_[4];   // The state is now a floating point number for parameter compatibility

	OwnedArray<HadronProgram> programs_;    // Storage of all program (preset) data
	int current_program_;

	std::bitset<NUM_UPDATES> update_flag_;
};
