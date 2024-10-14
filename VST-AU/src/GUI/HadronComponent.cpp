
//[Headers] You can add your own extra header files here...
#include "../HadronPlugin.h"
#include "../Hadron.h"

//[/Headers]

#include "HadronComponent.h"
#include "LnF_Hadron_Component.h"
#include "ImageData.h"

//[MiscUserDefs] You can add your own user definitions and misc code here...

//[/MiscUserDefs]

namespace {

	// Anonymous namespace for holding various constants used below

	const Colour text_color = Colour(0x66ffffff);
	const Colour texteditor_backgroundcolor = Colour(0xff0C79BA);
	const float  text_alpha_mouse = 1.0f;
	const float  text_alpha_nomouse = 0.7f;

	// Volume knob
	const double volume_min_value = -70.0;
	const double volume_max_value = 6.0;
	const double volume_step = 0.01;

	const float volume_start_angle = float_Pi * 1.15f;
	const float volume_end_angle = float_Pi * 2.85f;
	const float volume_zero_angle = float_Pi * 2.5f;

	const double volume_relative_zero = (0.0 - volume_min_value) / (volume_max_value - volume_min_value);
	const double volume_proportion_zero = (volume_zero_angle - volume_start_angle) / (volume_end_angle - volume_start_angle);
	const double volume_skew = log(volume_proportion_zero) / log(volume_relative_zero);
}

