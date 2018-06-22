/*

    Copyright (C) 2010 Oeyvind Brandtsegg and Partikkelaudio.com

    This file is part of the Hadron Particle Synthesizer.

    The Hadron Particle Synthesizer is free software; you can redistribute it
    and/or modify it under the terms of the GNU Lesser General Public
    License, version 3.0, as published by the Free Software Foundation.

    Hadron Particle Synthesizer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with Hadron Particle Synthesizer; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
    02111-1307 USA
*/

; modulators have a normalized range (0 to 1, og -0.5 to 0.5)
; scaling and offset is done in the modulation matrix
; exceptions to this rule are typical "real world signals", like frequency analysis, midi note numbers (and corresponding cps) etc
; * The modulator generators still have an amplitude parameter, 
; this is to enable feedback and self modulation,
; for example LFO1 output can be used to amplitude modulate the output of LFO2
; in a similar manner LFO1 output can be used to frequency modulate LFO2

        kNumMidinotes   active 89                                       ; we need a separate NumMidiNotes variable to ensure correct handling of release in envelopes
        kNumMidinotes   limit kNumMidinotes, 0, giMaxVoices             ; limit polyphony
        kNonLegato      trigger kNumMidinotes, 0.5, 0                   ; when no notes are active, and we play the first note (non legato playing)
        kRetrig         chnget "retrig"                                 ; trigger on any new midi note
        kRetrig         delayk kRetrig, 1/kr                            ; delay reinitialization, due to 1/kr delay in modmatrix processing
        kNonLegato      delayk kNonLegato, 1/kr                         ; delay reinitialization, due to 1/kr delay in modmatrix processing

/*
; grain clock retrigger on new midi note (not on legato playing)
        if kNonLegato == 0 goto grainClockTrigger
        reinit grainClockTrigger
grainClockTrigger:
        aClockTrigger   mpulse 1, 84600
                        chnset aClockTrigger, "midiGrainClockTrigger"
rireturn
*/

; control rate denormals
        kdenorm                 rnd31   giDenorm, 1

; global bpm variable from plugin host
        kHostTempoBpm           chnget  "hostTempoBpm"
        kHostTempoBpm           limit   kHostTempoBpm, 20, 600


; *************************************************
; *** LFOs ***
#define LFO(N)#
        
        iLFO$N._Global  chnget  "iLFO$N._Global"
        kLFO$N._Global  table   iLFO$N._Global, giSinglePreset_M
        if (kLFO$N._Global < 0.5) && (kNonLegato == 1) kgoto doLFO$N.reinit     ; If not LFO set to global mode, then nonlegato events ...
kgoto noLFO$N.reinit
doLFO$N.reinit:                                                                 ; reinitialize LFO
reinit LFO$N.reinit
noLFO$N.reinit:

        iLFO$N._Amp             chnget  "iLFO$N._Amp"   ; (get parmeter index)
        iLFO$N._Freq            chnget  "iLFO$N._Freq"
        iLFO$N._FreqBpmSyncIndx chnget  "iLFO$N._FreqBpmSync"
        iLFO$N._Wave            chnget  "iLFO$N._Waveform"
        iiLFO$N._Phase          chnget  "iLFO$N._Phase"

LFO$N.reinit:
        kLFO$N._Amp             table   iLFO$N._Amp, giSinglePreset_M
        ; filtering to avoid zipper noise in preset interpolation (and modmatrix updates)
        kLFO$N._Amp             = kLFO$N._Amp+kdenorm
        kLFO$N._Amp             tonek kLFO$N._Amp, giInterpolFilt
        kLFO$N._Freq            table   iLFO$N._Freq, giSinglePreset_M
        kLFO$N._FreqBpmSync     table iLFO$N._FreqBpmSyncIndx, giSinglePreset_M ; sync index for bpm sync to host
        kLFO$N._Freq            =(((kHostTempoBpm/60)*kLFO$N._Freq)*kLFO$N._FreqBpmSync)+(kLFO$N._Freq*(1-kLFO$N._FreqBpmSync))
        kLFO$N._Wave            table   iLFO$N._Wave, giSinglePreset_M
        kLFO$N._Wave            table   kLFO$N._Wave-1, giWaveforms
        iLFO$N._Phase           table   iiLFO$N._Phase, giSinglePreset_M
        kLFO$N.                 oscilikt        1, kLFO$N._Freq, kLFO$N._Wave, iLFO$N._Phase
        kLFO$N.                 = kLFO$N.*kLFO$N._Amp
rireturn
#

$LFO(1)
$LFO(2)
$LFO(3)
$LFO(4)

