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

;********************************************
; midi activation instrument
;********************************************
        gkNumMidinotes  active p1                       ; for update of note event data
        iNumMidinotes   active p1                       ; for update of note event release
        ; limit polyphony
        gkNumMidinotes  limit gkNumMidinotes, 0, giMaxVoices
        iNumMidinotes   limit iNumMidinotes,  0, giMaxVoices


        kRetrig         init 1
                        chnset  kRetrig, "retrig"       ; trigger on any new note event
        kRetrig         = 0


; grain clock retrigger on new midi note (not on legato playing)
                        chnset  1, "AnyMidiNoteActive"  ; test, to get the first grain to play on midi activation
        if iNumMidinotes == 1 goto grainClockTrigger
goto noGrainClockTrigger
grainClockTrigger:
        aClockTrigger   mpulse 1, 84600
                        chnset aClockTrigger, "midiGrainClockTrigger"
noGrainClockTrigger:

; midi note input
                        midinoteonkey p4, p5
        iCps            = cpsmidinn(p4)
        iNoteNum        = p4
        iVel            = p5
        iAmp            table iVel, giMidiVelocityMap; iVel/127
;       print iNoteNum, iVel, iAmp
;Stest  sprintf "Midi Cps %f", iCps
;puts   Stest, 1
;       a1              oscil   iAmp, iCps, giSine
;                       outs    a1*0, a1
/*
; get polyphonic voice number
        iPolyIndex      = -1
        iPolyVoiceN     = -1    
        getPolyVoiceNumber:
        iPolyIndex      = iPolyIndex+1
        iTest           table iPolyIndex, giPolyVoice1
        iPolyVoiceN     = (iTest == 0 ? iPolyIndex : iPolyVoiceN)
        if iPolyVoiceN == -1 igoto getPolyVoiceNumber
                        tableiw 1, iPolyIndex, giPolyVoice1
        print iPolyVoiceN
*/

; write note, for sorted note numbers (calculating interval between current and previous notes)
                        tableiw iNoteNum, iNumMidinotes, giSortedNotenum

; write note event data to tables
                        tablew  iCps, gkNumMidinotes, giMidiCps
                        tablew  iNoteNum, gkNumMidinotes, giMidiNoteNum
                        tablew  iVel, gkNumMidinotes, giMidiVelocity
                        tablew  iAmp, gkNumMidinotes, giMidiAmp

; write release flag to table, for each active voice
        iRelease1       = 1/kr                          ; minimal release time here, we only want to write the release flag
        xtratim         iRelease1
        krelease        release
        ;printk2 krelease
                        tablew  krelease, iNumMidinotes, giMidiRelease


; release stage, notelist maintenance
        if (krelease == 1) kgoto releaseWrite
        kgoto skiprelease

        releaseWrite:
        ktrigRelease    init 0
        if ktrigRelease == 1 goto skiprelease
;                       tablew  0, iPolyIndex, giPolyVoice1                     ; voice allocation (poly, interval) number, free voice number on release

; find notenum in giSortedNotenum, delete it by overwrite (shuffling later table data one step down)
        kfindNoteIndex  init 0
findNote:
        kfindNoteIndex  = kfindNoteIndex +1
        ktestNum        table   kfindNoteIndex, giSortedNotenum                 ; find the currently released note
        if ktestNum != iNoteNum kgoto findNote
compress:
        kNextNum        table kfindNoteIndex+1, giSortedNotenum                 ; get next value
                        tablew  kNextNum, kfindNoteIndex, giSortedNotenum       ; move it one index down in table
        if kNextNum == 0 goto doneCompress                                      ; if the number is zero, we're done compressing
        kfindNoteIndex  = kfindNoteIndex+1                                      ; increment index, 
        kgoto compress                                                          ; and repeat
doneCompress:

        ktrigRelease    = 1
        skiprelease:

