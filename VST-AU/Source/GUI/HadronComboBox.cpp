
#include "HadronComboBox.h"


HadronComboBox::HadronComboBox(String name)
	: ComboBox(name)
    , urlPath_(String())
{
}

HadronComboBox::~HadronComboBox()
{
}

void HadronComboBox::setUrlPath(const String& path)
{
    urlPath_ = path;
}

void HadronComboBox::mouseDown(const MouseEvent& e)
{
    if (urlPath_.isNotEmpty() && e.mods.isShiftDown()) {

        String selected_text = this->getText();
        URL link = URL(urlPath_ + String("state_") + selected_text + String(".htm"));
        if (link.isWellFormed()) {
            link.launchInDefaultBrowser();
        }
    }
    else {
        ComboBox::mouseDown(e);
    }
}
