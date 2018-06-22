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

; analyze samples 
        Sfname          strget  p4
        iftno           chnget  Sfname  ; get the table number from a named chn channel
        a1              loscil 1, 1, iftno, 1

        Stest           strcat "Analyzing data for soundfile: ", Sfname
        puts            Stest, 1

#include "inc/analyze_features.inc"

; make ftables to hold the analysis parameters
        iStrLen         strlen  Sfname
        SfnameRoot      strsub  Sfname, 0, iStrLen-4            ; chop off the file type extension (e.g. .wav)
        SampTable       strcat SfnameRoot, "AmpAnalysis"
        ScpsTable       strcat SfnameRoot, "CpsAnalysis"
        StransTable     strcat SfnameRoot, "TransientAnalysis"
        
        iSoundlen       tableng iftno
        p3              = iSoundlen/sr                  ; modify p3 to allow a once-through playback of the soundfile
        iAnalyzeLen     = iSoundlen/ksmps
        iExponent       = 2

findTableSize:  ; find the next power-of-two table size to fit the analysis data
        iExponent       = iExponent+1
        iAnalyzeFtlen   pow     2, iExponent
        if iAnalyzeFtlen < iAnalyzeLen igoto findTableSize

        iAmpFtno        ftgen   0, 0, iAnalyzeFtlen, -7, 0, iAnalyzeFtlen, 0            ; default amp is 0
        iCpsFtno        ftgen   0, 0, iAnalyzeFtlen, -7, 0, iAnalyzeFtlen, 0            ; default cps is 0 Hz
        iTransFtno      ftgen   0, 0, iAnalyzeFtlen, -7, 0, iAnalyzeFtlen, 0            ; default transient is 0
                        chnset  iAmpFtno, SampTable     ; write the table number to a named chn channel for later reference
                        chnset  iCpsFtno, ScpsTable     ; write the table number to a named chn channel for later reference
                        chnset  iTransFtno, StransTable ; write the table number to a named chn channel for later reference

; write analysis data to ftables 
        kindx           init 1
        kampindx        = int(kindx - (iAttack*kr))
        kcpsindx        = int(kindx - ((1/60)*kr));(ihopsize1/(2*ksmps)))
        ktransindx      = int(kampindx - (iResponse*0.001*kr*2))
        if kampindx < 1 kgoto noAmpWrite
                        tablew  kamp, kampindx, iAmpFtno
        noAmpWrite:
        if kcpsindx < 1 kgoto noCpsWrite
                        tablew  kcps, kcpsindx, iCpsFtno
        noCpsWrite:
        if ktransindx < 1 kgoto noTransWrite
                        tablew  kTransient, ktransindx, iTransFtno
        noTransWrite:
        kindx           = kindx + 1

; write end index (length of data) to table index 0
                        tablew  kindx, 0, iAmpFtno
                        tablew  kindx, 0, iCpsFtno
                        tablew  kindx, 0, iTransFtno



