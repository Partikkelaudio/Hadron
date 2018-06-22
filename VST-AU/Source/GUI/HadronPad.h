#pragma once

#include "HadronLabel.h"


class HadronPad : public Component, public ChangeBroadcaster, public LabelListener
{
public:
	HadronPad(String name = String::empty);
	~HadronPad();

    /** Changes the current xy values.

        This will trigger a callback to any ChangeListener objects that are registered, and will
        synchronously call the valueChanged() method in case subclasses want to handle it.

        @param value_x                  the horizontal X value to set
                                        (will be restricted to the 0.0 - 1.0 interval)
        @param value_y                  the vertical Y value to set
                                        (will be restricted to the 0.0 - 1.0 interval)
        @param sendUpdateMessage        if false, a change to the value will not trigger a call to
                                        any ChangeListeners or the valueChanged() method
        @param sendMessageSynchronously if true, then a call to the ChangeListeners will be made
                                        synchronously; if false, it will be asynchronous
    */
    void    setValues(double value_x, double value_y, 
                      const bool sendUpdateMessage = true, 
                      const bool sendMessageSynchronously = false);

    double  getValueX() const {return value_x_;}
    double  getValueY() const {return value_y_;}

protected:
	void paint(Graphics& g);
	void resized();

    void mouseDown(const MouseEvent& e);
	void mouseDrag(const MouseEvent& e);
	void mouseMove(const MouseEvent& e);
	void mouseUp(const MouseEvent& e);

    void labelTextChanged (Label* labelThatHasChanged);

private:
    void initializeLabel(Label* label);
    void calculateRatios();
    void updateLabelPosition();

    int value2posX(double value_x) const;
    int value2posY(double value_y) const;

    double pos2valueX(int pos_x) const;
    double pos2valueY(int pos_y) const;

private:
    double value_x_, value_y_;
    double ratio_x_, ratio_y_;

    int    mouse_offset_x_, mouse_offset_y_;

    HadronLabel   text_x_;
    HadronLabel   text_y_;

    // Hide copy constructor and assignment operator 
    HadronPad(const HadronPad&);
	const HadronPad operator= (const HadronPad&);
};

