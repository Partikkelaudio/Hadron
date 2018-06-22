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

; load analysis tracks for sound samples 
        Sfname          strget  p4
        iStrLen         strlen  Sfname
        SfnameRoot      strsub  Sfname, 0, iStrLen-4            ; chop off the file type extension (e.g. .wav)
        Sampfile        strcat  SfnameRoot, ".amp"
        Scpsfile        strcat  SfnameRoot, ".cps"
        Stransfile      strcat  SfnameRoot, ".trans"
        Sampfile        strcat  "samples/", Sampfile
        Scpsfile        strcat  "samples/", Scpsfile
        Stransfile      strcat  "samples/", Stransfile
        Sampfile        strcat  gSpath, Sampfile
        Scpsfile        strcat  gSpath, Scpsfile
        Stransfile      strcat  gSpath, Stransfile
        SampTable       strcat SfnameRoot, "AmpAnalysis"
        ScpsTable       strcat SfnameRoot, "CpsAnalysis"
        StransTable     strcat SfnameRoot, "TransientAnalysis"
        iAmpFtno        ftgen   0, 0, 65536, 2, 0               ; allocate table for importing table data from file (size is just an estimate)
        iCpsFtno        ftgen   0, 0, 65536, 2, 0               ; allocate table for importing table data from file (size is just an estimate)
        iTransFtno      ftgen   0, 0, 65536, 2, 0               ; allocate table for importing table data from file (size is just an estimate)
        puts Sampfile, 1
        puts Scpsfile, 1
        print ftlen(iAmpFtno)
        ftload          Sampfile, 1, iAmpFtno
        print ftlen(iAmpFtno)
        ftload          Scpsfile, 1, iCpsFtno
        ftload          Stransfile, 1, iTransFtno
;       puts SampTable, 1
                        chnset iAmpFtno, SampTable      ; write the table number to a named chn channel for later reference
                        chnset iCpsFtno, ScpsTable      ; write the table number to a named chn channel for later reference
                        chnset iTransFtno, StransTable  ; write the table number to a named chn channel for later reference