; *************************************************
; *** envelopes ***
#define envelope(N) #   
; *** envelope generator ***
envelope$N.:
        iEnv$N.Amp              chnget  "iEnvelope$N._Amp"
        kEnv$N.Amp              table   iEnv$N.Amp, giSinglePreset_M

        iHostTempoBpm           limit i(kHostTempoBpm), 20, 600
        iiDelay$N.              chnget  "iEnvelope$N._Delay"
        iDelay$N.               table   iiDelay$N., giSinglePreset_M            ; in seconds (in beats if bpm synced to host)
        iDelay$N.BpmSyncIndx    chnget  "iEnvelope$N._DelayBpmSync"
        iDelay$N.BpmSync                table iDelay$N.BpmSyncIndx, giSinglePreset_M    ; sync index for bpm sync to host
        iDelay$N.               = (((60/iHostTempoBpm)*iDelay$N.)*iDelay$N.BpmSync)+(iDelay$N.*(1-iDelay$N.BpmSync))

        iiAttack$N.             chnget  "iEnvelope$N._Attack"
        iAttack$N.              table   iiAttack$N., giSinglePreset_M
        iAttack$N.BpmSyncIndx   chnget  "iEnvelope$N._AttackBpmSync"
        iAttack$N.BpmSync       table iAttack$N.BpmSyncIndx, giSinglePreset_M   ; sync index for bpm sync to host
        iAttack$N.              = (((60/iHostTempoBpm)*iAttack$N.)*iAttack$N.BpmSync)+(iAttack$N.*(1-iAttack$N.BpmSync))

        iiDecay$N.              chnget  "iEnvelope$N._Decay"
        iDecay$N.               table   iiDecay$N., giSinglePreset_M
        iDecay$N.BpmSyncIndx    chnget  "iEnvelope$N._DecayBpmSync"
        iDecay$N.BpmSync                table iDecay$N.BpmSyncIndx, giSinglePreset_M    ; sync index for bpm sync to host
        iDecay$N.               = (((60/iHostTempoBpm)*iDecay$N.)*iDecay$N.BpmSync)+(iDecay$N.*(1-iDecay$N.BpmSync))

        iiSustain$N.            chnget  "iEnvelope$N._Sustain"
        iSustain$N.             table   iiSustain$N., giSinglePreset_M

        iiRelease$N.            chnget  "iEnvelope$N._Release"
        iRelease$N.             table   iiRelease$N., giSinglePreset_M
        iRelease$N.BpmSyncIndx  chnget  "iEnvelope$N._ReleaseBpmSync"
        iRelease$N.BpmSync      table iRelease$N.BpmSyncIndx, giSinglePreset_M  ; sync index for bpm sync to host
        iRelease$N.             = (((60/iHostTempoBpm)*iRelease$N.)*iRelease$N.BpmSync)+(iRelease$N.*(1-iRelease$N.BpmSync))

        iiCurve$N.              chnget  "iEnvelope$N._Curve"    
        iCurve$N.               table   iiCurve$N., giSinglePreset_M

        ; workaround for line segment generators, segment duration of zero is not allowed
        iDelay$N.$N.            limit   iDelay$N., 0.1/kr, 100 ; hack to allow faster envelope attack, also use envelope curve = 0 for fastest start time of envelopes
        iAttack$N.              limit   iAttack$N., 1/kr, 100
        iDecay$N.               limit   iDecay$N., 1/kr, 100
        iRelease$N.             limit   iRelease$N., 1/kr, 100
        iStart$N.               chnget  "Envelope$N."                           ; get the "current" value of the envelope (if the previous note did not allow the envelope to finish)
        kEnvelope$N.            transeg iStart$N., iDelay$N.$N., 0, iStart$N., iAttack$N., -iCurve$N., 1, \
                                        iDecay$N., iCurve$N., iSustain$N., 1, 0, iSustain$N.
        kEnvelope$N.Rel         init 1                                          ; initialize release segment value
rireturn

; *** handle the release stage ***              
        kreleaseSum$N.          tabsum  giMidiRelease                           ; check if any note is in the release stage
        krelease$N.             = (kNumMidinotes == kreleaseSum$N. ? 1 : 0)     ; if all active notes are in the release stage
        kreleaseInit$N.         trigger krelease$N., 0.5, 0                     ; reinit the release stage envelope
        if kreleaseInit$N. == 0 kgoto noReinitRelease$N.
reinit release$N.
noReinitRelease$N.:     
        if krelease$N. == 1 kgoto release$N.                            ; ... and perform the release stage envelope
        kgoto skiprelease$N.

release$N.:
        kEnvelope$N.Rel         transeg 1, iRelease$N., iCurve$N., 0            ; release stage envelope 
rireturn
skiprelease$N.:
        kEnvelope$N.            = kEnvelope$N.*kEnvelope$N.Rel                  ; merge release stage with the normal envelope
                                chnset  kEnvelope$N., "Envelope$N."             ; and write to chn (start value for retrig)
        kEnvelope$N.            = kEnvelope$N.*kEnv$N.Amp                               ; scale envelope with amp value

