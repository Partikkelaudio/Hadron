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

        
        kinChan chnget  "LiveSamplingChannel"                   ; audio input channel for sampling
        a1      inch    kinChan                                 ; signal input

        /*
         ;test signal
        a1      diskin "C:/Projects/Single_E_bent.wav", 1, 0, 1
        aout    = a1 * 0.1
                outs    aout, aout
        */
        aFeed   chnget  "liveModeFeedback"                      ; feedback from partikkel audio output
        iFeed   chnget  "iLiveFeedbackAmount"   
        kFeed   table   iFeed, giSinglePreset_M                 ; feedback gain
        a1      = a1 + (aFeed*kFeed)                            ; mix feedback with live input

; write audio to table
        iAudioTable     = giLiveFeed
        iLength         = ftlen(iAudioTable)
        gkstartFollow   tablewa iAudioTable, a1/0dbfs, 0                                ; write audio a1 to table 
        gkstartFollow   = (gkstartFollow > (giLiveFeedLen-1) ? 0 : gkstartFollow)       ; reset kstart when table is full
                        tablegpw iAudioTable
                        chnset  gkstartFollow, "kstartFollow"                           ; output the buffer position to chn

; analyze audio and write analysis to tables
#include "inc/analyze_features.inc"

; write analysis data to ftables 
        kindx           init 0
                        tablew  kamp, kindx, giLiveFeedAmp
                        tablew  kcps, kindx, giLiveFeedCps
                        tablew  kTransient, kindx, giLiveFeedTrans
        kindx           = (kindx > giLiveFeedAnalyzeLen ? 0 : kindx + 1)
        
