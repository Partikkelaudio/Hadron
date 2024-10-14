
#ifndef __JUCER_HEADER_HADRONCOMPONENT_HADRONCOMPONENT_CF055F79__
#define __JUCER_HEADER_HADRONCOMPONENT_HADRONCOMPONENT_CF055F79__

#include "JuceHeader.h"

#include "HadronPad.h"
#include "HadronMeter.h"
#include "HadronComboBox.h"
#include "HadronLabel.h"

class HadronPlugin;



/*************************************
**   HadronComponent
**************************************/

class HadronComponent : public AudioProcessorEditor,
	public ChangeListener,
	public Slider::Listener,
	public ComboBox::Listener,
	public Button::Listener,
	public Label::Listener,
	public Timer
{
public:
	//==============================================================================
	HadronComponent(HadronPlugin* const ownerFilter);
	~HadronComponent();

	void changeListenerCallback(ChangeBroadcaster* source);

	void timerCallback();
	void paint(Graphics& g);
	void resized();
	void sliderValueChanged(Slider* sliderThatWasMoved);
	void labelTextChanged(Label* labelThatWasChanged);
	void comboBoxChanged(ComboBox* comboBoxThatHasChanged);
	void buttonClicked(Button* buttonThatWasClicked);

	//==============================================================================

	juce_UseDebuggingNewOperator

private:
	//[UserVariables]   -- You can add your own custom variables in this section.
	HadronPlugin* getFilter() const throw() { return (HadronPlugin*)getAudioProcessor(); }

	void createVolumeKnob(Slider *slider, Label* label, const Font& font, int focusOrder);
	void createSelector(ComboBox* combo, int focusOrder);
	void createRecordButton(DrawableButton* button);
	void createExpressionSlider(Slider *slider, Label* label, const Font& font, int focusOrder);

	void updateFromFilter();
	void updateSoundList();
	void updateStateList();
	void updateSoundSelect();
	void updateStateSelect();
	void updateSampling();
	void updateParameters();

	void setLoadingState(bool is_loading);
	void writeToLog(String log_text);
	//[/UserVariables]

	//==============================================================================
	Slider      volumeKnob_;
	HadronLabel volumeLabel_;

	Slider exprSlider1_;
	Slider exprSlider2_;
	Slider exprSlider3_;
	Slider exprSlider4_;

	HadronLabel exprLabel1_;
	HadronLabel exprLabel2_;
	HadronLabel exprLabel3_;
	HadronLabel exprLabel4_;

	HadronComboBox presetSelector1_;
	HadronComboBox presetSelector2_;
	HadronComboBox presetSelector3_;
	HadronComboBox presetSelector4_;

	ComboBox sourceWaveSelector1_;
	ComboBox sourceWaveSelector2_;
	ComboBox sourceWaveSelector3_;
	ComboBox sourceWaveSelector4_;

	HadronMeter sourceWaveIndicator1_;
	HadronMeter sourceWaveIndicator2_;
	HadronMeter sourceWaveIndicator3_;
	HadronMeter sourceWaveIndicator4_;
	HadronMeter trainletIndicator_;

	HadronLabel trainletLabel_;

	DrawableButton recButton1_;
	DrawableButton recButton2_;
	DrawableButton recButton3_;
	DrawableButton recButton4_;

	HadronPad pad_;

	Image cachedImage_Background;
	Image cachedImage_Loading;

	ImageComponent loadingScreen_;

	String          docPath_;
	HyperlinkButton docLink_;
	DrawableButton  docLinkBtn_;

	//==============================================================================
	// (prevent copy constructor and operator= being generated..)
	HadronComponent(const HadronComponent&);
	const HadronComponent& operator= (const HadronComponent&);
};


#endif   // __JUCER_HEADER_HADRONCOMPONENT_HADRONCOMPONENT_CF055F79__
