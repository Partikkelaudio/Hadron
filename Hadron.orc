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
; globals
;***************************************************

	ksmps = 128
        nchnls  = 2
        0dbfs   = 1

#include "inc/parameterNumbering.inc"
#include "inc/modulatorNumbering.inc"

        giMidiChannel   = 1
        pgmassign       0, -1   ; disable midi pgm change
        massign         -1, 89  ; midi event instr (instr 90 always on)
	gk_preset_enable = 0
	giNumberOfSourceItems = 0
	gSsourceItems = ""
;       massign 1, 90   ; midi mono mode with modulators (old)
;       massign 1, 81   ; midi mono mode (old)
;       massign 1, 85   ; midi poly mode (old)
        
        ;chn_S "preset1loaded", 2
        chn_k "HadronLoaded", 2
        chn_k "displayAmpWave1", 2
        chn_k "displayAmpWave2", 2
        chn_k "displayAmpWave3", 2
        chn_k "displayAmpWave4", 2
        chn_k "displayAmpWave5", 2
        chn_k "lastRecordedSegment", 2
        chn_k "RecordBufferFull", 2

        gapulse1        init    0
        gapulse2        init    0
        gapulse3        init    0
        gapulse4        init    0

        giNumModulators = 64            ; number of modulator signals
        giNumParameters = 256           ; number of control parameters
        giMaskSize      = 512           ; size of masking tables
        giInterpolRate  = 30            ; update rate when interpolating between single presets in a master preset
        giInterpolFilt  = 15            ; filter frequency for control signal filtering, to avoid interpolation zipper noise. This value should be <= giInterpolRate/2.
        giDenorm        = 0.000000000000000000001       ; denorm value for used when denormalizing control signals (tonek/portk)

        gkNumMidinotes  init 0          ; number of currently active midi notes
        giMaxVoices     = 128           ; maximum midi polyphony (also used for mono mode)
        maxalloc        89, giMaxVoices ; polyphony limit (partly effective)
        giMidiCps       ftgen   0, 0, giMaxVoices, 2, 0
        giMidiNoteNum   ftgen   0, 0, giMaxVoices, 2, 0
        giMidiVelocity  ftgen   0, 0, giMaxVoices, 2, 0
        giMidiAmp       ftgen   0, 0, giMaxVoices, 2, 0
        giMidiRelease   ftgen   0, 0, giMaxVoices, 2, 0, 0

; init table write position for live sampling
        gkstart         init 0
        gkAtckIndex     init 0
        gkNumSegments   init 0
        gkstartFollow   init 0

; count number of sound files loaded
        giNumSoundfiles = 0

; single cycle waveforms flags
        gkSingleCycle1  init -1
        gkSingleCycle2  init -1
        gkSingleCycle3  init -1
        gkSingleCycle4  init -1

;***************************************************
;ftables

#include "inc/livesampling_ftables.inc"
#include "inc/partikkel_ftables.inc"
#include "inc/globals_ftables.inc"
#include "inc/calcWaveform_macro.inc"
#include "inc/udos.inc"

;******************************************************
; initialize chn values
        instr 1
#include "inc/chnparms_init.inc"
        endin
;******************************************************
        instr 2
        endin

;******************************************************
; generate automation, instr 20
#include "inc/automation_instruments.inc"

;******************************************************
; live sampling
instr 50
; check if record pointer should be reset
        kReset  chnget  "ResetRecordPointer"
        kZero   = 0
        if kReset == 0 goto noreset
        gkstart = 0
        chnset kZero, "RecordBufferFull"
        noreset:
endin

instr 51
#include "inc/inputSampling.inc"
endin

instr 52
#include "inc/inputFollow.inc"
endin

;******************************************************
; load sound files
instr 60
#include "inc/loadSamples.inc"
endin

; load analysis tracks for sound files
instr 61
#include "inc/loadSoundAnalysis.inc"
endin

; analyze sound files
instr 62
#include "inc/analyzeSamples.inc"
endin

; write analysis tracks to file
instr 63
#include "inc/analyzeTableSave.inc"
endin


;******************************************************
; preset handling
instr 70
; for reading preset to single preset mode
#include "inc/preset_Single_File_read_single.inc"
endin

instr 71
print p1, p2
Stest strget p4
puts Stest, 1
#include "inc/preset_Single_File_write.inc"
endin

instr 72
; for reading preset into a slot in a master preset
#include "inc/preset_Single_File_read.inc"
endin

instr 73
;#include "inc/preset_Master_File_handling.inc"
endin

instr 74
print p1, p2, p3
#include "inc/presetInterpolate.inc"
endin

instr 75
endin

instr 76
; update editor gui with values from preset
#include "inc/preset_to_gui.inc"
endin

instr 78
#include "inc/exportMaskTables.inc"
endin

instr 79
#include "inc/importMaskTables.inc"
endin

instr 80
#include "inc/setMaskTables.inc"
endin

instr 81
#include "inc/morphMaskTables.inc"
endin

instr 89
#include "inc/midi_note_instr.inc"
endin

instr 90
#include "inc/modulators.inc"
endin

instr 91
#include "inc/modulationMatrix.inc"
endin

instr 100
#include "inc/clearModulationMatrix.inc"
endin

instr 101
#include "inc/clearMaskTables.inc"
endin

instr 102
#include "inc/writeModulationMatrix.inc"
endin

instr 104
#include "inc/writeParameterToPreset.inc"
endin

instr 105
#include "inc/setModFuncTable.inc"
endin

instr 106
#include "inc/getParameterValue.inc"
endin

instr 107
#include "inc/exportModFuncTable.inc"
endin

;******************************************************
; instr 108-140, test instruments
;#include "inc/test_instr.inc"

;instr 149
;ftsave "matrix_example.txt", 1, giModScale1 
;endin

;******************************************************
; read audio in (sidechain), analyze for transients to form external clock pulse for partikkel
        instr 240
;Commented out until sidechaining actiavated
;#include "inc/analyze_external_clock_audio.inc"
        endin
;******************************************************
; partikkel instr
        instr 251
#include "inc/partikkel_instr.inc"
        endin
        instr 252
;$PartikkelInstrument(2)
        endin
        instr 253
;$PartikkelInstrument(3)
        endin
        instr 254
;$PartikkelInstrument(4)
        endin

;/* DISABLED, MONO MODE ONLY in VER 1.0
;#include "inc/partikkel_instr_poly.inc"
;        instr 255
;iPolyVoice      = frac(p1)
;$PartikkelInstrumentPoly(1)
;        endin
;*/

;******************************************************
; send message, Hadron loaded ok
        instr 260
        p3      = 2/kr
        ;outvalue "HadronLoaded", "1"
        chnset  1, "HadronLoaded"
        print sr, kr, ksmps
        endin

; enable preset control from host
	instr 261
	gk_preset_enable = 1
	endin


;***************************************************
; global effects, instr 293 pp
#include "inc/global_effects.inc"

;***************************************************
; master audio out
#include "inc/master_audio_out.inc"

;***************************************************
