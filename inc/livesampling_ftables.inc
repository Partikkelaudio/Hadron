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

; live sampling ftables
        giLiveSamplTableLen             init 8388608;
        giLiveSamplAudioTable           ftgen   0, 0, giLiveSamplTableLen, 2, 0 ; empty table, size 8388608 equals 190 seconds at 44.1kHz sr
        giLiveSamplAttackTable          ftgen   0, 0, 131072, 2, 0      ; empty table, size = maximum number of audio segments 
                                        chnset  giLiveSamplAttackTable, "giLiveSamplAttackTable"
        giLiveSamplingAnalyzeLen        = giLiveSamplTableLen/ksmps

; make ftables to hold the analysis parameters for live sampling
        iExponent               = 2
findTableSizeLiveSampling:      ; find the next power-of-two table size to fit the analysis data
        iExponent               = iExponent+1
        iAnalyzeFtlen           pow     2, iExponent
        if iAnalyzeFtlen < giLiveSamplTableLen/ksmps igoto findTableSizeLiveSampling
        giLiveSamplingAmp       ftgen   0, 0, iAnalyzeFtlen, -7, 0, iAnalyzeFtlen, 0            ; default amp is 0 dB
        giLiveSamplingCps       ftgen   0, 0, iAnalyzeFtlen, -7, 0, iAnalyzeFtlen, 0            ; default cps is 0 Hz
        giLiveSamplingTrans     ftgen   0, 0, iAnalyzeFtlen, -7, 0, iAnalyzeFtlen, 0            ; default transient is 0

; live input feedback table for granular delay (aka live follow mode)
        giLiveFeedLen           = 524288
        giLiveFeedLenSec        = giLiveFeedLen/sr
        giLiveFeed              ftgen   0, 0, giLiveFeedLen+1, 2, 0                             ; create empty buffer for live follow mode
        chnset                  giLiveFeed, "giLiveFeed"                                        ; write table number to named chn
        giLiveFeedAnalyzeLen    = giLiveFeedLen/ksmps

; make ftables to hold the analysis parameters for live feedback mode
        iExponent               = 2
findTableSizeLiveFeed:  ; find the next power-of-two table size to fit the analysis data
        iExponent       = iExponent+1
        iAnalyzeFtlen   pow     2, iExponent
        if iAnalyzeFtlen < giLiveFeedAnalyzeLen igoto findTableSizeLiveFeed
        giLiveFeedAmp   ftgen   0, 0, iAnalyzeFtlen, -7, 0, iAnalyzeFtlen, 0    ; default amp is 0
        giLiveFeedCps   ftgen   0, 0, iAnalyzeFtlen, -7, 0, iAnalyzeFtlen, 0            ; default cps is 0 Hz
        giLiveFeedTrans ftgen   0, 0, iAnalyzeFtlen, -7, 0, iAnalyzeFtlen, 0            ; default transient is 0

