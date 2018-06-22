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
; live sampled segment combobox administration
;******************************************************
        instr 19
        ivoice  = p4    ; the source number, combobox number
        isegment chnget"lastRecordedSegment"
	print ivoice, isegment
        Sbox    sprintf "source%i_id", ivoice
	Segment	sprintf "segment_%i", isegment
	Segment1 strcat ", ", Segment
	Sitems	strcat gSsourceItems, Segment1
        Sitems2 sprintf "items(%s)", Sitems
                chnset  Sitems2, Sbox
;timout 0, 1, skip
;        Sval    sprintfk "value(%i)", isegment+giNumberOfSourceItems
;                chnset  Sval, Sbox
;	puts Sval, 1 
;skip:

	Scoreline sprintfk {{i 20 0 1 1 %i "%s"}}, ivoice, Segment
	scoreline Scoreline, 1

        endin

;******************************************************
; parameter automation, set tables (source waveforms)
;******************************************************
        instr 20

        iVoice          = p4                    ; partikkel instance
        iWaveSlot       = p5                    ; wave slot (1,2,3 or 4)

        SwaveSlot       sprintf "Partikkel%iSourceWave%i", iVoice, iWaveSlot
        SwaveName       strget p6
        ;puts SwaveName, 1

; set flag for single cycle waveform mode
        iSingleCycle     = -1
        iTestSine       strcmp  SwaveName, "Sine"
        iSingleCycle    = (iTestSine == 0 ?  0 : iSingleCycle)
        iTest           strcmp  SwaveName, "Triangle"
        iSingleCycle    = (iTest == 0 ?  0 : iSingleCycle)
        iTest           strcmp  SwaveName, "Square"
        iSingleCycle    = (iTest == 0 ?  0 : iSingleCycle)
        iTest           strcmp  SwaveName, "Saw"
        iSingleCycle    = (iTest == 0 ?  0 : iSingleCycle)
        iTest           strcmp  SwaveName, "Pulse"
        iSingleCycle    = (iTest == 0 ?  0 : iSingleCycle)
; then set it for the waveslot being processed
        if iWaveSlot != 1 goto setSingleCycleFlag2
        gkSingleCycle1  = iSingleCycle
setSingleCycleFlag2:
        if iWaveSlot != 2 goto setSingleCycleFlag3
        gkSingleCycle2  = iSingleCycle
setSingleCycleFlag3:
        if iWaveSlot != 3 goto setSingleCycleFlag4
        gkSingleCycle3  = iSingleCycle
setSingleCycleFlag4:
        if iWaveSlot != 4 goto noSetSingleCycleFlag
        gkSingleCycle4  = iSingleCycle
noSetSingleCycleFlag:

; reassign waveform name for bandlimited waveforms
        iSmoothName     = (iSingleCycle == 0 && iTestSine != 0 ? 1 : 0)
        if iSmoothName == 0 goto noSmoothName
        SwaveName       strcat  SwaveName, "Smooth"
noSmoothName:

; special processing for live sampled segments
        ; test if "segment" is found in the start of the wave name
        ipos strindex   SwaveName, "segment"
        if ipos != 0 goto liveFollowMode
        SsegmentNum     strsub SwaveName, 8
        iSegmentNum     strtol SsegmentNum      ; this refers to a live sampled segment number
        iSegmentNum     = iSegmentNum + 10000   ; 10000 is added to the live sampled segment number, to keep it in a separate range from the table numbers for sound files
	;print iSegmentNum
        goto setWaveformNumber

liveFollowMode:
        ; test if "audioInput" is found in the start of the wave name
        ipos strindex   SwaveName, "audioInput"
        if ipos != 0 goto noLiveSampledSegment
        iSegmentNum     = giLiveFeed            ; this refers to a table number, containing a circular buffer for live audio recording
        goto setWaveformNumber

