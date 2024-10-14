#pragma once

#include "PluginParameter.h"

class Hadron {
public:
  enum {EXPR_1, EXPR_2, EXPR_3, EXPR_4, PRESET_X, PRESET_Y, VOLUME, NUM_PROGRAMPARAMS};
  enum {SAMPLING_1=NUM_PROGRAMPARAMS, SAMPLING_2, SAMPLING_3, SAMPLING_4, NUM_PARAMS};

  static double normalize(int index, double value) {return Parameter[index].normalize(value);}
  static double denormalize(int index, double value) {return Parameter[index].denormalize(value);}

  static const PluginParameter& getParameter(int index) {return Parameter[index];}
  static int   getNumParameters() {return NUM_PARAMS;}
  static int   getNumProgramParameters() {return NUM_PROGRAMPARAMS;}

private:
  static const PluginParameter Parameter[Hadron::NUM_PARAMS];
};