; *** envelope retrig ***
        iEnv$N.Retrig           chnget "iEnvelope$N._Retrig"                    
        kEnv$N.Retrig           table   iEnv$N.Retrig, giSinglePreset_M         ; select if envelope should be retriggered on new events
        kEnv$N.Retrig           = ((kNonLegato == 1) && (kEnv$N.Retrig < 0.5) ? 1 : kEnv$N.Retrig)    ; when no notes are active, and we play the first note (non legato playing) ... we still want to retrigger the envelope

; *** handle reinitialization on any new midi event ***
        if (kRetrig*kEnv$N.Retrig) < 0.5  kgoto noReinitEnvelope$N.
reinit envelope$N.                                                      ; reinitialize on new note
noReinitEnvelope$N.:                                                    ; skip reinit
#

$envelope(1)
$envelope(2)
$envelope(3)
$envelope(4)

; *************************************************
; *** random generators ***

        iRandh1Amp              chnget  "iRandh1_Amp"
        kRandh1Amp              table   iRandh1Amp, giSinglePreset_M
        kRandh1Amp              = kRandh1Amp*0.5
        iRandh1Freq             chnget  "iRandh1_Freq"
        kRandh1Freq             table   iRandh1Freq, giSinglePreset_M
        iRandh1_FreqBpmSyncIndx chnget  "iRandh1_FreqBpmSync"
        kRandh1_FreqBpmSync     table iRandh1_FreqBpmSyncIndx, giSinglePreset_M ; sync index for bpm sync to host
        kRandh1Freq             =(((kHostTempoBpm/60)*kRandh1Freq)*kRandh1_FreqBpmSync)+(kRandh1Freq*(1-kRandh1_FreqBpmSync))
; reinit method
        iRandh1Retrig           chnget "iRandh1_Retrig"                 
        kRandh1Retrig           table   iRandh1Retrig, giSinglePreset_M         ; select if randh should be reinitialized on new events (for tempo synced random generator),
        kRandh1Retrig           = ((kNonLegato == 1) && \                       ; when no notes are active, and we play the first note (non legato playing)
                                  (kRandh1Retrig < 0.5) ? 1 : kRandh1Retrig)    ; ... we still want to reinit the generator
        if (kRetrig*kRandh1Retrig) < 0.5  kgoto noReinitRandh1
reinit randh1                                                                   ; reinitialize on new note
noReinitRandh1:                                                                 ; skip reinit

randh1:
        kRandh1                 randh   kRandh1Amp, kRandh1Freq, 2
        kRandh1                 = kRandh1*kRandh1Amp

rireturn

        iRandh2Amp              chnget  "iRandh2_Amp"
        kRandh2Amp              table   iRandh2Amp, giSinglePreset_M
        kRandh2Amp              = kRandh2Amp*0.5
        iRandh2Freq             chnget  "iRandh2_Freq"
        kRandh2Freq             table   iRandh2Freq, giSinglePreset_M
        iRandh2_FreqBpmSyncIndx chnget  "iRandh2_FreqBpmSync"
        kRandh2_FreqBpmSync     table iRandh2_FreqBpmSyncIndx, giSinglePreset_M ; sync index for bpm sync to host
        kRandh2Freq             =(((kHostTempoBpm/60)*kRandh2Freq)*kRandh2_FreqBpmSync)+(kRandh2Freq*(1-kRandh2_FreqBpmSync))
; reinit method
        iRandh2Retrig           chnget "iRandh2_Retrig"                 
        kRandh2Retrig           table   iRandh2Retrig, giSinglePreset_M         ; select if randh should be reinitialized on new events (for tempo synced random generator),
        kRandh2Retrig           = ((kNonLegato == 1) && \                       ; when no notes are active, and we play the first note (non legato playing)
                                  (kRandh2Retrig < 0.5) ? 1 : kRandh2Retrig)    ; ... we still want to reinit the generator
        if (kRetrig*kRandh2Retrig) < 0.5  kgoto noReinitRandh2
reinit randh2                                                                   ; reinitialize on new note
noReinitRandh2:                                                                 ; skip reinit

randh2:
        kRandh2                 randh   1, kRandh2Freq, 2
        kRandh2                 = kRandh2*kRandh2Amp
