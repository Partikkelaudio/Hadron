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
#define SCORELEN # 86400 #				; set length of score
#define cpsMidi(N) # [440*(1.0594631^($N-69))] #	; get cps value from (midi style) note number
#define semiTone(N) # [1.0594631^$N] #			; transposition by semitones
;***************************************************
;***************************************************
;; INSTR START TIME IS HIGHLY IMPORTANT FOR CORRECT INITIALIZATION
;***************************************************
;***************************************************

;i1	0	1			; chn init
;i2	0	$SCORELEN ; i/otest

i50	1	$SCORELEN		; check record pointer reset
i52	1	$SCORELEN		; live follow input enable

i 74 	0.2 	-1			; and start preset interpolation for master presets

;i 240	0.3	$SCORELEN		; external audio (sidechain) sync input
i 251 	0.3	$SCORELEN		; partikkel instr
i 260	0.4  	1			; message to host (csound ready)

;********************************
; mask morphing functions

i81 	.1 	$SCORELEN	"gainmasks1"
i81 	.1 	$SCORELEN	"channelmasks1"
i81 	.1 	$SCORELEN	"wavemasks1"
i81 	.1 	$SCORELEN	"fmampmasks1"
i81 	.1 	$SCORELEN	"freqstartmasks1"
i81 	.1 	$SCORELEN	"freqendmasks1"

;i 100 	2	1			; clear modmatrix (test)
;i 101 	2	1			; clear mask tables (test)

;********************************
; modulator matrix
i90	0.2	$SCORELEN		; modulators 
i91	0.2	$SCORELEN		; mod matrix, and merge modulation with parameter values 
;********************************
;********************************

; enable always on instruments 
i293	0.3	$SCORELEN		; bandpass1
i294	0.3	$SCORELEN		; bandpass2
i295	0.3	$SCORELEN		; lowpass
i296	0.3	$SCORELEN		; bandpass3
i297	0.3	$SCORELEN		; delay
i400	0.5	$SCORELEN		; master audio out


;***************************************************

