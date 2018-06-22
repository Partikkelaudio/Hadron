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

; save analysis tables to file

        Sfname          strget  p4

        Stest           strcat "Saving analysis data for soundfile: ", Sfname
        puts            Stest, 1

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
        iAmpFtno        chnget SampTable
        iCpsFtno        chnget ScpsTable
        iTransFtno      chnget StransTable
        ftsave          Sampfile, 1, iAmpFtno
        ftsave          Scpsfile, 1, iCpsFtno
        ftsave          Stransfile, 1, iTransFtno