rireturn
        
        iRspl1Amp               chnget  "iRspline1_Amp"
        kRspl1Amp               table   iRspl1Amp, giSinglePreset_M
        kRspl1Amp               = kRspl1Amp*0.5
        iRspl1MinFreq           chnget  "iRspline1_MinFreq"
        kRspl1MinFreq           table   iRspl1MinFreq, giSinglePreset_M
        iRspl1MaxFreq           chnget  "iRspline1_MaxFreq"
        kRspl1MaxFreq           table   iRspl1MaxFreq, giSinglePreset_M
        kRspl1MinFreq           limit kRspl1MinFreq, 0.1, kr
        kRspl1MaxFreq           limit kRspl1MaxFreq, 0.1, kr
        kRspline1               jspline 1, kRspl1MinFreq, kRspl1MaxFreq
        kRspline1               = kRspline1*kRspl1Amp

        iRspl2Amp               chnget  "iRspline2_Amp"
        kRspl2Amp               table   iRspl2Amp, giSinglePreset_M
        kRspl2Amp               = kRspl2Amp*0.5
        iRspl2MinFreq           chnget  "iRspline2_MinFreq"
        kRspl2MinFreq           table   iRspl2MinFreq, giSinglePreset_M
        iRspl2MaxFreq           chnget  "iRspline2_MaxFreq"
        kRspl2MaxFreq           table   iRspl2MaxFreq, giSinglePreset_M
        kRspl2MinFreq           limit kRspl2MinFreq, 0.1, kr
        kRspl2MaxFreq           limit kRspl2MaxFreq, 0.1, kr
        kRspline2               jspline 1, kRspl2MinFreq, kRspl2MaxFreq
        kRspline2               = kRspline2*kRspl2Amp
        
; *************************************************
; *** Dividers (1/input) ***
        iDiv1input              chnget  "iDivider1Input"
        kDiv1input              table   iDiv1input, giSinglePreset_M
        kDiv1input              limit   kDiv1input, 0.01, 100000        ; to avoid divide by zero
        kDiv1output             = 1/kDiv1input

        iDiv2input              chnget  "iDivider2Input"
        kDiv2input              table   iDiv2input, giSinglePreset_M
        kDiv2input              limit   kDiv2input, 0.01, 100000        ; to avoid divide by zero
        kDiv2output             = 1/kDiv2input

        iDiv3input              chnget  "iDivider3Input"
        kDiv3input              table   iDiv3input, giSinglePreset_M
        kDiv3input              limit   kDiv3input, 0.01, 100000        ; to avoid divide by zero
        kDiv3output             = 1/kDiv3input

        iDiv4input              chnget  "iDivider4Input"
        kDiv4input              table   iDiv4input, giSinglePreset_M
        kDiv4input              limit   kDiv4input, 0.01, 100000        ; to avoid divide by zero
        kDiv4output             = 1/kDiv4input

; *************************************************
; *** Modulo (input%value) ***
        iMod1input              chnget  "iModulo1Input"
        kMod1input              table   iMod1input, giSinglePreset_M
        iMod1value              chnget  "iModulo1Value"
        kMod1value              table   iMod1value, giSinglePreset_M
        kMod1output             = kMod1input%kMod1value

; *************************************************
; *** Multipliers (input1*input2) ***
        iMult1input1            chnget  "iMultiplier1Input1"
        kMult1input1            table   iMult1input1, giSinglePreset_M
        iMult1input2            chnget  "iMultiplier1Input2"
        kMult1input2            table   iMult1input2, giSinglePreset_M
        kMult1output            = kMult1input1*kMult1input2
        iMult2input1            chnget  "iMultiplier2Input1"
        kMult2input1            table   iMult2input1, giSinglePreset_M
        iMult2input2            chnget  "iMultiplier2Input2"
        kMult2input2            table   iMult2input2, giSinglePreset_M
        kMult2output            = kMult2input1*kMult2input2

; *************************************************
; *** Transfer functions (table lookup waveshaping) ***
        iFunc1input             chnget          "iFunc1Input"
        kFunc1input             table           iFunc1input, giSinglePreset_M
        kFunc1output            tablekt         kFunc1input, giModTransFunc1, 1

        iFunc2input             chnget          "iFunc2Input"
        kFunc2input             table           iFunc2input, giSinglePreset_M
        kFunc2output            tablekt         kFunc2input, giModTransFunc2, 1

        iFunc3input             chnget          "iFunc3Input"
        kFunc3input             table           iFunc3input, giSinglePreset_M
        kFunc3output            tablekt         kFunc3input, giModTransFunc3, 1

        iFunc4input             chnget          "iFunc4Input"
        kFunc4input             table           iFunc4input, giSinglePreset_M
        kFunc4output            tablekt         kFunc4input, giModTransFunc4, 1

; *************************************************
; *** analysis signals ***

        kSoundLength1           chnget  "SoundLength1"  
        kSoundLength2           chnget  "SoundLength2"  
        kSoundLength3           chnget  "SoundLength3"  
        kSoundLength4           chnget  "SoundLength4"  

; time pointer (phase) for each source waveform.
        ksamplepos1             chnget  "Samplepos1AnalyzeIndex"
        ksamplepos2             chnget  "Samplepos2AnalyzeIndex"
        ksamplepos3             chnget  "Samplepos3AnalyzeIndex"
        ksamplepos4             chnget  "Samplepos4AnalyzeIndex"

