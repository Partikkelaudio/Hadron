#!/usr/bin/python
# -*- coding: latin-1 -*-

""" 
Make a HTML index file for all states documentation files in current directory.

@author: Øyvind Brandtsegg
@contact: obrandts@gmail.com
@license: GPL
@requires: csnd, os, re
"""
import os 
import sys
import re

#scriptPath = os.path.dirname( os.path.realpath( __file__ ) ) 
scriptPath = os.path.dirname(os.path.abspath(sys.argv[0]))
"""Get the location of the python file, may be different from cwd."""
os.chdir(scriptPath)
"""Then set cwd so that we are working in this directory, no matter where the script was executed from"""

import time
print '********************'
print os.getcwd()
print scriptPath
print '********************'
time.sleep(5)

def getStateFiles():
    """
    Get a list of the states description html files in the current directory
    
    @return: A list of files in the directory
    """
    files = os.listdir('.')
    statesfiles = []
    # filter text files starting with state_
    for f in files:
        if (len(re.findall('.htm|.html|.HTM|.HTML', f)) > 0) and (len(re.findall('state_', f)) > 0) :
            statesfiles.append(f) 
    return statesfiles
    
def sortStateFiles(filelist):
    """
    Sort the list of states description html files into categories. Categories specified by filename prefix.
    
    @filelist: The list of files to sort.
    @return: A dictionary with a key for each category, and all files in that category stored under that key.
    """
    i = 0 # file counter
    outDict = {'gr':[], 'gt':[], 'fx':[], 'tfx':[]}
    for file in filelist:
        if 'state_gr' in file:
            outDict['gr'].append(file)
            i += 1
        elif 'state_gt' in file:
            outDict['gt'].append(file)
            i += 1
        elif 'state_fx' in file:
            outDict['fx'].append(file)
            i += 1
        elif 'state_tfx' in file:
            outDict['tfx'].append(file)
            i += 1
    print 'sorted %i of %i files'%(i, len(filelist))
    sorted = []
    for f in outDict.values():
        sorted.extend(f)
    for f in sorted:
        filelist.remove(f)
    print 'unsorted files:', filelist
    return outDict

sortedFiles = sortStateFiles(getStateFiles())

categoryOrder = ['gr', 'gt', 'fx', 'tfx']
    
categoryFullNames = {'gr':'Synth States with Grain Rate Pitch definition',
                     'gt':'Synth States with Grain Transpose Pitch definition',
                     'fx':'Effects States',
                     'tfx':'Midi Triggered Effects States'}

categoryFullNamesBR = {'gr':'Synth States with <br>Grain Rate Pitch definition',
                     'gt':'Synth States with <br>Grain Transpose Pitch definition',
                     'fx':'Effects States',
                     'tfx':'Midi Triggered Effects States'}

category_files={'gr':'category_index_grainrate.html', 
                'gt':'category_index_graintranspose.html', 
                'fx':'category_index_effects.html', 
                'tfx':'category_index_triggeredeffects.html'}

grainrate_content = '''
				<h1>Synth States with Grain Rate Pitch definition</h1>
				<p>The Grain Rate (gr) states are audio synthesis states where the perceived pitch is constituted by the grain rate 
				(the number of audio particles/grains created per second)
				</p>
				<p>Some states have names ending with _samplecompatible or _singlecyclecompatible, these are slightly modified copies of states with the same name (without the extra name suffix). The modified copies might in some circumstances make for smoother morphing to other states. The samplecompatible suffix signifies that the state should be more "morph compatible" with other states using samples as source waveforms, while the singlecyclecompatible does the same for states using single cycle waveforms as source. 
				</p>\n'''
graintranspose_content = '''
				<h1>Synth States with Grain Transpose Pitch definition</h1>
				<p>The Grain Transpose (gt) states are audio synthesis states where the perceived pitch is constituted by the transposition of sound inside each audio particle/grain.
				</p>\n'''
effects_content = '''
				<h1>Effects States</h1>
				<p>The Effect states lets Hadron be used as an audio effect for live audio input. These are normally used with audioInput selected as the waveform source(s).
				</p>\n'''
tfx_content = '''
				<h1>Midi Triggered Effects States</h1>
				<p>The Midi Triggered Effects States (tfx) is similar to the Effects (fx) states, as these states also provide processing of a live audio input signal. The essential difference between fx and tfx states is that the tfx states require midi input to make sound, as the audio output is muted when no midi notes are sent to Hadron. 
				</p>\n'''

category_content = {'gr': grainrate_content,
                    'gt': graintranspose_content,
                    'fx': effects_content,
                    'tfx': tfx_content}

