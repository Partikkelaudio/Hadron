<CsoundSynthesizer>
<CsInstruments>
sr      =  44100
ksmps   =  8
nchnls  =  2

0dbfs = 1

instr 1
	iCps = p3 
	iMeth = p4
	iStretch = p5
	
	aPluck pluck .2, 1, iCps, 0, iMeth, iStretch 	
	outch 1, aPluck, 2, aPluck
endin

</CsInstruments>
<CsScore>
f0 86400
e
</CsScore>
</CsoundSynthesizer>