; offset for timepointer into analysis files
        iAnaOffset_Indx         chnget  "iAnalysisTimeOffset"                           ; get index, and
        kAnaOffset              table iAnaOffset_Indx, giSinglePreset_M                 ; read value from state/preset table
if kRetrig == 0 kgoto noReinitOffslide
reinit offSlide
noReinitOffslide:
offSlide:
        kOffslide               linseg  0, 4/kr, 1, 1, 1                                        ; "slide in" for time offset on new midi note
rireturn
        kSoundLength1           = (kSoundLength1 == 0 ? 1 : kSoundLength1)              ; avoid divz
        kAnaOffset              = (kAnaOffset/kSoundLength1)*kOffslide                  ; translate offset in ms to normalized phase value, and appply "slide in"
        ksamplepos1             = ksamplepos1+kAnaOffset                                ; apply offset 
        ksamplepos2             = ksamplepos2+kAnaOffset
        ksamplepos3             = ksamplepos3+kAnaOffset
        ksamplepos4             = ksamplepos4+kAnaOffset
        ksamplepos1             = (ksamplepos1 < 0 ? ksamplepos1 +1: ksamplepos1)       ; prevent undershoot
        ksamplepos2             = (ksamplepos2 < 0 ? ksamplepos2 +1: ksamplepos2)       ; prevent undershoot
        ksamplepos3             = (ksamplepos3 < 0 ? ksamplepos3 +1: ksamplepos3)       ; prevent undershoot
        ksamplepos4             = (ksamplepos4 < 0 ? ksamplepos4 +1: ksamplepos4)       ; prevent undershoot

        ksamplepos1             = (ksamplepos1 > 1 ? ksamplepos1 -1: ksamplepos1)       ; prevent overshoot
        ksamplepos2             = (ksamplepos2 > 1 ? ksamplepos2 -1: ksamplepos2)       ; prevent overshoot
        ksamplepos3             = (ksamplepos3 > 1 ? ksamplepos3 -1: ksamplepos3)       ; prevent overshoot
        ksamplepos4             = (ksamplepos4 > 1 ? ksamplepos4 -1: ksamplepos4)       ; prevent overshoot
        
; get the table numbers for the analysis, and the corresponding analysis length
        kAmpFtno1               chnget "AmpAnalysis1"
        kAmpFtno2               chnget "AmpAnalysis2"
        kAmpFtno3               chnget "AmpAnalysis3"
        kAmpFtno4               chnget "AmpAnalysis4"
        kCpsFtno1               chnget "CpsAnalysis1"
        kCpsFtno2               chnget "CpsAnalysis2"
        kCpsFtno3               chnget "CpsAnalysis3"
        kCpsFtno4               chnget "CpsAnalysis4"
        kTransFtno1             chnget "TransientAnalysis1"
        kTransFtno2             chnget "TransientAnalysis2"
        kTransFtno3             chnget "TransientAnalysis3"
        kTransFtno4             chnget "TransientAnalysis4"
        kLengthAnalys1          chnget "AnalysisLength1"
        kLengthAnalys2          chnget "AnalysisLength2"
        kLengthAnalys3          chnget "AnalysisLength3"
        kLengthAnalys4          chnget "AnalysisLength4"

; read the analysis data
        kAnalysAmp1             tablekt (ksamplepos1*(kLengthAnalys1-1))+1, kAmpFtno1   ; skip index 0 when reading analysis data, 
        kAnalysAmp2             tablekt (ksamplepos2*(kLengthAnalys2-1))+1, kAmpFtno2   ; ... as the analysis length is stored there
        kAnalysAmp3             tablekt (ksamplepos3*(kLengthAnalys3-1))+1, kAmpFtno3
        kAnalysAmp4             tablekt (ksamplepos4*(kLengthAnalys4-1))+1, kAmpFtno4
        kAnalysCps1             tablekt (ksamplepos1*(kLengthAnalys1-1))+1, kCpsFtno1
        kAnalysCps2             tablekt (ksamplepos2*(kLengthAnalys2-1))+1, kCpsFtno2
        kAnalysCps3             tablekt (ksamplepos3*(kLengthAnalys3-1))+1, kCpsFtno3
        kAnalysCps4             tablekt (ksamplepos4*(kLengthAnalys4-1))+1, kCpsFtno4
        kAnalysTrans1           tablekt (ksamplepos1*(kLengthAnalys1-1))+1, kTransFtno1
        kAnalysTrans2           tablekt (ksamplepos2*(kLengthAnalys2-1))+1, kTransFtno2
        kAnalysTrans3           tablekt (ksamplepos3*(kLengthAnalys3-1))+1, kTransFtno3
        kAnalysTrans4           tablekt (ksamplepos4*(kLengthAnalys4-1))+1, kTransFtno4

