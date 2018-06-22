#!/usr/bin/python
# -*- coding: latin-1 -*-

""" 
Hadron state and preset developer system, based on barebones

@author: Øyvind Brandtsegg
@contact: obrandts@gmail.com
@license: GPL
@requires: csnd, os, sys, re
"""

import csnd6 as csnd 
import cs.csMessages
import cs.csModule
import time
from constants import *
import os
import sys
import re
import comLine
import fixMaskFilesFormatting

#--------------------------------------------------------------------------------


# select the csound file
csoundFile = 'Hadron'
    
#### running csound
csModule = cs.csModule.CsoundModule(csoundFile)
"""Instance of the Csound module, setting up and running Csound."""
csound = csModule.csound
"""Pointer to the actual Csound instance."""
performanceThread = csModule.performanceThread
"""Pointer to the C++ thread running Csound."""
csMessages = cs.csMessages.CsoundMessages(csound, performanceThread) 
"""Instance of csMessages, used for all message passing from python to csound."""
comLine.csMessages = csMessages

# start csound thread
csModule.csoundPlay()

# init chn and global variables in Csound
rootdir = os.getcwd()+'/'
csMessages.csoundInputMessage('i 1 0 1 "%s"'%rootdir)


# wait for sound files to finish loading in Csound
#time.sleep(3)
while csMessages.getChnValue("HadronLoaded") == 0:
    time.sleep(0)

cli = comLine.CLI()
cli.cmdloop()

# stop threads
#eventCaller.stopThreads() 
csModule.stop()
    
