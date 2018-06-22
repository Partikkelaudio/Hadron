#!/usr/bin/python
# -*- coding: latin-1 -*-
""" 
Check and fix any irregularly formatted masking table files

Comments in mask table files must use Csound comment syntax (semicolon)
When writing mask files in MS-Exel, quotes (") are added to cells starting with a semicolon, so we need to remove these.
Also, replace any commas (,) with dots, for proper representation of fractional numbers

@author: Øyvind Brandtsegg
@contact: obrandts@gmail.com
@license: GPL
"""

import re
import fileinput
import os

def getMaskfileNames():
    """
    Get a list of the mask (text) files in the "mask_files" directory
    
    @param self: The object pointer.
    @return: A list of files in the directory
    """
    files = os.listdir('mask_files')
    # check that they are valid text file names
    for f in files:
        if len(re.findall('.txt|.TXT', f)) == 0:
            files.remove(f) 
    return files
    
for name in getMaskfileNames():
    name = 'mask_files/'+name
    print 'fixing formatting for mask file', name
    f = open(name, 'r')
    data = f.read()
    f.close()
    f = open(name, 'w')
    data = re.sub('\"', '', data)
    f.write(re.sub(',', '.', data))
    f.close()
    
        