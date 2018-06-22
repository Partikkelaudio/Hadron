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

; clear the mask tables
; used when importing text presets

                                        tableicopy      gifreqstartmasks1_A, giMaskEmpty
                                        tableicopy      gifreqstartmasks1_B, giMaskEmpty
                                        tableicopy      gifreqendmasks1_A, giMaskEmpty
                                        tableicopy      gifreqendmasks1_B, giMaskEmpty
                                        tableicopy      gifmampmasks1_A, giMaskEmpty
                                        tableicopy      gifmampmasks1_B, giMaskEmpty
                                        tableicopy      gigainmasks1_A, giMaskEmpty
                                        tableicopy      gigainmasks1_B, giMaskEmpty
                                        tableicopy      gichannelmasks1_A, gichannelmasksEmpty
                                        tableicopy      gichannelmasks1_B, gichannelmasksEmpty
                                        tableicopy      giwavemasks1_A, giwavemasksEmpty
                                        tableicopy      giwavemasks1_B, giwavemasksEmpty

; force update table morf function
        kforceUpdate    metro   0.1
                        chnset  kforceUpdate, "maskTableForceUpdate"



