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
; bandpass filter and ringmodulator effect 1, with send to other efx later in the efx chain
;***************************************************
        instr 293

; audio input
        aClean                  chnget  "Bandpass1Send"
        inLevel                 = 1.5
        ain                     = aClean * inLevel

; global bpm variable from plugin host
        kHostTempoBpm           chnget  "hostTempoBpm"
        kHostTempoBpm           limit   kHostTempoBpm, 20, 600

; controls
        iRmFreq_Indx            chnget  "iBandpass1RmFreq"
        kRmModFreq              table iRmFreq_Indx, giSinglePreset_M    ; ringmod freq (cycles per beat if synced to hostBpm)
        iRmFreqBpmSyncIndx      chnget  "iBandpass1RmFreqBpmSync"
        kRmFreqBpmSync          table iRmFreqBpmSyncIndx, giSinglePreset_M      ; sync index for bpm sync to host
        kRmModFreq              =(((kHostTempoBpm/60)*kRmModFreq)*kRmFreqBpmSync)+(kRmModFreq*(1-kRmFreqBpmSync))
        iRmMix_Indx             chnget  "iBandpass1RmMix"
        kRmMix                  table iRmMix_Indx, giSinglePreset_M     ; ringmod mix
        iBPFF_Indx              chnget  "iBandpass1Freq"
        kBpFiltFreq             table iBPFF_Indx, giSinglePreset_M      ; bandpass freq
        kBpFiltFreq             limit kBpFiltFreq, 5, sr/2
        kBpFiltFreq             tonek kBpFiltFreq, 10
        iBPBW_Indx              chnget  "iBandpass1BW"
        kBpBW                   table iBPBW_Indx, giSinglePreset_M      ; bandpass bandwidth
        iBPPan_Indx             chnget  "iBandpass1Pan"
        kPan                    table iBPPan_Indx, giSinglePreset_M     ; output pan
        kPan                    limit kPan, 0, 1
        iAmp_Indx               chnget  "iBandpass1Amp"
        kAmp                    table iAmp_Indx, giSinglePreset_M       ; output amp
        iMix_Indx               chnget  "iBandpass1Mix"
        kMix                    table iMix_Indx, giSinglePreset_M       ; dry/efx mix
        iBP1BP2_Indx            chnget  "iBandpass1_Send_Bandpass2"
        kSend_BP1BP2            table iBP1BP2_Indx, giSinglePreset_M    ; efx send
        iBP1LP_Indx             chnget  "iBandpass1_Send_Lowpass"
        kSend_BP1LP             table iBP1LP_Indx, giSinglePreset_M     ; efx send
        iBP1BP3_Indx            chnget  "iBandpass1_Send_Bandpass3"
        kSend_BP1BP3            table iBP1BP3_Indx, giSinglePreset_M    ; efx send
        iBP1DlyL_Indx           chnget  "iBandpass1_Send_DlyL"
        kSend_BP1DlyL           table iBP1DlyL_Indx, giSinglePreset_M   ; efx send
        iBP1DlyR_Indx           chnget  "iBandpass1_Send_DlyR"
        kSend_BP1DlyR           table iBP1DlyR_Indx, giSinglePreset_M   ; efx send

; rm, filter, amp, pan
        aMod                    oscil   1, kRmModFreq, giSine
        aMod                    = (ain*aMod*kRmMix) + (ain*(1-kRmMix))
        aFilt                   butterbp        aMod, kBpFiltFreq, kBpFiltFreq*kBpBW
        aFilt                   = (aFilt*kMix)+(aClean*(1-kMix))

; send to master and other efx
        chnmix  aFilt*kSend_BP1BP2,     "Bandpass2Send"
        chnmix  aFilt*kSend_BP1LP,      "LowpassSend"
        chnmix  aFilt*kSend_BP1BP3,     "Bandpass3Send"
        chnmix  aFilt*kSend_BP1DlyL,    "DelaySendLeft"
        chnmix  aFilt*kSend_BP1DlyR,    "DelaySendRight"
        chnmix  aFilt*sqrt(1-kPan)*kAmp,        "MasterAudioLeft"
        chnmix  aFilt*sqrt(kPan)*kAmp,"MasterAudioRight"

; clear chn channels used for mixing 
        a0 = 0
        chnset          a0, "Bandpass1Send"

        endin

;******************************************************