; generate a filtered (follow/envelope) version of the transient signals
#define TransientFollowing(N)#
        iTransAttack$N.         chnget  "iTransientAttack$N."
        kTransAttack$N.         table   iTransAttack$N., giSinglePreset_M
        iTransRelease$N.                chnget  "iTransientRelease$N."
        kTransRelease$N.                table   iTransRelease$N., giSinglePreset_M
        kTransCount$N.          init 0
        kTransCount$N.          = (kAnalysTrans$N. == 1 ? kr*kTransAttack$N. : kTransCount$N. -1)
        kTransCount$N.          limit kTransCount$N., -1, kr
        kAnalysTrans$N.C                = (kTransCount$N. > 0 ? 1 : kAnalysTrans$N.)
        aAnalysTrans$N.C                upsamp  kAnalysTrans$N.C
        aTransFollow$N.         follow2 aAnalysTrans$N.C, kTransAttack$N., kTransRelease$N.
        kTransFollow$N.         downsamp aTransFollow$N.
#
$TransientFollowing(1)
$TransientFollowing(2)
$TransientFollowing(3)
$TransientFollowing(4)

; *************************************************
; *** midi controller inputs ***
;kMidiCtrl1in    ctrl7   giMidiChannel, 1, 0, 1
;kMidiCtrl2in    ctrl7   giMidiChannel, 2, 0, 1
;kMidiCtrl3in    ctrl7   giMidiChannel, 3, 0, 1
;kMidiCtrl4in    ctrl7   giMidiChannel, 4, 0, 1

kMidiCtrl1      chnget  "ctrl1"                 
;kMidi1Changed   changed kMidiCtrl1in
;if kMidi1Changed == 0 goto skipCtrl1Write       ; write to variable only if midi controller value has changed
;kMidiCtrl1      = kMidiCtrl1in
;                chnset  kMidiCtrl1, "ctrl1"     ; overwrite value in chn channel on midi in
;skipCtrl1Write:

kMidiCtrl2      chnget  "ctrl2"                 
;kMidi2Changed   changed kMidiCtrl2in
;if kMidi2Changed == 0 goto skipCtrl2Write       ; write to variable only if midi controller value has changed
;kMidiCtrl2      = kMidiCtrl2in
;                chnset  kMidiCtrl2, "ctrl2"     ; overwrite value in chn channel on midi in
;skipCtrl2Write:

kMidiCtrl3      chnget  "ctrl3"                 
;kMidi3Changed   changed kMidiCtrl3in
;if kMidi3Changed == 0 goto skipCtrl3Write       ; write to variable only if midi controller value has changed
;kMidiCtrl3      = kMidiCtrl3in
;                chnset  kMidiCtrl3, "ctrl3"     ; overwrite value in chn channel on midi in
;skipCtrl3Write:

kMidiCtrl4      chnget  "ctrl4"                 
;kMidi4Changed   changed kMidiCtrl4in
;if kMidi4Changed == 0 goto skipCtrl4Write       ; write to variable only if midi controller value has changed
;kMidiCtrl4      = kMidiCtrl4in
;                chnset  kMidiCtrl4, "ctrl4"     ; overwrite value in chn channel on midi in
;skipCtrl4Write:

; *************************************************
; midi control 5 and 6 is directly routed to "presetX" and "presetY" chn channels,
; however, it seems sensible to keep the midi control inputs here,
; even if these two are not really modulators in the sense that they are not included in the modulation matrix processing
;kMidiCtrl5      ctrl7   giMidiChannel, 5, 0, 1  
;kMidi5Changed   changed kMidiCtrl5
;if kMidi5Changed == 0 goto skipCtrl5Write       ; write to chn only if midi controller value has changed
;                chnset  kMidiCtrl5, "presetX"
;skipCtrl5Write:
;
;kMidiCtrl6      ctrl7   giMidiChannel, 6, 0, 1
;kMidi6Changed   changed kMidiCtrl6
;if kMidi6Changed == 0 goto skipCtrl6Write       ; write to chn only if midi controller value has changed
;                chnset  kMidiCtrl6, "presetY"
;skipCtrl6Write:

; *************************************************
; *** portamento setup ***
        iPortAll        chnget  "iPortamento_Allnotes"
        kPortAll        table   iPortAll, giSinglePreset_M
        if ((kPortAll < 0.5) && kNonLegato == 1) kgoto doPortaReinit    ; If not portamento on all notes, then nonlegato events ...
kgoto noPortaReinit
doPortaReinit:                                                          ; ... get no portamento
reinit portaReinit
noPortaReinit:
        iPortamentoCps          chnget  "iPortamentoCps"
        kPortamentoCps          table   iPortamentoCps, giSinglePreset_M                ; portamento time
        iPortamentoNote         chnget  "iPortamentoNote"
        kPortamentoNote         table   iPortamentoNote, giSinglePreset_M               ; portamento time
        iPortamentoInterval     chnget  "iPortamentoInterval"
        kPortamentoInterval     table   iPortamentoInterval, giSinglePreset_M           ; portamento time
