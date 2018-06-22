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

;***************************************************
;ftables for partikkel
;***************************************************


#define PartikkelTables(N) #
        gidisttab$N.            ftgen   0, 0, giMaskSize, 16, 1, giMaskSize, 0, 0       ; probability distribution for random grain masking

        gifreqstartmasks$N.     ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; start freq scalers, per grain
        gifreqstartmasks$N._A   ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; ... used for mask morphing
        gifreqstartmasks$N._B   ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; ...

        gifreqendmasks$N.       ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; end freq scalers, per grain
        gifreqendmasks$N._A     ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; ... used for mask morphing
        gifreqendmasks$N._B     ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; ...

        gifmampmasks$N.         ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; FM index scalers, per grain
        gifmampmasks$N._A       ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; ... used for mask morphing
        gifmampmasks$N._B       ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; ...

        gigainmasks$N.          ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; gain masking table, amplitude for individual grains
        gigainmasks$N._A                ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; ... used for mask morphing
        gigainmasks$N._B                ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; ...

        gichannelmasks$N.       ftgen   0, 0, giMaskSize, -2,  0, 0,  0.5       ; channel masking table, output routing for individual grains (zero based, a value of 0.0 routes to output 1)
        gichannelmasks$N._A     ftgen   0, 0, giMaskSize, -2,  0, 0,  0.5       ; ... used for mask morphing
        gichannelmasks$N._B     ftgen   0, 0, giMaskSize, -2,  0, 0,  0.5       ; ...

        ; Wave mix : set gain per source waveform per grain, 
        ; in groups of 5 amp values, reflecting source1, source2, source3, source4, and the 5th slot is for trainlet amplitude.
        giwavemasks$N.          ftgen   0, 0, giMaskSize, -2, 0, 0,   1,1,0,0,0
        giwavemasks$N._A                ftgen   0, 0, giMaskSize, -2, 0, 0,   1,1,0,0,0 ; ... used for mask morphing
        giwavemasks$N._B                ftgen   0, 0, giMaskSize, -2, 0, 0,   1,1,0,0,0 ; ...

        ; write ftable numbers to named chn channels, to enable using strings in the score to point to ftable numbers
        Sdisttab                sprintf "gidisttab%i", $N.
        ;puts Sdisttab, 1 ; actually needed for Cabbage to force the processing of the sprintf, weird.. but we get an header init error without it

        Sfreqstartmasks sprintf "gifreqstartmasks%i", $N.
        Sfreqstartmasks_A       sprintf "gifreqstartmasks%i_A", $N.
        Sfreqstartmasks_B       sprintf "gifreqstartmasks%i_B", $N.

        Sfreqendmasks           sprintf "gifreqendmasks%i", $N.
        Sfreqendmasks_A         sprintf "gifreqendmasks%i_A", $N.
        Sfreqendmasks_B         sprintf "gifreqendmasks%i_B", $N.

        Sfmampmasks             sprintf "gifmampmasks%i", $N.
        Sfmampmasks_A           sprintf "gifmampmasks%i_A", $N.
        Sfmampmasks_B           sprintf "gifmampmasks%i_B", $N.

        Sgainmasks              sprintf "gigainmasks%i", $N.
        Sgainmasks_A            sprintf "gigainmasks%i_A", $N.
        Sgainmasks_B            sprintf "gigainmasks%i_B", $N.

        Schannelmasks           sprintf "gichannelmasks%i", $N.
        Schannelmasks_A         sprintf "gichannelmasks%i_A", $N.
        Schannelmasks_B         sprintf "gichannelmasks%i_B", $N.

        Swavemasks              sprintf "giwavemasks%i", $N.
        Swavemasks_A            sprintf "giwavemasks%i_A", $N.
        Swavemasks_B            sprintf "giwavemasks%i_B", $N.

        chnset  gidisttab$N., Sdisttab

        chnset  gifreqstartmasks$N., Sfreqstartmasks
        chnset  gifreqstartmasks$N._A, Sfreqstartmasks_A
        chnset  gifreqstartmasks$N._B, Sfreqstartmasks_B

        chnset  gifreqendmasks$N., Sfreqendmasks
        chnset  gifreqendmasks$N._A, Sfreqendmasks_A
        chnset  gifreqendmasks$N._B, Sfreqendmasks_B

        chnset  gifmampmasks$N., Sfmampmasks
        chnset  gifmampmasks$N._A, Sfmampmasks_A
        chnset  gifmampmasks$N._B, Sfmampmasks_B

        chnset  gigainmasks$N., Sgainmasks
        chnset  gigainmasks$N._A, Sgainmasks_A
        chnset  gigainmasks$N._B, Sgainmasks_B

        chnset  gichannelmasks$N., Schannelmasks
        chnset  gichannelmasks$N._A, Schannelmasks_A
        chnset  gichannelmasks$N._B, Schannelmasks_B

        chnset  giwavemasks$N., Swavemasks
        chnset  giwavemasks$N._A, Swavemasks_A
        chnset  giwavemasks$N._B, Swavemasks_B

