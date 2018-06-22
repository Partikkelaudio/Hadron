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
; set mask table values
;******************************************************

        SmaskFunc       strget p4                       ; set mask function (gain, channel, wave, freqstart, freqend, fmamptab)

        imaskSel        = p5                            ; select A (1) or B (2), the first or second mask table (we interpolate between these two to create the masks that are used by partikkel)
        if imaskSel = 2 goto B
        A:
        SmaskSel        = "A"
        goto AB_done
        B:
        SmaskSel        = "B"
        AB_done:

        SmaskTable      sprintf "gi%s_%s", SmaskFunc, SmaskSel
        imaskTableNum   chnget SmaskTable
        ;print imaskTableNum, p5, p6, p7, p8, p9, p10, p11

        ; (p6 to p71 sets new table values)
        ; ftgen does not allow more than approx 275 arguments, so for larger mask tables, use another instrument (importMaskTables.inc)
; generate new ftable, and copy it to the selected mask table
        iTemp           ftgentmp        0, 0, giMaskSize, -2, p6,p7,p8,p9,\
                                        p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,\
                                        p20,p21,p22,p23,p24,p25,p26,p27,p28,p29,\
                                        p30,p31,p32,p33,p34,p35,p36,p37,p38,p39,\
                                        p40,p41,p42,p43,p44,p45,p46,p47,p48,p49,\
                                        p50,p51,p52,p53,p54,p55,p56,p57,p58,p59,\
                                        p60,p61,p62,p63,p64,p65,p66,p67,p68,p69,\
                                        p70,p71

                        tableicopy      imaskTableNum, iTemp


; force update table morf function
        kforceUpdate    metro   0.1
                        chnset  kforceUpdate, "maskTableForceUpdate"
