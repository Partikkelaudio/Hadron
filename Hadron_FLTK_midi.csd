<CsoundSynthesizer>
<CsOptions>
 -odac1 -Q3 -M4
; -Q1 -d -odac1
</CsOptions>
<CsInstruments>

	sr = 44100  
	kr = 441
	ksmps = 100
	nchnls = 2	

	massign 1, 1

instr 1
endin

;*********************************************************************
; Gui widgets
;*********************************************************************
	instr	130

		FLpanel         "Hadron Controllers",750,300,100,100

iCTRjx1		= 20

iCTRvx1		= iCTRjx1 + 240
iCTRvx2		= iCTRvx1 + 50
iCTRvx3		= iCTRvx2 + 50
iCTRvx4		= iCTRvx3 + 50
iCTRvx5		= iCTRvx4 + 50

iCTRfx1		= iCTRvx1 + 10
iCTRfx2		= iCTRfx1 + 50
iCTRfx3		= iCTRfx2 + 50
iCTRfx4		= iCTRfx3 + 50

iCTRfx5		= iCTRfx4 + 80
iCTRfx6		= iCTRfx5 + 50

iCTRfx7		= iCTRfx6 + 70
iCTRfx8		= iCTRfx7 + 30
iCTRfx9		= iCTRfx8 + 30
iCTRfx10	= iCTRfx9 + 30

iCTRfy1		= 20
iCTRvy1		= iCTRfy1 + 240

gkJoyX, gkJoyY, gihJoyX, gihJoyY \
		FLjoy "XY", 0, 1, 0, 1, 0, 0, -1, -1, 220, 220, iCTRjx1, iCTRfy1
		FLsetVal_i	0.5, gihJoyX
		FLsetVal_i	0.5, gihJoyY	

ihs1 			FLbox "1", 1, 1, 12, 20, 20, iCTRjx1-20, iCTRfy1+200
ihs2 			FLbox "2", 1, 1, 12, 20, 20, iCTRjx1+220, iCTRfy1+200
ihs3 			FLbox "3", 1, 1, 12, 20, 20, iCTRjx1-20, iCTRfy1
ihs4 			FLbox "4", 1, 1, 12, 20, 20, iCTRjx1+220, iCTRfy1

iCTRhv1			FLvalue		" ", 		40,  20, iCTRvx1, iCTRvy1
gkCTRf1,iCTRhf1		FLslider	"sli_1", 0, 1, 0, 6, iCTRhv1, 	20, 220, iCTRfx1, iCTRfy1
iCTRhv2			FLvalue		" ", 		40,  20, iCTRvx2, iCTRvy1
gkCTRf2,iCTRhf2		FLslider	"sli_2", 0, 1, 0, 6, iCTRhv2, 	20, 220, iCTRfx2, iCTRfy1
iCTRhv3			FLvalue		" ", 		40,  20, iCTRvx3, iCTRvy1
gkCTRf3,iCTRhf3		FLslider	"sli_3", 0, 1, 0, 6, iCTRhv3, 	20, 220, iCTRfx3, iCTRfy1
iCTRhv4			FLvalue		" ", 		40,  20, iCTRvx4, iCTRvy1
gkCTRf4,iCTRhf4		FLslider	"sli_4", 0, 1, 0, 6, iCTRhv4, 	20, 220, iCTRfx4, iCTRfy1

gkCTRf5,iCTRhf6		FLslider	"L", 0, 1, 0, 2, -1, 	20, 220, iCTRfx5, iCTRfy1
gkCTRf6,iCTRhf7		FLslider	"R", 0, 1, 0, 2, -1, 	20, 220, iCTRfx6, iCTRfy1
			FLsetColor2 	100, 100, 100, iCTRhf6
			FLsetColor2 	100, 100, 100, iCTRhf7
			FLsetColor2 	200, 30, 30, iCTRhf6
			FLsetColor2 	200, 30, 30, iCTRhf7

gkCTRf8,iCTRhf8		FLslider	"1", 0, 1, 0, 2, -1, 	10, 220, iCTRfx7, iCTRfy1
gkCTRf9,iCTRhf9		FLslider	"2", 0, 1, 0, 2, -1, 	10, 220, iCTRfx8, iCTRfy1
gkCTRf10,iCTRhf10	FLslider	"3", 0, 1, 0, 2, -1, 	10, 220, iCTRfx9, iCTRfy1
gkCTRf11,iCTRhf11	FLslider	"4", 0, 1, 0, 2, -1, 	10, 220, iCTRfx10, iCTRfy1
			FLsetColor2 	100, 100, 100, iCTRhf8
			FLsetColor2 	100, 100, 100, iCTRhf9
			FLsetColor2 	100, 100, 100, iCTRhf10
			FLsetColor2 	100, 100, 100, iCTRhf11
			FLsetColor2 	200, 30, 30, iCTRhf8
			FLsetColor2 	200, 30, 30, iCTRhf9
			FLsetColor2 	200, 30, 30, iCTRhf10
			FLsetColor2 	200, 30, 30, iCTRhf11

        	FLpanel_end     
   		FLrun		
	
ichn	= 1
outkc	ichn, 1, gkCTRf1, 0, 1
outkc	ichn, 2, gkCTRf2, 0, 1
outkc	ichn, 3, gkCTRf3, 0, 1
outkc	ichn, 4, gkCTRf4, 0, 1
outkc	ichn, 5, gkJoyX, 0, 1
outkc	ichn, 6, gkJoyY, 0, 1

;krms values in
krmsL		ctrl7	1, 8, 0, 1
krmsR		ctrl7	1, 9, 0, 1
kupdate		metro	8
		FLsetVal kupdate, krmsL, iCTRhf6	; 
		FLsetVal kupdate, krmsR, iCTRhf7	; 

;test/debug values in
ktest1		ctrl7	1, 10, 0, 1
ktest2		ctrl7	1, 11, 0, 1
ktest3		ctrl7	1, 12, 0, 1
ktest4		ctrl7	1, 13, 0, 1
		FLsetVal kupdate, ktest1, iCTRhf8	; 
		FLsetVal kupdate, ktest2, iCTRhf9	; 
		FLsetVal kupdate, ktest3, iCTRhf10	; 
		FLsetVal kupdate, ktest4, iCTRhf11	; 
	endin
;*********************************************************************
	

</CsInstruments>

<CsScore>

i130 0 60000

e
</CsScore>
</CsoundSynthesizer>
