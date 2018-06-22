#pragma once

#include "../JuceLibraryCode/JuceHeader.h"

class HadronLabel : public Label
{
public:
	HadronLabel(const String& name = String::empty,
                const String& labelText = String::empty);
	~HadronLabel();

private:
    bool    use_modal_editor_;

    void showEditorModal();

    // Override to allow custom text editor
    virtual void mouseDoubleClick(const MouseEvent& e);
    virtual void focusGained (FocusChangeType cause);

    virtual void textEditorReturnKeyPressed(TextEditor& editor);
    virtual void textEditorEscapeKeyPressed(TextEditor& editor);
    virtual void textEditorFocusLost(TextEditor& editor);

    // Hide copy constructor and assignment operator 
    HadronLabel(const HadronLabel&);
	const HadronLabel operator= (const HadronLabel&);
};

