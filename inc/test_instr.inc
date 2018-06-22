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
instr 108
        print p1, giSinglePreset_M, giSinglePreset
        i1      table   0, giSinglePreset_M
        i2      table   1, giSinglePreset_M
        i3      table   2, giSinglePreset_M
        i4      table   3, giSinglePreset_M
        i5      table   4, giSinglePreset_M
        i6      table   5, giSinglePreset_M
        print i1, i2, i3, i4, i5, i6
        tableicopy giSinglePreset_M, giSinglePreset
        i1      table   0, giSinglePreset_M
        i2      table   1, giSinglePreset_M
        i3      table   2, giSinglePreset_M
        i4      table   3, giSinglePreset_M
        i5      table   4, giSinglePreset_M
        i6      table   5, giSinglePreset_M
        print i1, i2, i3, i4, i5, i6
endin

;******************************************************
instr 109
ilen    = ftlen(giSinglePreset)
print ilen
startOver:
kndx = 0
kmetro  metro 0.3
if kmetro == 0 kgoto done
copyTableValues:
        kval    table kndx, giSinglePreset
                tablew  kndx, kval, giSinglePreset_M
        kndx = kndx+1
        ;printk2 kndx
        ;printk2 kval, 5
        if kndx < ilen kgoto copyTableValues
        
        
done:
kndx = 0
endin

;******************************************************
instr 110
;       modmatrix giSinglePreset_M, giModulators, giSinglePreset, giModScale1_Empty, giNumModulators, giNumParameters
endin

;******************************************************
; master preset interpolate automation, to test interpolation noise
instr 111
imode   = p6    ; 0=X, 1=Y
isteps  = p7
isteps  = (isteps == 0 ? 1000:isteps)
kLFO    oscil p4*0.5, p5, giSine
kLFO    = kLFO + p4*0.5
kLFO    = int(kLFO*isteps)/isteps       ; quantize
if imode = 1 goto Y
X:
        chnset  kLFO, "presetX"
goto end
Y:
        chnset  kLFO, "presetY"
end:
endin

;******************************************************
; chn value investigation
;******************************************************
instr 115
        Sname   strget p4
        ktest   chnget  Sname
        printk2 ktest
endin

;******************************************************
; check parameter value in (any named) table
instr 116
        StableName      strget p4
        itableNum       chnget StableName
        index           = p5
        ival            table   index, itableNum
        ilen            = ftlen(itableNum)
        print ival, index, itableNum, ilen
endin

;******************************************************


;******************************************************
; mod matrix investigation
;******************************************************

;******************************************************
; print single matrix point
; this instrument should not be deleted, as it can be useful for preset programming
; the rest of the test instruments (in this file) is only needed for debugging purposes
;******************************************************
instr 120
; parse string representing modulator to parameter assignment
; must be in format ('mod       to      parameter'), use a single tab and no space between each word
        Sinput          strget          p4
        itabpos         strindex        Sinput, "\t"            ; find tab position in string
        Smod            strsub          Sinput, 0, itabpos      ; isolate modulator name
        Smod            strcat          "i", Smod               ; add "i" to the beginning of the modulator name, this is the named chn channel for modulator index
        Sparm           strsub          Sinput, itabpos+4, -1   ; isolate parameter name
        Sparm           strcat          "i", Sparm              ; add "i" to the beginning of the modulator name, this is the named chn channel for modulator index

        iModulator      chnget  Smod    ; modulator number, starting at zero
        iParameter      chnget  Sparm   ; parameter number, starting at zero

        index           = (iModulator*giNumParameters)+iParameter
        iValue          table   index, giModScale1
        print index, iValue
endin

;******************************************************
; print all nonzero matrix points
instr 121
        iModScale       = (p4>0?giModScale1_Master:giModScale1) ; if p4 set, investigate master modscale table, else investigate single preset modscale table
        print iModScale
        index           = 0
        itableng        tableng iModScale
readValue:
        iValue          table   index, iModScale
        if iValue == 0 goto noprint
        print index, iValue
noprint:
        index           = index +1
        if index > itableng goto end
        goto readValue
end:
endin

;******************************************************
; live sampling table investigation
;******************************************************
instr 125
        iStart          = p4
        iEnd            = p5
        iDur            = (iEnd-iStart)/sr
        p3              = iDur
        print p3
        aIndex          line iStart, iDur, iEnd
        a1              table   aIndex, giLiveSamplAudioTable
        a1              = a1 * 0dbfs
        outch           1, a1, 2, a1
endin

;******************************************************
; live sampling table investigation 2
;******************************************************
instr 126

        ; find audio segment start and end position
        iSegment        = p4
        iStart          table iSegment, giLiveSamplAttackTable
        iEnd            table iSegment+1, giLiveSamplAttackTable

        ; adjust samplepos
        iDur            = (iEnd-iStart)/sr
        p3              = iDur
        print iSegment, p3, iStart, iEnd
        ksamplepos      line 0, iDur, 1
        iLength         = (iEnd-iStart)/giLiveSamplTableLen
        ksamplepos      = (ksamplepos*iLength) + (iStart/giLiveSamplTableLen)
        ;printk2 ksamplepos*giLiveSamplTableLen
        aIndex          interp ksamplepos*giLiveSamplTableLen
        a1              table   aIndex, giLiveSamplAudioTable
        a1              = a1 * 0dbfs
        outch           1, a1, 2, a1
endin
