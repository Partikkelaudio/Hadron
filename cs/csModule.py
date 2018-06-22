#!/usr/bin/python
# -*- coding: latin-1 -*-

""" 
A separate thread which keeps Csound output going.

@author: Øyvind Brandtsegg
@contact: obrandts@gmail.com
@license: GPL
@requires: threading
"""

import csnd6 as csnd
import csoundCommandline
import threading
import time


class CsoundModule:

    def __init__(self,csoundFile):
        """
        Class constructor.
        
        @param self: The object pointer.
        """

        self.isRunning = True
        """A flag that keeps the thread running, can be deleted when we start using csnd.PerformanceThread properly"""    

        print 'commandline', csoundCommandline.csoundCommandline
        """The Csound commandline read from file "csoundCommandLine.py", setting options for audio i/o and buffers."""
        comlineParmsList = csoundCommandline.csoundCommandline.split(' ')

        # Create an instance of Csound, set orchestra, score and command line parameters
        self.csound = csnd.Csound()
        arguments = csnd.CsoundArgVList()
        arguments.Append("dummy")
        arguments.Append("%s.orc"%csoundFile)
        arguments.Append("%s.sco"%csoundFile)
        for item in comlineParmsList:
            arguments.Append("%s"%item)
        t =self.csound.Compile(arguments.argc(), arguments.argv())
        print 'test:', t
        self.hadronLoaded = False
        """Flag to test if Csound is finished loading"""

        self.performanceThread = csnd.CsoundPerformanceThread(self.csound)
        """The C++ csound performance thread"""
        
        #self.callbackdata = ''
        #self.performanceThread.SetProcessCallback(self.outValueCallback, self.callbackdata)

    def csoundPlay(self):
        """
        Start the performanceThread, a C++ thread for running csound, independent from the Python GIL.
        
        @param self: The object pointer.
        """
        print 'starting...'
        self.performanceThread.Play()
        print 'started'
        
    def outValueCallback(self, channel, value):
        if channel == "HadronLoaded":
            self.hadronLoaded = True

    def stop(self):
        """
        Terminate the csound performanceThread.
        
        @param self: The object pointer.
        """
        self.isRunning = False
        print 'stopping csound'        
        self.performanceThread.Stop()
        self.performanceThread.Join()
        time.sleep(1)
        # Clean up after ourselves.
        self.csound.Reset()
        self.csound.Cleanup()
