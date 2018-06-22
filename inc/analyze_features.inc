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

;*********************************************************************
; Transient detection

        iAttack         = 0.001
        iRelease        = 0.15                          ;(changed from 0.25, when also using the follow2 output as the amplitude analysis channel)
        aFollow         follow2 a1, iAttack, iRelease
        
        
        ahp             butterhp a1, 100
        iResponse       = 20                            ; response time in milliseconds
        kThresh         = 15                            ; attack threshold (in dB)
        iAttackT        = 0.01
        iReleaseT       = 0.25                          
        aFollowT        follow2 ahp, iAttack, iRelease
        kFollow         downsamp        aFollow         
        kFollowdb       = dbfsamp(kFollow)                      ; convert to dB
        kFollowDel      delayk  kFollowdb, iResponse/1000       ; delay with response time for comparision of levels
        
        ;attackAnalyze
        kTransient      init 0
        kTransient      = ((kFollowdb > kFollowDel + kThresh) ? 1 : 0)  ; if current rms plus threshold is larger than previous rms, set trig signal to current rms


;*********************************************************************
; Pitch and amp analysis

        kcps            init 0  
        ihopsize1       = 4096
        ihopsize2       = 512
        iChangeover     = (sr/ihopsize2)*3

if kcps > iChangeover kgoto small
        kcps, kamp      ptrack a1, ihopsize1
if kcps <= iChangeover kgoto nosmall
small:
        kcps, kamp      ptrack a1, ihopsize2
nosmall:

;kcps, kamp pitchamdf a1, 80, 1040


; we don't use the amp output from ptrack as it is quite noisy, now using the follow2 amp analysis
        kamp            downsamp aFollow

; filter pitch tracking signal
        imedianSize     = int(0.09*kr)          ; calc as (1/(ihopsize*2))*kr
        kcps            mediank kcps, imedianSize, imedianSize
