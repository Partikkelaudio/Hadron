<CsoundSynthesizer>
<CsInstruments>
sr = 44100
ksmps = 4
nchnls = 2

0dbfs = 1
giSine       ftgen 1, 0, 8193, 10, 1
giPitchTable ftgen 2, 0, 16, -7, 45, 16, 45 ; table of MIDI pitches for VCO
giFiltTable  ftgen 3, 0, 16, -7, 69, 16, 69 ; table of MIDI pitches for LPF 

giWaveShapeFn ftgen 0,0, 257, 9, .5,1,270
;giWaveShapeFn ftgen 0,0, 257, 9, .5,1,270,1.5,.33,90,2.5,.2,270,3.5,.143,90,4.5,.111,270


#define MAX_DEL_TIME # 6 #

; a-rate MIDI pitch to freq converter
opcode mtofA, a, a
    aIn xin
    aOut = (440.0*exp(log(2.0)*(aIn-69.0)/12.0))
    xout aOut
endop

; k-rate MIDI pitch to freq converter
opcode mtofK, k, k
    kIn xin
    kOut = (440.0*exp(log(2.0)*(kIn-69.0)/12.0))
    xout kOut
endop

; a-rate portamento
opcode porta, a, aki
    setksmps 1
    aIn, khtim, isig xin
    denorm aIn
    kIn downsamp aIn
    kOut portk kIn, khtim, isig
    aOut upsamp kOut
    xout aOut
endop

opcode tanhDist, a, ak
    aX, kDrive xin
    kDrive limit kDrive, .1, 8
    aX = aX * 4 * kDrive
    aY = tanh(aX)
    aY = aY * .25
    xout aY
endop

instr 1
    kSpeed       chnget "speed"              ; Determines speed of table reading.
    kPitchGlide  chnget "pglide"
    kPitchShift  chnget "pshift"
    kFiltGlide   chnget "fglide"
    kFPfollow    chnget "follow"
    kFiltReso    chnget "reso"
    kFiltShift   chnget "fshift"
    kFiltType    chnget "ftype"
    kDelay       chnget "delay"
    kDelayCut    chnget "delCut"
    kDelayFdbk   chnget "delFdbk"
    kDelayAmp    chnget "delAmp"
    kDistMethod  chnget "distMethod"
    kDrive       chnget "drive"
    kSimplePitchFollow chnget "simplefollow"
    kUseFiltTable chnget "useFiltTable"
	kPW chnget "pw"

    kSpeed = (kSpeed == 0 ? .001 : kSpeed)  ; IMPORTANT: Avoid kSpeed == 0.
    kPitchGlide = kPitchGlide * .05         ; Condition glide times.
    kFiltGlide  = kFiltGlide * .05

    aIndex phasor kSpeed                    ; This phasor drives the sequencer.
    kIndex downsamp aIndex
    outvalue "idx", kIndex * 16             ; Used to provide some visual feedback regarding sequence position.
    
    aPitch table aIndex, giPitchTable, 1    ; Get current oscillator pitch.
    aPitch = aPitch + kPitchShift
    kPitch downsamp aPitch
    aPitch porta aPitch, kPitchGlide, 0     ; Smooth changes in oscillator pitch.
    
    aFrq mtofA aPitch                       ; Convert pitch to frequency.
    aFrq limit aFrq, 30, sr / 2             ; Keep frequency > 30 and less than half of sampling rate.  

    if kUseFiltTable > 0 then
        kFiltPitch table kIndex, giFiltTable, 1 ; Get filter pitch.
    else
        kFiltPitch = 0
    endif

    if kSimplePitchFollow == 0 then
        kFiltPitch = kFiltPitch + kFiltShift + (kFPfollow * (kPitch-63)) + 63
    else
        kFiltPitch = kFiltPitch + kFiltShift + (kFPfollow * 12 + kPitch)
    endif
    
    kFiltPitch portk kFiltPitch, kFiltGlide ; Smooth changes in filter pitch.
    kFiltFrq mtofK kFiltPitch
    kFiltFrq limit kFiltFrq, 100, 9000      ; Prevent svfilter from blowing up.

    aVCO vco .6, aFrq, 2, kPW, giSine        ; Generate a square wave.
    ;aVCO2 vco .3, aFrq + .25, 2, .48, giSine
    ;aVCO = aVCO1 + aVCO2
	
	;aVCO vco .6, 220, 2, .5, giSine

    aNoise noise .6, 0

    aLP, aHP, aBP svfilter aVCO, kFiltFrq, kFiltReso ; Filter it.

    if kFiltType < 1 then
        aF = aLP
    elseif kFiltType < 2 then
        aF = aHP
    else 
        aF = aBP
    endif
	
    if kDistMethod == 0 then
        aD distort  aF, kDrive, giWaveShapeFn
    elseif kDistMethod == 1 then
        aD distort1 aF, kDrive, 1, 0, 0, 1
    else
        aD tanhDist aF, kDrive
    endif
	
    aD balance aD, aNoise   
    aD buthp aD, 37

    ; Let's add some feedback delay.
    kDel    = (1 / (abs(kSpeed) * 16)) * kDelay ; Delay time is multiple of one note (multiple == kDelay).
    ;kDel    lineto kDel, .05                    ; Smooth changes in delay time.
    kDel    limit kDel, .0001, $MAX_DEL_TIME
    aDel    upsamp kDel
    aNull   delayr $MAX_DEL_TIME                ; Setup delay line with max delay time == $MAX_DEL_TIME seconds.
    aDelOut deltap3 aDel                        ; Tap at delay time.
    aFeed   butlp aD + aDelOut, kDelayCut       ; Lowpass filter the input + delay tap.
            delayw aFeed * kDelayFdbk           ; Feed input + delay tap back into delay line.
    aDelOut = aDelOut * kDelayAmp               ; Adjust amplitude of delayed audio.

    aOut    = aDelOut + aD

    outch 1, aOut, 2, aOut

endin

</CsInstruments>
<CsScore>
f0 86400
i1 0 86400
e
</CsScore>
</CsoundSynthesizer>

