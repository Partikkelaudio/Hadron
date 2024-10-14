#pragma once

#include "JuceHeader.h"

class HadronMeter : public Component
{
public:
    HadronMeter(String name = String());
	~HadronMeter();

    void setValue(double value_x);

protected:
	void paint(Graphics& g);
	void resized();

private:
    double value_;

    int meterRegionStart_, meterRegionSize_;
    Rectangle<int> meterRect_;

    // Hide copy constructor and assignment operator 
    HadronMeter(const HadronMeter&);
	const HadronMeter operator= (const HadronMeter&);
};

