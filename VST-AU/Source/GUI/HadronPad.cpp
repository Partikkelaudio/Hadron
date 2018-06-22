#include "HadronPad.h"
#include "ImageData.h"


namespace {

    // Anonymous namespace for holding various constants used below

    const float two_pi = 2.0f * float_Pi;

    // Shrink-wrap diameter of cursor
    const int cursor_diameter = 24;
    const int cursor_radius = cursor_diameter / 2;

    // Add one extra pixel around the edge
    const int cursor_outer_diameter = cursor_diameter + 2;
    const int cursor_offset = cursor_outer_diameter / 2;

    const float cursor_shadow_offset = 3.0;
    const float cursor_circle_proportion = 0.5f;

    const Colour cursor_color = Colour(0xfffeb300);
    const float  cursor_alpha_mouse = 1.0f;
    const float  cursor_alpha_nomouse = 0.7f;
    
    const Colour cursor_shadow_color = Colour(0x66000000);
    const float  cursor_shadow_alpha = 0.75f;

    const Colour cursor_text_color = Colour(0x66ffffff);
    const Colour texteditor_backgroundcolor = Colour(0xff0C79BA);
    const float  cursor_text_alpha = 0.4f;
    const float  cursor_edit_alpha = 1.0f;
    
    const Rectangle<int> cursor_text_size = Rectangle<int>(24, 12);
    const int cursor_text_offset_x  = 4;
    const int cursor_text_offset_y  = 4;
    const int cursor_text_max_x = cursor_text_size.getWidth() + cursor_text_offset_x + cursor_diameter / 2;
    const int cursor_text_max_y = cursor_text_size.getHeight() + cursor_text_offset_y + cursor_diameter / 2;
}

HadronPad::HadronPad(String name)
	: Component(name)
    , ratio_x_(1.0)
    , ratio_y_(1.0)
    , value_x_(0.5)
    , value_y_(0.5)
    , mouse_offset_x_(0)
    , mouse_offset_y_(0)
    , text_x_()
    , text_y_()
{
	addMouseListener(this, true);

	addAndMakeVisible(&text_x_);
    initializeLabel(&text_x_);

	addAndMakeVisible(&text_y_);
    initializeLabel(&text_y_);

	setRepaintsOnMouseActivity(true);
}

HadronPad::~HadronPad()
{
}

void HadronPad::initializeLabel(Label* label)
{
    label->setJustificationType (Justification::centred);
	
    label->setColour(Label::textColourId, cursor_text_color.withAlpha(cursor_text_alpha));
    label->setColour(TextEditor::textColourId, cursor_text_color.withAlpha(cursor_edit_alpha));
//    label->setColour(TextEditor::highlightColourId, texteditor_backgroundcolor);
    label->setColour(TextEditor::highlightedTextColourId, cursor_text_color.withAlpha(cursor_edit_alpha));
//	label->setColour(TextEditor::focusedOutlineColourId, Colour(0x00ffffff));
	label->setColour (TextEditor::focusedOutlineColourId, texteditor_backgroundcolor);

    label->setFont(Font("Arial", 10.f, Font::plain));
    label->setEditable(false, true, false);
    label->addListener(this);
}

// The ratio between values (0.0-1.0) and draw position. 
// Updated only when the pad is resized. The ratios should always be 1.0 or less

inline void HadronPad::calculateRatios() 
{
    const int width = getWidth() - cursor_outer_diameter;
    const int height = getHeight() - cursor_outer_diameter;

	ratio_x_ = width > 1 ? 1.0 / width : 1.0;
	ratio_y_ = height > 1 ? 1.0 / height : 1.0;
}

inline int HadronPad::value2posX(double ) const
{
    return roundDoubleToInt(floor(value_x_/ratio_x_ + cursor_offset));
}

inline int HadronPad::value2posY(double ) const
{
    return roundDoubleToInt(floor(value_y_/ratio_y_ + cursor_offset));
}

inline double HadronPad::pos2valueX(int pos_x) const
{
    return jlimit(0.0, 1.0, (pos_x - cursor_offset) * ratio_x_);
}

inline double HadronPad::pos2valueY(int pos_y) const
{
    return jlimit(0.0, 1.0, (pos_y - cursor_offset) * ratio_y_);
}

void HadronPad::setValues(double value_x, double value_y, 
                          const bool sendUpdateMessage, 
                          const bool sendMessageSynchronously)
{
    value_x = jlimit(0.0, 1.0, value_x);
    value_y = jlimit(0.0, 1.0, value_y);

	if (value_x_ != value_x || value_y_ != value_y)
	{
        value_x_ = value_x;
        value_y_ = value_y;

        updateLabelPosition();
		repaint();

        if (sendUpdateMessage) {
            if (sendMessageSynchronously)
                sendSynchronousChangeMessage();
            else
                sendChangeMessage();
        }
    }
}

