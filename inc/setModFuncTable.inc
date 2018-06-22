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
; set modulator transfer function table
;******************************************************

        iModfuncNo      = p4                    ; select modulator function number (1,2,3,4)

        SfuncTable      sprintf "giModTransFunc%i", iModfuncNo
        ifuncTableNum   chnget SfuncTable
        ;print ifuncTableNum, p5, p6, p7, p8, p9

; generate new ftable, and copy it to the selected func table
        iTemp           ftgentmp        0, 0, giModFuncSize, p5,p6,p7,p8,p9,\
                                        p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,\
                                        p20,p21,p22,p23,p24,p25,p26,p27,p28,p29,\
                                        p30,p31,p32,p33,p34,p35,p36,p37,p38,p39,\
                                        p40,p41,p42,p43,p44,p45,p46,p47,p48,p49,\
                                        p50,p51,p52,p53,p54,p55,p56,p57,p58,p59,\
                                        p60,p61,p62,p63,p64,p65,p66,p67,p68,p69,\
                                        p70,p71

                        tableicopy      ifuncTableNum, iTemp

