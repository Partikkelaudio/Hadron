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

; write parameter value to the master preset (slot 0) and to the single preset table.
; If masterpresets are activated (preset interpolation), the single preset table will be overwritten,
; but in this case tha value from the master preset will be active

        Sparm           strget p4
        Sparm           strcat  "i", Sparm
        indx            chnget Sparm
        ival            = p5

        tableiw         ival, indx, giMasterPreset 
        tableiw         ival, indx, giSinglePreset

        ;if indx != 0 goto done
        ;puts Sparm, 1
        ;print indx, ival, giSinglePreset
        ;done:
