#include "HadronLabel.h"

HadronLabel::HadronLabel(const String& name, const String& labelText)
    : Label(name, labelText)
    , use_modal_editor_(false)
{
#if _WIN32
    // Windows need special handling (unless sonar is the host)
    const String hostPath(File::getSpecialLocation(File::hostApplicationPath).getFullPathName());
    const String hostFilename(File(hostPath).getFileName());
    bool is_sonar = hostFilename.containsIgnoreCase("SONAR");
    use_modal_editor_ = !is_sonar;
#endif 
}

HadronLabel::~HadronLabel()
{
}

void HadronLabel::mouseDoubleClick(const MouseEvent& e) 
{
    if (use_modal_editor_) {
        if (isEditableOnDoubleClick() && ! e.mods.isPopupMenu()) {
            showEditorModal();
        }
    }
    else {
        Label::mouseDoubleClick(e);
    }
}

void HadronLabel::focusGained (FocusChangeType cause)
{
    if (cause == focusChangedByTabKey && isEditableOnDoubleClick()) {
        use_modal_editor_ ? showEditorModal() : showEditor();
    }
}


void HadronLabel::textEditorReturnKeyPressed(TextEditor& text_ed)
{
    if (use_modal_editor_) {
        setText(text_ed.getText(), sendNotification);
        text_ed.exitModalState(0);
    }
    else {
        Label::textEditorReturnKeyPressed(text_ed);
    }
}

void HadronLabel::textEditorEscapeKeyPressed(TextEditor& text_ed)
{
    if (use_modal_editor_) {
        text_ed.exitModalState(0);
    }
    else {
        Label::textEditorEscapeKeyPressed(text_ed);
    }
}

void HadronLabel::textEditorFocusLost(TextEditor& text_ed)
{
    if (use_modal_editor_) {
        text_ed.exitModalState(0);
    }
    else {
        Label::textEditorFocusLost(text_ed);
    }
}

void HadronLabel::showEditorModal()
{
    ModalComponentManager::Callback* userCallback = 0;
    std::unique_ptr<ModalComponentManager::Callback> userCallbackDeleter (userCallback);
    Component::SafePointer<Component> prevFocused (Component::getCurrentlyFocusedComponent());
    Component::SafePointer<Component> prevTopLevel ((prevFocused != 0) ? prevFocused->getTopLevelComponent() : 0);

    std::unique_ptr<TextEditor> texteditor (createEditorComponent());
    texteditor->setColour(TextEditor::backgroundColourId, Colours::black);
    texteditor->setWantsKeyboardFocus (true);
    texteditor->setAlwaysOnTop (true);

    // Find screen position
    Rectangle<int> sr (getBounds ());
    sr.setPosition (getScreenX(), getScreenY());
    int fontheight = static_cast<int>(texteditor->getFont().getHeight()) + 4;
    if (sr.getHeight() > fontheight) {
        sr.translate (0, (sr.getHeight() - fontheight)/2);
        sr.setHeight (fontheight);
    }
    texteditor->setBounds(sr);

    texteditor->setText(getText(),false);
    texteditor->setHighlightedRegion (Range <int> (0, getText().length ()));
    texteditor->setVisible (true);
    texteditor->grabKeyboardFocus();
    texteditor->addToDesktop (ComponentPeer::windowIsTemporary, 0);
       
    texteditor->addListener (this);
    texteditor->enterModalState (false);
    texteditor->grabKeyboardFocus();

    texteditor->runModalLoop();

    if (prevTopLevel != 0)
        prevTopLevel->toFront (true);
    if (prevFocused != 0)
        prevFocused->grabKeyboardFocus();
}