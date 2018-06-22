#!/usr/bin/python
# -*- coding: latin-1 -*-

""" 
A Csound score writer

@author: Øyvind Brandtsegg
@contact: obrandts@gmail.com
@license: GPL
"""

import os
import re

maxSoundlen = 100

# create a file object
outfilename = 'analyzeSoundfiles1.inc'
f = open(outfilename, 'w')

# load and analyze sound files
def getWavefileNames():
    """
    Get a list of the sound files in the "samples" directory
    
    @param self: The object pointer.
    @return: A list of files in the directory
    """
    files = os.listdir('samples')
    wavfiles = []
    # check that they are valid wave file names
    for f in files:
        if len(re.findall('.wav|.WAV', f)) > 0:
            wavfiles.append(f) 
    return wavfiles

i = 0
for wavfile in getWavefileNames():
    f.write('i 2 %i 1 "%s"\n'%(i,wavfile))   # load sample
    i += 1
    f.write('i 3 %i 1 "%s"\n'%(i,wavfile))   # analyze sample
    i += 1
for wavfile in getWavefileNames():
    f.write('i 4 %i 1 "%s"\n'%(int(maxSoundlen)+i,wavfile))   # write analysis file
    i += 1
    
# close the file
f.close

print 'Csound score written to', outfilename