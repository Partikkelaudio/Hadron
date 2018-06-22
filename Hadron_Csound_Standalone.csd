<CsoundSynthesizer>
<CsOptions>
-odac22 -iadc22 -M2 -+rtmidi=mme -b2048 -B4096 -f
</CsOptions>
<CsInstruments>

#include "inc/hadron_FLTK.inc"
#include "Hadron.orc"	

instr 3
kCtrl1Changed	changed	gkCTRf1
if kCtrl1Changed == 0 goto skipCtrl1Write	; write to variable only if gui controller value has changed
		chnset	gkCTRf1, "ctrl1"	; overwrite value in chn channel on gui widget change
skipCtrl1Write:

kCtrl2Changed	changed	gkCTRf2
if kCtrl2Changed == 0 goto skipCtrl2Write	; write to variable only if gui controller value has changed
		chnset	gkCTRf2, "ctrl2"	; overwrite value in chn channel on gui widget change
skipCtrl2Write:

kCtrl3Changed	changed	gkCTRf3
if kCtrl3Changed == 0 goto skipCtrl3Write	; write to variable only if gui controller value has changed
		chnset	gkCTRf3, "ctrl3"	; overwrite value in chn channel on gui widget change
skipCtrl3Write:

kCtrl4Changed	changed	gkCTRf4
if kCtrl4Changed == 0 goto skipCtrl4Write	; write to variable only if gui controller value has changed
		chnset	gkCTRf4, "ctrl4"	; overwrite value in chn channel on gui widget change
skipCtrl4Write:

kCtrlXChanged	changed	gkJoyX
if kCtrlXChanged == 0 goto skipCtrlXWrite	; write to variable only if gui controller value has changed
		chnset	gkJoyX, "presetX"	; overwrite value in chn channel on gui widget change
skipCtrlXWrite:

kCtrlYChanged	changed	gkJoyY
if kCtrlYChanged == 0 goto skipCtrlYWrite	; write to variable only if gui controller value has changed
		chnset	gkJoyY, "presetY"	; overwrite value in chn channel on gui widget change
skipCtrlYWrite:

ktrig1on                trigger gkCTRb1, 0.5, 0
ktrig2on                trigger gkCTRb2, 0.5, 0
ktrig3on                trigger gkCTRb3, 0.5, 0
ktrig4on                trigger gkCTRb4, 0.5, 0
ktrig1of                trigger gkCTRb1, 0.5, 1
ktrig2of                trigger gkCTRb2, 0.5, 1
ktrig3of                trigger gkCTRb3, 0.5, 1
ktrig4of                trigger gkCTRb4, 0.5, 1

ksegment init -1
if ktrig1on == 1 then
        event "i", 51, 0, -1
        ksegment += 1
endif
if ktrig2on == 1 then
        event "i", 51, 0, -1
        ksegment += 1
endif
if ktrig3on == 1 then
        event "i", 51, 0, -1
        ksegment += 1
endif
if ktrig4on == 1 then
        event "i", 51, 0, -1
        ksegment += 1
endif

if ktrig1of == 1 then
        event "i", -51, 0, .1
        Score sprintfk {{i 20 0 1 1 1 "segment_%i"}}, ksegment
        scoreline Score, 1
endif
if ktrig2of == 1 then
        event "i", -51, 0, .1
        Score sprintfk {{i 20 0 1 1 2 "segment_%i"}}, ksegment
        scoreline Score, 1
endif
if ktrig3of == 1 then
        event "i", -51, 0, .1
        Score sprintfk {{i 20 0 1 1 3 "segment_%i"}}, ksegment
        scoreline Score, 1
endif
if ktrig4of == 1 then
        event "i", -51, 0, .1
        Score sprintfk {{i 20 0 1 1 4 "segment_%i"}}, ksegment
        scoreline Score, 1
endif


ktrig5on                trigger gkCTRb5, 0.5, 0
kplaysegment            = gkCTRt1
if ktrig5on == 1 then
        event "i", 126, 0, 1, kplaysegment
        ksegment += 1
endif


endin

</CsInstruments>

<CsScore>

#include "Hadron.sco"
i3	3	86400		; enable FLTK control
#include "hadron_cs_standalone_sco.inc"

e
</CsScore>
</CsoundSynthesizer>