//==============================================================================
HadronComponent::HadronComponent(HadronPlugin* const ownerFilter)
	: AudioProcessorEditor(ownerFilter),
	volumeKnob_(),
	volumeLabel_(String(), "-70dB"),
	exprSlider1_(),
	exprSlider2_(),
	exprSlider3_(),
	exprSlider4_(),
	exprLabel1_(),
	exprLabel2_(),
	exprLabel3_(),
	exprLabel4_(),
	presetSelector1_(),
	presetSelector2_(),
	presetSelector3_(),
	presetSelector4_(),
	sourceWaveSelector1_(),
	sourceWaveSelector2_(),
	sourceWaveSelector3_(),
	sourceWaveSelector4_(),
	sourceWaveIndicator1_(),
	sourceWaveIndicator2_(),
	sourceWaveIndicator3_(),
	sourceWaveIndicator4_(),
	trainletLabel_(String(), "Trainlet"),
	trainletIndicator_(),
	recButton1_(String(), DrawableButton::ImageRaw),
	recButton2_(String(), DrawableButton::ImageRaw),
	recButton3_(String(), DrawableButton::ImageRaw),
	recButton4_(String(), DrawableButton::ImageRaw),
	pad_(String()),
	cachedImage_Background(ImageCache::getFromMemory(ImageData::background_495_x_269_png, ImageData::background_495_x_269_pngSize)),
	cachedImage_Loading(ImageCache::getFromMemory(ImageData::loading_png, ImageData::loading_pngSize)),
	loadingScreen_(),
	docPath_(String()),
	docLink_("", URL("")),
	docLinkBtn_(String(), DrawableButton::ImageRaw)
{
	LookAndFeel::setDefaultLookAndFeel(LnF_Hadron_Component::getInstance());

	Font hadron_font = Font(11.0f, Font::plain);
	hadron_font.setTypefaceName("Arial");

	// Documentation Link
	docPath_ = String("file:///") + getFilter()->getPath() + String("/docs/");

	DrawableImage docLinkImg;
	docLinkImg.setImage(ImageCache::getFromMemory(ImageData::documentation_link_18_x_18_png, ImageData::documentation_link_18_x_18_pngSize));
	docLinkBtn_.setImages(&docLinkImg, 0, &docLinkImg, 0, 0, 0, 0, 0);

	docLinkBtn_.setWantsKeyboardFocus(false);
	addAndMakeVisible(&docLinkBtn_);

	docLink_.setURL(URL(docPath_ + String("index.html")));
	docLink_.setWantsKeyboardFocus(false);
	addAndMakeVisible(&docLink_);

	int nFocusOrder = 1;

	createVolumeKnob(&volumeKnob_, &volumeLabel_, hadron_font, nFocusOrder++);

	addAndMakeVisible(&sourceWaveIndicator1_);
	createSelector(&sourceWaveSelector1_, nFocusOrder++);

	addAndMakeVisible(&sourceWaveIndicator2_);
	createSelector(&sourceWaveSelector2_, nFocusOrder++);

	addAndMakeVisible(&sourceWaveIndicator3_);
	createSelector(&sourceWaveSelector3_, nFocusOrder++);

	addAndMakeVisible(&sourceWaveIndicator4_);
	createSelector(&sourceWaveSelector4_, nFocusOrder++);

	addAndMakeVisible(&trainletIndicator_);
	addAndMakeVisible(&trainletLabel_);
	trainletLabel_.setJustificationType(Justification::left);
	trainletLabel_.setText("Trainlet", dontSendNotification);
	trainletLabel_.Label::setColour(Label::backgroundColourId, Colour(0x00ffffff));
	trainletLabel_.Label::setColour(Label::textColourId, Colour(0xffffffff));
	trainletLabel_.Label::setColour(Label::outlineColourId, Colour(0x00ffffff));
	trainletLabel_.setWantsKeyboardFocus(false);
	trainletLabel_.setFont(hadron_font);

	// Rec buttons
	createRecordButton(&recButton1_);
	createRecordButton(&recButton2_);
	createRecordButton(&recButton3_);
	createRecordButton(&recButton4_);

	// State select combo boxes
	createSelector(&presetSelector1_, nFocusOrder++);
	presetSelector1_.setUrlPath(docPath_);

	createSelector(&presetSelector2_, nFocusOrder++);
	presetSelector2_.setUrlPath(docPath_);

	createSelector(&presetSelector3_, nFocusOrder++);
	presetSelector3_.setUrlPath(docPath_);

	createSelector(&presetSelector4_, nFocusOrder++);
	presetSelector4_.setUrlPath(docPath_);

	// XY pad
	addAndMakeVisible(&pad_);
	pad_.setExplicitFocusOrder(nFocusOrder++);
	pad_.addChangeListener(this);

	// Expression sliders and labels 
	createExpressionSlider(&exprSlider1_, &exprLabel1_, hadron_font, nFocusOrder++);
	createExpressionSlider(&exprSlider2_, &exprLabel2_, hadron_font, nFocusOrder++);
	createExpressionSlider(&exprSlider3_, &exprLabel3_, hadron_font, nFocusOrder++);
	createExpressionSlider(&exprSlider4_, &exprLabel4_, hadron_font, nFocusOrder++);

	loadingScreen_.setWantsKeyboardFocus(false);
	addAndMakeVisible(&loadingScreen_, -1);
	loadingScreen_.setImage(cachedImage_Loading);

	// Component size (totalt plugin window)

	setSize(495, 269);

	// Start a timer to refresh source wave indicators every 200 msecs
	// (Csound only samples 5 times a second - no point in refreshing at a higher rate)
	startTimer(200);

	setWantsKeyboardFocus(true);
	ownerFilter->addChangeListener(this);
	setLoadingState(true);
	updateFromFilter();

	writeToLog("Hadron editor constructed.");
}

void HadronComponent::writeToLog(String log_text)
{
	getFilter()->writeToLog("GUI " + log_text);
}

void HadronComponent::createVolumeKnob(Slider* knob, Label* label, const Font& font, int focusOrder)
{
	addAndMakeVisible(knob);
	knob->setRange(volume_min_value, volume_max_value, volume_step);
	knob->setSliderStyle(Slider::Rotary);
	knob->setTextBoxStyle(Slider::NoTextBox, false, 80, 20);
	knob->setRotaryParameters(volume_start_angle, volume_end_angle, false);
	knob->setSkewFactor(volume_skew);

	knob->setColour(Slider::backgroundColourId, Colour(0xff283B49));
	knob->setColour(Slider::rotarySliderFillColourId, Colour(0xff0C79BA));
	knob->setColour(Slider::rotarySliderOutlineColourId, Colour(0x0023526e));
	knob->setWantsKeyboardFocus(false);
	knob->addListener(this);

	addAndMakeVisible(label);
	label->setFont(font);
	label->setJustificationType(Justification::centredLeft);
	label->setEditable(false, true, false);
	label->setColour(Label::textColourId, text_color.withAlpha(text_alpha_nomouse));
	label->setColour(TextEditor::textColourId, text_color.withAlpha(text_alpha_mouse));
	label->setColour(TextEditor::highlightedTextColourId, text_color.withAlpha(text_alpha_mouse));
	label->setColour(TextEditor::focusedOutlineColourId, texteditor_backgroundcolor);
	label->setExplicitFocusOrder(focusOrder);
	label->addListener(this);
}

