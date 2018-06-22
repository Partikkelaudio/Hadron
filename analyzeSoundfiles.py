#!/usr/bin/python
# -*- coding: latin-1 -*-

""" 
Hadron state and preset developer system, based on barebones

@author: Øyvind Brandtsegg
@contact: obrandts@gmail.com
@license: GPL
@requires: csnd, os, sys, re
"""

import csnd 
import cs.csMessages
import cs.csModule
import time
import control.eventCaller
import control.theTime2
import os
import sys
import re

#--------------------------------------------------------------------------------

#### instantiate eventCaller
eventCaller = control.eventCaller.EventCaller()
"""The event caller is the central module, communication with all other parts of the application."""

theTime = control.theTime2.TheTime2(eventCaller)
"""theTime is the timed queue used for timed automation of method calls."""

# set the csound file (orc/sco, only prefix)
csoundFile = 'analyzeSoundfiles'
    
#### running csound
csThread = cs.csModule.CsoundThreadRoutine(theTime, csoundFile)
"""Instance of the Csound module, setting up and running Csound."""
csound = csThread.csound
"""Pointer to the actual Csound instance."""
performanceThread = csound#csThread.performanceThread
"""
(Would be) Pointer to the C++ thread running Csound. 
The current implementation does not use the performancethread, but the ksmps loop based method of running Csound. 
The pointer to the performance thread has been implemented to make it feasible to change between ksmps-loop and performancethread driven Csound.
"""
csMessages = cs.csMessages.CsoundMessages(csound, performanceThread) 
"""Instance of csMessages, used for all message passing from python to csound."""

# start csound thread
csThread.csoundThread.start()

# set path
rootdir = os.getcwd()+'/'
csMessages.csoundInputMessage('i 1 0 1 "%s"'%rootdir)


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

singleFileRun = 0
maxSoundlen = 0
try:
    if sys.argv[1]:
        singleFileRun = 1
except:
    print 'analyzing all files, ok? (yes to confirm)'
    input = raw_input()
    if input != 'yes': sys.exit()

if singleFileRun == 0:
    for wavfile in getWavefileNames():
        csMessages.csoundInputMessage('i 2 0 1 "%s"'%wavfile)   # load sample
        csMessages.csoundInputMessage('i 3 0 1 "%s"'%wavfile)   # analyze sample
        time.sleep(.1)
        maxSoundlen = csMessages.getChnValue("MaxSoundlen")
        print 'maxSoundlen', maxSoundlen
    for wavfile in getWavefileNames():
        csMessages.csoundInputMessage('i 4 %i 1 "%s"'%(int(maxSoundlen)+2,wavfile))   # write analysis file
        csMessages.csoundInputMessage('i 5 0 100')       # hold before exit
    # wait for sound files to finish loading/analyzing/saving in Csound
    time.sleep(maxSoundlen+4)
else:
    wavfile = sys.argv[1]
    if wavfile in getWavefileNames():
        csMessages.csoundInputMessage('i 2 0 1 "%s"'%wavfile)   # load sample
        csMessages.csoundInputMessage('i 3 0 1 "%s"'%wavfile)   # analyze sample
        time.sleep(.1)
        maxSoundlen = csMessages.getChnValue("MaxSoundlen")
        print 'maxSoundlen', maxSoundlen
        csMessages.csoundInputMessage('i 4 %i 1 "%s"'%(int(maxSoundlen)+2,wavfile))   # write analysis file
        csMessages.csoundInputMessage('i 5 0 3')       # hold before exit
        # wait for sound files to finish loading/analyzing/saving in Csound
        time.sleep(maxSoundlen+4)
    else:
        print 'wave file %s not in folder /samples'%wavfile
        print 'quitting'

        
print 'maxSoundlen', maxSoundlen
# stop threads
eventCaller.stopThreads() 
csThread.stop()
