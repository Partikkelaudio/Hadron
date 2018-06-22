<Cabbage>
form size(495, 469), caption("Hadron"), pluginID("hadr"), guirefresh(100)

image bounds(0,0, 495, 269), file("Background 495 x 269.png"), shape("round")

rslider channel("MasterLevel"), bounds(4, 23, 50, 50), range(-96, 6, -5, 3.3), trackercolour(20,101,151)
combobox bounds(24, 98, 112, 16), channel("source1"), value(0), populate("*.wav", "./samples"), channeltype("string"), identchannel("source1_id")
combobox bounds(24, 117, 112, 16), channel("source2"), value(0), populate("*.wav", "./samples"), channeltype("string"), identchannel("source2_id")
combobox bounds(24, 136, 112, 16), channel("source3"), value(0), populate("*.wav", "./samples"), channeltype("string"), identchannel("source3_id")
combobox bounds(24, 155, 112, 16), channel("source4"), value(0), populate("*.wav", "./samples"), channeltype("string"), identchannel("source4_id")

button bounds(8, 99, 14, 14), channel("rec1"), text("", ""), value(0), colour:0("black"), colour:1("red"), shape("round"), latched(1)
button bounds(8, 118, 14, 14), channel("rec2"), text("", ""), value(0), colour:0("black"), colour:1("red"), shape("round"), latched(1)
button bounds(8, 137, 14, 14), channel("rec3"), text("", ""), value(0), colour:0("black"), colour:1("red"), shape("round"), latched(1)
button bounds(8, 156, 14, 14), channel("rec4"), text("", ""), value(0), colour:0("black"), colour:1("red"), shape("round"), latched(1)

xypad bounds(137, 24, 221, 221), channel("presetX", "presetY"), rangex(0, 1.0, 0), rangey(0, 1.0, 0)
combobox bounds(137,  6, 109, 15), channel("state1"), value(0), populate("*.spst", "./states"), channeltype("string"), identchannel("state1_id")
combobox bounds(248,  6, 109, 15), channel("state2"), value(0), populate("*.spst", "./states"), channeltype("string"), identchannel("state2_id")
combobox bounds(137, 247, 109, 15), channel("state3"), value(0), populate("*.spst", "./states/"), channeltype("string"), identchannel("state3_id")
combobox bounds(248, 247, 109, 15), channel("state4"), value(0),  populate("*.spst", "/states"), channeltype("string"), identchannel("state4_id")

vslider channel("ctrl1"), bounds(356, 43, 38, 201), range(0.0, 1.0, 0), colour(152,160,164), trackercolour(242,1,131), textbox(1)
vslider channel("ctrl2"), bounds(389, 43, 38, 201), range(0.0, 1.0, 0), colour(152,160,164), trackercolour(255,42,0), textbox(1)
vslider channel("ctrl3"), bounds(422, 43, 38, 201), range(0.0, 1.0, 0), colour(152,160,164), trackercolour(251,141,0), textbox(1)
vslider channel("ctrl4"), bounds(455, 43, 38, 201), range(0.0, 1.0, 0), colour(152,160,164), trackercolour(36,199,0), textbox(1)

infobutton bounds(7, 248, 14, 14), channel("help"), text("?"), file("./docs/index.html")

csoundoutput bounds(4, 270, 490, 200)

</Cabbage>

<CsoundSynthesizer>
<CsOptions>
-n -+rtmidi=NULL -M0 -d

</CsOptions>
<CsInstruments>

#include "Hadron.orc"   

chnset 1, "CabbageMode"

instr 3
; GUI event control
Ssource1 chnget "source1"
Ssource2 chnget "source2"
Ssource3 chnget "source3"
Ssource4 chnget "source4"
kchangedsource1 changed Ssource1
kchangedsource2 changed Ssource2
kchangedsource3 changed Ssource3
kchangedsource4 changed Ssource4

if kchangedsource1==1 then
Scoreline sprintfk {{i 20 0 1 1 1 "%s"}}, Ssource1
scoreline Scoreline, 1
endif
if kchangedsource2==1 then
Scoreline sprintfk {{i 20 0 1 1 2 "%s"}}, Ssource2
scoreline Scoreline, 1
endif
if kchangedsource3==1 then
Scoreline sprintfk {{i 20 0 1 1 3 "%s"}}, Ssource3
scoreline Scoreline, 1
endif
if kchangedsource4==1 then
Scoreline sprintfk {{i 20 0 1 1 4 "%s"}}, Ssource4
scoreline Scoreline, 1
endif

Sstate1 chnget "state1"
Sstate2 chnget "state2"
Sstate3 chnget "state3"
Sstate4 chnget "state4"
kchangedstate1 changed Sstate1
kchangedstate2 changed Sstate2
kchangedstate3 changed Sstate3
kchangedstate4 changed Sstate4