void HadronComponent::createSelector(ComboBox* combo, int)
{
	addAndMakeVisible(combo);
	combo->setEditableText(false);
	combo->setJustificationType(Justification::left);
	combo->setTextWhenNothingSelected(String());
	combo->setTextWhenNoChoicesAvailable("(no choices)");
	combo->setColour(ComboBox::backgroundColourId, Colour(0x00ffffff));
	combo->setColour(ComboBox::textColourId, Colour(0xffffffff));
	combo->setColour(ComboBox::outlineColourId, Colour(0x00ffffff));
	combo->setColour(ComboBox::arrowColourId, Colour(0xffffffff));
	combo->setColour(ComboBox::buttonColourId, Colour(0x00ffffff));
	combo->setWantsKeyboardFocus(false);
	//    combo->setExplicitFocusOrder(focusOrder);
	combo->addListener(this);
}


void HadronComponent::createRecordButton(DrawableButton* button)
{
	DrawableImage recButtonHoverOffImg, recButtonHoverOnImg, recButtonIdleOffImg, recButtonIdleOnImg;
	recButtonHoverOffImg.setImage(ImageCache::getFromMemory(ImageData::rec_hover_off_png, ImageData::rec_hover_off_pngSize));
	recButtonHoverOnImg.setImage(ImageCache::getFromMemory(ImageData::rec_hover_on_png, ImageData::rec_hover_on_pngSize));
	recButtonIdleOffImg.setImage(ImageCache::getFromMemory(ImageData::rec_idle_off_png, ImageData::rec_idle_off_pngSize));
	recButtonIdleOnImg.setImage(ImageCache::getFromMemory(ImageData::rec_idle_on_png, ImageData::rec_idle_on_pngSize));

	addAndMakeVisible(button);
	button->setWantsKeyboardFocus(false);
	button->addListener(this);
	button->setImages(&recButtonIdleOffImg, &recButtonHoverOffImg, 0, 0, &recButtonIdleOnImg, &recButtonHoverOnImg, 0, 0);
}

void HadronComponent::createExpressionSlider(Slider* slider, Label* label, const Font& font, int focusOrder)
{
	addAndMakeVisible(slider);
	slider->setRange(0, 1, 0.01);
	slider->setSliderStyle(Slider::LinearVertical);
	slider->setTextBoxStyle(Slider::NoTextBox, false, 80, 20);
	slider->Slider::setColour(Slider::backgroundColourId, Colour(0xff540731));
	slider->Slider::setColour(Slider::trackColourId, Colour(0xffF10284));

	slider->setWantsKeyboardFocus(false);
	slider->addListener(this);

	addAndMakeVisible(label);
	label->setFont(font);
	label->setJustificationType(Justification::centred);
	label->setEditable(false, true, false);
	label->setColour(Label::textColourId, text_color.withAlpha(text_alpha_nomouse));
	label->setColour(TextEditor::textColourId, text_color.withAlpha(text_alpha_mouse));
	label->setColour(TextEditor::highlightedTextColourId, text_color.withAlpha(text_alpha_mouse));
	label->setColour(TextEditor::focusedOutlineColourId, texteditor_backgroundcolor);

	label->setExplicitFocusOrder(focusOrder);
	label->addListener(this);
}



HadronComponent::~HadronComponent()
{
	getFilter()->removeChangeListener(this);
	pad_.removeChangeListener(this);

	if (isTimerRunning()) {
		stopTimer();
	}

	writeToLog("Hadron editor destructed.");
}

//==============================================================================

void HadronComponent::timerCallback()
{
	HadronPlugin* const filter = getFilter();

	if (!this->isEnabled() && filter->hasLoadedHadron()) {
		setLoadingState(false);
	}

	const double level1_ = filter->getVolumeIndicator(0);
	const double level2_ = filter->getVolumeIndicator(1);
	const double level3_ = filter->getVolumeIndicator(2);
	const double level4_ = filter->getVolumeIndicator(3);
	const double level5_ = filter->getVolumeIndicator(4);

	sourceWaveIndicator1_.setValue(juce_isfinite(level1_) ? jlimit(0.0, 1.0, level1_) : 0.0);
	sourceWaveIndicator2_.setValue(juce_isfinite(level2_) ? jlimit(0.0, 1.0, level2_) : 0.0);
	sourceWaveIndicator3_.setValue(juce_isfinite(level3_) ? jlimit(0.0, 1.0, level3_) : 0.0);
	sourceWaveIndicator4_.setValue(juce_isfinite(level4_) ? jlimit(0.0, 1.0, level4_) : 0.0);
	trainletIndicator_.setValue(juce_isfinite(level5_) ? jlimit(0.0, 1.0, level5_) : 0.0);
}

void HadronComponent::paint(Graphics& g)
{
	//[UserPrePaint] Add your own custom painting code here..
	//[/UserPrePaint]

	g.fillAll(Colours::white);
	g.setColour(Colours::black);
	g.drawImage(cachedImage_Background,
		0, 0, 495, 269,
		0, 0, cachedImage_Background.getWidth(), cachedImage_Background.getHeight());


	//[UserPaint] Add your own custom painting code here..
	//[/UserPaint]
}


void HadronComponent::resized()
{
	// 
	volumeKnob_.setBounds(5, 24, 49, 49);
	volumeLabel_.setBounds(80, 51, 45, 16);

	exprSlider1_.setBounds(359, 43, 32, 184);
	exprSlider2_.setBounds(392, 43, 32, 184);
	exprSlider3_.setBounds(425, 43, 32, 184);
	exprSlider4_.setBounds(458, 43, 32, 184);

	exprLabel1_.setBounds(359, 228, 32, 17);
	exprLabel2_.setBounds(392, 228, 32, 17);
	exprLabel3_.setBounds(425, 228, 32, 17);
	exprLabel4_.setBounds(458, 228, 32, 17);

	presetSelector1_.setBounds(137, 6, 112, 18);
	presetSelector2_.setBounds(248, 6, roundToInt((112) * 1.0000f), roundToInt((18) * 1.0000f));
	presetSelector3_.setBounds(137, 247, roundToInt((112) * 1.0000f), roundToInt((18) * 1.0000f));
	presetSelector4_.setBounds(248, 247, roundToInt((112) * 1.0000f), roundToInt((18) * 1.0000f));

	sourceWaveSelector1_.setBounds(24, 99, roundToInt((110) * 1.0000f), roundToInt((16) * 1.0000f));
	sourceWaveSelector2_.setBounds(24, 118, roundToInt((110) * 1.0000f), roundToInt((16) * 1.0000f));
	sourceWaveSelector3_.setBounds(24, 137, roundToInt((110) * 1.0000f), roundToInt((16) * 1.0000f));
	sourceWaveSelector4_.setBounds(24, 156, roundToInt((110) * 1.0000f), roundToInt((16) * 1.0000f));
	trainletLabel_.setBounds(26, 175, roundToInt((110) * 1.0000f), roundToInt((16) * 1.0000f));

	sourceWaveIndicator1_.setBounds(25, 98, roundToInt((110) * 1.0000f), roundToInt((16) * 1.0000f));
	sourceWaveIndicator2_.setBounds(25, 117, roundToInt((110) * 1.0000f), roundToInt((16) * 1.0000f));
	sourceWaveIndicator3_.setBounds(25, 136, roundToInt((110) * 1.0000f), roundToInt((16) * 1.0000f));
	sourceWaveIndicator4_.setBounds(25, 155, roundToInt((110) * 1.0000f), roundToInt((16) * 1.0000f));
	trainletIndicator_.setBounds(25, 174, roundToInt((110) * 1.0000f), roundToInt((16) * 1.0000f));

	recButton1_.setBounds(5, 97, 18, 18);
	recButton2_.setBounds(5, 116, 18, 18);
	recButton3_.setBounds(5, 135, 18, 18);
	recButton4_.setBounds(5, 154, 18, 18);

	docLink_.setBounds(5, 246, 18, 18);
	docLinkBtn_.setBounds(5, 246, 18, 18);

	RelativeRectangle("parent.width / 2 - 150, parent.height / 2 - 50, left + 300, top + 100").applyToComponent(loadingScreen_);
	pad_.setBounds(137, 24, 221, 221);

}