;***************************************************
; bandpass filter effect 2, with send to other efx later in the efx chain
;***************************************************
        instr 294

; audio input
        aClean          chnget  "Bandpass2Send"
        inLevel         = 1.5
        ain             = aClean * inLevel

; controls
        iBPFF_Indx              chnget  "iBandpass2Freq"
        kBpFiltFreq             table iBPFF_Indx, giSinglePreset_M      ; bandpass freq
        kBpFiltFreq             limit kBpFiltFreq, 5, sr/2
        kBpFiltFreq             tonek kBpFiltFreq, 10
        iBPBW_Indx              chnget  "iBandpass2BW"
        kBpBW                   table iBPBW_Indx, giSinglePreset_M      ; bandpass bandwidth
        iBPPan_Indx             chnget  "iBandpass2Pan"
        kPan                    table iBPPan_Indx, giSinglePreset_M     ; output pan
        kPan                    limit kPan, 0, 1
        iAmp_Indx               chnget  "iBandpass2Amp"
        kAmp                    table iAmp_Indx, giSinglePreset_M       ; output amp
        iMix_Indx               chnget  "iBandpass2Mix"
        kMix                    table iMix_Indx, giSinglePreset_M       ; dry/efx mix
        iBP2LP_Indx             chnget  "iBandpass2_Send_Lowpass"
        kSend_BP2LP             table iBP2LP_Indx, giSinglePreset_M     ; efx send
        iBP2BP3_Indx            chnget  "iBandpass2_Send_Bandpass3"
        kSend_BP2BP3            table iBP2BP3_Indx, giSinglePreset_M    ; efx send
        iBP2DlyL_Indx           chnget  "iBandpass2_Send_DlyL"
        kSend_BP2DlyL           table iBP2DlyL_Indx, giSinglePreset_M   ; efx send
        iBP2DlyR_Indx           chnget  "iBandpass2_Send_DlyR"
        kSend_BP2DlyR           table iBP2DlyR_Indx, giSinglePreset_M   ; efx send

; filter, amp, pan
        aFilt                   butterbp        ain, kBpFiltFreq, kBpFiltFreq*kBpBW
        aFilt                   = (aFilt*kMix)+(aClean*(1-kMix))

; send to master and other efx
        chnmix  aFilt*kSend_BP2LP,      "LowpassSend"
        chnmix  aFilt*kSend_BP2BP3,     "Bandpass3Send"
        chnmix  aFilt*kSend_BP2DlyL,    "DelaySendLeft"
        chnmix  aFilt*kSend_BP2DlyR,    "DelaySendRight"
        chnmix  aFilt*sqrt(1-kPan)*kAmp,"MasterAudioLeft"
        chnmix  aFilt*sqrt(kPan)*kAmp,  "MasterAudioRight"

; clear chn channels used for mixing 
        a0 = 0
        chnset          a0, "Bandpass2Send"

        endin

;******************************************************

;***************************************************
; lowpass filter (lpf18), with send to other efx later in the efx chain
;***************************************************
        instr 295

; audio input
        aClean          chnget  "LowpassSend"
        inLevel         = 0.5
        ain             = aClean * inLevel
                        denorm  ain

; controls
        iLPFF_Indx              chnget  "iLowpassFreq"
        kLpFiltFreq             table iLPFF_Indx, giSinglePreset_M      ; filter cutoff
        kLpFiltFreq             limit kLpFiltFreq, 0.1, sr/2
        iLPRes_Indx             chnget  "iLowpassRes"
        kLpRes                  table iLPRes_Indx, giSinglePreset_M     ; filter resonance
        kLpRes                  limit kLpRes, 0, 9
        iLPDist_Indx            chnget  "iLowpassDist"
        kLpDist                 table iLPDist_Indx, giSinglePreset_M    ; filter dist
        kLpDist                 limit kLpDist, 0, 9
        iLPPan_Indx             chnget  "iLowpassPan"
        kPan                    table iLPPan_Indx, giSinglePreset_M     ; output pan
        kPan                    limit kPan, 0, 1
        iAmp_Indx               chnget  "iLowpassAmp"
        kAmp                    table iAmp_Indx, giSinglePreset_M       ; output amp
        iMix_Indx               chnget  "iLowpassMix"
        kMix                    table iMix_Indx, giSinglePreset_M       ; dry/efx mix
        iLPBP3_Indx             chnget  "iLowpass_Send_BP3"
        kSend_LPBP3             table iLPBP3_Indx, giSinglePreset_M     ; efx send
        iLPDlyL_Indx            chnget  "iLowpass_Send_DlyL"
        kSend_LPDlyL            table iLPDlyL_Indx, giSinglePreset_M    ; efx send
        iLPDlyR_Indx            chnget  "iLowpass_Send_DlyR"
        kSend_LPDlyR            table iLPDlyR_Indx, giSinglePreset_M    ; efx send