; temporary tables for presets
        gidisttab$N._pre                        ftgen   0, 0, giMaskSize, 16, 1, giMaskSize, 0, 0       ; probability distribution for random grain masking

        gifreqstartmasks$N._A_pre       ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; ... used for mask morphing
        gifreqstartmasks$N._B_pre       ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; ...

        gifreqendmasks$N._A_pre         ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; ... used for mask morphing
        gifreqendmasks$N._B_pre         ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; ...

        gifmampmasks$N._A_pre           ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; ... used for mask morphing
        gifmampmasks$N._B_pre           ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; ...

        gigainmasks$N._A_pre            ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; ... used for mask morphing
        gigainmasks$N._B_pre            ftgen   0, 0, giMaskSize, -2, 0, 0,   1         ; ...

        gichannelmasks$N._A_pre         ftgen   0, 0, giMaskSize, -2,  0, 0,  0.5       ; ... used for mask morphing
        gichannelmasks$N._B_pre         ftgen   0, 0, giMaskSize, -2,  0, 0,  0.5       ; ...

        giwavemasks$N._A_pre            ftgen   0, 0, giMaskSize, -2, 0, 0,   1,1,0,0,0 ; ... used for mask morphing
        giwavemasks$N._B_pre            ftgen   0, 0, giMaskSize, -2, 0, 0,   1,1,0,0,0 ; ...

        gidisttab$N._Master             ftgen   0, 0, giMaskSize*4, 16, 1, giMaskSize*4, 0, 0   ; probability distribution for random grain masking

        gifreqstartmasks$N._A_Master    ftgen   0, 0, giMaskSize*4, -2, 0, 0,   1       ; ... used for mask morphing
        gifreqstartmasks$N._B_Master    ftgen   0, 0, giMaskSize*4, -2, 0, 0,   1       ; ...

        gifreqendmasks$N._A_Master      ftgen   0, 0, giMaskSize*4, -2, 0, 0,   1       ; ... used for mask morphing
        gifreqendmasks$N._B_Master      ftgen   0, 0, giMaskSize*4, -2, 0, 0,   1       ; ...

        gifmampmasks$N._A_Master                ftgen   0, 0, giMaskSize*4, -2, 0, 0,   1       ; ... used for mask morphing
        gifmampmasks$N._B_Master                ftgen   0, 0, giMaskSize*4, -2, 0, 0,   1       ; ...

        gigainmasks$N._B_Master         ftgen   0, 0, giMaskSize*4, -2, 0, 0,   1       ; ... used for mask morphing
        gigainmasks$N._A_Master         ftgen   0, 0, giMaskSize*4, -2, 0, 0,   1       ; ...

        gichannelmasks$N._A_Master      ftgen   0, 0, giMaskSize*4, -2,  0, 0,  0.5     ; ... used for mask morphing
        gichannelmasks$N._B_Master      ftgen   0, 0, giMaskSize*4, -2,  0, 0,  0.5     ; ...

        giwavemasks$N._A_Master         ftgen   0, 0, giMaskSize*4, -2, 0, 0,   1,1,0,0,0       ; ... used for mask morphing
        giwavemasks$N._B_Master         ftgen   0, 0, giMaskSize*4, -2, 0, 0,   1,1,0,0,0       ; ...
        
#

$PartikkelTables(1)
;$PartikkelTables(2)
;$PartikkelTables(3)
;$PartikkelTables(4)

#define ModulatorTables(N) #
        ; multipliers for scaling of modulator signals
        giModScale$N.                   ftgen   0, 0, giNumModulators*giNumParameters, -2, 0            ; the table read by the modulation matrix
        giModScale$N._pre               ftgen   0, 0, giNumModulators*giNumParameters, -2, 0            ; temporary table used when importing presets
        giModScale$N._Master            ftgen   0, 0, giNumModulators*giNumParameters*4, -2, 0          ; table to hold 4 presets (master preset)
#
$ModulatorTables(1)
;$ModulatorTables(2)
;$ModulatorTables(3)
;$ModulatorTables(4)

        ; modulation matrix tables
        giModulators                    ftgen   0, 0, giNumModulators*giNumParameters, -2, 0            ; modulator signals continuously written to this table


