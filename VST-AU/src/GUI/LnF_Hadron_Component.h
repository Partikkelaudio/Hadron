#include "JuceHeader.h"

#ifndef _HADRON_LOOK_AND_FEEL_CLASSES_H_
#define _HADRON_LOOK_AND_FEEL_CLASSES_H_


class LnF_Hadron_Component : public LookAndFeel_V2, public DeletedAtShutdown
{
public:
	LnF_Hadron_Component();
	~LnF_Hadron_Component();

	void drawLinearSlider (Graphics& g,
                                   int x, int y,
                                   int width, int height,
                                   float sliderPos,
                                   float minSliderPos,
                                   float maxSliderPos,
                                   Slider::SliderStyle style,
                                   Slider& slider) override;

	int getSliderThumbRadius (Slider& slider) override;
	void drawRotarySlider (Graphics& g,
                                    int x, int y,
                                    int width, int height,
                                    float sliderPos,
                                    float rotaryStartAngle,
                                    float rotaryEndAngle,
                                    Slider& slider) override;
    Font getComboBoxFont (ComboBox& box) override;

	//static const char* expressionSliderMask_png;
	//static const int expressionSliderMask_pngSize;

	juce_DeclareSingleton (LnF_Hadron_Component, false) 

private:
	Image cachedImage_expressionSliderMask_png;
	Image cachedImage_expressionSliderKnob_png;
};

#endif
