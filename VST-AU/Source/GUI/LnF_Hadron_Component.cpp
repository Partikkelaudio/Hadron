#include "LnF_Hadron_Component.h"
#include "ImageData.h"

int getSourceX(Slider& slider);
/*
TODO:
HadronPresetComboBox:
- Change drawing method for popup menu
	- Apparently it should be sufficient to implement drawing methods for PopupMenu in LnF_Hadron_Component.
	Not entirely sure how this applies to mouse interaction
*/


juce_ImplementSingleton (LnF_Hadron_Component);

LnF_Hadron_Component::LnF_Hadron_Component()
: cachedImage_expressionSliderMask_png(ImageCache::getFromMemory(ImageData::exp_slider_mask_alpha_32_x_167_png, ImageData::exp_slider_mask_alpha_32_x_167_pngSize))
  , cachedImage_expressionSliderKnob_png(ImageCache::getFromMemory(ImageData::expression_slider_knob_32_x_17_png, ImageData::expression_slider_knob_32_x_17_pngSize))
{
}

LnF_Hadron_Component::~LnF_Hadron_Component()
{
  clearSingletonInstance();
}


int LnF_Hadron_Component::getSliderThumbRadius(Slider& )
{
	return 9;
}

int getSourceX(Slider& slider)
{
	// Some sort of offset for the "faderbutton" if mouse is over or mousebutton pressed down
	if(slider.isMouseOver())
	{
		if(slider.isMouseButtonDownAnywhere())
		{
			// 32 px offset to get next fader knob image (when mouse pressed) 
			return 32;
		}
		// 32 px offset to get next fader knob image (when mouse hovering)
		return 32;
	};
	
	return 0;
}

// Expression sliders

void LnF_Hadron_Component::drawLinearSlider(Graphics& g,
												int x, int y,
												int width, int height,
												float sliderPos,
												float , float ,
												Slider::SliderStyle,
												Slider& slider)
{
	g.setColour(slider.findColour(Slider::trackColourId));

	//g.fillRect(x, int(sliderPos), width, height - int(sliderPos) + getSliderThumbRadius(slider));
	g.fillRect(x, y-1, width, int(sliderPos) - getSliderThumbRadius(slider));
		
	g.setColour(slider.findColour(Slider::backgroundColourId));
		
	g.fillRect(x, y-1, width, int(sliderPos) - getSliderThumbRadius(slider));
		
		
	g.setImageResamplingQuality(Graphics::lowResamplingQuality);
	//g.drawImage(cachedImage_expressionSliderMask_png, x, y, width, height, 0, 0, width, height, false);
	g.drawImage(cachedImage_expressionSliderMask_png, x, y-1, width, int(sliderPos) - getSliderThumbRadius(slider), 0, 0, width, height, false);

	// Draw fader knob
	g.setImageResamplingQuality(Graphics::mediumResamplingQuality);
	g.setColour(Colour(0xffffffff));
	int sourceX = getSourceX(slider);

	g.drawImage (cachedImage_expressionSliderKnob_png, 
					x, int(sliderPos - getSliderThumbRadius(slider)),33,17,
					sourceX,0,33,17, false);
	
}

// Volume dial drawing

void LnF_Hadron_Component::drawRotarySlider (Graphics& g,
                                    int x, int y,
                                    int width, int height,
                                    float sliderPos,
                                    const float rotaryStartAngle,
                                    const float rotaryEndAngle,
                                    Slider& slider)
{
    const float radius = jmin (width / 2, height / 2) - 2.0f;
    const float centreX = x + width * 0.5f;
    const float centreY = y + height * 0.5f;
    const float rx = centreX - radius;
    const float ry = centreY - radius;
    const float rw = radius * 2.0f;
    const float angle = rotaryStartAngle + sliderPos * (rotaryEndAngle - rotaryStartAngle);
    const bool isMouseOver = slider.isMouseOverOrDragging() && slider.isEnabled();
	const float thickness = 0.4f;
    
	Path backgroundPath;
	backgroundPath.addPieSegment(rx, ry, rw, rw,
								0.0f * float_Pi, 4.0f * float_Pi,
								thickness);
	g.setColour(slider.findColour(Slider::backgroundColourId));
	g.fillPath(backgroundPath);

    if (slider.isEnabled())
        g.setColour (slider.findColour (Slider::rotarySliderFillColourId).withAlpha (isMouseOver ? 1.0f : 0.7f));
    else
        g.setColour (Colour (0x80808080));
   	

    Path filledArc;
    filledArc.addPieSegment (rx, ry, rw, rw,
                            rotaryStartAngle,
                            angle,
                            thickness);
    g.fillPath (filledArc);

    if (slider.isEnabled())
        g.setColour (slider.findColour (Slider::rotarySliderOutlineColourId));
    else
        g.setColour (Colour (0x80808080));

    Path outlineArc;
    //outlineArc.addPieSegment (rx, ry, rw, rw, rotaryStartAngle, rotaryEndAngle, thickness);
    outlineArc.addPieSegment (rx, ry, rw, rw, rotaryStartAngle, rotaryEndAngle, thickness);
  	outlineArc.closeSubPath();
	

    g.strokePath (outlineArc, PathStrokeType (slider.isEnabled() ? (isMouseOver ? 1.2f : 0.8f) : 0.3f));
    g.strokePath (backgroundPath, PathStrokeType (slider.isEnabled() ? (isMouseOver ? 1.2f : 0.8f) : 0.3f));
    
}

Font LnF_Hadron_Component::getComboBoxFont (ComboBox& )
{
    return Font("Arial", 11.f, Font::plain);
}