void HadronComponent::sliderValueChanged(Slider* sliderThatWasMoved)
{
	if (sliderThatWasMoved == &volumeKnob_)
	{
		getFilter()->setParameterDenormalized(Hadron::VOLUME, static_cast<float>(volumeKnob_.getValue()), true);
	}
	else if (sliderThatWasMoved == &exprSlider1_)
	{
		getFilter()->setParameterNotifyingHost(Hadron::EXPR_1, static_cast<float>(exprSlider1_.getValue()));
	}
	else if (sliderThatWasMoved == &exprSlider2_)
	{
		getFilter()->setParameterNotifyingHost(Hadron::EXPR_2, static_cast<float>(exprSlider2_.getValue()));
	}
	else if (sliderThatWasMoved == &exprSlider3_)
	{
		getFilter()->setParameterNotifyingHost(Hadron::EXPR_3, static_cast<float>(exprSlider3_.getValue()));
	}
	else if (sliderThatWasMoved == &exprSlider4_)
	{
		getFilter()->setParameterNotifyingHost(Hadron::EXPR_4, static_cast<float>(exprSlider4_.getValue()));
	}
}

void HadronComponent::labelTextChanged(Label* labelThatHasChanged)
{
	if (labelThatHasChanged == &volumeLabel_)
	{
		getFilter()->setParameterDenormalized(Hadron::VOLUME, (volumeLabel_.getText(false)).getFloatValue(), true);
	}
	else if (labelThatHasChanged == &exprLabel1_)
	{
		getFilter()->setParameterDenormalized(Hadron::EXPR_1, (exprLabel1_.getText(false)).getFloatValue(), true);
	}
	else if (labelThatHasChanged == &exprLabel2_)
	{
		getFilter()->setParameterDenormalized(Hadron::EXPR_2, (exprLabel2_.getText(false)).getFloatValue(), true);
	}
	else if (labelThatHasChanged == &exprLabel3_)
	{
		getFilter()->setParameterDenormalized(Hadron::EXPR_3, (exprLabel3_.getText(false)).getFloatValue(), true);
	}
	else if (labelThatHasChanged == &exprLabel4_)
	{
		getFilter()->setParameterDenormalized(Hadron::EXPR_4, (exprLabel4_.getText(false)).getFloatValue(), true);
	}

}

void HadronComponent::comboBoxChanged(ComboBox* comboBoxThatHasChanged)
{
	if (comboBoxThatHasChanged == &presetSelector1_)
	{
		getFilter()->setState(0, presetSelector1_.getText());
	}
	else if (comboBoxThatHasChanged == &presetSelector2_)
	{
		getFilter()->setState(1, presetSelector2_.getText());
	}
	else if (comboBoxThatHasChanged == &presetSelector3_)
	{
		getFilter()->setState(2, presetSelector3_.getText());
	}
	else if (comboBoxThatHasChanged == &presetSelector4_)
	{
		getFilter()->setState(3, presetSelector4_.getText());
	}
	else if (comboBoxThatHasChanged == &sourceWaveSelector1_)
	{
		getFilter()->setSourceSound(0, sourceWaveSelector1_.getText());
	}
	else if (comboBoxThatHasChanged == &sourceWaveSelector2_)
	{
		getFilter()->setSourceSound(1, sourceWaveSelector2_.getText());
	}
	else if (comboBoxThatHasChanged == &sourceWaveSelector3_)
	{
		getFilter()->setSourceSound(2, sourceWaveSelector3_.getText());
	}
	else if (comboBoxThatHasChanged == &sourceWaveSelector4_)
	{
		getFilter()->setSourceSound(3, sourceWaveSelector4_.getText());
	}
}

