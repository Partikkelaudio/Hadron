#!/usr/bin/python
# -*- coding: latin-1 -*-

""" 
Check the installer date (both Win and OSX, check if any files in repo is more recent (have been edited).

@author: Øyvind Brandtsegg
@contact: obrandts@gmail.com
@license: GPL
@requires: os, re, shutil
"""
import os
import re
import time

#--------------------------------------------------------------------------------

winInstaller = './installer/Win/Hadron_DSP_Installer_Win_ver_0.95.beta.exe'
macInstaller = './installer/OSX/Hadron_DSP_Installer_OSX_ver_0.95.beta.zip'
winDate = os.stat(winInstaller)[8]
macDate = os.stat(macInstaller)[8]
installerDate = min(winDate,macDate)

macwin = 'windows'
if winDate>macDate: macwin = 'OSX'
print 'dates: win = %s, mac = %s'%(time.strftime('%y %b %d %H %M', time.localtime(winDate)), time.strftime('%y %b %d %H %M', time.localtime(macDate)))
print 'using date for %s installer'%macwin



def checkInstallerDate(debug=0):
    modfiles = 0
    for root, dirs, files in os.walk('C:/Projects/hadron'):
        if len(re.findall('.hg|bkup_edit|build|states-txt|states|samples|mask_files|func_files|control|cs|comp', root)) == 0:
            for f in files:
                if len(re.findall('.pyc|.DS_Store|csoundCommandline|currentEdits|todo', f)) == 0:
                    filedate = os.stat(root+'/'+f)[8]
                    if filedate > installerDate:
                        if debug: print 'file %s modified after installer build'%(root+'/'+f)
                        modfiles +=1
    return modfiles
		
if __name__ == '__main__':
    a = checkInstallerDate(1)
    print '%i files modified after installer was built'%a