portaReinit:
        kPortaOn                linseg 0, 1, 1                                  ; portamento time fade in (no portamento on nonlegato events)
        kPortamentoCps          = kPortamentoCps* kPortaOn
        kPortamentoNote         = kPortamentoNote* kPortaOn
        kPortamentoInterval     = kPortamentoInterval* kPortaOn
rireturn


; *************************************************
; *** midi note activation values ***

        kMidiNoteCps    table   gkNumMidinotes, giMidiCps, 0,0,1        ; read the midi note cps data for the currently active note
        kMidiNoteCps_p  portk   kMidiNoteCps, kPortamentoCps*0.15       ; portamento filtering 

        kMidiNoteNum    table   gkNumMidinotes, giMidiNoteNum, 0,0,1    ; read the midi note num data for the currently active note
        iMidiNoteOffset chnget  "iMidiNoteOffset"
        kMidiNoteOffset table   iMidiNoteOffset, giSinglePreset_M
        kMidiNoteNum    = kMidiNoteNum + kMidiNoteOffset
        kMidiNoteNum_p  portk   kMidiNoteNum, kPortamentoNote*0.15              ; portamento filtering 


        kMidiNoteVel    table   gkNumMidinotes, giMidiVelocity, 0,0,1   ; read the midi note velocity data for the currently active note
        kMidiNoteAmp    table   gkNumMidinotes, giMidiAmp, 0,0,1        ; read the midi note amp data for the currently active note

        kNoteNumOld     table   kNumMidinotes-1, giSortedNotenum, 0,0,1 ; read the midi note num data for the previous active note
        kNoteNumNew     table   kNumMidinotes, giSortedNotenum, 0,0,1           ; read the midi note num data for the currently active note
        kNoteInterval   = (kNumMidinotes == 1 ? 0 : kNoteNumNew-kNoteNumOld)    ; get the interval between the two last notes
        kNoteInterval   limit kNoteInterval, -60, 60
        kNoteInterval_p portk   kNoteInterval, kPortamentoInterval*0.1  ; portamento filtering 
        kNumnotesOld    = kNumMidinotes 