void HadronComponent::buttonClicked(Button* buttonThatWasClicked)
{
	HadronPlugin* const filter = getFilter();

	if (buttonThatWasClicked == &recButton1_) {
		// Toggle sampling
		filter->setParameterNotifyingHost(Hadron::SAMPLING_1, filter->getSamplingState(0) ? 0.0f : 1.0f);
	}
	else if (buttonThatWasClicked == &recButton2_) {
		// Toggle sampling
		filter->setParameterNotifyingHost(Hadron::SAMPLING_2, filter->getSamplingState(1) ? 0.0f : 1.0f);
	}
	else if (buttonThatWasClicked == &recButton3_) {
		// Toggle sampling
		filter->setParameterNotifyingHost(Hadron::SAMPLING_3, filter->getSamplingState(2) ? 0.0f : 1.0f);
	}
	else if (buttonThatWasClicked == &recButton4_) {
		// Toggle sampling
		filter->setParameterNotifyingHost(Hadron::SAMPLING_4, filter->getSamplingState(3) ? 0.0f : 1.0f);
	}
}


void HadronComponent::changeListenerCallback(ChangeBroadcaster* source) {

	if (source == &pad_) {
		getFilter()->setParameterNotifyingHost(Hadron::PRESET_X, static_cast<float>(pad_.getValueX()));
		getFilter()->setParameterNotifyingHost(Hadron::PRESET_Y, static_cast<float>(pad_.getValueY()));
	}
	else {
		updateFromFilter();
	};
}


void HadronComponent::updateFromFilter() {

	HadronPlugin* const filter = getFilter();

	if (filter->checkUpdate(HadronPlugin::UPDATE_SOUNDLIST)) {
		updateSoundList();
	}
	if (filter->checkUpdate(HadronPlugin::UPDATE_STATELIST)) {
		updateStateList();
	}
	if (filter->checkUpdate(HadronPlugin::UPDATE_SOUNDSELECT)) {
		updateSoundSelect();
	}
	if (filter->checkUpdate(HadronPlugin::UPDATE_STATESELECT)) {
		updateStateSelect();
	}
	if (filter->checkUpdate(HadronPlugin::UPDATE_SAMPLING)) {
		updateSampling();
	}
	if (filter->checkUpdate(HadronPlugin::UPDATE_PARAMETERS)) {
		updateParameters();
	}
}


void HadronComponent::updateSoundList()
{
	HadronPlugin* const filter = getFilter();
	filter->getCallbackLock().enter();
	filter->doneUpdate(HadronPlugin::UPDATE_SOUNDLIST);
	filter->getCallbackLock().exit();

	// Update sounds

	const StringArray& sounds = filter->getSoundLabels();

	sourceWaveSelector1_.clear(NotificationType::dontSendNotification);
	sourceWaveSelector2_.clear(NotificationType::dontSendNotification);
	sourceWaveSelector3_.clear(NotificationType::dontSendNotification);
	sourceWaveSelector4_.clear(NotificationType::dontSendNotification);


	for (int i = 0; i < sounds.size(); ++i) {
		if (sounds[i].startsWithChar('-')) {
			sourceWaveSelector1_.addSeparator();
			sourceWaveSelector2_.addSeparator();
			sourceWaveSelector3_.addSeparator();
			sourceWaveSelector4_.addSeparator();
		}
		else {
			sourceWaveSelector1_.addItem(sounds[i], i + 1);
			sourceWaveSelector2_.addItem(sounds[i], i + 1);
			sourceWaveSelector3_.addItem(sounds[i], i + 1);
			sourceWaveSelector4_.addItem(sounds[i], i + 1);
		}
	}
	updateSoundSelect();
}

void HadronComponent::updateStateList()
{
	HadronPlugin* const filter = getFilter();
	filter->getCallbackLock().enter();
	filter->doneUpdate(HadronPlugin::UPDATE_STATELIST);
	filter->getCallbackLock().exit();

	// Update states
	const StringArray& states = filter->getStateLabels();

	presetSelector1_.clear(NotificationType::dontSendNotification);
	presetSelector2_.clear(NotificationType::dontSendNotification);
	presetSelector3_.clear(NotificationType::dontSendNotification);
	presetSelector4_.clear(NotificationType::dontSendNotification);

	for (int i = 0; i < states.size(); ++i) {
		presetSelector1_.addItem(states[i], i + 1);
		presetSelector2_.addItem(states[i], i + 1);
		presetSelector3_.addItem(states[i], i + 1);
		presetSelector4_.addItem(states[i], i + 1);
	}
	updateStateSelect();
}


