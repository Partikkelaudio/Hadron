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

#define calcWaveformParameters(W'N) #

if kwaveform$W. < 10000 kgoto noSegment$W. 
        ; find audio segment start and end position
        kSegment$W.             = kwaveform$W. - 10000
        kStart$W.               table kSegment$W., giLiveSamplAttackTable
        kEnd$W.                 table kSegment$W.+1, giLiveSamplAttackTable
        ;Satck sprintfk "attack table values %i %i %i %i", table:k(0,giLiveSamplAttackTable), table:k(1,giLiveSamplAttackTable), table:k(2,giLiveSamplAttackTable), table:k(3,giLiveSamplAttackTable)
        ;puts Satck, kSegment$W. +1
        kEnd$W.                 = kEnd$W.-(isample_release*sr)                  ; do not include release segment of recording when calculating endpoint

        ; adjust samplepos
        kLen$W.                 = kEnd$W.-kStart$W.
        kLength$W.              = kLen$W./giLiveSamplTableLen
        ksamplepos$W.dirtest    = ksamplepos$W.                                 ; save samplepos in normalized range to be used for playback direction testing later
        ksamplepos$W.           = (ksamplepos$W.*kLength$W.) + (kStart$W./giLiveSamplTableLen)

        ;Ssegm$W.          sprintfk "segm, start, end, len: %i %f %f %f", kSegment$W., kStart$W., kEnd$W., (kEnd$W.-kStart$W.)/sr
        ;printk2 ksamplepos$W.

        ; adjust kwavekey
        kwavekey$W._tmp         = cent(kwavfreq$W.) * (sr/giLiveSamplTableLen)

        ; set live sampling table as waveform
        kwaveform$W.a           = giLiveSamplAudioTable
        kgoto passWaveform$W.

noSegment$W.:
        kLen$W.                 tableng kwaveform$W.
        k_origFactor$W.         divz 261.625565, korig_key$W., 1
        kwavekey$W._tmp         = cent(kwavfreq$W.) * (sr/kLen$W.) * k_origFactor$W.
        ; if waveform is a single cycle wave, set original wavekey to 261.625565 (261.625565Hz)
        kwavekey$W._tmp         = (gkSingleCycle$W. == 0 ? 261.625565*cent(kwavfreq$W.) : kwavekey$W._tmp)
        kwaveform$W.a           = kwaveform$W.

if kwaveform$W. != giLiveFeed kgoto passWaveform$W.
        ; adjust samplepos for live follow mode
        igDlySpos$W.BpmSyncIndx chnget  "iPartikkel1GrainDelayTime$W.BpmSync"
        kgDlySpos$W.BpmSyncIndx table igDlySpos$W.BpmSyncIndx, giSinglePreset_M ; sync index for bpm sync to host
        ksamplepos$W.           =(((60/kHostTempoBpm)*ksamplepos$W.*(4/giLiveFeedLenSec))*kgDlySpos$W.BpmSyncIndx)+(ksamplepos$W.*(1-kgDlySpos$W.BpmSyncIndx))
        ; if samplepos is close to zero, see to it that grain playback does not cross the record pointer border,
        ; as this will delay the (live feed) sound for the length of a livefeed sample buffer.
        ; So, check grain duration and transpose, limit samplepos accordingly
        ksamplepos$W.           limit ksamplepos$W., (kduration*cent(kwavfreq$W.)*kwavfreq)/(giLiveFeedLenSec*1000), 1
        ;printk2 ksamplepos1
        ; make samplepos follow the record pointer instead of staying at a stationary value, makes live follow samplepos into "grain delay time"
        ksamplepos$W.           = (kstartFollow/giLiveFeedLen) - ksamplepos$W.
        ksamplepos$W.           = (ksamplepos$W. < 0 ? ksamplepos$W.+1 : ksamplepos$W.) ; wrap around on undershoot
        ksamplepos$W.           = (ksamplepos$W. > 1 ? ksamplepos$W.-1 : ksamplepos$W.) ; wrap around on overshoot

        kwavekey$W.             = kwavekey$W._tmp
        kgoto passWaveform$W.

passWaveform$W.:

        kSoundLen$W.            = kLen$W./sr    ; waveform length in seconds
                                chnset  kSoundLen$W., "SoundLength$W."
        ; avoid wrapping around of samplepos for sampled (and live sampled) segments
        ksamplepos$W.           mirror ksamplepos$W., 0, 1
        

        ; filtering to avoid zipper noise in preset interpolation (and modmatrix updates)
        ;kwavekey$W._tmp                = kwavekey$W._tmp+kdenorm
        ;kwavekey$W._tmp                tonek kwavekey$W._tmp, giInterpolFilt

if kwaveform$W. == giLiveFeed kgoto noChangeDirection$W.
if kwaveform$W. >= 10000 kgoto liveSampleChangeDirection$W.
        ; invert read direction (wavekey) if grain duration is longer than the remaining (after samplepos) part of the wave source
        kwavekey$W.             = (kduration*cent(kwavfreq$W.)*kwavfreq > (1-ksamplepos$W.)*kSoundLen$W.*1000 ? kwavekey$W._tmp*-1 : kwavekey$W._tmp)
kgoto noChangeDirection$W.
liveSampleChangeDirection$W.:
        ; (used to be change of direction, but now we changed our mind and just mute the grain instead)
        ; special handling of live sampled segments, mute the source wave in the grain if the read pointer will cross the boundary to the next live sampled segment
        kwavekey$W.             = kwavekey$W._tmp
        if kduration*cent(kwavfreq$W.)*kwavfreq > (1-ksamplepos$W.dirtest)*kSoundLen$W.*1000 then
        kN_$W.                  = 0
        ilen_wamptab            = ftlen(iwaveamptab)
        kzero                   = 0
muteSourceWave$W.:
        ki_$W.                  = 2+$W.+(kN_$W.*4)-1
                                tablew kzero, ki_$W., iwaveamptab
        kN_$W.                  += 1
        if ki_$W. < ilen_wamptab-4 kgoto muteSourceWave$W.
        endif


noChangeDirection$W.:


#
