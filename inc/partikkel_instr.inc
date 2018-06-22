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

;***************************************************
; partikkel instr
;***************************************************

; calculation of timepoint, transpose, and waveform selection when using live sampled segments



;***************************************************
; granular synthesis parameters


; control rate denormals
        kdenorm                 rnd31   giDenorm, 1

; global bpm variable from plugin host
        kHostTempoBpm           chnget  "hostTempoBpm"
        kHostTempoBpm           limit   kHostTempoBpm, 20, 600

; amplitude
        iampIndx                chnget  "iPartikkel1Amp"
        kamp                    table iampIndx, giSinglePreset_M                        ; output amplitude

/*
; 
; hack, to get the first grain to play on midi activation
; this is because the envelopes in some cases are delayed by 1/kr period through the modmatrix handling
        ktrigger        chnget  "AnyMidiNoteActive"
        ktrigset        = 0
                        chnset  ktrigset, "AnyMidiNoteActive"   
        kamp            = kamp + ktrigger*0.4
*/

; grain rate
        igRateIndx              chnget  "iPartikkel1GrainRate"
        kGrainRate              table igRateIndx, giSinglePreset_M              ; number of grains per second (per beat if synced to hostBpm)
        ;kGrainRate             = kGrainRate + 0.00001
        igRateBpmSyncIndx       chnget  "iPartikkel1GrainRateBpmSync"
        kGrainRateBpmSync       table igRateBpmSyncIndx, giSinglePreset_M       ; sync index for bpm sync to host
        kGrainRate              =(((kHostTempoBpm/60)*kGrainRate)*kGrainRateBpmSync)+(kGrainRate*(1-kGrainRateBpmSync))
        ;printks2 "grain amp %f \n", kamp
        ;printks2 "grain rate %f \n", kGrainRate
        ; filtering to avoid zipper noise in preset interpolation (and modmatrix updates)
        kGrainRate              = kGrainRate+kdenorm
        kGrainRate              tonek kGrainRate, giInterpolFilt

/* Commented out until sidechaining actiavated
;****
; soft sync
        id1                   = 1
        gapulse1              init 0
        gaphase1              init 0
        isynGravIndx            chnget  "iPartikkel1SyncGravity"
        ksyncGravity            table isynGravIndx, giSinglePreset_M            ; sync amount control
        ; get external audio transients, and their rate
        aClockIn                chnget  "externalAudioClock"                    ; external audio analyzed for transients (pulse signal)
        kRateClockIn            chnget  "externalClockRate"                     ; estimated rate of external pulses (number of pulses per second)
        kGravityCenter          divz kGrainRate, kRateClockIn, 1                ; get ratio between grain rate and external clock rate, used as...
        kGravityCenter          limit kGravityCenter, 0.01, 1                   ; "sync gravitation center" expressed as a fraction of the time between grains
        asyncPolarity           table gaphase1*(1/kGravityCenter), giSquare, 1        ; use the phase of partikkelsync instance n (1) to find sync polarity for the sync signal.
        async                   =(aClockIn*0.5)*ksyncGravity*asyncPolarity*-1   ; prepare sync signal with polarity and strength


;****
; Clock Drift method, letting the internal clock (kGrainRate) be modified by the external clock rate (kRateClockIn)
; to a varying degree, controlled by the kDrift parameter (range 0 to 1).
; if kDrift is 0 only the rate of the internal clock is used
; if kDrift is 1 only the rate ov the external clock is used
; if kDrift is low, the rate will slowly approach the external clock rate
; when the internal clock rate value changes, it will influence the resulting rate,
; by soft resetting the filter states interpolationg between the two rates

kInternalChange changed kGrainRate
kDrift          chnget  "Drift"

kClockIn        = (kDrift < 0.01 ? kGrainRate : kRateClockIn)
kClockIn        = (kInternalChange == 1 && kDrift < 0.99 ? kGrainRate : kClockIn)
kPortTime       table   kDrift, giGrainDriftTim, 1
kNewRate        portk   kClockIn, kPortTime*2

if kInternalChange == 0 kgoto clockmix
reinit clockmix
clockmix:
icMixTime       divz    1, i(kDrift), 0
icStart         = 1-i(kDrift)
icEnd           = (i(kDrift)<0.01 ? 1 : 0)
kcMix           transeg icStart, icMixTime, -3, 0
rireturn
kcMix           portk   kcMix, 0.5

kGrainRateD     = kNewRate*(1-kcMix) + kGrainRate*kcMix
;****
*/ ;Commented out until sidechaining actiavated
; the following temporarily substitutes the sidechaining input calculations
kGrainRateD     = kGrainRate
async           = 0
id1           = 1

; reset grain clock on new midi note
        amidiClockTrigger       chnget "midiGrainClockTrigger"
        amidiClockTrigger       delay amidiClockTrigger, 0.001+(5/kr)
        kGrainRateSwitch        = (kGrainRate > 30 ? 0 : 1)                     ; reset grain clock on new midi note only for low grain rates
        async                   = async + (amidiClockTrigger*kGrainRateSwitch)

; grain rate FM
        iGrFmFreqIndx           chnget "iPartikkel1GrFmFreq"          
        kGrFmFreq               table iGrFmFreqIndx, giSinglePreset_M           ; FM freq for modulating the grainrate (cycles per beat if synced to hostBpm)
        iGrFmFreqBpmSyncIndx    chnget  "iPartikkel1GrFmFreqBpmSync"
        kGrFmFreqBpmBpmSync     table iGrFmFreqBpmSyncIndx, giSinglePreset_M    ; sync index for bpm sync to host
        kGrFmFreq               =(((kHostTempoBpm/60)*kGrFmFreq)*kGrFmFreqBpmBpmSync)+(kGrFmFreq*(1-kGrFmFreqBpmBpmSync))
        iGrFmIndexIndx          chnget "iPartikkel1GrFmIndex"                                 
        kGrFmIndex              table iGrFmIndexIndx, giSinglePreset_M          ; FM index for modulating the grainrate (normally kept in a 0.0 to 1.0 range)

        ; filtering to avoid zipper noise in preset interpolation (and modmatrix updates)
        kGrFmFreq               = kGrFmFreq+kdenorm
        kGrFmIndex              = kGrFmIndex+kdenorm
        kGrFmFreq               tonek kGrFmFreq, giInterpolFilt
        kGrFmIndex              tonek kGrFmIndex, giInterpolFilt
        iGrFmWave               = giSine                                        ; FM waveform, for modulating the grainrate 
        aGrFmSig                oscil kGrFmIndex, kGrFmFreq, iGrFmWave          ; audio signal for frequency modulation of grain rate
        agrainfreq              = kGrainRateD + (aGrFmSig*kGrainRateD)          ; add the modulator signal to the grain rate signal

        ;agrainfreq             limit   agrainfreq, -3000, (sr/2)-1
/*
        aAccumulator1           init 0
        aInput                  = agrainfreq
        minaccum aAccumulator1, aInput
        ktest                   downsamp aAccumulator1
        printk2 ktest, 10

        aAccumulator2           init 0
        aInput                  = agrainfreq
        maxaccum aAccumulator2, aInput
        ktest2                  downsamp aAccumulator2
        printk2 ktest2, 30
*/

; distribution 
        idistrIndx              chnget "iPartikkel1Distribution"      
        kdistribution           table idistrIndx, giSinglePreset_M              ; grain random distribution in time
        idisttab                = gidisttab1                                  ; probability distribution for random grain masking

; grain shape
        iGrainDurIndx           chnget "iPartikkel1GrainDur"          
        kGrainDur               table iGrainDurIndx, giSinglePreset_M           ; length of each grain relative to grain rate 
        kGrainRateDd            = ((kGrainRateD<0.1)&&(kGrainRateD>-0.1)?0:kGrainRateD)
        kduration               divz (kGrainDur*1000), kGrainRateDd, 10         ; grain dur in milliseconds, relative to grain rate
        kduration               = abs(kduration)                                ; ... in case some mapping method makes it negative

        ienv_attack             = giSigmoRise                                   ; grain attack shape (from table)
        ienv_decay              = giSigmoFall                                   ; grain decay shape (from table)
        isusAmtIndx             chnget "iPartikkel1Sustain"           
        ksustain_amount         table isusAmtIndx, giSinglePreset_M             ; balance between enveloped time(attack+decay) and sustain level time, 0.0 = no time at sustain level
        iadrIndx                chnget "iPartikkel1AdRatio"           
        ka_d_ratio              table iadrIndx, giSinglePreset_M                        ; balance between attack time and decay time, 0.0 = zero attack time and full decay time

        ienv2amtIndx            chnget "iPartikkel1Env2Amt"           
        kenv2amt                table ienv2amtIndx, giSinglePreset_M            ; amount of secondary enveloping per grain (e.g. for fof synthesis)
        ienv2tab                = giExpFall                                     ; secondary grain shape (from table), enveloping the whole grain if used

