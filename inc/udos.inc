/*

    Copyright (C) 2010-2016 Oeyvind Brandtsegg and Partikkelaudio.com

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


; this UDO is needed to upsample the samplepos pointer with interpolation
; simply using interp will give artifacts when the time pointer wraps around (from 1 to 0)
; UpsampPhasor ensures correct interpolation across the wraparound boundary,

        gikr = kr
        opcode UpsampPhasor, a,k
                kval xin
                setksmps 1
                kold init 0
                if (abs(kold-kval)<0.5) && (abs(kold-kval)>0) then
                reinit interpolator
                elseif abs(kold-kval)>0.5 then; when phasor restarts 
                kold = kold-1
                reinit interpolator
                endif
                interpolator:
                aval linseg i(kold), 1/gikr, i(kval), 1/gikr, i(kval)
                rireturn
                kold = kval
                xout aval
        endop
