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

;******************************************************
; initialize chn values
;******************************************************

; this instrument should only run for 1 k-pass
        p3 = 1/kr

; set our root path
        Scwd    chnget "CSD_PATH"
        puts Scwd, 1
                
        gSpath          strget  p4
        ;gSpath          = Scwd
        print p1, p2, p3
        puts    gSpath, 1
        

; live sampling parameters
        chnset  1,      "LiveSamplingChannel"   ; select audio input for live sampling (mono)
        chnset  5,      "AmpResponse"           ; in milliseconds
        chnset  1,      "AtckThresh"            ; in dB (plus dB, relative to previous rms measurement)
        chnset  -60,    "MinThresh"             ; in dB (minus dB scale with 0dB as max level)
        chnset  -6,     "RelThresh"             ; in dB (minus dB scale with 0dB as max level)
        chnset  0.5,    "RelTime"               ; release time for live sampling

; master
        chnset  1,      "MasterLevel"           ; master audio out level
        chnset  60,     "hostTempoBpm"          ; initialize host bpm value to 1 beat per second

; export table numbers

; export the number of the giModScale1 table, used for writing preset files as text in Python
        chnset  giModScale1, "giModScale1"

; export the global giNumParameters, used for writing preset files as text in Python
        chnset  giNumParameters, "giNumParameters"

; export the number of the giSinglePreset table, used for writing preset files as text in Python
        chnset  giSinglePreset, "giSinglePreset"
        chnset  giSinglePreset_M, "giSinglePreset_M"    ; possibly useful for visualization of parameters

; export the current preset file version number, used for writing preset files as text in Python
        chnset giPresetVersion, "giPresetVersion"

; set default source audio
                        chnset  1, "LiveSamplingChannel"
                        chnset  giLiveFeed, "Partikkel1SourceWave1"
                        chnset  giLiveFeed, "Partikkel1SourceWave2"
                        chnset  giLiveFeed, "Partikkel1SourceWave3"
                        chnset  giLiveFeed, "Partikkel1SourceWave4"
                        chnset  giLiveFeedAmp, "AmpAnalysis1"
                        chnset  giLiveFeedAmp, "AmpAnalysis2"
                        chnset  giLiveFeedAmp, "AmpAnalysis3"
                        chnset  giLiveFeedAmp, "AmpAnalysis4"
                        chnset  giLiveFeedCps, "CpsAnalysis1"
                        chnset  giLiveFeedCps, "CpsAnalysis2"
                        chnset  giLiveFeedCps, "CpsAnalysis3"
                        chnset  giLiveFeedCps, "CpsAnalysis4"
                        chnset  giLiveFeedTrans, "TransientAnalysis1"
                        chnset  giLiveFeedTrans, "TransientAnalysis2"
                        chnset  giLiveFeedTrans, "TransientAnalysis3"
                        chnset  giLiveFeedTrans, "TransientAnalysis4"
                        chnset giLiveFeedAnalyzeLen, "AnalysisLength1"
                        chnset giLiveFeedAnalyzeLen, "AnalysisLength2"
                        chnset giLiveFeedAnalyzeLen, "AnalysisLength3"
                        chnset giLiveFeedAnalyzeLen, "AnalysisLength4"


        