; grain pitch (transpose, or "playback speed")
        iwavfreqIndx            chnget "iPartikkel1GrainPitch"                
        kwavfreq                table iwavfreqIndx, giSinglePreset_M            ; (master) transposition (playback speed) of audio inside grains
                                                                                ; for audio files, original playback speed is achieved at kwavfreq = 1.0
                                                                                ; for single cycle waveforms, kwavfreq sets the fundamental pitch
                                                                                ; Independent pitching of the 4 source waveforms can be controlled via
                                                                                ; "PartikkelGrainPitch1" to "PartikkelGrainPitch4",
                                                                                ; (see above)

; pitch sweep
        isweepshapeIndx         chnget "iPartikkel1Sweepshape"                        
        ksweepshape             table isweepshapeIndx, giSinglePreset_M         ; grain wave pitch sweep shape (sweep speed), 0.5 is linear sweep
        iwavfreqstarttab        = gifreqstartmasks1                           ; start freq scalers (ftable), per grain
        iwavfreqendtab          = gifreqendmasks1                             ; end freq scalers (ftable), per grain

; FM of grain pitch (playback speed)
        iPtchFmFreqIndx         chnget "iPartikkel1PitchFmFreq"                       
        kPtchFmFreq             table iPtchFmFreqIndx, giSinglePreset_M                 ; FM freq, modulating waveform pitch, (cycles per beat if synced to hostBpm)
        iPitchFmFreqBpmSyncIndx chnget  "iPartikkel1PitchFmFreqBpmSync"
        kPitchFmFreqBpmSync     table iPitchFmFreqBpmSyncIndx, giSinglePreset_M         ; sync index for bpm sync to host
        kPtchFmFreq             =(((kHostTempoBpm/60)*kPtchFmFreq)*kPitchFmFreqBpmSync)+(kPtchFmFreq*(1-kPitchFmFreqBpmSync))
        iPtchFmIndexIndx        chnget "iPartikkel1PitchFmIndex"                      ; FM index, modulating waveform pitch
        kPtchFmIndex            table iPtchFmIndexIndx, giSinglePreset_M                ; FM index, modulating waveform pitch
        ; filtering to avoid zipper noise in preset interpolation (and modmatrix updates)
        kPtchFmFreq             = kPtchFmFreq+kdenorm
        kPtchFmIndex            = kPtchFmIndex+kdenorm
        kPtchFmFreq             tonek kPtchFmFreq, giInterpolFilt
        kPtchFmIndex            tonek kPtchFmIndex, giInterpolFilt

        iPtchFmWave             = giSine                                                ; FM waveform, modulating waveform pitch
        ifmamptab               = gifmampmasks1                                       ; FM index scalers (ftable), per grain
        ifmenv                  = giLinFall                                     ; FM index envelope, over each grain (from table)
        kPtchFmIndex            = kPtchFmIndex + (kPtchFmIndex*kPtchFmFreq*0.00001)     ; FM index scaling formula
        awavfm                  oscil   kPtchFmIndex, kPtchFmFreq, iPtchFmWave          ; audio input for frequency modulation inside grain

; trainlet parameters
        icosine                 = giCosine                                      ; needs to be a cosine wave to create trainlets
        iTrainCpsIndx           chnget "iPartikkel1TrainCps"                  
        kTrainCps               table iTrainCpsIndx, giSinglePreset_M           ; set cps equal to grain freq, creating a single cycle of a trainlet inside each grain
        inumpartIndx            chnget "iPartikkel1TrainPartials"             
        knumpartials            table inumpartIndx, giSinglePreset_M            ; number of partials in trainlet
        ichromaIndx             chnget "iPartikkel1TrainChroma"       
        kchroma                 table ichromaIndx, giSinglePreset_M             ; chroma, falloff of partial amplitude towards sr/2
        ; filtering to avoid zipper noise in preset interpolation (and modmatrix updates)
        ;kchroma                        = kchroma+kdenorm
        ;kchroma                        tonek kchroma, giInterpolFilt


