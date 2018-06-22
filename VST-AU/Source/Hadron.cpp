#include "Hadron.h"

const PluginParameter Hadron::Parameter[Hadron::NUM_PARAMS] 
    = {PluginParameter("Expr ctrl 1", "ctrl1", PluginParameter::LINEAR), 
      PluginParameter("Expr ctrl 2", "ctrl2", PluginParameter::LINEAR), 
      PluginParameter("Expr ctrl 3", "ctrl3", PluginParameter::LINEAR), 
      PluginParameter("Expr ctrl 4", "ctrl4", PluginParameter::LINEAR), 
      PluginParameter("Preset X", "presetX", PluginParameter::LINEAR), 
      PluginParameter("Preset Y", "presetY", PluginParameter::LINEAR), 
      PluginParameter("Master level", "MasterLevel", PluginParameter::LINEAR, 0.0, -70.0, 6.0),
      PluginParameter("Sampling 1", "sampling1", PluginParameter::INT),
      PluginParameter("Sampling 2", "sampling2", PluginParameter::INT),
      PluginParameter("Sampling 3", "sampling3", PluginParameter::INT),
      PluginParameter("Sampling 4", "sampling4", PluginParameter::INT)    
    };
