#!/usr/bin/python
# -*- coding: latin-1 -*-

""" 
Check documentation for all states in states-release. 

Report missing or outdated documentation.

@author: Øyvind Brandtsegg
@contact: obrandts@gmail.com
@license: GPL
@requires: os, re, shutil
"""
import os
import re
import time

#--------------------------------------------------------------------------------


def getStatefileNames():
    """
    Get a list of the states files in the "states-release" directory
    
    @param self: The object pointer.
    @return: A list of files in the directory
    """
    files = os.listdir('states-release')
    statefiles = []
    # check that they are valid state file names
    for f in files:
        if len(re.findall('.spst|.SPST', f)) > 0:
            statefiles.append(f) 
    return statefiles

def getStateDocsNames():
    """
    Get a list of the states documentation files in the "docs" directory
    
    @param self: The object pointer.
    @return: A list of files in the directory
    """
    files = os.listdir('docs')
    docfiles = []
    # check that they are valid state documentation file names
    for f in files:
        if len(re.findall('.htm|.HTM', f)) > 0:
            if 'state_' in f:
                docfiles.append(f) 
    return docfiles

def docsPresentForAllStates():
    ## check if documentation excists for all states files
    docfiles = getStateDocsNames()
    statefiles = getStatefileNames()
    statefiles.remove('_unassigned.spst')
    statefiles_tested = [] #collect statefiles that have ok docs here
    docfiles_tested = []
    for statefile in statefiles:
        docfile = 'state_'+statefile[:-4]+'htm'
        if docfile in docfiles:
            docfiles_tested.append(docfile)
            statefiles_tested.append(statefile)
    for statefile in statefiles_tested:
        statefiles.remove(statefile) #remove files that have ok documentation
    for docfile in docfiles_tested:
        docfiles.remove(docfile) #remove doc files that have a corresponding state
    if len(statefiles) == 0:
        print 'states documentation is complete, all states are documented'
    else:
        print 'missing or outdated documentation for: ', statefiles
    if len(docfiles) == 0:
        print 'no orphan docfiles'
    else:
        print 'orphan docfiles: ', docfiles
    return len(statefiles), len(docfiles), statefiles_tested
    
def docsUpToDate(statefiles_tested):
    ## check if documentation is up to date
    updated_flag = 0
    for statefile in statefiles_tested:
        docfile = 'state_'+statefile[:-4]+'htm'
        if os.stat('./states/'+statefile)[8] > os.stat('./docs/'+docfile)[8]:
            print 'statefile %s may have outdated documentation'%statefile
            updated_flag += 1
    if updated_flag == 0:
        print 'documentation up to date'
    return updated_flag
    
def checkStatesDocumentation():
    a,b,statefiles_tested = docsPresentForAllStates()
    c = docsUpToDate(statefiles_tested)
    return a,b,c

if __name__ == '__main__':
    a,b,c = checkStatesDocumentation()
    print 'checkStatesDocumentation:', a,b,c