; masking
        igainmasks              = gigainmasks1                                        ; gain masking table, amplitude for individual grains
        ichannelmasks           = gichannelmasks1                             ; channel masking table, output routing for individual grains

        irandMaskIndx           chnget "iPartikkel1RandomMask"                
        krandommask             table irandMaskIndx, giSinglePreset_M           ; random masking (muting) of individual grains

        ; mix of source waves
        iwaveamptab     = giwavemasks1                                ; wave mix masking, gain per source waveform per grain, 
        ; xy mixing surface for the 4 source waves, plus separate control for trainlet mix in relation to the other 4 sources
        iWaveXIndx      chnget "iPartikkel1WaveX"
        kWaveX          table iWaveXIndx, giSinglePreset_M
        iWaveYIndx      chnget "iPartikkel1WaveY"
        kWaveY          table iWaveYIndx, giSinglePreset_M
        iTrainAmpIndx   chnget "iPartikkel1TrainAmp"
        kTrainAmp       table iTrainAmpIndx, giSinglePreset_M


        ; filtering to avoid zipper noise in preset interpolation (and modmatrix updates)
        kWaveX                  = kWaveX+kdenorm
        kWaveY                  = kWaveY+kdenorm
        kTrainAmp               = kTrainAmp+kdenorm
        kWaveX                  tonek kWaveX, giInterpolFilt
        kWaveY                  tonek kWaveY, giInterpolFilt
        kTrainAmp               tonek kTrainAmp, giInterpolFilt

        ; calculate gain for 4 sources from XY position
        kwgain1         limit sqrt((1-kWaveX)*(1-kWaveY)), 0, 1
        kwgain2         limit sqrt(kWaveX*(1-kWaveY)), 0, 1
        kwgain3         limit sqrt((1-kWaveX)*kWaveY), 0, 1
        kwgain4         limit sqrt(kWaveX*kWaveY), 0, 1

        ; modify source wave gains in relation to trainlet amp
        kwavegain1      = kwgain1 * (1-kTrainAmp)       
        kwavegain2      = kwgain2 * (1-kTrainAmp)       
        kwavegain3      = kwgain3 * (1-kTrainAmp)       
        kwavegain4      = kwgain4 * (1-kTrainAmp)       
        ; write to wave mix mask table
        tablew          kwavegain1, 2, iwaveamptab      
        tablew          kwavegain2, 3, iwaveamptab
        tablew          kwavegain3, 5, iwaveamptab
        tablew          kwavegain4, 4, iwaveamptab
        tablew          kTrainAmp, 6, iwaveamptab

;***************************************************
; setup of source waveforms

; select source waveforms
                
        kwaveform1      chnget "Partikkel1SourceWave1"                ; source audio waveform 1
        kwaveform2      chnget "Partikkel1SourceWave2"                ; source audio waveform 1
        kwaveform3      chnget "Partikkel1SourceWave3"                ; source audio waveform 1
        kwaveform4      chnget "Partikkel1SourceWave4"                ; source audio waveform 1

;itest   = 1234

        
; independent transposition for each source wave
        iwavfreq1Indx   chnget "iPartikkel1GrainPitch1"
        kwavfreq1       table iwavfreq1Indx, giSinglePreset_M   
        iwavfreq2Indx   chnget "iPartikkel1GrainPitch2"
        kwavfreq2       table iwavfreq2Indx, giSinglePreset_M   
        iwavfreq3Indx   chnget "iPartikkel1GrainPitch3"
        kwavfreq3       table iwavfreq3Indx, giSinglePreset_M   
        iwavfreq4Indx   chnget "iPartikkel1GrainPitch4"
        kwavfreq4       table iwavfreq4Indx, giSinglePreset_M   

