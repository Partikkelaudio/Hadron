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
; import mask table values from tab (or space) delimited text file
;******************************************************

        ; first, work around the limitation of only one string argument in an instr call
        Sstring         strget p4                               ; the string contains "maskfunc A/B filename"
        imode           = p5                                    ; import mode (0=ascii, 1=ftload)

        iSpace          strindex        Sstring, " "            ; find space in string
        ;print          iSpace
        SmaskFunc       strsub          Sstring, 0, iSpace      ; separate the mask func name...
        Sstring         strsub          Sstring, iSpace+1, -1   ; ... and the rest of the string

        iSpace          strindex        Sstring, " "            ; find space in string
        ;print          iSpace
        SmaskSel        strsub          Sstring, 0, iSpace      ; separate the A/B mask selector ...
        Sfilename       strsub          Sstring, iSpace+1, -1   ; ... and the rest of the string (this shoulld now be the filename)

        puts SmaskFunc, 1
        puts SmaskSel, 1
        puts Sfilename, 1

        SmaskTable      sprintf "gi%s_%s", SmaskFunc, SmaskSel
        imaskTableNum   chnget SmaskTable
        ;print imaskTableNum

if imode == 0 then
        ; read from file to generate new ftable in place of the previous mask table
        iTemp           ftgen   imaskTableNum, 0, giMaskSize, -23, Sfilename
else
        Sfilename_p     sprintf         "mask_files/%s", Sfilename
                        ftload          Sfilename_p, 1, imaskTableNum
endif

; force update table morf function
        kforceUpdate    metro   0.1
                        chnset  kforceUpdate, "maskTableForceUpdate"
