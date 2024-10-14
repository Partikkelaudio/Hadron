#pragma once

#include <string>

struct PluginParameter {
    std::string ui_name;
    std::string cs_name;
    
    enum tType {DEFAULT, INT, LINEAR, EXPONENT} type;

    double def_value;
    double min_value;
    double max_value;

	PluginParameter()
		: ui_name(""), cs_name(""), type(DEFAULT), def_value(0.0), min_value(0.0), max_value(1.0) {}
	PluginParameter(const std::string& cs)
		: ui_name(cs), cs_name(cs), type(DEFAULT), def_value(0.0), min_value(0.0), max_value(1.0) {}
    PluginParameter(const std::string& cs, tType t, double def, double min, double max) 
    : ui_name(cs), cs_name(cs), type(t), def_value(def), min_value(min), max_value(max) {}
    PluginParameter(const std::string& ui, const std::string& cs, tType t) 
    : ui_name(ui), cs_name(cs), type(t), def_value(0.0), min_value(0.0), max_value(1.0) {}
    PluginParameter(const std::string& ui, const std::string& cs, tType t, double def, double min, double max) 
    : ui_name(ui), cs_name(cs), type(t), def_value(def), min_value(min), max_value(max) {}

    double normalize(double value) const   // Convert from range to normalized value (0.0 - 1.0)
        {return (value - min_value) / (max_value - min_value);}

    double denormalize(double value) const // Convert from normalized to range value
        {return min_value + value * (max_value - min_value);}
};