// Virtual methods from Component

void HadronPad::resized()
{
	calculateRatios();

    text_x_.setBounds(cursor_text_size);
    text_y_.setBounds(cursor_text_size);
}

void HadronPad::paint(Graphics& g)
{
    int pos_x = value2posX(value_x_);
    int pos_y = value2posY(value_y_);

    float cursor_pos_x = static_cast<float>(pos_x - cursor_radius + cursor_shadow_offset);
    float cursor_pos_y = static_cast<float>(pos_y - cursor_radius + cursor_shadow_offset);

    Path cursor_path;
	cursor_path.addPieSegment(cursor_pos_x, cursor_pos_y, (float)cursor_diameter, (float)cursor_diameter, 0.0f, two_pi, cursor_circle_proportion);
	g.setColour(cursor_shadow_color.withAlpha(cursor_shadow_alpha));
	g.fillPath(cursor_path);
	
    cursor_path.applyTransform(AffineTransform::translation(-cursor_shadow_offset, -cursor_shadow_offset));
	g.setColour(cursor_color.withAlpha(isMouseOver() ? cursor_alpha_mouse : cursor_alpha_nomouse));
	g.fillPath(cursor_path);
}


void HadronPad::mouseDown(const MouseEvent& e)
{
    // Only handle events from the pad itself
    if (isEnabled() && e.eventComponent == this) {

        // Handle clicking outside center of cursor without jumping cursor
        int pos_x = value2posX(value_x_);
        int pos_y = value2posY(value_y_);

        const Rectangle<int> cursor_rect 
            = Rectangle<int>(pos_x - cursor_radius, pos_y - cursor_radius, cursor_diameter, cursor_diameter);
        const Point<int> mouse_point = e.getPosition();

        if (cursor_rect.contains(mouse_point)) {
            mouse_offset_x_ = pos_x - mouse_point.getX();
            mouse_offset_y_ = pos_y - mouse_point.getY();
        }
        else {
            mouse_offset_x_ = 0;
            mouse_offset_y_ = 0;
        }

        mouseDrag(e);
    }
}

void HadronPad::mouseMove(const MouseEvent& )
{	
}

void HadronPad::mouseDrag(const MouseEvent& e)
{
    if (isEnabled() && (e.eventComponent == this) && e.mods.isLeftButtonDown()) {            

        value_x_ = pos2valueX(e.x + mouse_offset_x_);
        value_y_ = pos2valueY(e.y + mouse_offset_y_);

    	sendChangeMessage();
        updateLabelPosition();
		repaint();
	}
}

void HadronPad::mouseUp(const MouseEvent& )
{
    if (isEnabled()) {
		repaint();
	}
}

void HadronPad::labelTextChanged(Label* labelThatHasChanged) 
{
    if (labelThatHasChanged == &text_x_) {
        value_x_ = jlimit(0.0, 1.0, text_x_.getText().getDoubleValue());
    }
    if (labelThatHasChanged == &text_y_) {
        value_y_ = jlimit(0.0, 1.0, text_y_.getText().getDoubleValue());
    }

    sendChangeMessage();
    updateLabelPosition();
	repaint();
}

void HadronPad::updateLabelPosition()
{
    text_x_.setText(String(value_x_, 2), dontSendNotification);
    text_y_.setText(String(value_y_, 2), dontSendNotification);

    int pos_x = value2posX(value_x_);
    int pos_y = value2posY(value_y_);

    if (pos_x + cursor_text_max_x > getWidth()) {
        // Place horizontal text on the left
        text_x_.setTopRightPosition(pos_x - cursor_radius - cursor_text_offset_x, pos_y - cursor_text_size.getHeight() / 2);
        text_x_.setJustificationType (Justification::right);
    }
    else {
        // Place horizontal text on the right
        text_x_.setTopLeftPosition(pos_x + cursor_radius + cursor_text_offset_x, pos_y - cursor_text_size.getHeight() / 2);
        text_x_.setJustificationType (Justification::left);
    }

    if (pos_y + cursor_text_max_y > getHeight()) {
        // Place vertical text above
        text_y_.setCentrePosition(pos_x, pos_y - cursor_radius - cursor_text_offset_y - cursor_text_size.getHeight() / 2);
    }
    else {
        // Place vertical text below
        text_y_.setCentrePosition(pos_x, pos_y + cursor_radius + cursor_text_offset_y + cursor_text_size.getHeight() / 2);
    }

}

