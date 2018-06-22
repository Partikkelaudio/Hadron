#!/usr/bin/python
# -*- coding: latin-1 -*-

""" 
Check files in repo against files in the betatest directory, to ensure that intermediate edits in betatest is propagated into repo.

@author: Øyvind Brandtsegg
@contact: obrandts@gmail.com
@license: GPL
@requires: os, re, shutil
"""
import os
import re
import time

#--------------------------------------------------------------------------------

# get betatest directory
print 'enter betatest directory (default "C:/Program Files/Hadron")'
betaroot = raw_input()
if len(betaroot) < 2:
    betaroot = 'C:/Program Files/Hadron'

#betadirs = ['/Csound_Hadron', '/docs', '/GUI', '/inc', '/presets', '/samples', '/states']
#repodirs = ['/CsoundMod/win/Csound_Hadron', '/docs', '/M4L/GUI', '/inc', '/presets', '/samples-release', '/states-release']
betadirs = ['/docs', '/GUI', '/inc',]
repodirs = ['/docs', '/M4L/GUI', '/inc']
excludefiles = ['uninstall.exe']

def getFiles(path):
    files = os.listdir(path)
    for f in os.listdir(path):
        if os.path.isdir(path+'/'+f):
            files.remove(f)
    return files

def checkBetaEdits(beta, repo):
    updated_flag = 0
    for file in getFiles(beta):
        fileInRepo = 0
        try:
            os.stat(repo+'/'+file)
            fileInRepo = 1
        except:
            if file not in excludefiles:
                print 'file %s/%s in beta does not exist in repo %s/%s'%(beta,file,repo,file)
        if fileInRepo:
            if os.stat(beta+'/'+file)[8] > os.stat(repo+'/'+file)[8]:
                print 'file %s in beta %s may be edited'%(file, beta)
                updated_flag += 1
    if updated_flag == 0:
        print '%s up to date in repo'%repo
    return updated_flag

def checkBetaToRepo():
    updated = 0
    for i in range(len(betadirs)):
        updated += checkBetaEdits(betaroot+betadirs[i], '.'+repodirs[i])
    updated += checkBetaEdits(betaroot, '.')
    
    if updated == 0:
        print 'All checked files ok in repo'
    else:
        print '**************************************************'
        print 'Some edits in beta may need to be merged into repo'
        print '**************************************************'
    return updated

if __name__ == '__main__':
    a = checkBetaToRepo()
    print 'checkBetaToRepo:', a