################ write index ################
print 'writing index_states.html'
outfile = open('index_states.html', 'w')
outfile.write('''<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<link rel="stylesheet" type="text/css" href="hadron.css" />
	<link rel="icon" href="images/favicon.ico" />

	<title>Hadron States Documentation</title>
</head>

<body>
	<div id="headUC">
	</div>

	<div class="clear">
	</div>

	<div id="bodywrap">
		<div id="innerbody">
			<img src="images/pagetitles/maintitle.png" alt="Hadron States Documentation" class="titleimage">

			<div class="clear">
			</div>

			<div id="leftmenu">
				<h2>Hadron State Documentation Index</h2></a>

				<a href="category_index_grainrate.html"><h2>Synth States with <br>Grain Rate Pitch definition</h2></a>

				<a href="category_index_graintranspose.html"><h2>Synth States with <br>Grain Transpose Pitch definition</h2></a>

				<a href="category_index_effects.html"><h2>Effects States</h2></a>

				<a href="category_index_triggeredeffects.html"><h2>Midi Triggered Effects States</h2></a>
				&nbsp;
			</div>

			<div id="rightcontent">
				<h1>Hadron State Documentation Index</h1>
				<p>The states are divided into categories, representing different modes of functionality for the Hadron plugin.</p>
				<p>Hadron can be used as an effects processor or as a synth. When used as a synth, pitch can be determined by grain rate (number of 
				audio particles per second)
				or by grain transpose (the pitch inside each audio particle).
				When used as an effect there is also two different modes: one traditional effect mode where audio in is always processed and sent out,
				and another "midi triggered effect" mode where the Hadron output is muted until a midi note is received.</p>

				<hr>
\n''')

for category in categoryOrder:
    if category == 'gr' or category == 'fx':
        outfile.write('				<div class="index_column">\n')
    outfile.write('				<h2>%s</h2>\n'%categoryFullNames[category])
    outfile.write('				<p>\n')
    for file in sortedFiles[category]:
        basename = file.split('.')[0].split('state_')[1]
        outfile.write('				<a href="%s">%s</a><br>\n'%(file,basename))
    outfile.write('				</p>\n')
    if category == 'gt' or category == 'tfx':
        outfile.write('				</div>\n')



outfile.write('''			</div>

			<div class="clear">
			</div>
		</div>
	</div>
	<div class="clear">
	</div>
	<div id="footer">
		<div id="footercopyright">
			Copyright &copy; 2010
			Partikkel Audio &reg; All Rights Reserved
		</div>

		<div id="footerlogo">
			<!-- [ Partikkel Audio Logo ] -->
		</div>
	</div>
	<div class="empty-block">
	</div>
</body>
</html>
\n''')

outfile.close()

############ category files #########################
for currCategory in categoryOrder:
    print 'writing %s'%category_files[currCategory]
    outfile = open(category_files[currCategory], 'w')
    outfile.write('''
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<link rel="stylesheet" type="text/css" href="hadron.css" />
	<link rel="icon" href="images/favicon.ico" />

	<title>Hadron States Documentation</title>
</head>

<body>
	<div id="headUC">
	</div>

	<div class="clear">
	</div>

	<div id="bodywrap">
		<div id="innerbody">
			<img src="images/pagetitles/maintitle.png" alt="Hadron States Documentation" class="titleimage">

			<div class="clear">
			</div>

			<div id="leftmenu">
				<a href="index_states.html"><h2>State Documentation Index</h2></a>

\n''')

    for category in categoryOrder:
        if category == currCategory:
            outfile.write('				<h2>%s</h2>'%categoryFullNamesBR[currCategory])
            outfile.write('				<p class="leftmenu">')
            for file in sortedFiles[category]:
                basename = file.split('.')[0].split('state_')[1]
                outfile.write('				<a href="%s">%s</a><br>\n'%(file,basename))
            outfile.write('				</p>')
        else:
            outfile.write('				<a href="%s"><h2>%s</h2></a>'%(category_files[category], categoryFullNamesBR[category]))
    
    outfile.write('''				
    &nbsp;
			</div>

			<div id="rightcontent">\n''')
    outfile.write(category_content[currCategory])
    outfile.write('''
				<p>Please select states from the left hand menu for state description sheet.
				</p>
			</div>

			<div class="clear">
			</div>
		</div>
	</div>
	<div class="clear">
	</div>
	<div id="footer">
		<div id="footercopyright">
			Copyright &copy; 2010
			Partikkel Audio &reg; All Rights Reserved
		</div>

		<div id="footerlogo">
			<!-- [ Partikkel Audio Logo ] -->
		</div>
	</div>
	<div class="empty-block">
	</div>
</body>
</html>
\n''')

###################### clean up after our py installer on windows ####

import os
import time
time.sleep(2)
d = os.getcwd()
for f in os.listdir(d):
    if (len(re.findall('.pyd|.zip', f)) > 0) :
        os.remove(os.path.join(d,f))
os.chdir('Microsoft.VC90.CRT')
d = os.getcwd()
for f in os.listdir(d):
        os.remove(os.path.join(d,f))
os.chdir('..')
os.rmdir('Microsoft.VC90.CRT')