noLiveSampledSegment:
        puts SwaveName, 1
        iSegmentNum     chnget SwaveName        ; this refers to a table number, containing a loaded soundfile or a single cycle waveform
        if iSegmentNum != 0 goto doneLoadingFile
        Sscoreline      sprintf {{i 60 0 .1 "%s"
                                  i 61 0 .1 "%s"}}, SwaveName, SwaveName
        scoreline_i     Sscoreline
checkSoundLoaded:
        iSegmentNum     chnget SwaveName        ; this refers to a table number, containing a loaded soundfile
        if iSegmentNum == 0 goto holdWhileLoadingSound
doneLoadingFile:
        SwaveName_orig  strcat SwaveName, "_orig"
        i_origkey       chnget SwaveName_orig   ; read original key (in cps) for this sample
        SwaveSlot_orig  strcat SwaveSlot, "_orig"
                        chnset i_origkey, SwaveSlot_orig        ; write original key to waveslot channel

setWaveformNumber:
        SloadStr        sprintf "Set source wave:%s, segmentOrTableNum:%i, voice:%i, slot:%i", SwaveName, iSegmentNum, iVoice, iWaveSlot
        puts SloadStr, 1
                        chnset  iSegmentNum, SwaveSlot
; output the assigned wave name to host
                        SwaveSlotName strcat SwaveSlot, "Name"
                        ;outvalue SwaveSlotName, SwaveName

; set flags for liveFollow or live sampling mode
        iFollowMode     strindex SwaveName, "audioInput"
        iLiveSamplMode  strindex SwaveName, "segment"

; find the analysis ftables corresponding to the assigned source wave, using SwaveName to format the table names and chn to lookup the numbers
        iStrLen         strlen  SwaveName
        SwnameRoot      strsub  SwaveName, 0, iStrLen-4         ; chop off the file type extension (e.g. .wav)
        SampTable       strcat SwnameRoot, "AmpAnalysis"
        iAmpFtno        chnget SampTable
        ; special case for live follow mode, for live sampling segments, and for classic wavetable sources
        iAmpFtno        = (iFollowMode == 0 ? giLiveFeedAmp : iAmpFtno)
        iAmpFtno        = (iLiveSamplMode == 0 ? giLiveSamplingAmp : iAmpFtno)
        iAmpFtno        = (iSingleCycle == 0 ? giAmpFnDefault : iAmpFtno)
        SAmpAnalysFtab  sprintf "AmpAnalysis%i", iWaveSlot
                        chnset iAmpFtno, SAmpAnalysFtab
        ScpsTable       strcat SwnameRoot, "CpsAnalysis"
        iCpsFtno        chnget ScpsTable
        ; special case for live follow mode, for live sampling segments, and for classic wavetable sources
        iCpsFtno        = (iFollowMode == 0 ? giLiveFeedCps : iCpsFtno)
        iCpsFtno        = (iLiveSamplMode == 0 ? giLiveSamplingCps : iCpsFtno)
        iCpsFtno        = (iSingleCycle == 0 ? giCpsFnDefault : iCpsFtno)
        SCpsAnalysFtab  sprintf "CpsAnalysis%i", iWaveSlot
                        chnset iCpsFtno, SCpsAnalysFtab
        StransTable     strcat SwnameRoot, "TransientAnalysis"
        iTransFtno      chnget StransTable
        ; special case for live follow mode, for live sampling segments, and for classic wavetable sources
        iTransFtno      = (iFollowMode == 0 ? giLiveFeedTrans : iTransFtno)
        iTransFtno      = (iLiveSamplMode == 0 ? giLiveSamplingTrans : iTransFtno)
        iTransFtno      = (iSingleCycle == 0 ? giTransFnDefault : iTransFtno)
        STransAnalysFtab sprintf "TransientAnalysis%i", iWaveSlot
                        chnset iTransFtno, STransAnalysFtab

