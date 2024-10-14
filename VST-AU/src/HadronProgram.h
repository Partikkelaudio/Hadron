#pragma once

#include "JuceHeader.h"
#include "Hadron.h"

struct HadronProgram {

    HadronProgram();

    String  name_;
    String  selected_state_[4];
    String  selected_sound_[4];
    float   params_[Hadron::NUM_PROGRAMPARAMS];
};
