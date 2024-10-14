#include "HadronProgram.h"

HadronProgram::HadronProgram()
    : name_("Default")
{
    for (int i=0; i<4; ++i) {
        selected_sound_[i] = String("Sine");
        selected_state_[i] = String("_unassigned");
    }
    
    for (int i=0; i<Hadron::NUM_PROGRAMPARAMS; ++i) {
        // Initialize all parameters to 0.0 denormalized
        params_[i] = static_cast<float>(Hadron::normalize(i, 0.0));
    }
}