; get the analysis length
        kLengthAnalys   table   0, iAmpFtno
        ; special case for live follow mode and for live sampling segments
        kLengthAnalys   = (iFollowMode == 0 ? giLiveFeedAnalyzeLen : kLengthAnalys)
        kLengthAnalys   = (iLiveSamplMode == 0 ? giLiveSamplingAnalyzeLen : kLengthAnalys)
        SAnalysisLength sprintf "AnalysisLength%i", iWaveSlot
                        chnset kLengthAnalys, SAnalysisLength


; write soundfile name as ascii to table, to enable saving soundfile name as part of preset
#define WriteSoundfileName(Voice'Slot)#

; first, remove "Smooth" from the single cycle waveforms that use it in their name
        iTestS1         strcmp  SwaveName, "TriangleSmooth"
        iTestS2         strcmp  SwaveName, "SquareSmooth"
        iTestS3         strcmp  SwaveName, "SawSmooth"
        iTestS4         strcmp  SwaveName, "PulseSmooth"
        iTestS          = (iTestS1 == 0 ? 1 : 0)
        iTestS          = (iTestS2 == 0 ? 1 : iTestS)
        iTestS          = (iTestS3 == 0 ? 1 : iTestS)
        iTestS          = (iTestS4 == 0 ? 1 : iTestS)
        if iTestS == 0 goto noSmooth$Voice.$Slot.
        ilen            strlen SwaveName
        SwaveName       strsub  SwaveName, 0, ilen-6
        puts SwaveName, 1
noSmooth$Voice.$Slot.:

; then do the conversion from characters to ascii
        ipos            = -1
        iStrLen         strlen SwaveName
WriteAsciiLoop_$Voice._$Slot.:
        ipos            = ipos + 1
        iAscii          strchar SwaveName, ipos
        ;print iAscii
; write ascii to table 
        tableiw         iAscii, ipos, giPartikkel$Voice.SourceWave$Slot.Name    
        if ipos < iStrLen goto WriteAsciiLoop_$Voice._$Slot.
        SoutvalName     sprintf "p%iwav%iname", $Voice., $Slot.
                        ;outvalue SoutvalName, SwaveName
#

; kludgy hack to allow dynamic wavetable name
if iVoice == 1 goto voice1
if iVoice == 2 goto voice2
Swarning  = "instr 20, voice number > 2 not implemented"

voice1:
if iWaveSlot == 1 goto v1Slot1
if iWaveSlot == 2 goto v1Slot2
if iWaveSlot == 3 goto v1Slot3
if iWaveSlot == 4 goto v1Slot4
v1Slot1:
$WriteSoundfileName(1'1)
goto end
v1Slot2:
$WriteSoundfileName(1'2)
goto end
v1Slot3:
$WriteSoundfileName(1'3)
goto end
v1Slot4:
$WriteSoundfileName(1'4)
goto end

voice2:
if iWaveSlot == 1 goto v2Slot1
if iWaveSlot == 2 goto v2Slot2
if iWaveSlot == 3 goto v2Slot3
if iWaveSlot == 4 goto v2Slot4
v2Slot1:
$WriteSoundfileName(2'1)
goto end
v2Slot2:
$WriteSoundfileName(2'2)
goto end
v2Slot3:
$WriteSoundfileName(2'3)
goto end
v2Slot4:
$WriteSoundfileName(2'4)
goto end


holdWhileLoadingSound:
        kSegmentNum     init 0
        kSegmentLoaded  init 0
        kSegmentLoaded  = (kSegmentNum > 0 ? 1 : 0)
        kSegmentNum     chnget SwaveName                ; this refers to a table number, containing a loaded soundfile
        if kSegmentNum == 0 goto end                    ; don't do anything while waiting for sound to load
        if kSegmentLoaded == 1 goto doneLoadingFile     ; do the reinit (on next line) only once
reinit checkSoundLoaded                                 ; reinit and assign sound to source waveform when loaded

end:

        endin
;******************************************************
