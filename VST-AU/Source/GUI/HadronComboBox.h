#pragma once

#include "../JuceLibraryCode/JuceHeader.h"

class HadronComboBox : public ComboBox
{
public:
	HadronComboBox(String name = String::empty);
	~HadronComboBox();

    void setUrlPath(const String& path);

protected:
    void mouseDown(const MouseEvent& e);

private:
    String urlPath_;

    // Hide copy constructor and assignment operator 
    HadronComboBox(const HadronComboBox&);
	const HadronComboBox operator= (const HadronComboBox&);
};