; original key for each source wave (used to modify kwavfreqN in calcWaveformParameters
        korig_key1      chnget "Partikkel1SourceWave1_orig"
        korig_key2      chnget "Partikkel1SourceWave2_orig"
        korig_key3      chnget "Partikkel1SourceWave3_orig"
        korig_key4      chnget "Partikkel1SourceWave4_orig"

; time pointer (phase). This can be independent for each source waveform.
        isamplepos1Indx chnget "iPartikkel1Samplepos1"        
        ksamplepos1     table isamplepos1Indx, giSinglePreset_M ; time pointer into source waveform 1
        isamplepos2Indx chnget "iPartikkel1Samplepos2"        
        ksamplepos2     table isamplepos2Indx, giSinglePreset_M ; time pointer into source waveform 1
        isamplepos3Indx chnget "iPartikkel1Samplepos3"        
        ksamplepos3     table isamplepos3Indx, giSinglePreset_M ; time pointer into source waveform 1
        isamplepos4Indx chnget "iPartikkel1Samplepos4"        
        ksamplepos4     table isamplepos4Indx, giSinglePreset_M ; time pointer into source waveform 1

;*************************************
; calculation of timepoint, transpose, and waveform selection when using live sampled segments
        kstartFollow    chnget  "kstartFollow"                  ; the current buffer write position for live follow mode
        isample_release chnget  "liveSamplingReleaseTime"       ; the live sampling release (fade out) time

$calcWaveformParameters(1'1)
$calcWaveformParameters(2'1)
$calcWaveformParameters(3'1)
$calcWaveformParameters(4'1)

        ;puts Ssegm1, kSegment1+1
        ;puts Ssegm2, kSegment1+1
        ;puts Ssegm3, kSegment1+1
        ;puts Ssegm4, kSegment1+1



; filtering to avoid zipper noise in preset interpolation (and modmatrix updates)
        kspos1_pre      = ksamplepos1                   ; store the value before the filter, to allow a jump from 1.0 to 0.0 unfiltered
        ksamplepos1     = ksamplepos1+kdenorm
        ksamplepos1     tonek ksamplepos1, giInterpolFilt*2
        ksamplepos1     = (kspos1_pre < 0.05 || kspos1_pre > 0.95 ? kspos1_pre : ksamplepos1) ; skip filter when value is at the extremes

        kspos2_pre      = ksamplepos2                   ; store the value before the filter, to allow a jump from 1.0 to 0.0 unfiltered
        ksamplepos2     = ksamplepos2+kdenorm
        ksamplepos2     tonek ksamplepos2, giInterpolFilt*2
        ksamplepos2     = (kspos2_pre < 0.05 || kspos2_pre > 0.95 ? kspos2_pre : ksamplepos2) ; skip filter when value is at the extremes

        kspos3_pre      = ksamplepos3                   ; store the value before the filter, to allow a jump from 1.0 to 0.0 unfiltered
        ksamplepos3     = ksamplepos3+kdenorm
        ksamplepos3     tonek ksamplepos3, giInterpolFilt*2
        ksamplepos3     = (kspos3_pre < 0.05 || kspos3_pre > 0.95 ? kspos3_pre : ksamplepos3) ; skip filter when value is at the extremes

        kspos4_pre      = ksamplepos4                   ; store the value before the filter, to allow a jump from 1.0 to 0.0 unfiltered
        ksamplepos4     = ksamplepos4+kdenorm
        ksamplepos4     tonek ksamplepos4, giInterpolFilt*2
        ksamplepos4     = (kspos4_pre < 0.05 || kspos4_pre > 0.95 ? kspos4_pre : ksamplepos4) ; skip filter when value is at the extremes

;Stest  sprintfk        "Samplepos %f %f %f %f \n", ksamplepos1, ksamplepos2, ksamplepos3, ksamplepos4
;puts   Stest, ksamplepos1+ ksamplepos2+ ksamplepos3+ ksamplepos4


; write samplepos to a chn channel for use as read index in analysis tables
                        chnset  ksamplepos1, "Samplepos1AnalyzeIndex"
                        chnset  ksamplepos2, "Samplepos2AnalyzeIndex"
                        chnset  ksamplepos3, "Samplepos3AnalyzeIndex"
                        chnset  ksamplepos4, "Samplepos4AnalyzeIndex"

; upsample time pointer
	asamplepos1	UpsampPhasor ksamplepos1	; upsample with interpolation and conditional on phase reset
	asamplepos2	UpsampPhasor ksamplepos2
	asamplepos3	UpsampPhasor ksamplepos3
	asamplepos4	UpsampPhasor ksamplepos4

;***************************************************
; system parameter
        imax_grains     = 100                           ; max number of grains per k-period

;***************************************************

a1,a2,a3,a4,a5,a6,a7,a8 partikkel agrainfreq, kdistribution, idisttab, async, kenv2amt, ienv2tab, \
                  ienv_attack, ienv_decay, ksustain_amount, ka_d_ratio, kduration, kamp, igainmasks, \
                  kwavfreq, ksweepshape, iwavfreqstarttab, iwavfreqendtab, awavfm, \
                  ifmamptab, ifmenv, icosine, kTrainCps, knumpartials, \
                  kchroma, ichannelmasks, krandommask, kwaveform1a, kwaveform2a, kwaveform3a, kwaveform4a, \
                  iwaveamptab, asamplepos1, asamplepos2, asamplepos3, asamplepos4, \
                  kwavekey1, kwavekey2, kwavekey3, kwavekey4, imax_grains, id1

gapulse1,gaphase1   partikkelsync   id1


;***************************************************
; readout of wavemix masks, to make signals for display of which sound souces are currently active

        kWdispStartMask table   0, iwaveamptab  
        kWdispEndMask   table   1, iwaveamptab  
        kWdispTrig      downsamp gapulse1, ksmps      ; downsampling averaged over ksmps to make sure we catch the impulse
        kWdispTrig      = kWdispTrig*ksmps              ; normalize, after gain loss in averaging
        kWdispIndex     init -1
        kWdispIndex     = kWdispIndex+kWdispTrig
        kWdispIndex     = (kWdispIndex < kWdispStartMask ? kWdispStartMask : kWdispIndex)
        kWdispIndex     = (kWdispIndex > kWdispEndMask ? kWdispStartMask : kWdispIndex)
        kWdispWave1     table   (kWdispIndex*5)+2, iwaveamptab  ; current amp for waveform 1
        kWdispWave2     table   (kWdispIndex*5)+3, iwaveamptab  ; 2
        kWdispWave3     table   (kWdispIndex*5)+4, iwaveamptab  ; 3
        kWdispWave4     table   (kWdispIndex*5)+5, iwaveamptab  ; 4
        kWdispWave5     table   (kWdispIndex*5)+6, iwaveamptab  ; current amp for trainlets

        kdispWavMetro   metro   5
        kWdispWave1f    samphold kWdispWave1, kdispWavMetro
        kWdispWave2f    samphold kWdispWave2, kdispWavMetro
        kWdispWave3f    samphold kWdispWave3, kdispWavMetro
        kWdispWave4f    samphold kWdispWave4, kdispWavMetro
        kWdispWave5f    samphold kWdispWave5, kdispWavMetro
                        chnset  kWdispWave1f, "displayAmpWave1"
                        chnset  kWdispWave2f, "displayAmpWave2"
                        chnset  kWdispWave3f, "displayAmpWave3"
                        chnset  kWdispWave4f, "displayAmpWave4"
                        chnset  kWdispWave5f, "displayAmpWave5"
        ;Sdisplay       sprintfk "wave amps %i %f %f %f %f %f", kWdispIndex, kWdispWave1, kWdispWave2, kWdispWave3, kWdispWave4, kWdispWave5
        ;kputsTrig      = kWdispIndex+100;kWdispWave1*3 + kWdispWave2*5 + kWdispWave3*7 + kWdispWave4*9 + kWdispWave5*11
        ;puts Sdisplay, kputsTrig

;***************************************************
; output routing
        iWidth_Indx     chnget  "iDryStereoWidth"
        kStereoWidth    table iWidth_Indx, giSinglePreset_M             ; stereo width for the two first partikkel outputs
        kStereoWidth    = abs(kStereoWidth)                             ; hack to create abs, should have been done as a regular modulator in modulators.inc
        kPan1           = (1-kStereoWidth)*0.5
        kPan1           limit kPan1, 0.00000001, 0.5            ; avoid sqrt of zero
        aLeft           = (a1*sqrt(1-kPan1))+(a2*sqrt(kPan1))
        aRight          = (a2*sqrt(1-kPan1))+(a1*sqrt(kPan1))

        chnmix          aLeft,  "MasterAudioLeft"
        chnmix          aRight, "MasterAudioRight"
        chnmix          a3,     "Bandpass1Send"
        chnmix          a4,     "Bandpass2Send"
        chnmix          a5,     "LowpassSend"
        chnmix          a6,     "Bandpass3Send"
        chnmix          a7,     "DelaySendLeft"
        chnmix          a8,     "DelaySendRight"


;***************************************************

