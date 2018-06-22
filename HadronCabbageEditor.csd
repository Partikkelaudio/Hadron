<Cabbage>
form size(1700, 975), caption("Hadron"), pluginID("hadr"), guirefresh(100)

image bounds(0,0, 1700, 975), file(""), colour("black")
image bounds(220,690, 495, 269), file("Background 495 x 269.png"), shape("round")

rslider channel("MasterLevel"), bounds(224, 713, 50, 50), range(-96, 6, -5, 3.3), trackercolour(20,101,151)
hslider channel("displayAmpWave1"), bounds(244, 785, 112, 5), range(0.0, 1.0, 0), colour(152,160,164), trackercolour(163,176,255), trackerthickness(1), gradient(0), svgfile("slider", "testslider.svg")
hslider channel("displayAmpWave2"), bounds(244, 807, 112, 5), range(0.0, 1.0, 0), colour(152,160,164), trackercolour(163,176,255), trackerthickness(1), gradient(0), svgfile("slider", "testslider.svg")
hslider channel("displayAmpWave3"), bounds(244, 829, 112, 5), range(0.0, 1.0, 0), colour(152,160,164), trackercolour(163,176,255), trackerthickness(1), gradient(0), svgfile("slider", "testslider.svg")
hslider channel("displayAmpWave4"), bounds(244, 851, 112, 5), range(0.0, 1.0, 0), colour(152,160,164), trackercolour(163,176,255), trackerthickness(1), gradient(0), svgfile("slider", "testslider.svg")
hslider channel("displayAmpWave5"), bounds(244, 873, 112, 3), range(0.0, 1.0, 0), colour(152,160,164), trackercolour(163,176,255), trackerthickness(1), gradient(0), svgfile("slider", "testslider.svg")
combobox bounds(244, 788, 112, 16), channel("source1"), value(0), channeltype("string"), identchannel("source1_id")
combobox bounds(244, 810, 112, 16), channel("source2"), value(0), channeltype("string"), identchannel("source2_id")
combobox bounds(244, 832, 112, 16), channel("source3"), value(0), channeltype("string"), identchannel("source3_id")
combobox bounds(244, 854, 112, 16), channel("source4"), value(0), channeltype("string"), identchannel("source4_id")


;gentable bounds(240,  785, 120, 80), identchannel("source_amps"), tablenumber(1), tablecolour("lightblue"), tablegridcolour(0,0,0,0), amprange(-.03,1,1), zoom(-1), samplerange(0,5), rotate(1.5, 60, 40)

button bounds(228, 789, 14, 14), channel("rec1"), text("", ""), value(0), colour:0("black"), colour:1("red"), shape("round"), latched(1)
button bounds(228, 811, 14, 14), channel("rec2"), text("", ""), value(0), colour:0("black"), colour:1("red"), shape("round"), latched(1)
button bounds(228, 833, 14, 14), channel("rec3"), text("", ""), value(0), colour:0("black"), colour:1("red"), shape("round"), latched(1)
button bounds(228, 855, 14, 14), channel("rec4"), text("", ""), value(0), colour:0("black"), colour:1("red"), shape("round"), latched(1)

xypad bounds(357, 714, 221, 221), channel("presetX", "presetY"), rangex(0, 1.0, 0), rangey(0, 1.0, 0)
combobox bounds(357, 696, 109, 15), channel("state1"), value(0), populate("*.spst", "./states"), channeltype("string"), identchannel("state1_id")
combobox bounds(468, 696, 109, 15), channel("state2"), value(0), populate("*.spst", "./states"), channeltype("string"), identchannel("state2_id")
combobox bounds(357, 937, 109, 15), channel("state3"), value(0), populate("*.spst", "./states/"), channeltype("string"), identchannel("state3_id")
combobox bounds(468, 937, 109, 15), channel("state4"), value(0),  populate("*.spst", "/states"), channeltype("string"), identchannel("state4_id")

vslider channel("ctrl1"), bounds(576, 733, 38, 201), range(0.0, 1.0, 0), colour(152,160,164), trackercolour(242,1,131), textbox(1)
vslider channel("ctrl2"), bounds(609, 733, 38, 201), range(0.0, 1.0, 0), colour(152,160,164), trackercolour(255,42,0), textbox(1)
vslider channel("ctrl3"), bounds(642, 733, 38, 201), range(0.0, 1.0, 0), colour(152,160,164), trackercolour(251,141,0), textbox(1)
vslider channel("ctrl4"), bounds(675, 733, 38, 201), range(0.0, 1.0, 0), colour(152,160,164), trackercolour(36,199,0), textbox(1)

infobutton bounds(227, 938, 14, 14), channel("help"), text("?"), file("./docs/index.html")

; for file saving
label text("Save state as..."), bounds(10, 900, 200, 10)
texteditor bounds(10, 920, 200, 15), channel("stateName"), text("")
button bounds(10, 940, 60, 14), channel("save"), text("save", "save"), value(0), colour:0("black"), colour:1("red"), shape("round"), latched(0)
;button bounds(80, 940, 100, 14), channel("reloadstates"), text("reload states", "reload states"), value(0), colour:0("black"), colour:1("red"), shape("round"), latched(0)

; table editor
label text("Table edit"), bounds(760, 712, 100, 10), align("left")
infobutton bounds(760, 725, 30, 15), channel("tablehelp"), text("?"), colour("blue"), fontcolour("white"), file("./tablehelp.txt");, identchannel("chan"), alpha(val), visible(val), rotate(radians, pivotx, pivoty), widgetarray("chan", number)
texteditor bounds(790, 725, 435, 15), channel("ftablecommand"), text("")
button bounds(1230, 725, 30, 15), channel("ftableupdate"), text("!", "!"), latched(0)
gentable bounds(760, 750, 500, 210), tablenumber(194, 193, 192, 191), tablecolour("red", "blue", "green", "yellow"), amprange(-1, 1, -1, 0.1), identchannel("functabs")

; masks
label text("Mask file import/export..."), bounds(1070, 630, 160, 10), , align("left")
combobox bounds(1070, 640, 130, 15), channel("maskfunc"), value(0),  channeltype("string"), items("gainmasks", "channelmasks", "wavemasks", "freqstartmasks", "freqendmasks", "fmampmasks")
combobox bounds(1203, 640, 50, 15), channel("maskAB"), value(0),  channeltype("string"), items("A", "B")
texteditor bounds(1070, 660, 183, 15), channel("maskfilename"), text("")
button bounds(1070, 680, 60, 14), channel("importmask"), text("import", "import"), value(0), colour:0("black"), colour:1("red"), shape("round"), latched(0)
button bounds(1140, 680, 60, 14), channel("exportmask"), text("export", "export"), value(0), colour:0("black"), colour:1("red"), shape("round"), latched(0)

; modmatrix editor
label text("Modmatrix edit"), bounds(640, 575, 100, 10), align("left")
infobutton bounds(740, 570, 30, 15), channel("matrixhelp"), text("?"), colour("blue"), fontcolour("white"), file("./modmatrixhelp.txt");, identchannel("chan"), alpha(val), visible(val), rotate(radians, pivotx, pivoty), widgetarray("chan", number)
texteditor bounds(640, 590, 410, 20), channel("modmatrixcommand"), text("")

csoundoutput bounds(1270, 830, 420, 150)

;**********
;editor
button bounds(0, 0, 60, 14), channel("editmode"), text("editor", "editor"), value(0), colour:0("black"), colour:1("green"), shape("round"), latched(1)

;********************
; paste python generated gui here


label text("Partikkel1Samplepos1"), bounds(10, 20, 200, 10)
hslider channel("Partikkel1Samplepos1"), bounds(10, 30, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Partikkel1Samplepos2"), bounds(10, 45, 200, 10)
hslider channel("Partikkel1Samplepos2"), bounds(10, 55, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Partikkel1Samplepos3"), bounds(10, 70, 200, 10)
hslider channel("Partikkel1Samplepos3"), bounds(10, 80, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Partikkel1Samplepos4"), bounds(10, 95, 200, 10)
hslider channel("Partikkel1Samplepos4"), bounds(10, 105, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Partikkel1Amp"), bounds(10, 120, 200, 10)
hslider channel("Partikkel1Amp"), bounds(10, 130, 200, 12), range(0.0, 3.0, 0, 1.0), textbox(1)
label text("Partikkel1SyncGravity"), bounds(10, 145, 200, 10)
hslider channel("Partikkel1SyncGravity"), bounds(10, 155, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Partikkel1GrainRate"), bounds(10, 170, 200, 10)
hslider channel("Partikkel1GrainRate"), bounds(10, 180, 200, 12), range(0.0, 2000.0, 0, 0.35), textbox(1)
label text("Partikkel1GrFmFreq"), bounds(10, 195, 200, 10)
hslider channel("Partikkel1GrFmFreq"), bounds(10, 205, 200, 12), range(0.0, 2000.0, 0, 0.35), textbox(1)
label text("Partikkel1GrFmIndex"), bounds(10, 220, 200, 10)
hslider channel("Partikkel1GrFmIndex"), bounds(10, 230, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Partikkel1Distribution"), bounds(10, 245, 200, 10)
hslider channel("Partikkel1Distribution"), bounds(10, 255, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Partikkel1GrainDur"), bounds(10, 270, 200, 10)
hslider channel("Partikkel1GrainDur"), bounds(10, 280, 200, 12), range(0.0, 9.0, 0, 0.35), textbox(1)
label text("Partikkel1Sustain"), bounds(10, 295, 200, 10)
hslider channel("Partikkel1Sustain"), bounds(10, 305, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Partikkel1AdRatio"), bounds(10, 320, 200, 10)
hslider channel("Partikkel1AdRatio"), bounds(10, 330, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Partikkel1Env2Amt"), bounds(10, 345, 200, 10)
hslider channel("Partikkel1Env2Amt"), bounds(10, 355, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Partikkel1GrainPitch"), bounds(10, 370, 200, 10)
hslider channel("Partikkel1GrainPitch"), bounds(10, 380, 200, 12), range(0.0, 3.0, 0, 1.0), textbox(1)
label text("Partikkel1GrainPitch1"), bounds(10, 395, 200, 10)
hslider channel("Partikkel1GrainPitch1"), bounds(10, 405, 200, 12), range(-500.0, 500.0, 0, 1.0), textbox(1)
label text("Partikkel1GrainPitch2"), bounds(10, 420, 200, 10)
hslider channel("Partikkel1GrainPitch2"), bounds(10, 430, 200, 12), range(-500.0, 500.0, 0, 1.0), textbox(1)
label text("Partikkel1GrainPitch3"), bounds(10, 445, 200, 10)
hslider channel("Partikkel1GrainPitch3"), bounds(10, 455, 200, 12), range(-500.0, 500.0, 0, 1.0), textbox(1)
label text("Partikkel1GrainPitch4"), bounds(10, 470, 200, 10)
hslider channel("Partikkel1GrainPitch4"), bounds(10, 480, 200, 12), range(-500.0, 500.0, 0, 1.0), textbox(1)
label text("Partikkel1Sweepshape"), bounds(10, 495, 200, 10)
hslider channel("Partikkel1Sweepshape"), bounds(10, 505, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Partikkel1PitchFmFreq"), bounds(10, 520, 200, 10)
hslider channel("Partikkel1PitchFmFreq"), bounds(10, 530, 200, 12), range(0.0, 2000.0, 0, 0.35), textbox(1)
label text("Partikkel1PitchFmIndex"), bounds(10, 545, 200, 10)
hslider channel("Partikkel1PitchFmIndex"), bounds(10, 555, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Partikkel1TrainCps"), bounds(10, 570, 200, 10)
hslider channel("Partikkel1TrainCps"), bounds(10, 580, 200, 12), range(0.0, 1000.0, 0, 0.35), textbox(1)
label text("Partikkel1TrainPartials"), bounds(10, 595, 200, 10)
hslider channel("Partikkel1TrainPartials"), bounds(10, 605, 200, 12), range(0.0, 20.0, 0, 1.0), textbox(1)
label text("Partikkel1TrainChroma"), bounds(10, 620, 200, 10)
hslider channel("Partikkel1TrainChroma"), bounds(10, 630, 200, 12), range(0.0, 4.0, 0, 1.0), textbox(1)
label text("Partikkel1RandomMask"), bounds(10, 645, 200, 10)
hslider channel("Partikkel1RandomMask"), bounds(10, 655, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Partikkel1WaveX"), bounds(10, 670, 200, 10)
hslider channel("Partikkel1WaveX"), bounds(10, 680, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Partikkel1WaveY"), bounds(10, 695, 200, 10)
hslider channel("Partikkel1WaveY"), bounds(10, 705, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Partikkel1TrainAmp"), bounds(10, 720, 200, 10)
hslider channel("Partikkel1TrainAmp"), bounds(10, 730, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("LiveFeedbackAmount"), bounds(10, 745, 200, 10)
hslider channel("LiveFeedbackAmount"), bounds(10, 755, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("DryStereoWidth"), bounds(220, 20, 200, 10)
hslider channel("DryStereoWidth"), bounds(220, 30, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass1RmFreq"), bounds(220, 45, 200, 10)
hslider channel("Bandpass1RmFreq"), bounds(220, 55, 200, 12), range(0.0, 14000.0, 0, 0.35), textbox(1)
label text("Bandpass1RmMix"), bounds(220, 70, 200, 10)
hslider channel("Bandpass1RmMix"), bounds(220, 80, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass1Freq"), bounds(220, 95, 200, 10)
hslider channel("Bandpass1Freq"), bounds(220, 105, 200, 12), range(0.0, 14000.0, 0, 0.35), textbox(1)
label text("Bandpass1BW"), bounds(220, 120, 200, 10)
hslider channel("Bandpass1BW"), bounds(220, 130, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass1Pan"), bounds(220, 145, 200, 10)
hslider channel("Bandpass1Pan"), bounds(220, 155, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass1Amp"), bounds(220, 170, 200, 10)
hslider channel("Bandpass1Amp"), bounds(220, 180, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass1Mix"), bounds(220, 195, 200, 10)
hslider channel("Bandpass1Mix"), bounds(220, 205, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass1_Send_Bandpass2"), bounds(220, 220, 200, 10)
hslider channel("Bandpass1_Send_Bandpass2"), bounds(220, 230, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass1_Send_Lowpass"), bounds(220, 245, 200, 10)
hslider channel("Bandpass1_Send_Lowpass"), bounds(220, 255, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass1_Send_Bandpass3"), bounds(220, 270, 200, 10)
hslider channel("Bandpass1_Send_Bandpass3"), bounds(220, 280, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass1_Send_DlyL"), bounds(220, 295, 200, 10)
hslider channel("Bandpass1_Send_DlyL"), bounds(220, 305, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass1_Send_DlyR"), bounds(220, 320, 200, 10)
hslider channel("Bandpass1_Send_DlyR"), bounds(220, 330, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass2Freq"), bounds(220, 345, 200, 10)
hslider channel("Bandpass2Freq"), bounds(220, 355, 200, 12), range(0.0, 14000.0, 0, 0.35), textbox(1)
label text("Bandpass2BW"), bounds(220, 370, 200, 10)
hslider channel("Bandpass2BW"), bounds(220, 380, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass2Pan"), bounds(220, 395, 200, 10)
hslider channel("Bandpass2Pan"), bounds(220, 405, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass2Amp"), bounds(220, 420, 200, 10)
hslider channel("Bandpass2Amp"), bounds(220, 430, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass2Mix"), bounds(220, 445, 200, 10)
hslider channel("Bandpass2Mix"), bounds(220, 455, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass2_Send_Lowpass"), bounds(220, 470, 200, 10)
hslider channel("Bandpass2_Send_Lowpass"), bounds(220, 480, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass2_Send_Bandpass3"), bounds(220, 495, 200, 10)
hslider channel("Bandpass2_Send_Bandpass3"), bounds(220, 505, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass2_Send_DlyL"), bounds(220, 520, 200, 10)
hslider channel("Bandpass2_Send_DlyL"), bounds(220, 530, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass2_Send_DlyR"), bounds(220, 545, 200, 10)
hslider channel("Bandpass2_Send_DlyR"), bounds(220, 555, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("LowpassFreq"), bounds(430, 20, 200, 10)
hslider channel("LowpassFreq"), bounds(430, 30, 200, 12), range(0.0, 14000.0, 0, 0.35), textbox(1)
label text("LowpassRes"), bounds(430, 45, 200, 10)
hslider channel("LowpassRes"), bounds(430, 55, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("LowpassDist"), bounds(430, 70, 200, 10)
hslider channel("LowpassDist"), bounds(430, 80, 200, 12), range(0.0, 5.0, 0, 1.0), textbox(1)
label text("LowpassPan"), bounds(430, 95, 200, 10)
hslider channel("LowpassPan"), bounds(430, 105, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("LowpassAmp"), bounds(430, 120, 200, 10)
hslider channel("LowpassAmp"), bounds(430, 130, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("LowpassMix"), bounds(430, 145, 200, 10)
hslider channel("LowpassMix"), bounds(430, 155, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Lowpass_Send_BP3"), bounds(430, 170, 200, 10)
hslider channel("Lowpass_Send_BP3"), bounds(430, 180, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Lowpass_Send_DlyL"), bounds(430, 195, 200, 10)
hslider channel("Lowpass_Send_DlyL"), bounds(430, 205, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Lowpass_Send_DlyR"), bounds(430, 220, 200, 10)
hslider channel("Lowpass_Send_DlyR"), bounds(430, 230, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass3Freq"), bounds(430, 245, 200, 10)
hslider channel("Bandpass3Freq"), bounds(430, 255, 200, 12), range(0.0, 14000.0, 0, 0.35), textbox(1)
label text("Bandpass3BW"), bounds(430, 270, 200, 10)
hslider channel("Bandpass3BW"), bounds(430, 280, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass3Pan"), bounds(430, 295, 200, 10)
hslider channel("Bandpass3Pan"), bounds(430, 305, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass3Amp"), bounds(430, 320, 200, 10)
hslider channel("Bandpass3Amp"), bounds(430, 330, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass3Mix"), bounds(430, 345, 200, 10)
hslider channel("Bandpass3Mix"), bounds(430, 355, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass3_Send_DlyL"), bounds(430, 370, 200, 10)
hslider channel("Bandpass3_Send_DlyL"), bounds(430, 380, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Bandpass3_Send_DlyR"), bounds(430, 395, 200, 10)
hslider channel("Bandpass3_Send_DlyR"), bounds(430, 405, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("DelayTimeLeft"), bounds(430, 420, 200, 10)
hslider channel("DelayTimeLeft"), bounds(430, 430, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("DelayTimeRight"), bounds(430, 445, 200, 10)
hslider channel("DelayTimeRight"), bounds(430, 455, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("DelayFeedbackLeft"), bounds(430, 470, 200, 10)
hslider channel("DelayFeedbackLeft"), bounds(430, 480, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("DelayFeedbackRight"), bounds(430, 495, 200, 10)
hslider channel("DelayFeedbackRight"), bounds(430, 505, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("DelayXFeedback"), bounds(430, 520, 200, 10)
hslider channel("DelayXFeedback"), bounds(430, 530, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("DelayHpFreq"), bounds(430, 545, 200, 10)
hslider channel("DelayHpFreq"), bounds(430, 555, 200, 12), range(0.0, 14000.0, 0, 0.35), textbox(1)
label text("DelayLpFreq"), bounds(430, 570, 200, 10)
hslider channel("DelayLpFreq"), bounds(430, 580, 200, 12), range(0.0, 14000.0, 0, 0.35), textbox(1)
label text("DelayStereoWidth"), bounds(430, 595, 200, 10)
hslider channel("DelayStereoWidth"), bounds(430, 605, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("DelayAmp"), bounds(430, 620, 200, 10)
hslider channel("DelayAmp"), bounds(430, 630, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("DelayMix"), bounds(430, 645, 200, 10)
hslider channel("DelayMix"), bounds(430, 655, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("LFO1_Amp"), bounds(640, 20, 200, 10)
hslider channel("LFO1_Amp"), bounds(640, 30, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("LFO1_Freq"), bounds(640, 45, 200, 10)
hslider channel("LFO1_Freq"), bounds(640, 55, 200, 12), range(0.0, 100.0, 0, 0.35), textbox(1)
label text("LFO1_Waveform"), bounds(640, 70, 200, 10)
hslider channel("LFO1_Waveform"), bounds(640, 80, 200, 12), range(0.0, 10.0, 0, 1.0), textbox(1)
label text("LFO1_Phase"), bounds(640, 95, 200, 10)
hslider channel("LFO1_Phase"), bounds(640, 105, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("LFO1_Global"), bounds(640, 120, 200, 10)
hslider channel("LFO1_Global"), bounds(640, 130, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("LFO2_Amp"), bounds(640, 145, 200, 10)
hslider channel("LFO2_Amp"), bounds(640, 155, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("LFO2_Freq"), bounds(640, 170, 200, 10)
hslider channel("LFO2_Freq"), bounds(640, 180, 200, 12), range(0.0, 100.0, 0, 0.35), textbox(1)
label text("LFO2_Waveform"), bounds(640, 195, 200, 10)
hslider channel("LFO2_Waveform"), bounds(640, 205, 200, 12), range(0.0, 10.0, 0, 1.0), textbox(1)
label text("LFO2_Phase"), bounds(640, 220, 200, 10)
hslider channel("LFO2_Phase"), bounds(640, 230, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("LFO2_Global"), bounds(640, 245, 200, 10)
hslider channel("LFO2_Global"), bounds(640, 255, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("LFO3_Amp"), bounds(640, 270, 200, 10)
hslider channel("LFO3_Amp"), bounds(640, 280, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("LFO3_Freq"), bounds(640, 295, 200, 10)
hslider channel("LFO3_Freq"), bounds(640, 305, 200, 12), range(0.0, 100.0, 0, 0.35), textbox(1)
label text("LFO3_Waveform"), bounds(640, 320, 200, 10)
hslider channel("LFO3_Waveform"), bounds(640, 330, 200, 12), range(0.0, 10.0, 0, 1.0), textbox(1)
label text("LFO3_Phase"), bounds(640, 345, 200, 10)
hslider channel("LFO3_Phase"), bounds(640, 355, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("LFO3_Global"), bounds(640, 370, 200, 10)
hslider channel("LFO3_Global"), bounds(640, 380, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("LFO4_Amp"), bounds(640, 395, 200, 10)
hslider channel("LFO4_Amp"), bounds(640, 405, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("LFO4_Freq"), bounds(640, 420, 200, 10)
hslider channel("LFO4_Freq"), bounds(640, 430, 200, 12), range(0.0, 100.0, 0, 0.35), textbox(1)
label text("LFO4_Waveform"), bounds(640, 445, 200, 10)
hslider channel("LFO4_Waveform"), bounds(640, 455, 200, 12), range(0.0, 10.0, 0, 1.0), textbox(1)
label text("LFO4_Phase"), bounds(640, 470, 200, 10)
hslider channel("LFO4_Phase"), bounds(640, 480, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("LFO4_Global"), bounds(640, 495, 200, 10)
hslider channel("LFO4_Global"), bounds(640, 505, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Randh1_Amp"), bounds(850, 20, 200, 10)
hslider channel("Randh1_Amp"), bounds(850, 30, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Randh1_Freq"), bounds(850, 45, 200, 10)
hslider channel("Randh1_Freq"), bounds(850, 55, 200, 12), range(0.0, 100.0, 0, 0.35), textbox(1)
label text("Randh1_Retrig"), bounds(850, 70, 200, 10)
hslider channel("Randh1_Retrig"), bounds(850, 80, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Randh2_Amp"), bounds(850, 95, 200, 10)
hslider channel("Randh2_Amp"), bounds(850, 105, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Randh2_Freq"), bounds(850, 120, 200, 10)
hslider channel("Randh2_Freq"), bounds(850, 130, 200, 12), range(0.0, 100.0, 0, 0.35), textbox(1)
label text("Randh2_Retrig"), bounds(850, 145, 200, 10)
hslider channel("Randh2_Retrig"), bounds(850, 155, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Rspline1_Amp"), bounds(850, 170, 200, 10)
hslider channel("Rspline1_Amp"), bounds(850, 180, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Rspline1_MinFreq"), bounds(850, 195, 200, 10)
hslider channel("Rspline1_MinFreq"), bounds(850, 205, 200, 12), range(0.0, 100.0, 0, 0.35), textbox(1)
label text("Rspline1_MaxFreq"), bounds(850, 220, 200, 10)
hslider channel("Rspline1_MaxFreq"), bounds(850, 230, 200, 12), range(0.0, 100.0, 0, 0.35), textbox(1)
label text("Rspline2_Amp"), bounds(850, 245, 200, 10)
hslider channel("Rspline2_Amp"), bounds(850, 255, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Rspline2_MinFreq"), bounds(850, 270, 200, 10)
hslider channel("Rspline2_MinFreq"), bounds(850, 280, 200, 12), range(0.0, 100.0, 0, 0.35), textbox(1)
label text("Rspline2_MaxFreq"), bounds(850, 295, 200, 10)
hslider channel("Rspline2_MaxFreq"), bounds(850, 305, 200, 12), range(0.0, 100.0, 0, 0.35), textbox(1)
label text("Divider1Input"), bounds(850, 320, 200, 10)
hslider channel("Divider1Input"), bounds(850, 330, 200, 12), range(0.0, 100.0, 0, 1.0), textbox(1)
label text("Divider2Input"), bounds(850, 345, 200, 10)
hslider channel("Divider2Input"), bounds(850, 355, 200, 12), range(0.0, 100.0, 0, 1.0), textbox(1)
label text("Divider3Input"), bounds(850, 370, 200, 10)
hslider channel("Divider3Input"), bounds(850, 380, 200, 12), range(0.0, 100.0, 0, 1.0), textbox(1)
label text("Divider4Input"), bounds(850, 395, 200, 10)
hslider channel("Divider4Input"), bounds(850, 405, 200, 12), range(0.0, 100.0, 0, 1.0), textbox(1)
label text("Modulo1Input"), bounds(850, 420, 200, 10)
hslider channel("Modulo1Input"), bounds(850, 430, 200, 12), range(0.0, 100.0, 0, 1.0), textbox(1)
label text("Modulo1Value"), bounds(850, 445, 200, 10)
hslider channel("Modulo1Value"), bounds(850, 455, 200, 12), range(0.0, 100.0, 0, 1.0), textbox(1)
label text("Multiplier1Input1"), bounds(850, 470, 200, 10)
hslider channel("Multiplier1Input1"), bounds(850, 480, 200, 12), range(0.0, 100.0, 0, 1.0), textbox(1)
label text("Multiplier1Input2"), bounds(850, 495, 200, 10)
hslider channel("Multiplier1Input2"), bounds(850, 505, 200, 12), range(0.0, 100.0, 0, 1.0), textbox(1)
label text("Multiplier2Input1"), bounds(850, 520, 200, 10)
hslider channel("Multiplier2Input1"), bounds(850, 530, 200, 12), range(0.0, 100.0, 0, 1.0), textbox(1)
label text("Multiplier2Input2"), bounds(850, 545, 200, 10)
hslider channel("Multiplier2Input2"), bounds(850, 555, 200, 12), range(0.0, 100.0, 0, 1.0), textbox(1)
label text("Func1Input"), bounds(1060, 20, 200, 10)
hslider channel("Func1Input"), bounds(1060, 30, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Func2Input"), bounds(1060, 45, 200, 10)
hslider channel("Func2Input"), bounds(1060, 55, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Func3Input"), bounds(1060, 70, 200, 10)
hslider channel("Func3Input"), bounds(1060, 80, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Func4Input"), bounds(1060, 95, 200, 10)
hslider channel("Func4Input"), bounds(1060, 105, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("TransientAttack1"), bounds(1060, 120, 200, 10)
hslider channel("TransientAttack1"), bounds(1060, 130, 200, 12), range(0.0, 0.3, 0, 0.35), textbox(1)
label text("TransientRelease1"), bounds(1060, 145, 200, 10)
hslider channel("TransientRelease1"), bounds(1060, 155, 200, 12), range(0.0, 0.3, 0, 0.35), textbox(1)
label text("TransientAttack2"), bounds(1060, 170, 200, 10)
hslider channel("TransientAttack2"), bounds(1060, 180, 200, 12), range(0.0, 0.3, 0, 0.35), textbox(1)
label text("TransientRelease2"), bounds(1060, 195, 200, 10)
hslider channel("TransientRelease2"), bounds(1060, 205, 200, 12), range(0.0, 0.3, 0, 0.35), textbox(1)
label text("TransientAttack3"), bounds(1060, 220, 200, 10)
hslider channel("TransientAttack3"), bounds(1060, 230, 200, 12), range(0.0, 0.3, 0, 0.35), textbox(1)
label text("TransientRelease3"), bounds(1060, 245, 200, 10)
hslider channel("TransientRelease3"), bounds(1060, 255, 200, 12), range(0.0, 0.3, 0, 0.35), textbox(1)
label text("TransientAttack4"), bounds(1060, 270, 200, 10)
hslider channel("TransientAttack4"), bounds(1060, 280, 200, 12), range(0.0, 0.3, 0, 0.35), textbox(1)
label text("TransientRelease4"), bounds(1060, 295, 200, 10)
hslider channel("TransientRelease4"), bounds(1060, 305, 200, 12), range(0.0, 0.3, 0, 0.35), textbox(1)
label text("Portamento_Allnotes"), bounds(1060, 320, 200, 10)
hslider channel("Portamento_Allnotes"), bounds(1060, 330, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("PortamentoCps"), bounds(1060, 345, 200, 10)
hslider channel("PortamentoCps"), bounds(1060, 355, 200, 12), range(0.0, 2.0, 0, 0.35), textbox(1)
label text("PortamentoNote"), bounds(1060, 370, 200, 10)
hslider channel("PortamentoNote"), bounds(1060, 380, 200, 12), range(0.0, 2.0, 0, 0.35), textbox(1)
label text("PortamentoInterval"), bounds(1060, 395, 200, 10)
hslider channel("PortamentoInterval"), bounds(1060, 405, 200, 12), range(0.0, 2.0, 0, 0.35), textbox(1)
label text("MidiNoteOffset"), bounds(1060, 420, 200, 10)
hslider channel("MidiNoteOffset"), bounds(1060, 430, 200, 12), range(0.0, 90.0, 0, 1.0), textbox(1)
label text("AnalysisTimeOffset"), bounds(1060, 445, 200, 10)
hslider channel("AnalysisTimeOffset"), bounds(1060, 455, 200, 12), range(0.0, 1.0, 0, 0.35), textbox(1)
label text("gainmasks1Morf"), bounds(1060, 470, 200, 10)
hslider channel("gainmasks1Morf"), bounds(1060, 480, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("channelmasks1Morf"), bounds(1060, 495, 200, 10)
hslider channel("channelmasks1Morf"), bounds(1060, 505, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("wavemasks1Morf"), bounds(1060, 520, 200, 10)
hslider channel("wavemasks1Morf"), bounds(1060, 530, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("freqstartmasks1Morf"), bounds(1060, 545, 200, 10)
hslider channel("freqstartmasks1Morf"), bounds(1060, 555, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("freqendmasks1Morf"), bounds(1060, 570, 200, 10)
hslider channel("freqendmasks1Morf"), bounds(1060, 580, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("fmampmasks1Morf"), bounds(1060, 595, 200, 10)
hslider channel("fmampmasks1Morf"), bounds(1060, 605, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Envelope1_Amp"), bounds(1280, 20, 200, 10)
hslider channel("Envelope1_Amp"), bounds(1280, 30, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope1_Delay"), bounds(1280, 45, 200, 10)
hslider channel("Envelope1_Delay"), bounds(1280, 55, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope1_Attack"), bounds(1280, 70, 200, 10)
hslider channel("Envelope1_Attack"), bounds(1280, 80, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope1_Decay"), bounds(1280, 95, 200, 10)
hslider channel("Envelope1_Decay"), bounds(1280, 105, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope1_Sustain"), bounds(1280, 120, 200, 10)
hslider channel("Envelope1_Sustain"), bounds(1280, 130, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Envelope1_Release"), bounds(1280, 145, 200, 10)
hslider channel("Envelope1_Release"), bounds(1280, 155, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope1_Curve"), bounds(1280, 170, 200, 10)
hslider channel("Envelope1_Curve"), bounds(1280, 180, 200, 12), range(-5.0, 5.0, 0, 1.0), textbox(1)
label text("Envelope1_Retrig"), bounds(1280, 195, 200, 10)
hslider channel("Envelope1_Retrig"), bounds(1280, 205, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Envelope2_Amp"), bounds(1280, 220, 200, 10)
hslider channel("Envelope2_Amp"), bounds(1280, 230, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope2_Delay"), bounds(1280, 245, 200, 10)
hslider channel("Envelope2_Delay"), bounds(1280, 255, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope2_Attack"), bounds(1280, 270, 200, 10)
hslider channel("Envelope2_Attack"), bounds(1280, 280, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope2_Decay"), bounds(1280, 295, 200, 10)
hslider channel("Envelope2_Decay"), bounds(1280, 305, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope2_Sustain"), bounds(1280, 320, 200, 10)
hslider channel("Envelope2_Sustain"), bounds(1280, 330, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Envelope2_Release"), bounds(1280, 345, 200, 10)
hslider channel("Envelope2_Release"), bounds(1280, 355, 200, 12), range(0.0, 3.0, 0, 1.0), textbox(1)
label text("Envelope2_Curve"), bounds(1280, 370, 200, 10)
hslider channel("Envelope2_Curve"), bounds(1280, 380, 200, 12), range(-5.0, 5.0, 0, 1.0), textbox(1)
label text("Envelope2_Retrig"), bounds(1280, 395, 200, 10)
hslider channel("Envelope2_Retrig"), bounds(1280, 405, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Envelope3_Amp"), bounds(1280, 420, 200, 10)
hslider channel("Envelope3_Amp"), bounds(1280, 430, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope3_Delay"), bounds(1280, 445, 200, 10)
hslider channel("Envelope3_Delay"), bounds(1280, 455, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope3_Attack"), bounds(1280, 470, 200, 10)
hslider channel("Envelope3_Attack"), bounds(1280, 480, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope3_Decay"), bounds(1280, 495, 200, 10)
hslider channel("Envelope3_Decay"), bounds(1280, 505, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope3_Sustain"), bounds(1280, 520, 200, 10)
hslider channel("Envelope3_Sustain"), bounds(1280, 530, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Envelope3_Release"), bounds(1280, 545, 200, 10)
hslider channel("Envelope3_Release"), bounds(1280, 555, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope3_Curve"), bounds(1280, 570, 200, 10)
hslider channel("Envelope3_Curve"), bounds(1280, 580, 200, 12), range(-5.0, 5.0, 0, 1.0), textbox(1)
label text("Envelope3_Retrig"), bounds(1280, 595, 200, 10)
hslider channel("Envelope3_Retrig"), bounds(1280, 605, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Envelope4_Amp"), bounds(1280, 620, 200, 10)
hslider channel("Envelope4_Amp"), bounds(1280, 630, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope4_Delay"), bounds(1280, 645, 200, 10)
hslider channel("Envelope4_Delay"), bounds(1280, 655, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope4_Attack"), bounds(1280, 670, 200, 10)
hslider channel("Envelope4_Attack"), bounds(1280, 680, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope4_Decay"), bounds(1280, 695, 200, 10)
hslider channel("Envelope4_Decay"), bounds(1280, 705, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope4_Sustain"), bounds(1280, 720, 200, 10)
hslider channel("Envelope4_Sustain"), bounds(1280, 730, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Envelope4_Release"), bounds(1280, 745, 200, 10)
hslider channel("Envelope4_Release"), bounds(1280, 755, 200, 12), range(0.0, 2.0, 0, 1.0), textbox(1)
label text("Envelope4_Curve"), bounds(1280, 770, 200, 10)
hslider channel("Envelope4_Curve"), bounds(1280, 780, 200, 12), range(-5.0, 5.0, 0, 1.0), textbox(1)
label text("Envelope4_Retrig"), bounds(1280, 795, 200, 10)
hslider channel("Envelope4_Retrig"), bounds(1280, 805, 200, 12), range(0.0, 1.0, 0, 1.0), textbox(1)
label text("Partikkel1GrainRateBpmSync"), bounds(1515, 20, 180, 10), align("left")
checkbox bounds(1500, 20, 12, 12), channel("Partikkel1GrainRateBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Partikkel1GrFmFreqBpmSync"), bounds(1515, 45, 180, 10), align("left")
checkbox bounds(1500, 45, 12, 12), channel("Partikkel1GrFmFreqBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Partikkel1PitchFmFreqBpmSync"), bounds(1515, 70, 180, 10), align("left")
checkbox bounds(1500, 70, 12, 12), channel("Partikkel1PitchFmFreqBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Partikkel1GrainDelayTime1BpmSync"), bounds(1515, 95, 180, 10), align("left")
checkbox bounds(1500, 95, 12, 12), channel("Partikkel1GrainDelayTime1BpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Partikkel1GrainDelayTime2BpmSync"), bounds(1515, 120, 180, 10), align("left")
checkbox bounds(1500, 120, 12, 12), channel("Partikkel1GrainDelayTime2BpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Partikkel1GrainDelayTime3BpmSync"), bounds(1515, 145, 180, 10), align("left")
checkbox bounds(1500, 145, 12, 12), channel("Partikkel1GrainDelayTime3BpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Partikkel1GrainDelayTime4BpmSync"), bounds(1515, 170, 180, 10), align("left")
checkbox bounds(1500, 170, 12, 12), channel("Partikkel1GrainDelayTime4BpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Bandpass1RmFreqBpmSync"), bounds(1515, 195, 180, 10), align("left")
checkbox bounds(1500, 195, 12, 12), channel("Bandpass1RmFreqBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("DelayTimeBpmSync"), bounds(1515, 220, 180, 10), align("left")
checkbox bounds(1500, 220, 12, 12), channel("DelayTimeBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("LFO1_FreqBpmSync"), bounds(1515, 245, 180, 10), align("left")
checkbox bounds(1500, 245, 12, 12), channel("LFO1_FreqBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("LFO2_FreqBpmSync"), bounds(1515, 270, 180, 10), align("left")
checkbox bounds(1500, 270, 12, 12), channel("LFO2_FreqBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("LFO3_FreqBpmSync"), bounds(1515, 295, 180, 10), align("left")
checkbox bounds(1500, 295, 12, 12), channel("LFO3_FreqBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("LFO4_FreqBpmSync"), bounds(1515, 320, 180, 10), align("left")
checkbox bounds(1500, 320, 12, 12), channel("LFO4_FreqBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Envelope1_DelayBpmSync"), bounds(1515, 345, 180, 10), align("left")
checkbox bounds(1500, 345, 12, 12), channel("Envelope1_DelayBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Envelope1_AttackBpmSync"), bounds(1515, 370, 180, 10), align("left")
checkbox bounds(1500, 370, 12, 12), channel("Envelope1_AttackBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Envelope1_DecayBpmSync"), bounds(1515, 395, 180, 10), align("left")
checkbox bounds(1500, 395, 12, 12), channel("Envelope1_DecayBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Envelope1_ReleaseBpmSync"), bounds(1515, 420, 180, 10), align("left")
checkbox bounds(1500, 420, 12, 12), channel("Envelope1_ReleaseBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Envelope2_DelayBpmSync"), bounds(1515, 445, 180, 10), align("left")
checkbox bounds(1500, 445, 12, 12), channel("Envelope2_DelayBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Envelope2_AttackBpmSync"), bounds(1515, 470, 180, 10), align("left")
checkbox bounds(1500, 470, 12, 12), channel("Envelope2_AttackBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Envelope2_DecayBpmSync"), bounds(1515, 495, 180, 10), align("left")
checkbox bounds(1500, 495, 12, 12), channel("Envelope2_DecayBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Envelope2_ReleaseBpmSync"), bounds(1515, 520, 180, 10), align("left")
checkbox bounds(1500, 520, 12, 12), channel("Envelope2_ReleaseBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Envelope3_DelayBpmSync"), bounds(1515, 545, 180, 10), align("left")
checkbox bounds(1500, 545, 12, 12), channel("Envelope3_DelayBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Envelope3_AttackBpmSync"), bounds(1515, 570, 180, 10), align("left")
checkbox bounds(1500, 570, 12, 12), channel("Envelope3_AttackBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Envelope3_DecayBpmSync"), bounds(1515, 595, 180, 10), align("left")
checkbox bounds(1500, 595, 12, 12), channel("Envelope3_DecayBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Envelope3_ReleaseBpmSync"), bounds(1515, 620, 180, 10), align("left")
checkbox bounds(1500, 620, 12, 12), channel("Envelope3_ReleaseBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Envelope4_DelayBpmSync"), bounds(1515, 645, 180, 10), align("left")
checkbox bounds(1500, 645, 12, 12), channel("Envelope4_DelayBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Envelope4_AttackBpmSync"), bounds(1515, 670, 180, 10), align("left")
checkbox bounds(1500, 670, 12, 12), channel("Envelope4_AttackBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Envelope4_DecayBpmSync"), bounds(1515, 695, 180, 10), align("left")
checkbox bounds(1500, 695, 12, 12), channel("Envelope4_DecayBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Envelope4_ReleaseBpmSync"), bounds(1515, 720, 180, 10), align("left")
checkbox bounds(1500, 720, 12, 12), channel("Envelope4_ReleaseBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Randh1_FreqBpmSync"), bounds(1515, 745, 180, 10), align("left")
checkbox bounds(1500, 745, 12, 12), channel("Randh1_FreqBpmSync"), value(0), colour:0("black"), colour:1("red")
label text("Randh2_FreqBpmSync"), bounds(1515, 770, 180, 10), align("left")
checkbox bounds(1500, 770, 12, 12), channel("Randh2_FreqBpmSync"), value(0), colour:0("black"), colour:1("red")

; done paste pythongenerated
;***************************


</Cabbage>

<CsoundSynthesizer>
<CsOptions>
-n -+rtmidi=NULL -M0 -d

</CsOptions>
<CsInstruments>
        giSourceDisplays     ftgen   1, 0, 8, -2, 0 

#include "Hadron.orc"   

chnset 1, "CabbageMode"

instr 3
; GUI event control
Ssource1 chnget "source1"
Ssource2 chnget "source2"
Ssource3 chnget "source3"
Ssource4 chnget "source4"
kchangedsource1 changed Ssource1
kchangedsource2 changed Ssource2
kchangedsource3 changed Ssource3
kchangedsource4 changed Ssource4
puts Ssource1, kchangedsource1+1
if kchangedsource1==1 then
Scoreline sprintfk {{i 20 0 1 1 1 "%s"}}, Ssource1
scoreline Scoreline, 1
endif
if kchangedsource2==1 then
Scoreline sprintfk {{i 20 0 1 1 2 "%s"}}, Ssource2
scoreline Scoreline, 1
endif
if kchangedsource3==1 then
Scoreline sprintfk {{i 20 0 1 1 3 "%s"}}, Ssource3
scoreline Scoreline, 1
endif
if kchangedsource4==1 then
Scoreline sprintfk {{i 20 0 1 1 4 "%s"}}, Ssource4
scoreline Scoreline, 1
endif


Sstate1 chnget "state1"
Sstate2 chnget "state2"
Sstate3 chnget "state3"
Sstate4 chnget "state4"
kchangedstate1 changed Sstate1
kchangedstate2 changed Sstate2
kchangedstate3 changed Sstate3
kchangedstate4 changed Sstate4

keditmode chnget "editmode"
keditmode_on trigger keditmode, 0.5, 0
keditmode_off trigger keditmode, 0.5, 1

if kchangedstate1==1 then
Scoreline sprintfk {{i 72 0 1 "%s" 2}}, Sstate1
scoreline Scoreline, 1
endif
if kchangedstate2==1 then
Scoreline sprintfk {{i 72 0 1 "%s" 3}}, Sstate2
scoreline Scoreline, 1
endif
if kchangedstate3==1 then
if keditmode == 1 then
event "i", 74, 0, .5
Scoreline sprintfk {{i 72 0.2 1 "%s" 0}}, Sstate3
scoreline Scoreline, 1
event "i", 76, 0.6, 1
else
Scoreline sprintfk {{i 72 0 1 "%s" 0}}, Sstate3
scoreline Scoreline, 1
endif
endif
if kchangedstate4==1 then
Scoreline sprintfk {{i 72 0 1 "%s" 1}}, Sstate4
scoreline Scoreline, 1
endif

if keditmode_on == 1 then
event "i", -74, 0, 1
endif
if keditmode_off == 1 then
event "i", 74, 0, -1
endif

krec1 chnget "rec1"
krec2 chnget "rec2"
krec3 chnget "rec3"
krec4 chnget "rec4"
kchangedrec1 changed krec1
kchangedrec2 changed krec2
kchangedrec3 changed krec3
kchangedrec4 changed krec4

if kchangedrec1==1 then
if krec1 == 1 then
event "i", 51.1, 0, -1
else
event "i", -51.1, 0, 1
event "i", 19, .1, .1, 1
endif
endif

if kchangedrec2==1 then
if krec2 == 1 then
event "i", 51.2, 0, -1, 2
else
event "i", -51.2, 0, 1
endif
endif

if kchangedrec3==1 then
if krec3 == 1 then
event "i", 51.3, 0, -1, 3
else
event "i", -51.3, 0, 1
endif
endif

if kchangedrec4==1 then
if krec4 == 1 then
event "i", 51.4, 0, -1, 4
else
event "i", -51.4, 0, 1
endif
endif

;******
; editor

#define EDITPARM(Parm)#
kval            chnget $Parm
kvalC           changed kval
if kvalC > 0 then
Sparmline       sprintfk {{i 104 0 1 "%s" %f}}, $Parm, kval
scoreline Sparmline, 1
endif
#
$EDITPARM("Partikkel1Samplepos1")
$EDITPARM("Partikkel1Samplepos2")
$EDITPARM("Partikkel1Samplepos3")
$EDITPARM("Partikkel1Samplepos4")
$EDITPARM("Partikkel1Amp")
$EDITPARM("Partikkel1SyncGravity")
$EDITPARM("Partikkel1GrainRate")
$EDITPARM("Partikkel1GrFmFreq")
$EDITPARM("Partikkel1GrFmIndex")
$EDITPARM("Partikkel1Distribution")
$EDITPARM("Partikkel1GrainDur")
$EDITPARM("Partikkel1Sustain")
$EDITPARM("Partikkel1AdRatio")
$EDITPARM("Partikkel1Env2Amt")
$EDITPARM("Partikkel1GrainPitch")
$EDITPARM("Partikkel1GrainPitch1")
$EDITPARM("Partikkel1GrainPitch2")
$EDITPARM("Partikkel1GrainPitch3")
$EDITPARM("Partikkel1GrainPitch4")
$EDITPARM("Partikkel1Sweepshape")
$EDITPARM("Partikkel1PitchFmFreq")
$EDITPARM("Partikkel1PitchFmIndex")
$EDITPARM("Partikkel1TrainCps")
$EDITPARM("Partikkel1TrainPartials")
$EDITPARM("Partikkel1TrainChroma")
$EDITPARM("Partikkel1RandomMask")
$EDITPARM("Partikkel1WaveX")
$EDITPARM("Partikkel1WaveY")
$EDITPARM("Partikkel1TrainAmp")
$EDITPARM("LiveFeedbackAmount")
$EDITPARM("DryStereoWidth")
$EDITPARM("Bandpass1RmFreq")
$EDITPARM("Bandpass1RmMix")
$EDITPARM("Bandpass1Freq")
$EDITPARM("Bandpass1BW")
$EDITPARM("Bandpass1Pan")
$EDITPARM("Bandpass1Amp")
$EDITPARM("Bandpass1Mix")
$EDITPARM("Bandpass1_Send_Bandpass2")
$EDITPARM("Bandpass1_Send_Lowpass")
$EDITPARM("Bandpass1_Send_Bandpass3")
$EDITPARM("Bandpass1_Send_DlyL")
$EDITPARM("Bandpass1_Send_DlyR")
$EDITPARM("Bandpass2Freq")
$EDITPARM("Bandpass2BW")
$EDITPARM("Bandpass2Pan")
$EDITPARM("Bandpass2Amp")
$EDITPARM("Bandpass2Mix")
$EDITPARM("Bandpass2_Send_Lowpass")
$EDITPARM("Bandpass2_Send_Bandpass3")
$EDITPARM("Bandpass2_Send_DlyL")
$EDITPARM("Bandpass2_Send_DlyR")
$EDITPARM("LowpassFreq")
$EDITPARM("LowpassRes")
$EDITPARM("LowpassDist")
$EDITPARM("LowpassPan")
$EDITPARM("LowpassAmp")
$EDITPARM("LowpassMix")
$EDITPARM("Lowpass_Send_BP3")
$EDITPARM("Lowpass_Send_DlyL")
$EDITPARM("Lowpass_Send_DlyR")
$EDITPARM("Bandpass3Freq")
$EDITPARM("Bandpass3BW")
$EDITPARM("Bandpass3Pan")
$EDITPARM("Bandpass3Amp")
$EDITPARM("Bandpass3Mix")
$EDITPARM("Bandpass3_Send_DlyL")
$EDITPARM("Bandpass3_Send_DlyR")
$EDITPARM("DelayTimeLeft")
$EDITPARM("DelayTimeRight")
$EDITPARM("DelayFeedbackLeft")
$EDITPARM("DelayFeedbackRight")
$EDITPARM("DelayXFeedback")
$EDITPARM("DelayHpFreq")
$EDITPARM("DelayLpFreq")
$EDITPARM("DelayStereoWidth")
$EDITPARM("DelayAmp")
$EDITPARM("DelayMix")
$EDITPARM("LFO1_Amp")
$EDITPARM("LFO1_Freq")
$EDITPARM("LFO1_Waveform")
$EDITPARM("LFO1_Phase")
$EDITPARM("LFO1_Global")
$EDITPARM("LFO2_Amp")
$EDITPARM("LFO2_Freq")
$EDITPARM("LFO2_Waveform")
$EDITPARM("LFO2_Phase")
$EDITPARM("LFO2_Global")
$EDITPARM("LFO3_Amp")
$EDITPARM("LFO3_Freq")
$EDITPARM("LFO3_Waveform")
$EDITPARM("LFO3_Phase")
$EDITPARM("LFO3_Global")
$EDITPARM("LFO4_Amp")
$EDITPARM("LFO4_Freq")
$EDITPARM("LFO4_Waveform")
$EDITPARM("LFO4_Phase")
$EDITPARM("LFO4_Global")
$EDITPARM("Envelope1_Amp")
$EDITPARM("Envelope1_Delay")
$EDITPARM("Envelope1_Attack")
$EDITPARM("Envelope1_Decay")
$EDITPARM("Envelope1_Sustain")
$EDITPARM("Envelope1_Release")
$EDITPARM("Envelope1_Curve")
$EDITPARM("Envelope1_Retrig")
$EDITPARM("Envelope2_Amp")
$EDITPARM("Envelope2_Delay")
$EDITPARM("Envelope2_Attack")
$EDITPARM("Envelope2_Decay")
$EDITPARM("Envelope2_Sustain")
$EDITPARM("Envelope2_Release")
$EDITPARM("Envelope2_Curve")
$EDITPARM("Envelope2_Retrig")
$EDITPARM("Envelope3_Amp")
$EDITPARM("Envelope3_Delay")
$EDITPARM("Envelope3_Attack")
$EDITPARM("Envelope3_Decay")
$EDITPARM("Envelope3_Sustain")
$EDITPARM("Envelope3_Release")
$EDITPARM("Envelope3_Curve")
$EDITPARM("Envelope3_Retrig")
$EDITPARM("Envelope4_Amp")
$EDITPARM("Envelope4_Delay")
$EDITPARM("Envelope4_Attack")
$EDITPARM("Envelope4_Decay")
$EDITPARM("Envelope4_Sustain")
$EDITPARM("Envelope4_Release")
$EDITPARM("Envelope4_Curve")
$EDITPARM("Envelope4_Retrig")
$EDITPARM("Randh1_Amp")
$EDITPARM("Randh1_Freq")
$EDITPARM("Randh1_Retrig")
$EDITPARM("Randh2_Amp")
$EDITPARM("Randh2_Freq")
$EDITPARM("Randh2_Retrig")
$EDITPARM("Rspline1_Amp")
$EDITPARM("Rspline1_MinFreq")
$EDITPARM("Rspline1_MaxFreq")
$EDITPARM("Rspline2_Amp")
$EDITPARM("Rspline2_MinFreq")
$EDITPARM("Rspline2_MaxFreq")
$EDITPARM("Divider1Input")
$EDITPARM("Divider2Input")
$EDITPARM("Divider3Input")
$EDITPARM("Divider4Input")
$EDITPARM("Modulo1Input")
$EDITPARM("Modulo1Value")
$EDITPARM("Multiplier1Input1")
$EDITPARM("Multiplier1Input2")
$EDITPARM("Multiplier2Input1")
$EDITPARM("Multiplier2Input2")
$EDITPARM("Func1Input")
$EDITPARM("Func2Input")
$EDITPARM("Func3Input")
$EDITPARM("Func4Input")
$EDITPARM("TransientAttack1")
$EDITPARM("TransientRelease1")
$EDITPARM("TransientAttack2")
$EDITPARM("TransientRelease2")
$EDITPARM("TransientAttack3")
$EDITPARM("TransientRelease3")
$EDITPARM("TransientAttack4")
$EDITPARM("TransientRelease4")
$EDITPARM("Portamento_Allnotes")
$EDITPARM("PortamentoCps")
$EDITPARM("PortamentoNote")
$EDITPARM("PortamentoInterval")
$EDITPARM("MidiNoteOffset")
$EDITPARM("AnalysisTimeOffset")
$EDITPARM("gainmasks1Morf")
$EDITPARM("channelmasks1Morf")
$EDITPARM("wavemasks1Morf")
$EDITPARM("freqstartmasks1Morf")
$EDITPARM("freqendmasks1Morf")
$EDITPARM("fmampmasks1Morf")
$EDITPARM("Partikkel1GrainRateBpmSync")
$EDITPARM("Partikkel1GrFmFreqBpmSync")
$EDITPARM("Partikkel1PitchFmFreqBpmSync")
$EDITPARM("Partikkel1GrainDelayTime1BpmSync")
$EDITPARM("Partikkel1GrainDelayTime2BpmSync")
$EDITPARM("Partikkel1GrainDelayTime3BpmSync")
$EDITPARM("Partikkel1GrainDelayTime4BpmSync")
$EDITPARM("Bandpass1RmFreqBpmSync")
$EDITPARM("DelayTimeBpmSync")
$EDITPARM("LFO1_FreqBpmSync")
$EDITPARM("LFO2_FreqBpmSync")
$EDITPARM("LFO3_FreqBpmSync")
$EDITPARM("LFO4_FreqBpmSync")
$EDITPARM("Envelope1_DelayBpmSync")
$EDITPARM("Envelope1_AttackBpmSync")
$EDITPARM("Envelope1_DecayBpmSync")
$EDITPARM("Envelope1_ReleaseBpmSync")
$EDITPARM("Envelope2_DelayBpmSync")
$EDITPARM("Envelope2_AttackBpmSync")
$EDITPARM("Envelope2_DecayBpmSync")
$EDITPARM("Envelope2_ReleaseBpmSync")
$EDITPARM("Envelope3_DelayBpmSync")
$EDITPARM("Envelope3_AttackBpmSync")
$EDITPARM("Envelope3_DecayBpmSync")
$EDITPARM("Envelope3_ReleaseBpmSync")
$EDITPARM("Envelope4_DelayBpmSync")
$EDITPARM("Envelope4_AttackBpmSync")
$EDITPARM("Envelope4_DecayBpmSync")
$EDITPARM("Envelope4_ReleaseBpmSync")
$EDITPARM("Randh1_FreqBpmSync")
$EDITPARM("Randh2_FreqBpmSync")

; save state

SstateName      chnget "stateName"
;SstateNameP     strcat "states/", SstateName
knewstate	changed SstateName
puts SstateName, knewstate+1
ksave           chnget "save"
ksavetrig       trigger ksave, 0.5, 0
printk2 ksavetrig
if ksavetrig > 0 then
Sstatesave      sprintfk {{i 71 0 1 "%s"}}, SstateName
                scoreline Sstatesave, 1
endif

Smaskfunc      chnget "maskfunc"
SmaskAB        chnget "maskAB"
Smaskfilename  chnget "maskfilename"
knewmask 	changed Smaskfilename
puts Smaskfilename, knewmask+1
Smaskstring    sprintfk "%s1 %s %s", Smaskfunc, SmaskAB, Smaskfilename

kexportmask    chnget "exportmask"
kexporttrig    trigger kexportmask, 0.5, 0
if kexporttrig > 0 then
Sexportmask    sprintfk {{i 78 0 1 "%s.msk"}}, Smaskstring
               scoreline Sexportmask, 1
endif

kimportmask    chnget "importmask"
kimporttrig    trigger kimportmask, 0.5, 0
if kimporttrig > 0 then
Simportmask    sprintfk {{i 79 0 1 "%s.msk" 0}}, Smaskstring
               scoreline Simportmask, 1
endif

Smodcom    chnget "modmatrixcommand"
kmodcom    changed Smodcom
if kmodcom > 0 then
kspace1_indx  strindexk Smodcom, " "
Smodsource  strsubk Smodcom, 0, kspace1_indx
Smodcom1    strsubk Smodcom, kspace1_indx+1, -1
kspace2_indx  strindexk Smodcom1, " "
Smodtarget  strsubk Smodcom1, 0, kspace2_indx
Smodval    strsubk Smodcom1, kspace2_indx+1, -1
Smodassignment sprintfk "%s\tto\t%s", Smodsource, Smodtarget
puts Smodassignment, kmodcom+1
Sevent  sprintfk {{i 102 0 1 "%s" "%s" -1}}, Smodassignment, Smodval
scoreline Sevent, 1
endif


Sfcom    chnget "ftablecommand"
kfcom    changed Sfcom
if kfcom > 0 then
Sevent  sprintfk "i 6 0 1 %s", Sfcom
scoreline Sevent, 1
endif
kfupd   chnget "ftableupdate"
kfupdtrig trigger kfupd, 0.5, 0
if kfupdtrig > 0 then
Sfupdt  sprintf "tablenumber(%i,%i,%i,%i)", giModTransFunc1, giModTransFunc2, giModTransFunc3, giModTransFunc4
        chnset Sfupdt, "functabs"
        puts Sfupdt,kfupdtrig+1
endif
endin

instr 4
; populate source wave combo boxes
iCnt init 0
SFilenames[] directory "./samples", ".wav"
iNumberOfFiles lenarray SFilenames

Sitems = {{}}
until iCnt>=iNumberOfFiles do
    ;printf_i "Filename = %s \n", 1, SFilenames[iCnt]
    Sfile = SFilenames[iCnt]
    Sfile strsub Sfile, 10, -1; chop off folder name
    Sitems strcat Sitems, Sfile
    Sitems strcat Sitems, ", "
    iCnt = iCnt+1
od
Sitems2 sprintf {{%sSine, Triangle, Saw, Square, Pulse, audioInput}}, Sitems
giNumberOfSourceItems = iNumberOfFiles+6
gSsourceItems = Sitems2
puts Sitems2, 1

isource = 1
while isource <=4 do 
        Sbox    sprintf "source%i", isource
        Sbox_id strcat Sbox, "_id"
        Scom    sprintf "items(%s)", Sitems2
                chnset Scom, Sbox_id
	isource +=1
od
                
endin


instr 5

endin

instr 6
ifuncnum = p4
print ifuncnum

itabnums ftgen 0, 0, 4, -2, giModTransFunc1, giModTransFunc2, giModTransFunc3, giModTransFunc4
itabnum table ifuncnum-1, itabnums
igen    = p5
print itabnum
itemp ftgen itabnum, 0, giModFuncSize, igen, p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25,p26
print itemp
itest   table 1000, itemp 
print itest
Scom sprintf "tablenumber(%i,%i,%i,%i)", giModTransFunc1, giModTransFunc2, giModTransFunc3, giModTransFunc4
puts Scom, 1
        chnset Scom, "functabs"
endin

instr 7
endin

</CsInstruments>  
<CsScore>
i1  0.1 1 ""
#include "Hadron.sco"
i3 1 86400            ; Cabbage gui handling
i4.1 1 1 
</CsScore>
</CsoundSynthesizer>