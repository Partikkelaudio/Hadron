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

;******************************************************
; morph between two mask tables
;******************************************************

; choose mask function (gain, channel, wave, freqstart, freqend, fmamp)
; get two table numbers: mask_A and mask_B
; get interpolation index
; morph, write to mask table

        SmaskFunc       strget p4               ; 
        SmaskTable      sprintf "gi%s", SmaskFunc
        imaskTableNum   chnget SmaskTable
        SmaskTable_A    sprintf "gi%s_A", SmaskFunc
        imaskTableNum_A chnget SmaskTable_A
        SmaskTable_B    sprintf "gi%s_B", SmaskFunc
        imaskTableNum_B chnget SmaskTable_B

        Sparam          sprintf "i%sMorf", SmaskFunc
        imorphIndx      chnget  Sparam
        kMorph          table imorphIndx, giSinglePreset_M
        kMorph          = abs(kMorph)                   ; hack to create abs, should have been done as a regular modulator in modulators.inc
        kMorph          limit kMorph, 0, 1

; morph indexing
        iMorphTab       ftgentmp        0, 0, 2, -2, imaskTableNum_A, imaskTableNum_B

; execute morphing (write new values to mask table)
forceUpdate:
                        ftmorf          kMorph, iMorphTab, imaskTableNum
rireturn

        kforceUpdate    chnget  "maskTableForceUpdate"
        if kforceUpdate == 0 goto end
        reinit forceUpdate
end:
