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

; delay effect
; ainL and ainR are inputs, aLeft and aRight are outputs

        ; global bpm variable from plugin host
        kHostTempoBpm           chnget  "hostTempoBpm"
        kHostTempoBpm           limit   kHostTempoBpm, 20, 600

        ; controls: time, feed
        iDelTimeBpmSyncIndx     chnget  "iDelayTimeBpmSync"
        kDelTimeBpmSync         table iDelTimeBpmSyncIndx, giSinglePreset_M     ; sync index for bpm sync to host
        iDTL_Indx               chnget  "iDelayTimeLeft"
        kDelTimeL               table iDTL_Indx, giSinglePreset_M       ; left channel delay time in seconds (in beats if bpm synced to host)
        kDelTimeL               =(((60/kHostTempoBpm)*kDelTimeL)*kDelTimeBpmSync)+(kDelTimeL*(1-kDelTimeBpmSync))
        kDelTimeL               = kDelTimeL*1000                        ; in milliseconds for vdelay
        ;printks2 "deltime L %f \n", kDelTimeL
        iDTR_Indx               chnget  "iDelayTimeRight"
        kDelTimeR               table iDTR_Indx, giSinglePreset_M       ; right channel delay time in seconds (in beats if bpm synced to host)
        kDelTimeR               =(((60/kHostTempoBpm)*kDelTimeR)*kDelTimeBpmSync)+(kDelTimeR*(1-kDelTimeBpmSync))
        kDelTimeR               = kDelTimeR*1000                        ; in milliseconds for vdelay
        iFeedL_Indx             chnget  "iDelayFeedbackLeft"
        kFeedL                  table iFeedL_Indx, giSinglePreset_M     ; delay feedback left
        iFeedR_Indx             chnget  "iDelayFeedbackRight"
        kFeedR                  table iFeedR_Indx, giSinglePreset_M     ; delay feedback right
        iXFeed_Indx             chnget  "iDelayXFeedback"
        kXFeed                  table iXFeed_Indx, giSinglePreset_M     ; crossfeed L to R and R to L
        iHPFF_Indx              chnget  "iDelayHpFreq"
        kHpFiltFreq             table iHPFF_Indx, giSinglePreset_M      ; hipass filter on delay line
        iLPFF_Indx              chnget  "iDelayLpFreq"
        kLpFiltFreq             table iLPFF_Indx, giSinglePreset_M      ; lopass filter on delay line
        iWidth_Indx             chnget  "iDelayStereoWidth"
        kStereoWidth            table iWidth_Indx, giSinglePreset_M     ; stereo width for the two delay outputs
        iAmp_Indx               chnget  "iDelayAmp"
        kAmp                    table iAmp_Indx, giSinglePreset_M       ; output amp
        iMix_Indx               chnget  "iDelayMix"
        kMix                    table iMix_Indx, giSinglePreset_M       ; dry/efx mix


        ; upsample and filter delay time changes
        ;printk2 kDelTimeL, 5
        ;printk2 kDelTimeR, 8
        aDelTimeL       interp  kDelTimeL
        aDelTimeR       interp  kDelTimeR
        aDelTimeL       butterlp aDelTimeL, 4
        aDelTimeR       butterlp aDelTimeR, 4
        
        ; feedback and cross feedback
        aDlyL           init 0
        aDlyR           init 0
        ainL            = ainL + (aDlyL*kFeedL) + (aDlyR*kXFeed)
        ainR            = ainR + (aDlyR*kFeedR) + (aDlyL*kXFeed)
        
        ; delay processing
        imaxdel         = 5000
        aDlyL           vdelay  ainL, aDelTimeL, imaxdel
        aDlyR           vdelay  ainR, aDelTimeR, imaxdel
        
        ; filtering
        aDlyL           butterhp aDlyL, kHpFiltFreq
        aDlyR           butterhp aDlyR, kHpFiltFreq
        aDlyL           butterlp aDlyL, kLpFiltFreq
        aDlyR           butterlp aDlyR, kLpFiltFreq

        ; dry/wet mix
        a1              = (aDlyL*kMix*kAmp)+(aCleanL*(1-kMix))
        a2              = (aDlyR*kMix*kAmp)+(aCleanR*(1-kMix))

        ; output pan
        kPan1           = (1-kStereoWidth)*0.5
        kPan1           limit kPan1, 0.00000001, 0.5            ; avoid sqrt of zero
        aLeft           = (a1*sqrt(1-kPan1))+(a2*sqrt(kPan1))
        aRight          = (a2*sqrt(1-kPan1))+(a1*sqrt(kPan1))
