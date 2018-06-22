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

; load samples 
Sfname          strget  p4
;print p1,p2,p3
;puts Sfname, 1
Sdirfname       strcat  "samples/", Sfname
Sdirfname       strcat  gSpath, Sdirfname
;puts Sdirfname, 1
iftno           ftgen   0, 0, 0, 1, Sdirfname, 0, 0, 1
                chnset  iftno, Sfname                   ; write the table number to a named chn channel for later reference
i_orig          = ftcps(iftno)                          ; read original key from sound file header
i_orig          = (i_orig == -1 ? 261.625565 : i_orig)  ; use default (middle C) if not set
i_orig          = i_orig*(sr/ftsr(iftno))               ; and relate it to the original sample rate for this soundfile

Sfname_orig     strcat  Sfname, "_orig"
                chnset  i_orig, Sfname_orig             ; write the original key (in cps) to a named channel for later reference
giNumSoundfiles = giNumSoundfiles+1
                chnset  giNumSoundfiles, "numberOfSoundFilesLoaded"
itest chnget "numberOfSoundFilesLoaded"         
Stest sprintf "Num files loaded: %i %s %s", itest, Sfname, Sdirfname
puts Stest, 1