if kchangedstate1==1 then
Scoreline sprintfk {{i 72 0 1 "%s" 2}}, Sstate1
scoreline Scoreline, 1
endif
if kchangedstate2==1 then
Scoreline sprintfk {{i 72 0 1 "%s" 3}}, Sstate2
scoreline Scoreline, 1
endif
if kchangedstate3==1 then
Scoreline sprintfk {{i 72 0 1 "%s" 0}}, Sstate3
scoreline Scoreline, 1
endif
if kchangedstate4==1 then
Scoreline sprintfk {{i 72 0 1 "%s" 1}}, Sstate4
scoreline Scoreline, 1
endif

krec1 chnget "rec1"
krec2 chnget "rec2"
krec3 chnget "rec3"
krec4 chnget "rec4"
kchangedrec1 changed krec1
kchangedrec2 changed krec2
kchangedrec3 changed krec3
kchangedrec4 changed krec4

if kchangedrec1==1 then
if krec1 == 1 then
event "i", 51.1, 0, -1, 1
else
event "i", -51.1, 0, 1
endif
endif

if kchangedrec2==1 then
if krec2 == 1 then
event "i", 51.2, 0, -1, 2
else
event "i", -51.2, 0, 1
endif
endif

if kchangedrec3==1 then
if krec3 == 1 then
event "i", 51.3, 0, -1, 3
else
event "i", -51.3, 0, 1
endif
endif

if kchangedrec4==1 then
if krec4 == 1 then
event "i", 51.4, 0, -1, 4
else
event "i", -51.4, 0, 1
endif
endif

endin

instr 4
; get items in combo as string
        Sbox    strget p4
        ktrig   metro 5 ; not too fast (for some reason...)
        kindex  init 0
        kindex += ktrig
        Sindx  sprintfk "value(%i)", kindex
        Sbox_id strcat Sbox, "_id"
        puts Sbox_id, 1
        chnset Sindx, Sbox_id
        Sstate1 chnget Sbox
        Sinit_item strcpy Sstate1
        kinit_ndx init 0 ; used to look for the item originally displayed
        kinit_ndx_found init 0  ; the index of the item originally displayed
;        puts Sinit_item, 1
        kchangedstate1 changed Sstate1
        Sitems  = {{}}
        if ktrig == 1 then
        Sitems_old strcpyk Sitems
        endif
        if kchangedstate1 == 1 then
        if kinit_ndx_found == 0 then
        kinit_ndx += 1
        ktest strcmpk Sinit_item, Sstate1
        if ktest == 0 then
        kinit_ndx_found = kinit_ndx
        endif
        endif
        Sitems2 sprintfk {{%s, "%s"}}, Sitems, Sstate1
        Sitems strcpyk Sitems2
        endif
        ktest   strindexk Sitems, {{"}}
        if ktest != 0 then
        Sitems2 strsubk Sitems, 2, -1
        Sitems strcpyk Sitems2
        endif

; how to check if all items has been read??
; *: the third (!) ktrig that does not give a kchangedstate ?? 
knochange_counter init 0
knewstr strcmpk Sitems, Sitems_old
if ktrig==1 then
        knochange_counter += ktrig
elseif kchangedstate1 == 1 then
        knochange_counter = 0
endif

if (knochange_counter==3) && (ktrig==1)then
        Sitems3 sprintfk {{%s, "Sine", "Triangle", "Saw", "Square", "Pulse", "AudioInput"}}, Sitems
        ; remove the unintended first item in the string of items (the initial item showed by the combo box appears an extra time first in the string)
        Sitems4 strcpyk Sitems3
        kpos    strindexk Sitems4, {{", }}
        Sitems3a strsubk Sitems3, kpos+3, -1
        Sboxitems strcat Sbox, "_items"
                chnset Sitems3a, Sboxitems
                Scoreline sprintfk {{i 5 0 1 "%s" %i}}, Sbox, kinit_ndx_found
                scoreline Scoreline, 1
        turnoff
endif
endin

instr 5
        Sbox    strget p4
        Sbox_id strcat Sbox, "_id"
        init_ndx_found = p5
        Sboxitems strcat Sbox, "_items"
        Sitems  chnget Sboxitems
        Scom    sprintfk "items(%s)", Sitems
        puts Scom, 1
                chnset Scom, Sbox_id
        timout 0, 0.3, skip     ; need to wait until the previous identchannel message has been handled (1/kr is not sufficient if we do this on several combo boxes simultaneously)
        Scom2   sprintfk "value(%i)", init_ndx_found
                chnset Scom2, Sbox_id
skip:
endin


</CsInstruments>  
<CsScore>
i1  0.1 1 ""
#include "Hadron.sco"
i3 0.3 86400
i4.1 .2 -1 "source1"
i4.2 .2 -1 "source2"
i4.3 .2 -1 "source3"
i4.4 .2 -1 "source4"

</CsScore>
</CsoundSynthesizer>