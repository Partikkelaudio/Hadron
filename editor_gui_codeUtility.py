#!/usr/bin/python
# -*- coding: latin-1 -*-

#    Copyright 2015 Oeyvind Brandtsegg 

import sys


parm_file = open('parameterlist.inc', 'r')
tempfile = open('tempfile.inc', 'w')
guifile = open('temp_gui.inc', 'w')
preset_to_guifile = open('temp_preset_to_gui.inc', 'w')

import re
getparm = re.compile(r'\"(.+?)\"', flags=re.DOTALL)
getval = re.compile(r'-?\d+.\d+', flags=re.DOTALL)

parms = []
for line in parm_file.readlines():
    name = getparm.findall(line)
    vals = getval.findall(line)
    if len(name)>0: 
        parm_val = [name[0], vals[0], vals[1], vals[2]]
        parms.append(parm_val)
'''
for p in parms:
    print '*'
    print p
'''

# write the many lines of macro calls to a temp file for manual copy
for p in parms:
    tempfile.write('$EDITPARM("{}")\n'.format(p[0]))

# organize parms in gui colums
parms_split = [] # list of parms, divided by colums in the gui
parmdividers = ["Partikkel1Samplepos1","DryStereoWidth", "LowpassFreq", "LFO1_Amp", "Envelope1_Amp","Randh1_Amp","Func1Input","Partikkel1GrainRateBpmSync", 'done']
i = 0
for p in parms:
    if p[0] == parmdividers[i]:
        print p[0]
        parms_split.append([])
        i += 1
    parms_split[-1].append(p)

#########
ystep = 10
w = 200
h1 = 10
h2 = 12
hstep = 25
gui_element = '''
label text("{displayname}"), bounds({x}, {y1}, {w}, {h1})
hslider channel("{parmname}"), bounds({x}, {y2}, {w}, {h2}), range({pmin}, {pmax}, 0, {pskew}), textbox(1)'''
gui_element_butn = '''
label text("{displayname}"), bounds({x2}, {y1}, {w}, {h1}), align("left")
checkbox bounds({x}, {y1}, {h2}, {h2}), channel("{parmname}"), value(0), colour:0("black"), colour:1("red")'''

x = 10
y = 20
for p in parms_split[0]:
    guifile.write(gui_element.format(displayname=p[0], parmname=p[0], x=x, y1=y, y2=y+ystep, w=w, h1=h1, h2=h2, pmin=p[1], pmax=p[2], pskew=p[3]))
    y += hstep

x = 220
y = 20
for p in parms_split[1]:
    guifile.write(gui_element.format(displayname=p[0], parmname=p[0], x=x, y1=y, y2=y+ystep, w=w, h1=h1, h2=h2, pmin=p[1], pmax=p[2], pskew=p[3]))
    y += hstep

x = 430
y = 20
for p in parms_split[2]:
    guifile.write(gui_element.format(displayname=p[0], parmname=p[0], x=x, y1=y, y2=y+ystep, w=w, h1=h1, h2=h2, pmin=p[1], pmax=p[2], pskew=p[3]))
    y += hstep

x = 640
y = 20
for p in parms_split[3]:
    guifile.write(gui_element.format(displayname=p[0], parmname=p[0], x=x, y1=y, y2=y+ystep, w=w, h1=h1, h2=h2, pmin=p[1], pmax=p[2], pskew=p[3]))
    y += hstep

x = 850
y = 20
for p in parms_split[5]:
    guifile.write(gui_element.format(displayname=p[0], parmname=p[0], x=x, y1=y, y2=y+ystep, w=w, h1=h1, h2=h2, pmin=p[1], pmax=p[2], pskew=p[3]))
    y += hstep

x = 1060
y = 20
for p in parms_split[6]:
    guifile.write(gui_element.format(displayname=p[0], parmname=p[0], x=x, y1=y, y2=y+ystep, w=w, h1=h1, h2=h2, pmin=p[1], pmax=p[2], pskew=p[3]))
    y += hstep

x = 1280
y = 20
for p in parms_split[4]:
    guifile.write(gui_element.format(displayname=p[0], parmname=p[0], x=x, y1=y, y2=y+ystep, w=w, h1=h1, h2=h2, pmin=p[1], pmax=p[2], pskew=p[3]))
    y += hstep

x = 1500
x2 = 1515
y = 20
w = 180
for p in parms_split[7]:
    guifile.write(gui_element_butn.format(displayname=p[0], parmname=p[0], x=x, x2=x2, y1=y, w=w, h1=h1, h2=h2, pmin=p[1], pmax=p[2], pskew=p[3]))
    y += hstep


###
gui_parm_update = '''
        i{parm}_indx chnget  "i{parm}"
        k{parm} table i{parm}_indx, giSinglePreset
        chnset k{parm}, "{parm}"'''
for p in parms:
    preset_to_guifile.write(gui_parm_update.format(parm=p[0]))