#pragma once

#include "JuceHeader.h"

class HadronLabel : public Label
{
public:
	HadronLabel(const String& name = String(),
                const String& labelText = String());
	~HadronLabel();

private:
    bool    use_modal_editor_;

    void showEditorModal();

    // Override to allow custom text editor
    virtual void mouseDoubleClick(const MouseEvent& e);
    virtual void focusGained (FocusChangeType cause);

    virtual void textEditorReturnKeyPressed(TextEditor& text_ed);
    virtual void textEditorEscapeKeyPressed(TextEditor& text_ed);
    virtual void textEditorFocusLost(TextEditor& text_ed);

    // Hide copy constructor and assignment operator 
    HadronLabel(const HadronLabel&);
	const HadronLabel operator= (const HadronLabel&);
};

