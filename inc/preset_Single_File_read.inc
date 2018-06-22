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
print p1, p2, p3, p4, p5
Stest strget p4
puts Stest, 1

;******************************************************
; read values from masking table, write to a master masking table (for use as source for HVS)
#define readMaskTable(tName'presetSlotNum)#
iMaskIndx       = 0
read$tName.:
iVal            table   iMaskIndx, $tName._pre
                tableiw iVal, iMaskIndx+(giMaskSize*$presetSlotNum.), $tName._Master
i$tName.Val = iVal
iMaskIndx       = iMaskIndx + 1
if iMaskIndx < giMaskSize igoto read$tName.
#

;******************************************************
; read values from modFunc table, write to a master modFunc table (for use as source for HVS)
#define readModFuncTable(tName'presetSlotNum)#
iIndx           = 0
read$tName.:
iVal            table   iIndx, $tName._pre
                tableiw iVal, iIndx+(giModFuncSize*$presetSlotNum.), $tName._Master
i$tName.Val     = iVal
iIndx           = iIndx + 1
if iIndx < giModFuncSize igoto read$tName.
#

;******************************************************
#define PresetRead(N'filename'presetSlot)#
; read preset from file, put values into master preset slot

ftload $filename., 1, giSinglePreset, gidisttab1, gifreqstartmasks1_A_pre, gifreqstartmasks1_B_pre, gifreqendmasks1_A_pre, gifreqendmasks1_B_pre, gifmampmasks1_A_pre, gifmampmasks1_B_pre, gigainmasks1_A_pre, gigainmasks1_B_pre, gichannelmasks1_A_pre, gichannelmasks1_B_pre, giwavemasks1_A_pre,giwavemasks1_B_pre, giModScale1_pre, giModTransFunc1_pre,giModTransFunc2_pre, giModTransFunc3_pre, giModTransFunc4_pre

if $presetSlot. >=0 then
; write preset name as ascii to table (master sub preset, used when saving master preset)
        iSubPresetName  = ($presetSlot. == 0 ? giSubPresetName1 : 0)
        iSubPresetName  = ($presetSlot. == 1 ? giSubPresetName2 : iSubPresetName)
        iSubPresetName  = ($presetSlot. == 2 ? giSubPresetName3 : iSubPresetName)
        iSubPresetName  = ($presetSlot. == 3 ? giSubPresetName4 : iSubPresetName)
        ipos            = 0
        ilen            strlen $filename.
        Spath           strcat gSpath, "states/"
        igLen           strlen Spath
        $filename.      strsub $filename., igLen

iteratePresetName$presetSlot.:
        if ipos >= ilen goto writeNull$presetSlot.
        iAscii          strchar $filename., ipos
        goto writeName$presetSlot.
writeNull$presetSlot.:
        iAscii          = 0     ; clear remaining part of table to get rid of any old and longer name stored there
writeName$presetSlot.:
        Schar           strsub  $filename., ipos, ipos+1
                        tableiw iAscii, ipos, iSubPresetName
        ipos            = ipos + 1
        if ipos < giPresetNameMaxLen igoto iteratePresetName$presetSlot.
endif

; transfer masking tables from "_pre" to "_Master"
$readMaskTable(gidisttab$N.'$presetSlot.)
$readMaskTable(gifreqstartmasks$N._A'$presetSlot.)      
$readMaskTable(gifreqstartmasks$N._B'$presetSlot.)
$readMaskTable(gifreqendmasks$N._A'$presetSlot.)
$readMaskTable(gifreqendmasks$N._B'$presetSlot.)
$readMaskTable(gifmampmasks$N._A'$presetSlot.)
$readMaskTable(gifmampmasks$N._B'$presetSlot.)
$readMaskTable(gigainmasks$N._A'$presetSlot.)
$readMaskTable(gigainmasks$N._B'$presetSlot.)
$readMaskTable(gichannelmasks$N._A'$presetSlot.)
$readMaskTable(gichannelmasks$N._B'$presetSlot.)
$readMaskTable(giwavemasks$N._A'$presetSlot.)
$readMaskTable(giwavemasks$N._B'$presetSlot.)

; transfer ModScale table from "_pre" to "_Master"
        iModIndx        = 0
readModScale:
        iVal            table   iModIndx, giModScale$N._pre
                        tableiw iVal, iModIndx+(giNumModulators*giNumParameters*$presetSlot.), giModScale$N._Master
        iModIndx        = iModIndx + 1
if iModIndx < (giNumModulators*giNumParameters) igoto readModScale

; transfer giSinglePreset to giMasterPreset, with index offset corresponding to preset slot number
        indx    = 0
copyParameter:
        ival    table   indx, giSinglePreset
                        tableiw ival, indx+(giNumParameters*$presetSlot.), giMasterPreset
        indx            = indx + 1
if indx < giNumParameters igoto copyParameter

; transfer modFunc tables from "_pre" to "_Master"
$readModFuncTable(giModTransFunc1'$presetSlot.)
$readModFuncTable(giModTransFunc2'$presetSlot.)
$readModFuncTable(giModTransFunc3'$presetSlot.)
$readModFuncTable(giModTransFunc4'$presetSlot.)

#

;******************************************************
; calling macros here
;******************************************************
SpresetfileIn   strget p4
Spresetfile     strcat  "states/", SpresetfileIn
Spresetfile     strcat  gSpath, Spresetfile
Stest sprintf "Instr72: %s", Spresetfile
puts Stest, 1
iPresetSlot     = p5
$PresetRead(1'Spresetfile'iPresetSlot)
;puts Spresetfile, 1
SoutvalName     sprintf "pre%iname", iPresetSlot
SoutvalNam      sprintf "preset%iloaded", iPresetSlot
                ;outvalue SoutvalName, SpresetfileIn
                ;chnset Spresetfile, SoutvalNam
                ;chnset ktest, "kstartTesting"
