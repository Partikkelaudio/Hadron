#pragma once

#include "PluginParameter.h"
#include "Hadron.h"

#include <string>
#include <deque>
#include <vector>
#include <fstream>

class Csound;

class CSoundInterface {
public:
	CSoundInterface();
	~CSoundInterface();

	enum { MIDI_ON, MIDI_OFF, CTRL };

	struct Midi {
		int sample_position;
		int type;
		int data1;
		int data2;

		Midi(int pos, int tp, int d1, int d2)
			: sample_position(pos), type(tp), data1(d1), data2(d2) {}
	};
	typedef std::vector<Midi> MidiVector;

	bool initialize(const std::string& root_path, const std::string& orc_sco, const std::string& csound_log_path, int block_size);
	bool running() const { return running_; }

	void run();
	void stop();
	void terminate();

	// Methods for enabling the instrument
	void enableInstrument(bool enable);
	void enablePresetInterpolate(bool enable);
	void setRootPath(const std::string& root_path);

	// Methods for loading presets
	void loadMasterPreset(const std::string& name);
	void saveMasterPreset(const std::string& name);
	void loadSinglePreset(const std::string& name, int slot_num = -1);
	void saveSinglePreset(const std::string& name);

	// Methods for setting input material
	void loadSourceSound(const std::string& name);
	void setSourceSound(const std::string& name, int slot_num);
	void setLiveFollow(int slot_num);
	void setLiveSampler(int slot_num, int segment_num);
	void doSampling(bool on);
	void performKsmps();

	// Methods for handling parameters (Note: VST uses float)
	void  setParameter(int index, float value);
	float getParameter(int index) const;

	// Additional MIDI handling methods
	void setMIDInoteOn(int note_num, int velocity);
	void setMIDInoteOff(int note_num, int velocity);

	// Methods for accessing CSound information
	int getLastRecordedSegment() const;
	double getAmountOfRecordBufferUsed() const;
	int getNumberOfSoundFilesLoaded() const;
	bool isHadronLoaded() const;

	std::ofstream& getLogFile() { return csound_log_; }

	double getVolumeIndicator(unsigned int index) const;

	void setBPM(double value);
	void process(float* const* data, int num_channels, int num_samples, const MidiVector& midi);

private:
	void    setChannel(const std::string& name, double value);
	double  getChannel(const std::string& name) const;
	void    processMidiMessage(const Midi& message);

	bool    initialized() const;
	bool    processing() const;

	Csound				*csound_;
	bool					initialized_;   // True after initialization
	bool					running_;       // True when csound runs
	int						csound_position_;
	std::ofstream csound_log_;


	// Variables and methods for handling note on/off
	float midiNoteInstrument(int increment);
	bool  midiNotePlaying(int note_num);

	float noteOnInstrument(int note_num);
	float noteOffInstrument(int note_num);

	enum { NOTE_NUMBERS = 128 };
	unsigned int  note_table_[NOTE_NUMBERS];
	unsigned int  note_increment_;
	unsigned int  note_counter_;
};