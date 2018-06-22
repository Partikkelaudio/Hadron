#include "HadronMeter.h"

namespace {

    // Anonymous namespace for holding various constants used below
    const int bar_indent = 1;

    const Colour meter_color = Colour(0xff0C79BA);
    const Colour outline_color = Colour(0xff283B49);
}


HadronMeter::HadronMeter(String name)
	: Component(name)
    , value_(0.0)
    , meterRegionStart_(0)
    , meterRegionSize_(1)
{
}

HadronMeter::~HadronMeter()
{
}

void HadronMeter::setValue(double value)
{
    if (value_ != value) {
        value_ = value;
        repaint();
    }
}

// Virtual methods from Component

void HadronMeter::resized() 
{
    meterRegionStart_ = bar_indent;
    meterRegionSize_ = getWidth() - bar_indent * 2;
    meterRect_.setBounds (meterRegionStart_, bar_indent, meterRegionSize_, getHeight() - bar_indent * 2);
}


void HadronMeter::paint(Graphics& g) 
{
    double meter_pos = (meterRegionStart_ + value_ * meterRegionSize_);

	g.setColour(meter_color);
	g.fillRect(meterRect_.getX(), meterRect_.getY(), int(meter_pos), meterRect_.getHeight());

    g.setColour (outline_color);
    g.drawRect (0, 0, getWidth(), getHeight(), 1);
}

