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

iPresetTable = giSinglePreset
Spresetfile     strget p4
Spresetfile     strcat  "states/", Spresetfile
Spresetfile     strcat  gSpath, Spresetfile
; write preset table and masking tables to disk
        ftsave Spresetfile, 1, giSinglePreset, gidisttab1, \
                        gifreqstartmasks1_A, gifreqstartmasks1_B, \
                        gifreqendmasks1_A, gifreqendmasks1_B, \
                        gifmampmasks1_A, gifmampmasks1_B, \
                        gigainmasks1_A, gigainmasks1_B, \ 
                        gichannelmasks1_A, gichannelmasks1_B, \
                        giwavemasks1_A, giwavemasks1_B, \
                        giModScale1,\
                        giModTransFunc1, giModTransFunc2, \
                        giModTransFunc3, giModTransFunc4


