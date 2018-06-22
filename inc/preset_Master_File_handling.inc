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

; macro to generate a string from ascii code stored in an ftable
#define GenerateStringFromAscii(tableName)#
	Sout	= ""
	ipos	= 0
iterate$tableName:
	iAscii	table	ipos, $tableName
	if iAscii == 0 goto done$tableName
	Schar	sprintf	"%c", iAscii
	Sout	strcat Sout, Schar
	ipos	= ipos + 1
	goto iterate$tableName
done$tableName:
	;puts	Sout, 1
#

Spresetfile	strget p4
Spresetfile	strcat	"presets/", Spresetfile
Spresetfile	strcat	gSpath, Spresetfile
Stest		sprintf "master preset handling: %s", Spresetfile
puts Stest, 1
if p5 > 0 goto read

;********************************************
save:

; read controller values and other parameters to be saved with the master preset
	iMidiCtrl1indx  	chnget	"iMidiCtrl1"
	iMidiCtrl2indx  	chnget	"iMidiCtrl2"
	iMidiCtrl3indx  	chnget	"iMidiCtrl3"
	iMidiCtrl4indx  	chnget	"iMidiCtrl4"
	kMidiCtrl1		table iMidiCtrl1indx, giModulators
	kMidiCtrl2		table iMidiCtrl2indx, giModulators
	kMidiCtrl3		table iMidiCtrl3indx, giModulators
	kMidiCtrl4		table iMidiCtrl4indx, giModulators
	kMidiCtrl5		chnget "presetX"
	kMidiCtrl6		chnget "presetY"
		tablew	kMidiCtrl1, 0, giMasterParams
		tablew	kMidiCtrl2, 1, giMasterParams
		tablew	kMidiCtrl3, 2, giMasterParams
		tablew	kMidiCtrl4, 3, giMasterParams
		tablew	kMidiCtrl5, 4, giMasterParams
		tablew	kMidiCtrl6, 5, giMasterParams


ftsave Spresetfile, 1, giSubPresetName1, giSubPresetName2, giSubPresetName3, giSubPresetName4, \
giPartikkel1SourceWave1Name, giPartikkel1SourceWave2Name, giPartikkel1SourceWave3Name, giPartikkel1SourceWave4Name,\
giMasterParams ;; *(Live sampling table not saved)* ;;, giLiveSamplAudioTable, giLiveSamplAttackTable

goto end
;********************************************

read:

ftload Spresetfile, 1, giSubPresetName1, giSubPresetName2, giSubPresetName3, giSubPresetName4, \
giPartikkel1SourceWave1Name, giPartikkel1SourceWave2Name, giPartikkel1SourceWave3Name, giPartikkel1SourceWave4Name,\
giMasterParams ;; *(Live sampling table not read)* ;;, giLiveSamplAudioTable, giLiveSamplAttackTable

; read controller values and other parameters to be recalled with the master preset
	kMidiCtrl1		table 0, giMasterParams
	kMidiCtrl2		table 1, giMasterParams
	kMidiCtrl3		table 2, giMasterParams
	kMidiCtrl4		table 3, giMasterParams
	kMidiCtrl5		table 4, giMasterParams
	kMidiCtrl6		table 5, giMasterParams
	iMidiCtrl1indx  	chnget	"iMidiCtrl1"
	iMidiCtrl2indx  	chnget	"iMidiCtrl2"
	iMidiCtrl3indx  	chnget	"iMidiCtrl3"
	iMidiCtrl4indx  	chnget	"iMidiCtrl4"
	tablew	kMidiCtrl1, iMidiCtrl1indx, giModulators
	tablew	kMidiCtrl2, iMidiCtrl2indx, giModulators
	tablew	kMidiCtrl3, iMidiCtrl3indx, giModulators
	tablew	kMidiCtrl4, iMidiCtrl4indx, giModulators
		chnset	kMidiCtrl5, "presetX"
		chnset	kMidiCtrl6, "presetY"

; get the names of the single presets to be loaded in the master preset
; load each single preset
$GenerateStringFromAscii(giSubPresetName1)
Sscoreline	sprintf	{{i 72 0 1 "%s" 0}}, Sout
scoreline_i	Sscoreline

$GenerateStringFromAscii(giSubPresetName2)
Sscoreline	sprintf	{{i 72 0 1 "%s" 1}}, Sout
scoreline_i	Sscoreline

$GenerateStringFromAscii(giSubPresetName3)
Sscoreline	sprintf	{{i 72 0 1 "%s" 2}}, Sout
scoreline_i	Sscoreline

$GenerateStringFromAscii(giSubPresetName4)
Sscoreline	sprintf	{{i 72 0 1 "%s" 3}}, Sout
scoreline_i	Sscoreline

; parse ascii code representing sound file names, call instr 20 to assign sound files to wave slots

$GenerateStringFromAscii(giPartikkel1SourceWave1Name)
instance	= 1
Sscoreline	sprintf	{{i 20 0 1 %i 1 "%s"}}, instance, Sout
scoreline_i	Sscoreline
$GenerateStringFromAscii(giPartikkel1SourceWave2Name)
Sscoreline	sprintf	{{i 20 0 1 %i 2 "%s"}}, instance, Sout
scoreline_i	Sscoreline
$GenerateStringFromAscii(giPartikkel1SourceWave3Name)
Sscoreline	sprintf	{{i 20 0 1 %i 3 "%s"}}, instance, Sout
scoreline_i	Sscoreline
$GenerateStringFromAscii(giPartikkel1SourceWave4Name)
Sscoreline	sprintf	{{i 20 0 1 %i 4 "%s"}}, instance, Sout
scoreline_i	Sscoreline
end:
