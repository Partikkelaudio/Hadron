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
;ftables
;***************************************************

/*
        ; load audio files
        giStruglKor     ftgen   0, 0, 0, 1, "samples/GrSrc_StruglKor2mono.wav", 0, 0, 0         ; soundfile
        giVibDist       ftgen   0, 0, 0, 1, "samples/GrSrc_VibLineDistTone3.wav", 0, 0, 0       ; soundfile
        giFolwPiano     ftgen   0, 0, 0, 1, "samples/GrSrc_FlwMe1.wav", 0, 0, 0                 ; soundfile
        giHendrix1      ftgen   0, 0, 0, 1, "samples/GrSrc_JH2.wav", 0, 0, 0                    ; soundfile
        ; write ftable numbers to named chn channels, to enable using strings in the score to point to ftable numbers
        chnset          giStruglKor, "giStruglKor"
        chnset          giVibDist, "giVibDist"
        chnset          giFolwPiano, "giFolwPiano"
        chnset          giHendrix1, "giHendrix1"
*/

        ; grain envelope tables
        giSigmoRise     ftgen   0, 0, 8193, 19, 0.5, 1, 270, 1                          ; rising sigmoid
        giSigmoFall     ftgen   0, 0, 8193, 19, 0.5, 1, 90, 1                           ; falling sigmoid
        giExpFall       ftgen   0, 0, 8193, 5, 1, 8193, 0.00001                         ; exponential decay
        giLinFall       ftgen   0, 0, 8193, 7, 1, 8193, 0                               ; linear decay
        giTriangleWin   ftgen   0, 0, 8193, 7, 0, 4096, 1, 4096, 0                      ; triangular window 
        giSquareWin     ftgen   0, 0, 8193, 7, 1, 8193, 1                               ; square window (all 1, = no windowing)
        giTwinPeaks     ftgen   0, 0, 8193, 7, 0, 2048, 1, 2048, 0, 2048, 1, 2048, 0    ; two triangular peaks
        giTwinPeaksX    ftgen   0, 0, 8193, 5, 0.01, 2048, 1, 2048, 0.01, 2048, 1, 2048, 0.01   ; two triangular peaks, exponential

        ; standard waveforms
        giSine          ftgen   0, 0, 65537, 10, 1                                              ; sine wave
        giCosine        ftgen   0, 0, 8193, 9, 1, 1, 90                                         ; cosine wave
        giTri           ftgen   0, 0, 8193, 7, 0, 2048, 1, 4096, -1, 2048, 0                    ; triangle wave 
        giSquare        ftgen   0, 0, 1024, 7, 1, 512, 1, 0, -1, 512, -1                        ; square wave 
        giSawDown       ftgen   0, 0, 1024, 7, 1, 1024, -1                                      ; sawtooth wave, downward slope 
        giSawUp         ftgen   0, 0, 1024, 7, -1, 1024, 1                                      ; sawtooth wave, upward slope 
        giPulse         ftgen   0, 0, 4096, 2, 1, 0                                             ; 1 at first index, rest is zeroes
        giPulseBi       ftgen   0, 0, 4096, 2, 1, -1, 0                                         ; 1 at first index, then -1, rest is zeroes

        ; bandlimited classic waveforms
        giTriSmooth     ftgen   0, 0, 65537, 30, giTri, 1, 20, 44100 
        giSquareSmooth  ftgen   0, 0, 65537, 30, giSquare, 1, 20, 44100 
        giSawSmooth     ftgen   0, 0, 65537, 30, giSawDown, 1, 20, 44100 
        giPulseSmooth   ftgen   0, 0, 65537, 30, giPulseBi, 1, 20, 44100 


        ; other LFO tables
        giRamp          ftgen   0, 0, 1024, 7, 0, 1024, 1                                       ; ramp from 0 to 1
        gi3Step         ftgen   0, 0, 1024, 7, -1, 342, -1, 0, 0, 341, 0, 0, 1, 341, 1          ; 3 step ramp
        gi4Step         ftgen   0, 0, 1024, 7, -1, 256, -1, 0,          \                       ; 4 step ramp
                                               (-1/3), 256, (-1/3), 0,  \
                                               (1/3), 256, (1/3), 0,    \
                                               1, 256, 1
        gi5Step         ftgen   0, 0, 1024, 7,  -1, 205, -1, 0, \                               ; 5 step ramp
                                                -0.5, 205, -0.5, 0, \
                                                0, 205, 0, 0, \
                                                0.5, 205, 0.5, 0, \
                                                1, 204, 1
        gi6Step         ftgen   0, 0, 1024, 7,  -1, 171, -1, 0, \                               ; 6 step ramp
                                                -0.6, 170, -0.6, 0, \
                                                -0.2, 171, -0.2, 0, \
                                                0.2, 171, 0.2, 0, \
                                                0.6, 170, 0.6, 0, \
                                                1, 171, 1 
        gi8Step         ftgen   0, 0, 1024, 7, -1, 128, -1, 0,          \                       ; 8 step ramp
                                              (-5/7), 128, (-5/7), 0,   \
                                              (-3/7), 128, (-3/7), 0,   \
                                              -(1/7), 128, -(1/7), 0,   \
                                              (1/7), 128, (1/7), 0,     \
                                              (3/7), 128, (3/7), 0,     \
                                              (5/7), 128, (5/7), 0,     \
                                              1, 128, 1      


        ; write ftable numbers to named chn channels, to enable using strings in the score to point to ftable numbers
        chnset          giSine, "Sine"
        chnset          giCosine, "Cosine"
        chnset          giTri, "Triangle"
        chnset          giSquare, "Square"
        chnset          giSawDown, "SawDown"
        chnset          giSawUp, "SawUp"
        chnset          giTriSmooth, "TriangleSmooth"
        chnset          giSquareSmooth, "SquareSmooth"
        chnset          giSawSmooth, "SawSmooth"
        chnset          giPulseSmooth, "PulseSmooth"

        ; lookup of table numbers for waveforms (for LFOs etc)
        giWaveforms     ftgen   0, 0, 64, -2, giSine, giTri, giSquare, giSawDown, giSawUp, giRamp, \
                                              gi3Step, gi4Step, gi5Step, gi6Step, gi8Step               ; add more LFO waveforms as needed

        ; modulator transfer function tables
        giModFuncSize   = 8192
        giModTransFunc1 ftgen   0, 0, giModFuncSize, 7, 0, giModFuncSize, 1             ; linear transfer func as default
        giModTransFunc2 ftgen   0, 0, giModFuncSize, 7, 0, giModFuncSize, 1             ; linear transfer func as default
        giModTransFunc3 ftgen   0, 0, giModFuncSize, 7, 0, giModFuncSize, 1             ; linear transfer func as default
        giModTransFunc4 ftgen   0, 0, giModFuncSize, 7, 0, giModFuncSize, 1             ; linear transfer func as default
        ; temporary tables for presets
        giModTransFunc1_pre     ftgen   0, 0, giModFuncSize, 7, 0, giModFuncSize, 1             ; linear transfer func as default
        giModTransFunc2_pre     ftgen   0, 0, giModFuncSize, 7, 0, giModFuncSize, 1             ; linear transfer func as default
        giModTransFunc3_pre     ftgen   0, 0, giModFuncSize, 7, 0, giModFuncSize, 1             ; linear transfer func as default
        giModTransFunc4_pre     ftgen   0, 0, giModFuncSize, 7, 0, giModFuncSize, 1             ; linear transfer func as default
        giModTransFunc1_Master  ftgen   0, 0, giModFuncSize*4, 7, 0, giModFuncSize, 1           ; linear transfer func as default
        giModTransFunc2_Master  ftgen   0, 0, giModFuncSize*4, 7, 0, giModFuncSize, 1           ; linear transfer func as default
        giModTransFunc3_Master  ftgen   0, 0, giModFuncSize*4, 7, 0, giModFuncSize, 1           ; linear transfer func as default
        giModTransFunc4_Master  ftgen   0, 0, giModFuncSize*4, 7, 0, giModFuncSize, 1           ; linear transfer func as default


        ; write ftable numbers to named chn channels, to enable using strings in the score to point to ftable numbers
        chnset          giModTransFunc1, "giModTransFunc1"
        chnset          giModTransFunc2, "giModTransFunc2"
        chnset          giModTransFunc3, "giModTransFunc3"
        chnset          giModTransFunc4, "giModTransFunc4"
        ; needed only for debugging
        ;chnset         giModTransFunc1_pre, "giModTransFunc1_pre"
        ;chnset         giModTransFunc2_pre, "giModTransFunc2_pre"
        ;chnset         giModTransFunc3_pre, "giModTransFunc3_pre"
        ;chnset         giModTransFunc4_pre, "giModTransFunc4_pre"
        ;chnset         giModTransFunc1_Master, "giModTransFunc1_Master"
        ;chnset         giModTransFunc2_Master, "giModTransFunc2_Master"
        ;chnset         giModTransFunc3_Master, "giModTransFunc3_Master"
        ;chnset         giModTransFunc4_Master, "giModTransFunc4_Master"


        ; analysis ftables
        ;giAmpFn                ftgen   0, 0, 65537, 2, 0                                       ; empty table for amp analysis data
        ;giCpsFn                ftgen   0, 0, 65537, 2, 0                                       ; empty table for pitch analysis data
        ; default analysis tables (for analysis data bypass)
        giAmpFnDefault  ftgen   0, 0, 1024, 2, 1024, 0                                  ; default amp is 0 dB
        giCpsFnDefault  ftgen   0, 0, 1024, 2, 1024, 0                                  ; default cps is 0 Hz
        giTransFnDefault ftgen  0, 0, 1024, 2, 1024, 0                                  ; default transient is 0

        ; grain clock rate drift to external sync clock rate
        giGrainDriftTim ftgen   0, 0, 8192, 7, 0, 81, 0, 0, 1, \                        ; grain drift port times
                                                2025, 0.9, \
                                                2025, 0.4, \
                                                2025, 0.2, \
                                                2036, 0.0


        ; utility
        ; midi velocity mapping
        giMidiVelocityMap       ftgen   0, 0, 128, 16, 0, 128, 0, 1 


        ; preset ftable
        giSinglePreset          ftgen   0, 0, giNumParameters, -23, "default_preset.table"
        ; write table num for parameter values
                                chnset  giSinglePreset, "ParameterTableNum"

        giSinglePreset_M        ftgen   0, 0, giNumParameters, -23, "default_preset.table"
                                                                                        ; "empty" table for storing parameter values after modmatrix processing
                                                                                        ; partikkel will read parameter values from this table


        ; master preset table, containing values for 4 presets, to be interpolated with HVS
        giMasterPreset          ftgen   0, 0, giNumParameters*4, -18, 
                                                giSinglePreset, 1, 0, giNumParameters-1,
                                                giSinglePreset, 1, giNumParameters, (giNumParameters*2)-1,
                                                giSinglePreset, 1, giNumParameters*2, (giNumParameters*3)-1,
                                                giSinglePreset, 1, giNumParameters*3, (giNumParameters*4)-1
        

        giMasterParams          ftgen   0, 0, 64, -2, 0                                 ; parameters to be saved/recalled with master presets

        giPresetPos             ftgen   0, 0, 4, -2, 0,1,2,3                                    ; positions of the presets in HVS 2D space (do not change)
        
        giPolyVoice1            ftgen   0, 0, 128, -2, 0                                                ; voice number allocation for polyphonic midi playing, keep track of active voices

        giSortedNotenum         ftgen   0, 0, 128, -2, 0                                                ; sorted note numbers, all active (currently playing) note numbers sorted from oldest to newest

        ; empty/default tables, used for clearing
        giModScaleEmpty         ftgen 0, 0, giNumModulators*giNumParameters, -2, 0      ; empty modmatrix
        giMaskEmpty             ftgen 0, 0, giMaskSize, -2, 0, 0,   1           ; default mask table
        gichannelmasksEmpty     ftgen 0, 0, giMaskSize, -2, 0, 0,  0.5          ; default channel mask table
        giwavemasksEmpty        ftgen 0, 0, giMaskSize, -2, 0, 0,  1,0,0,0,0            ; default wave mask table


#define GenerateTablesForSoundfileNames(Voice)#
        giPartikkel$Voice.SourceWave1Name       ftgen   0, 0, 256, -2, 0                ; empty table to hold ascii codes representing the sound file name for waveslot 1
        giPartikkel$Voice.SourceWave2Name       ftgen   0, 0, 256, -2, 0                ; empty table to hold ascii codes representing the sound file name for waveslot 2
        giPartikkel$Voice.SourceWave3Name       ftgen   0, 0, 256, -2, 0                ; empty table to hold ascii codes representing the sound file name for waveslot 3
        giPartikkel$Voice.SourceWave4Name       ftgen   0, 0, 256, -2, 0                ; empty table to hold ascii codes representing the sound file name for waveslot 4
#
$GenerateTablesForSoundfileNames(1)     ; for partikkel instance 1
$GenerateTablesForSoundfileNames(2)     ; for partikkel instance 2

; tables to hold names (as ascii codes) of subpresets in a master preset
        giPresetNameMaxLen              = 256
        giSubPresetName1                ftgen   0, 0, giPresetNameMaxLen, 2, 0          ; empty table, name can be up to 256 characters long
        giSubPresetName2                ftgen   0, 0, giPresetNameMaxLen, 2, 0          ; empty table, name can be up to 256 characters long
        giSubPresetName3                ftgen   0, 0, giPresetNameMaxLen, 2, 0          ; empty table, name can be up to 256 characters long
        giSubPresetName4                ftgen   0, 0, giPresetNameMaxLen, 2, 0          ; empty table, name can be up to 256 characters long




