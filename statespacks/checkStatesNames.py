#!/usr/bin/python
# -*- coding: latin-1 -*-

""" 
Check states names (all available states, check against a "used in some context").

Used for sorting states into paacks, checking which states must be present for a demo to run etc

@author: Øyvind Brandtsegg
@contact: obrandts@gmail.com
@license: GPL
@requires: os, re, shutil
"""
import os
import re

#--------------------------------------------------------------------------------

outfile = file('statesnames_temp.txt', 'w')

excludestates = []
f = file('list_freestates.txt', 'r')
for line in f:
    if len(re.findall('^fx|^gr|^gt|^tfx', line)) > 0:
        line = line.split('\n')[0]
        excludestates.append(line)

print excludestates

states = os.listdir('../states')
for state in states:
    if len(re.findall('^fx|^gr|^gt|^tfx', state)) > 0:  # may be commented out to include all temporary and unfinished states too
        state = state.split('.spst')[0]
        if state not in excludestates:
            outfile.write(state+'\n')
outfile.close()
