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

;*********************
; attack detector module,
; written by Oeyvind Brandtsegg 2005 (obrandts@online.no)
;*********************
; use a1 as audio input
; kTrig is the output, it's 1 at an attack and zero at all other times.
; An alternative control signal is also output, named kState.
; kState goes to 1 at the time of an attack, and stays at 1 while the audio amplitude is above threshold,
; kState goes to -1 after the amplitude has dropped below threshold, awaiting the next attack.
;*********************


kresponse       chnget  "AmpResponse"   ; in milliseconds
katk_thresh     chnget  "AtckThresh"    ; in dB (plus dB, relative to previous rms measurement)
kmin_thresh     chnget  "MinThresh"     ; in dB (minus dB scale with 0dB as max level)
kRelThresh      chnget  "RelThresh"     ; in dB (minus dB with reference to the attack level)
kRelTime        chnget  "RelTime"       ; release time (time to continue sampling after the signal has fallen below the release thresh)


kresponseTrig   changed kresponse
if kresponseTrig == 0 goto dontChangeResponse
reinit changeResponse
dontChangeResponse:

; detect signal attack 
changeResponse:
iresponse       chnget  "AmpResponse"
idelaytime      = iresponse * 0.001
a1_dly          delay   a1, idelaytime

irms_freq       = 20;1/idelaytime                               ; lp filter frequency for rms analysis, in cps
krms            rms     a1, irms_freq
krms_prev       rms     a1_dly, irms_freq
krms_dB         = dbfsamp(krms)
krms_prev_dB    = dbfsamp(krms_prev)
rireturn

;printks        "input rms %f %f %f %f %f %n", 1, krms_dB, krms_prev_dB, kmin_thresh, katk_thresh, kRelThresh

attackAnalyze:
ktrig           init 0
ktrig           = ((krms_dB > krms_prev_dB + katk_thresh) && \  ; if current rms plus threshold is larger than previous rms
                   (krms_dB > kmin_thresh) ? \                  ; and current rms is over minimum attack threshold
                    1 : 0)                                      ; set trig signal to current rms

; detect signal rms below a certain percentage of the attack strength
kCurAtckRms     samphold krms_dB, ktrig
;printks        "release %f %f %n", 1, kCurAtckRms, kRelThresh
;printk2 kCurAtckRms
ksignalUnder    = (krms_dB < (kCurAtckRms + kRelThresh) ? 1 : 0)
ktrigUnder      trigger ksignalUnder, 0.5, 0

; when signal below threshold, wait for irelease seconds
; if signal goes above threshold during release, don't release

; time stamping allow for delayed release trigger
ktime           timeinsts
ktimeMarkOff    init 0
ktimeMarkOff    = (ktrigUnder > 0 ? ktime : ktimeMarkOff)
kDeltaOff       = (ktime - ktimeMarkOff) * ksignalUnder
ktrigOff        = (kDeltaOff > kRelTime ? ksignalUnder : 0)

;*********************
; kState is 1 after attack and while signal is above threshold level
; kState goes to -1 when signal has dropped below threshold and has stayed low for kRelTime seconds
kState          init 0
kState          = (ktrig > 0 ? 1 : kState)
kState          = (ktrigOff > 0 ? -1 : kState)

;*********************
; kTrig is 1 at the time of an attack in the audio input, and zero at all other times
kTrig           trigger kState, 0.5, 0
kTrigOff        trigger kState, 0.5, 1  ; trigger signal when kState goes to -1 (after release)