; filter
        aFilt                   lpf18   ain, kLpFiltFreq, kLpRes, kLpDist
        aFilt                   = (aFilt*kMix)+(aClean*(1-kMix))

; send to master and other efx
        chnmix  aFilt*kSend_LPBP3,      "Bandpass3Send"
        chnmix  aFilt*kSend_LPDlyL,     "DelaySendLeft"
        chnmix  aFilt*kSend_LPDlyR,     "DelaySendRight"
        chnmix  aFilt*sqrt(1-kPan)*kAmp,"MasterAudioLeft"
        chnmix  aFilt*sqrt(kPan)*kAmp,  "MasterAudioRight"

; clear chn channels used for mixing 
        a0 = 0
        chnset          a0, "LowpassSend"

        endin

;******************************************************

;***************************************************
; bandpass filter effect 3, with send to other efx later in the efx chain
;***************************************************
        instr 296

; audio input
        aClean          chnget  "Bandpass3Send"
        inLevel         = 1.5
        ain             = aClean * inLevel

; controls
        iBPFF_Indx              chnget  "iBandpass3Freq"
        kBpFiltFreq             table iBPFF_Indx, giSinglePreset_M      ; bandpass freq
        kBpFiltFreq             limit kBpFiltFreq, 5, sr/2
        kBpFiltFreq             tonek kBpFiltFreq, 10
        iBPBW_Indx              chnget  "iBandpass3BW"
        kBpBW                   table iBPBW_Indx, giSinglePreset_M      ; bandpass bandwidth
        iBPPan_Indx             chnget  "iBandpass3Pan"
        kPan                    table iBPPan_Indx, giSinglePreset_M     ; output pan
        kPan                    limit kPan, 0, 1
        iAmp_Indx               chnget  "iBandpass3Amp"
        kAmp                    table iAmp_Indx, giSinglePreset_M       ; output amp
        iMix_Indx               chnget  "iBandpass3Mix"
        kMix                    table iMix_Indx, giSinglePreset_M       ; dry/efx mix
        iBP3DlyL_Indx           chnget  "iBandpass3_Send_DlyL"
        kSend_BP3DlyL           table iBP3DlyL_Indx, giSinglePreset_M   ; efx send
        iBP3DlyR_Indx           chnget  "iBandpass3_Send_DlyR"
        kSend_BP3DlyR           table iBP3DlyR_Indx, giSinglePreset_M   ; efx send


; filter
        aFilt                   butterbp        ain, kBpFiltFreq, kBpFiltFreq*kBpBW
        aFilt                   = (aFilt*kMix)+(aClean*(1-kMix))

; send to master and other efx
        chnmix  aFilt*kSend_BP3DlyL,    "DelaySendLeft"
        chnmix  aFilt*kSend_BP3DlyR,    "DelaySendRight"
        chnmix  aFilt*sqrt(1-kPan)*kAmp,"MasterAudioLeft"
        chnmix  aFilt*sqrt(kPan)*kAmp,  "MasterAudioRight"

; clear chn channels used for mixing 
        a0 = 0
        chnset          a0, "Bandpass3Send"

        endin

;******************************************************

;***************************************************
; delay effect
;***************************************************
        instr 297
; audio input
        aCleanL         chnget  "DelaySendLeft"
        aCleanR         chnget  "DelaySendRight"
        inLevel         = 1.0
        ainL            = aCleanL * inLevel
        ainR            = aCleanR * inLevel

#include "inc/efx_delay.inc"

; send to master 
        chnmix  aLeft,  "MasterAudioLeft"
        chnmix  aRight, "MasterAudioRight"

; clear chn channels used for mixing 
        a0 = 0
        chnset          a0, "DelaySendLeft"
        chnset          a0, "DelaySendRight"

        endin

;******************************************************

