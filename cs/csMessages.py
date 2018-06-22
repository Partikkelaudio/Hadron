#!/usr/bin/python
# -*- coding: latin-1 -*-

""" 
Handles communication between Python and Csound.

@author: Øyvind Brandtsegg
@contact: obrandts@gmail.com
@license: GPL
@requires: csnd
@requires: random
"""

import csnd6 as csnd
import random

class CsoundMessages:
    """This class handles all communication between Python and the csound instance."""

    def __init__(self, csound, performanceThread):
        """
        Class constructor.
        
        @param self: The object pointer.
        @param csound: Instance of Csound interface object.
        """
        self.csound = csound
        self.performanceThread = performanceThread

    def csoundInputMessage(self, message):
        """
        Delivers a message directly to Csound. Wrapper for csound InputMessage.
        
        @param self: The object pointer.
        @param message: The Csound message to be delivered.
        """
        self.performanceThread.InputMessage(message)
                

    def getCsoundBusChannels(self):
        """
        Returns a list of all allocated bus channels between Python and Csound.
        
        @param self: The object pointer.
        @return: Channel list.
        """
        chnlst = csnd.CsoundChannelList(self.csound)
        channelList = []
        n = chnlst.Count()
        for i in range(n):
            item = []
            item.append(chnlst.Name(i))
            if chnlst.IsControlChannel(i):
                item.append('control')
            elif chnlst.IsAudioChannel(i):
                item.append('audio')
            elif chnlst.IsStringChannel(i):
                item.append('string')
            channelList.append(item)
        return channelList

    def listCsoundBusChannels(self):
        """
        Prints a list of all allocated bus channels between python and csound.
        
        @param self: The object pointer.
        """
        chnlst = csnd.CsoundChannelList(self.csound)

        n = chnlst.Count()
        if n > 0:
            print '============================================================'
            print 'Csound chn channels listing'
            print 'Currently using', n, 'channels'
            print '------------------------------------------------------------'
        for i in range(n):
            print 'Name:', chnlst.Name(i)
            if chnlst.IsControlChannel(i):
                print '       | Type: control', '| Input:', ['no', 'yes'][chnlst.IsInputChannel(i)], '| Output:', ['no', 'yes'][chnlst.IsOutputChannel(i)]
            elif chnlst.IsAudioChannel(i):
                print '       | Type: audio', '| Input:', ['no', 'yes'][chnlst.IsInputChannel(i)], '| Output:', ['no', 'yes'][chnlst.IsOutputChannel(i)]
            elif chnlst.IsStringChannel(i):
                print '       | Type: string', '| Input:', ['no', 'yes'][chnlst.IsInputChannel(i)], '| Output:', ['no', 'yes'][chnlst.IsOutputChannel(i)]

    def getChnValue(self, name):
        """
        Get the value stored in a csound chn channel
        
        @param self: The object pointer.
        @param name: The name of the channel to be interrogated.
        @return: The value of the channel
        """
        return self.csound.GetChannel(name)
    
    
    def sendControlToCsound(self, channelName, value):
        """
        Send a control value to csound, using the software bus and chn opcode in csound.
        
        @param self: The object pointer.
        @param channelName: Channel name.
        @param value: The value to be sent to the designated channel.
        """
        self.csound.SetChannel(channelName, value)

    def sendControlToCsound_(self, channelNameAndValue):
        """
        Wrapper for self.sendControlToCsound(), using channels name and value as a list.
        
        @param self: The object pointer.
        @param channelNameAndValue: Channel name and value as a list.
        """
        channelName, value = channelNameAndValue
        print channelName, value
        self.csound.SetChannel(channelName, value)

    def TableGet(self, table, index):
        """
        Get the value of an index of a csound ftable. 
        
        Wrapper for csound.TableGet

        @param self: The object pointer.
        @param table: The table number.
        @param index: The index into the table.
        @return: The value at index.
        """
        return self.csound.TableGet(table, index)
