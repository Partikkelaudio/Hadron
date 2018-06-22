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
; check parameter value in (preset) table

        Sparm1  strget p4
        Sparm   strcat  "i", Sparm1
        iparm   chnget Sparm
        ibogus  = p5
        itabsel = p6
        itable  = (itabsel > 0 ? giSinglePreset_M : giSinglePreset)
        ival    table   iparm, itable
        ilen    = ftlen(itable)
        ;print iparm, ival, itable, ilen
        Stest   sprintf "Parameter %s has value %f", Sparm1, ival
        puts    Stest, 1

