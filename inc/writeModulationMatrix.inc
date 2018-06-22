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

; write offset and scale values to the modulation matrix
; one instr call modifies scaling for one matrix point

; parse string representing modulator to parameter assignment
; must be in format ('mod       to      parameter'), use a single tab and no space between each word
        Sinput          strget          p4
        itabpos         strindex        Sinput, "\t"            ; find tab position in string
        Smod            strsub          Sinput, 0, itabpos      ; isolate modulator name
        Smod_i          strcat          "i", Smod               ; add "i" to the beginning of the modulator name, this is the named chn channel for modulator index
        iModulator      chnget          Smod_i                  ; modulator number, starting at zero
        Sparm           strsub          Sinput, itabpos+4, -1   ; isolate parameter name
        Sparm_i         strcat          "i", Sparm              ; add "i" to the beginning of the modulator name, this is the named chn channel for modulator index
        iParameter      chnget          Sparm_i                 ; parameter number, starting at zero

; The following should print a warning for unrecognized modulators and parameters,
; however, it will silently accept parameter names used as modulators and vice versa.
; This should be fixed, but currently we don't differentiate between chn channel names used for parameter and modulator names,
; probably, the chn channel names should be differentiated (e.g. mod_iLFO2 and parm_iLFO2_Amp)

        iNotLFO1        strcmp          "LFO1", Smod
        if iNotLFO1 == 0 goto skipModTest
        if iModulator == 0 goto warningPrintMod
skipModTest:
        if iParameter == 0 goto warningPrintParm
        goto contin
warningPrintMod:
        Swarning        sprintf "error: modmatrix does not recognize modulator %s", Smod
        puts Swarning, 1
        if iParameter == 0 goto warningPrintParm
        goto done
warningPrintParm:
        Swarning        sprintf "error: modmatrix does not recognize parameter %s", Sparm
        puts Swarning, 1
        goto done
        contin:


; allow p5 to be either string or number
; p5 is scaling factor of modulator to parameter
        iScale          = p5            
	Sscale		strget p5
	ip5len 		strlen Sscale
	ihack           strcmp Sscale,"hello"
	ip5len          *= ihack
	if ip5len > 0 then
	iScale 		strtod Sscale
	endif

        iSlot           = p6            ; preset slot

        print iModulator, iParameter
        puts Sinput, 1
        puts Smod_i, 1
        puts Sparm_i, 1
        print iScale

        index           = (iModulator*giNumParameters)+iParameter
                        tableiw iScale, index, giModScale1

        indexM          = index + (giNumModulators*giNumParameters*iSlot)
        tableiw         iScale, indexM, giModScale1_Master

        done:




