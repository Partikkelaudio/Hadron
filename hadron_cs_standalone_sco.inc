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

;****************
; Assign sound files to source wave slots, use number 1,2,3,4 for the source waveform slots.
; You find the available sound files in the /samples directory. Sound files are loaded when assigned.
; The classic waveforms "Sine", "Triangle", "Square", "Saw", "Pulse" are also available

i1  0 1 ""

i20 3 1 1 1 "Cello.wav"
i20 3 1 1 2 "Sine"              ; (for classic waveforms, don't use any filename extension)
i20 3 1 1 3 "ahnoise.wav"
i20 3 1 1 4 "HangOn.wav"

;****************
; load states, use number 0,1,2,3 for the four state slots

i 72 2.5 1 "grFilterSynth.spst" 0
i 72 2.5 1 "grBlackBells.spst" 1
i 72 2.5 1 "grReedyFormantStepSync.spst" 2
i 72 2.5 1 "grTrainletDistribution.spst" 3

;****************
;****************
/*
; alternate configuration for use as an audio effect
; uncomment as needed
i20 3 1 1 1 "audioInput"
i20 3 1 1 2 "audioInput"                
i20 3 1 1 3 "audioInput"
i20 3 1 1 4 "audioInput"

i 72 1.5 1 "fxGroctaver.spst" 0
i 72 1.5 1 "fxLowpassRand.spst" 1
i 72 1.5 1 "fxTwinPeaks.spst" 2
i 72 1.5 1 "fxGrainFlanger2.spst" 3
*/


;****************
