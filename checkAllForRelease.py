#!/usr/bin/python
# -*- coding: latin-1 -*-

""" 
Check files hadron repo for release, "all in one" check

Will run the following tests and collect the results.
updateReleaseSamplesAndStates.py
checkBetaToRepo.py
checkStatesDocumentation.py
checkInstaller.py

@author: Øyvind Brandtsegg
@contact: obrandts@gmail.com
@license: GPL
"""

#--------------------------------------------------------------------------------

import updateReleaseSamplesAndStates
import checkBetaToRepo
import checkStatesDocumentation
import checkInstallerDate

a,b,c,d = updateReleaseSamplesAndStates.updateReleaseSamplesAndStates()
print 'updateReleaseSamples: ', a,b,c,d
e = checkBetaToRepo.checkBetaToRepo()
f,g,h = checkStatesDocumentation.checkStatesDocumentation()
i = checkInstallerDate.checkInstallerDate()
if i > 0:
    print 'checkInstallerDate: %i files more recent than installer'%i

print 'error log:', a,b,c,d,e,f,g,h,i
test = a+b+c+d+e+f+g+h+i

if test == 0:
    print 'All checked files ok, ready to go!'
else:
    print '**************************************************'
    print 'Not ready for release, %i error(s)'%test
    print '**************************************************'
    