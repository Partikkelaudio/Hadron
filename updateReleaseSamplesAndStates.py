#!/usr/bin/python
# -*- coding: latin-1 -*-

""" 
Update the samples-release and states-release directories with any changes done to the same files in samples and states directories.
@author: Øyvind Brandtsegg
@contact: obrandts@gmail.com
@license: GPL
@requires: os, re, shutil
"""
import os
import re
import shutil

#--------------------------------------------------------------------------------

def getWavefileNames(dir):
    """
    Get a list of the sound files in the "samples-release" directory
    
    @param self: The object pointer.
    @return: A list of files in the directory
    """
    files = os.listdir(dir)
    wavfiles = []
    # check that they are valid wave file names
    for f in files:
        if len(re.findall('.wav|.WAV', f)) > 0:
            wavfiles.append(f) 
    return wavfiles

def getStatefileNames(dir):
    """
    Get a list of the states files in the "states-release" directory
    
    @param self: The object pointer.
    @return: A list of files in the directory
    """
    files = os.listdir(dir)
    statefiles = []
    # check that they are valid state file names
    for f in files:
        if len(re.findall('.spst|.SPST', f)) > 0:
            statefiles.append(f) 
    return statefiles

def updateSamples():
    # copy from store to release if the file in store is more recent
    numWaveFiles = 0
    for wavfile in getWavefileNames('samples-release'):
        release = './samples-release/'+wavfile
        store = './samples/'+wavfile
        if os.stat(store)[8] > os.stat(release)[8]:
            print 'copy:', 'samples/' + wavfile, 'samples-release/' + wavfile
            shutil.copyfile('samples/' + wavfile, 'samples-release/' + wavfile)
            numWaveFiles += 1
    print 'wavefiles copied:', numWaveFiles
    return numWaveFiles

def updateStates():
    numStateFiles = 0
    for statefile in getStatefileNames('states-release'):
        release = './states-release/'+statefile
        store = './states/'+statefile
        if os.stat(store)[8] > os.stat(release)[8]:
            print 'copy:', 'states/' + statefile, 'states-release/' + statefile
            shutil.copyfile('states/' + statefile, 'states-release/' + statefile)
            numStateFiles += 1        
    print 'statesfiles copied:', numStateFiles
    return numStateFiles

def copyNewSamples():
    # check for recent files in store that does not yet exist in release
    print 'checking for new samples...'
    mostRecentSample = 0
    newSamples = 0
    for wavfile in getWavefileNames('samples-release'):
        if os.stat('./samples-release/'+wavfile)[8] > mostRecentSample:
            mostRecentSample = os.stat('./samples-release/'+wavfile)[8]
    for wavfile in getWavefileNames('samples'):
        if os.stat('./samples/'+wavfile)[8] > mostRecentSample:
            print 'file "%s" seems to be new, copy this wave file to release directory ? (Yes/No)'%wavfile
            user = raw_input()
            if len(re.findall('yes|Yes|Y|y', user)) > 0:
                print 'copying wavefile', wavfile
                shutil.copyfile('samples/' + wavfile, 'samples-release/' + wavfile)
                newSamples += 1
            else:
                print 'skip ', wavfile
    print 'adding %i new samples to samples-release'%newSamples
    return newSamples
            
def copyNewStates():
    print 'checking for new states...'
    mostRecentState = 0
    newStates = 0
    for statefile in getStatefileNames('states-release'):
        if os.stat('./states-release/'+statefile)[8] > mostRecentState:
            mostRecentState = os.stat('./states-release/'+statefile)[8]
    for statefile in getStatefileNames('states'):
        if os.stat('./states/'+statefile)[8] > mostRecentState:
            print 'file "%s" seems to be new, copy this state file to release directory ? (Yes/No)'%statefile
            user = raw_input()
            if len(re.findall('yes|Yes|Y|y', user)) > 0:
                print 'copying statefile', statefile
                shutil.copyfile('states/' + statefile, 'states-release/' + statefile)
                newStates += 1
            else:
                print 'skip ', statefile
    print 'adding %i new states to samples-release'%newStates
    return newStates
    
def updateReleaseSamplesAndStates():
    a = updateSamples()
    b = updateStates()
    c = copyNewSamples()
    d = copyNewStates()
    return a,b,c,d

if __name__ == '__main__':
    a,b,c,d = updateReleaseSamplesAndStates()
    print 'updateReleaseSamples: ', a,b,c,d