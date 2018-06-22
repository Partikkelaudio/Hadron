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
; record output
;***************************************************
        instr 398
; audio input
        ainL            chnget  "MasterAudioLeft"
        ainR            chnget  "MasterAudioRight"

        fout            "test.wav", 14, ainL*0dbfs, ainR*0dbfs

        endin
;***************************************************

;***************************************************
; signal amp display for the (FLTK) preset programming helper
;***************************************************
        instr 399
; audio input
        ainL            chnget  "MasterAudioLeft"
        ainR            chnget  "MasterAudioRight"

        kupdate         metro   8
        krmsL           rms     ainL
        krmsR           rms     ainR
        kVU_L           max_k   ainL, kupdate, 1
        kVU_R           max_k   ainR, kupdate, 1

outkc   1, 8, kVU_L, 0, 1
outkc   1, 9, kVU_R, 0, 1
/*
        iTransEnv1indx          chnget  "iTransientEnvelope1"
        kTransFollow1           table iTransEnv1indx, giModulators
outkc   1, 10, kTransFollow1, 0, 1

        iAnalysTrans1indx       chnget  "iTransientAnalysis1"
        kTrans1                 table iAnalysTrans1indx, giModulators
outkc   1, 11, kTrans1, 0, 1

        iFunc1indx              chnget  "iFunc1"
        kFunc1                  table iFunc1indx, giModulators
outkc   1, 12, kFunc1, -1, 1

        iMultiplier1indx        chnget  "iMultiplier1"
        kMultiplier1            table iMultiplier1indx, giModulators
outkc   1, 13, kMultiplier1, -1, 1
*/

        endin
;***************************************************
; master audio out
;***************************************************

        instr 400

; audio input
        ainL            chnget  "MasterAudioLeft"
        ainR            chnget  "MasterAudioRight"
        
; declick on turnon
        kdeclick        linseg 0, 1, 0, 1, 1, 1, 1
        ainL            = ainL*kdeclick
        ainR            = ainR*kdeclick

        
        ; for live mode feedback
        aSum            = (ainL+ainR)*0dbfs*0.5
        aSum            clip aSum, 1, 0dbfs*0.95
        aSum            dcblock2 aSum
        chnset          aSum,   "liveModeFeedback"              

        ; master amp via chn and via midi ctrl no 7
        kMasterAmp      chnget  "MasterLevel"                           ; input in db, 0db = master amp of 1
        kMasterAmp      = ampdbfs(kMasterAmp)
        ;kMidiCtrl7in    ctrl7   giMidiChannel, 7, 0.0001, 2
        ;kMidiAmpChanged changed kMidiCtrl7in
        ;if kMidiAmpChanged == 0 goto skipCtrl7Write                     ; write to variable only if midi controller value has changed
                        ;chnset  dbfsamp(kMidiCtrl7in), "MasterLevel"    ; overwrite value in chn channel on midi in
;skipCtrl7Write:

        kMasterAmp      = kMasterAmp * 0dbfs
        aMasterAmp      interp  kMasterAmp
        adenorm         rnd31   giDenorm, 1
        aMasterAmp      butterlp aMasterAmp+adenorm, 15
        ainL            = ainL * aMasterAmp
        ainR            = ainR * aMasterAmp

        outch           1, ainL, 2, ainR
        ;fout           "test.wav", 14, ainL, ainR

; clear chn channels used for mixing 
;       chnclear        "MasterAudioLeft"
;       chnclear        "MasterAudioRight"
        a0 = 0
        chnset          a0, "MasterAudioLeft"
        chnset          a0, "MasterAudioRight"

        endin
;***************************************************