; *************************************************
; write modulator signals to table

        iLFO1indx               chnget  "iLFO1"
        iLFO2indx               chnget  "iLFO2"
        iLFO3indx               chnget  "iLFO3"
        iLFO4indx               chnget  "iLFO4"
        iEnvelope1indx          chnget  "iEnvelope1"
        iEnvelope2indx          chnget  "iEnvelope2"
        iEnvelope3indx          chnget  "iEnvelope3"
        iEnvelope4indx          chnget  "iEnvelope4"
        iRandh1indx             chnget  "iRandh1"
        iRandh2indx             chnget  "iRandh2"
        iRspline1indx           chnget  "iRspline1"
        iRspline2indx           chnget  "iRspline2"
        iDivider1indx           chnget  "iDivider1"
        iDivider2indx           chnget  "iDivider2"
        iDivider3indx           chnget  "iDivider3"
        iDivider4indx           chnget  "iDivider4"
        iModulo1indx            chnget  "iModulo1"
        iMultiplier1indx        chnget  "iMultiplier1"
        iMultiplier2indx        chnget  "iMultiplier2"
        iFunc1indx              chnget  "iFunc1"
        iFunc2indx              chnget  "iFunc2"
        iFunc3indx              chnget  "iFunc3"
        iFunc4indx              chnget  "iFunc4"
        iAnalysAmp1indx         chnget  "iAmpAnalysis1"
        iAnalysCps1indx         chnget  "iCpsAnalysis1"
        iAnalysTrans1indx       chnget  "iTransientAnalysis1"
        iTransEnv1indx          chnget  "iTransientEnvelope1"
        iAnalysAmp2indx         chnget  "iAmpAnalysis2"
        iAnalysCps2indx         chnget  "iCpsAnalysis2"
        iAnalysTrans2indx       chnget  "iTransientAnalysis2"
        iTransEnv2indx          chnget  "iTransientEnvelope2"
        iAnalysAmp3indx         chnget  "iAmpAnalysis3"
        iAnalysCps3indx         chnget  "iCpsAnalysis3"
        iAnalysTrans3indx       chnget  "iTransientAnalysis3"
        iTransEnv3indx          chnget  "iTransientEnvelope3"
        iAnalysAmp4indx         chnget  "iAmpAnalysis4"
        iAnalysCps4indx         chnget  "iCpsAnalysis4"
        iAnalysTrans4indx       chnget  "iTransientAnalysis4"
        iTransEnv4indx          chnget  "iTransientEnvelope4"
        iSoundLength1indx       chnget  "iSoundLength1"
        iSoundLength2indx       chnget  "iSoundLength2"
        iSoundLength3indx       chnget  "iSoundLength3"
        iSoundLength4indx       chnget  "iSoundLength4"
        iMidiCtrl1indx          chnget  "iMidiCtrl1"
        iMidiCtrl2indx          chnget  "iMidiCtrl2"
        iMidiCtrl3indx          chnget  "iMidiCtrl3"
        iMidiCtrl4indx          chnget  "iMidiCtrl4"
        iMidiNoteCpsindx        chnget  "iMidiNoteCps"
        iMidiNoteNumindx        chnget  "iMidiNoteNum"
        iMidiNoteVelindx        chnget  "iMidiNoteVel"
        iMidiNoteAmpindx        chnget  "iMidiNoteAmp"
        iMidiNoteIntvindx       chnget  "iMidiNoteInterval"


        tablew  kLFO1, iLFO1indx, giModulators
        tablew  kLFO2, iLFO2indx, giModulators
        tablew  kLFO3, iLFO3indx, giModulators
        tablew  kLFO4, iLFO4indx, giModulators
        tablew  kEnvelope1, iEnvelope1indx, giModulators
        tablew  kEnvelope2, iEnvelope2indx, giModulators
        tablew  kEnvelope3, iEnvelope3indx, giModulators
        tablew  kEnvelope4, iEnvelope4indx, giModulators
        tablew  kRandh1, iRandh1indx, giModulators
        tablew  kRandh2, iRandh2indx, giModulators
        tablew  kRspline1, iRspline1indx, giModulators
        tablew  kRspline2, iRspline2indx, giModulators
        tablew  kDiv1output, iDivider1indx, giModulators
        tablew  kDiv2output, iDivider2indx, giModulators
        tablew  kDiv3output, iDivider3indx, giModulators
        tablew  kDiv4output, iDivider4indx, giModulators
        tablew  kMod1output, iModulo1indx, giModulators
        tablew  kMult1output, iMultiplier1indx, giModulators
        tablew  kMult2output, iMultiplier2indx, giModulators
        tablew  kFunc1output, iFunc1indx, giModulators
        tablew  kFunc2output, iFunc2indx, giModulators
        tablew  kFunc3output, iFunc3indx, giModulators
        tablew  kFunc4output, iFunc4indx, giModulators
        tablew  kAnalysAmp1, iAnalysAmp1indx, giModulators
        tablew  kAnalysCps1, iAnalysCps1indx, giModulators
        tablew  kAnalysTrans1, iAnalysTrans1indx, giModulators
        tablew  kTransFollow1, iTransEnv1indx, giModulators
        tablew  kAnalysAmp2, iAnalysAmp2indx, giModulators
        tablew  kAnalysCps2, iAnalysCps2indx, giModulators
        tablew  kAnalysTrans2, iAnalysTrans2indx, giModulators
        tablew  kTransFollow2, iTransEnv2indx, giModulators
        tablew  kAnalysAmp3, iAnalysAmp3indx, giModulators
        tablew  kAnalysCps3, iAnalysCps3indx, giModulators
        tablew  kAnalysTrans3, iAnalysTrans3indx, giModulators
        tablew  kTransFollow3, iTransEnv3indx, giModulators
        tablew  kAnalysAmp4, iAnalysAmp4indx, giModulators
        tablew  kAnalysCps4, iAnalysCps4indx, giModulators
        tablew  kAnalysTrans4, iAnalysTrans4indx, giModulators
        tablew  kTransFollow4, iTransEnv4indx, giModulators
        tablew  kSoundLength1, iSoundLength1indx, giModulators
        tablew  kSoundLength2, iSoundLength2indx, giModulators
        tablew  kSoundLength3, iSoundLength3indx, giModulators
        tablew  kSoundLength4, iSoundLength4indx, giModulators
        tablew  kMidiCtrl1, iMidiCtrl1indx, giModulators
        tablew  kMidiCtrl2, iMidiCtrl2indx, giModulators
        tablew  kMidiCtrl3, iMidiCtrl3indx, giModulators
        tablew  kMidiCtrl4, iMidiCtrl4indx, giModulators
        tablew  kMidiNoteCps_p, iMidiNoteCpsindx, giModulators
        tablew  kMidiNoteNum_p, iMidiNoteNumindx, giModulators
        tablew  kMidiNoteVel, iMidiNoteVelindx, giModulators
        tablew  kMidiNoteAmp, iMidiNoteAmpindx, giModulators
        tablew  kNoteInterval_p, iMidiNoteIntvindx, giModulators

; *************************************************
; clear giMidiRelease table for new test on next k-rate period (envelope retrig processing)
kRelClearIndex  = 0
clearReleaseTable:
                        tablew  0, kRelClearIndex, giMidiRelease
        kRelClearIndex  = kRelClearIndex + 1
        if kRelClearIndex < giMaxVoices kgoto clearReleaseTable
