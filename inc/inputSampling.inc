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

        
        kinChan         chnget "LiveSamplingChannel"    ; audio input channel for sampling
        a1              inch    kinChan                 ; signal input

; create a gap at start of recording (so start of next segment can not be heard at end of this segment)
        ireleasetime    = 0.1
                        chnset  ireleasetime, "liveSamplingReleaseTime"
        kGap            init 0
        if kGap         == 1 kgoto noGap
        gkstart         = gkstart + (ireleasetime*sr)
        kGap            = 1
noGap:

; short fade in at live sampling start
        aEnv            linseg 0, 0.03, 1, 1, 1
        a1              = a1*aEnv

; short fade out at live sampling end
        xtratim         ireleasetime
        krelease        release
        if krelease == 0 kgoto noRelease
        aRelEnv         line 1, ireleasetime, 0
        a1              = a1*aRelEnv
noRelease:

; ckeck if recording should be skipped (buffer full)
        kFull           init 0
                        chnset kFull, "RecordBufferFull"
;       printk2 kFull
        ;if kFull == 1 goto end
        ;if kFull != 1 goto noreset
        ;kZero          = 0
;                       chnset  kZero, "AmountOfRecordBufferUsed"
;                       chnset kZero, "RecordBufferFull"
noreset:


; write audio to table
        iAudioTable     = giLiveSamplAudioTable
        iTabLen         tableng iAudioTable
        konce           init 1                  ; WORKAROUND TABLEWA BUG
        koffset         = i(gkstart)*konce      ; WORKAROUND TABLEWA BUG
        gkstart         tablewa iAudioTable, a1/0dbfs, koffset        ;write audio a1 to table 
        konce           = 0                     ; WORKAROUND TABLEWA BUG

; analyze audio for attack points
;#include "inc/attackDetect.inc"
        kTrig           init 1                                  ; disabled autosegmenting
        gkNumSegments   = gkNumSegments + kTrig

; write attack triggers to table (as index into audio table
        iAtckTable      = giLiveSamplAttackTable
        ;printks "gkstart %i \n", 0.5, gkstart
        if kTrig == 0 kgoto noAtckPoint
                tablew  gkstart, gkAtckIndex, iAtckTable                ; write start point of segment
                gkAtckIndex = gkAtckIndex + 1
                chnset  gkAtckIndex, "lastRecordedSegment"
                Snumsegments    sprintfk "*live sampling segment number %i", gkAtckIndex-1
                ;puts Snumsegments, gkAtckIndex

        noAtckPoint:
                ;printk2 gkAtckIndex, 5
                tablew  gkstart, gkAtckIndex, iAtckTable        ; continuously rewrite end point of segment
                chnset  gkstart/iTabLen, "AmountOfRecordBufferUsed"
                i_gkstart   = i(gkstart)
                ;print i_gkstart
                ;printk2 gkstart;/iTabLen
                ;chnset        gkAtckIndex, "lastRecordedSegment"

        if gkstart < iTabLen-ksmps-(ireleasetime*sr) goto end
                kOne    = 1
                chnset  kOne, "AmountOfRecordBufferUsed"
                chnset kOne, "RecordBufferFull"
                gkstart         = 0
                turnoff
        end:

; analyze audio and write analysis to tables
#include "inc/analyze_features.inc"

; write analysis data to ftables 
        kindx           init 0
                        tablew  kamp, kindx, giLiveSamplingAmp
                        tablew  kcps, kindx, giLiveSamplingCps
                        tablew  kTransient, kindx, giLiveSamplingTrans
        kindx           = (kindx > giLiveSamplingAnalyzeLen ? 0 : kindx + 1)

        kTrig           = 0                                     ; disabled autosegmenting
