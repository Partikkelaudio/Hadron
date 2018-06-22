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

; grain clock pulse audio input
        a1              inch    3                                       ; 
        a2              inch    4                                       ; 
        ain             = a1+a2                                         ; use both sync inputs

/*
; test sync setup
        itempo          = 1
                        chnset itempo, "syncPulseTempo"
        ktempo          chnget "syncPulseTempo"
        ain             mpulse 1, 1/ktempo
        outch           1, ain*20
*/

; Transient analysis
        kAttack         = 0.001
        kRelease        = 0.25
        aFollow         follow2 ain, kAttack, kRelease
        iResponse       = 50                            ; response time in milliseconds
        kThresh         = 0.15                          ; attack threshold (in dB)
        kFollow         downsamp        aFollow         
        kFollowdb       = dbfsamp(kFollow+1)                    ; convert to dB
        kFollowDel      delayk  kFollowdb, iResponse/1000       ; delay with response time for comparision of levels
        kTransient      init 0
        kTransient      = ((kFollowdb > kFollowDel + kThresh) ? 1 : 0)  ; if current rms plus threshold is larger than previous rms, set trig signal to current rms
        kTransTrig      trigger kTransient, 0.5, 0
        if kTransTrig == 0 goto pulse
reinitPulse:
reinit pulse
pulse:
        aPulsePhase     linseg 0, 1/ksmps, ksmps, 1, ksmps
        aTransient      table   aPulsePhase, giPulse, 1
rireturn
                        chnset  aTransient, "externalAudioClock"


; Rate analysis
        kSecond         metro 1
        kRate           init 1
        kcount          init 0
        kcount          = kcount+kTransTrig
        if kSecond == 0 kgoto noReset
        kRate           = (kRate*0.3)+(kcount*0.7)      ; weighted average
        kcount          = 0                             ; reset counter once per second
noReset:

                        chnset  kRate, "externalClockRate"
;printk2 kTransTrig
;printk2 kRate, 5
