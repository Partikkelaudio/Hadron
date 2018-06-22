
        sr = 44100  
        kr = 441
        ksmps = 100
        nchnls = 2      
        0dbfs   = 1

        giSine          ftgen   0, 0, 65537, 10, 1                              ; sine wave
        giNumSoundfiles = 0
        giMaxSoundlen   = 1


;*********************************************************************
; set path
;*********************************************************************
        instr 1
gSpath  strget p4
        endin


;*********************************************************************
; import samples
;*********************************************************************
        instr 2
#include "inc/loadSamples.inc"
        endin

;*********************************************************************
; sample play and analyze
;*********************************************************************
        instr   3
#include "inc/analyzeSamples.inc"
giMaxSoundlen   = (p3 > giMaxSoundlen ? p3 : giMaxSoundlen)     ; set giMaxSoundlen equal to the longest sound
        chnset  giMaxSoundlen, "MaxSoundlen"
        endin

;*********************************************************************
; write ftables to files
;*********************************************************************
        instr 4
#include "inc/analyzeTableSave.inc"
        endin

;*********************************************************************

        instr 5
        endin