void HadronComponent::updateSoundSelect()
{
	HadronPlugin* const filter = getFilter();
	filter->getCallbackLock().enter();
	filter->doneUpdate(HadronPlugin::UPDATE_SOUNDSELECT);
	filter->getCallbackLock().exit();

	sourceWaveSelector1_.setText(filter->getSoundSelection(0));
	sourceWaveSelector2_.setText(filter->getSoundSelection(1));
	sourceWaveSelector3_.setText(filter->getSoundSelection(2));
	sourceWaveSelector4_.setText(filter->getSoundSelection(3));
}

void HadronComponent::updateStateSelect()
{
	HadronPlugin* const filter = getFilter();
	filter->getCallbackLock().enter();
	filter->doneUpdate(HadronPlugin::UPDATE_STATESELECT);
	filter->getCallbackLock().exit();

	presetSelector1_.setText(filter->getStateSelection(0));
	presetSelector2_.setText(filter->getStateSelection(1));
	presetSelector3_.setText(filter->getStateSelection(2));
	presetSelector4_.setText(filter->getStateSelection(3));
}


void HadronComponent::updateSampling()
{
	HadronPlugin* const filter = getFilter();
	filter->getCallbackLock().enter();
	filter->doneUpdate(HadronPlugin::UPDATE_SAMPLING);

	const bool samp_1 = filter->getSamplingState(0);
	const bool samp_2 = filter->getSamplingState(1);
	const bool samp_3 = filter->getSamplingState(2);
	const bool samp_4 = filter->getSamplingState(3);

	filter->getCallbackLock().exit();

	recButton1_.setToggleState(samp_1, NotificationType::dontSendNotification);
	recButton2_.setToggleState(samp_2, NotificationType::dontSendNotification);
	recButton3_.setToggleState(samp_3, NotificationType::dontSendNotification);
	recButton4_.setToggleState(samp_4, NotificationType::dontSendNotification);
}


void HadronComponent::updateParameters()
{
	HadronPlugin* const filter = getFilter();
	filter->getCallbackLock().enter();
	filter->doneUpdate(HadronPlugin::UPDATE_PARAMETERS);

	const double preset_x = filter->getParameter(Hadron::PRESET_X);
	const double preset_y = filter->getParameter(Hadron::PRESET_Y);

	const double ctrl_1 = filter->getParameter(Hadron::EXPR_1);
	const double ctrl_2 = filter->getParameter(Hadron::EXPR_2);
	const double ctrl_3 = filter->getParameter(Hadron::EXPR_3);
	const double ctrl_4 = filter->getParameter(Hadron::EXPR_4);

	const double master_volume = filter->getParameterDenormalized(Hadron::VOLUME);

	filter->getCallbackLock().exit();

	pad_.setValues(preset_x, preset_y, false);

	exprSlider1_.setValue(ctrl_1, dontSendNotification);
	exprSlider2_.setValue(ctrl_2, dontSendNotification);
	exprSlider3_.setValue(ctrl_3, dontSendNotification);
	exprSlider4_.setValue(ctrl_4, dontSendNotification);

	exprLabel1_.setText(exprSlider1_.getTextFromValue(ctrl_1), dontSendNotification);
	exprLabel2_.setText(exprSlider2_.getTextFromValue(ctrl_2), dontSendNotification);
	exprLabel3_.setText(exprSlider3_.getTextFromValue(ctrl_3), dontSendNotification);
	exprLabel4_.setText(exprSlider4_.getTextFromValue(ctrl_4), dontSendNotification);

	volumeKnob_.setValue(master_volume, dontSendNotification);
	volumeLabel_.setText(volumeKnob_.getTextFromValue(master_volume) + String(" dB"), dontSendNotification);
}

void HadronComponent::setLoadingState(bool is_loading)
{
	loadingScreen_.setEnabled(is_loading);
	loadingScreen_.setVisible(is_loading);
	this->setEnabled(!is_loading);
	writeToLog(is_loading ? "Hadron is loading" : "Hadron is enabled");
}
