#!/usr/bin/python
# -*- coding: latin-1 -*-

""" 
A command line interpreter for the Hadron state and preset developer system

@author: Øyvind Brandtsegg
@contact: obrandts@gmail.com
@license: GPL
@requires: re, os, cmd, readline, re
"""

import os
import cmd
import readline
import re
import modMatrixMap
import time


class CLI(cmd.Cmd):

    def __init__(self):
        cmd.Cmd.__init__(self)
        self.prompt = 'hadron:>>> '
        self.intro = '\n'.join([' ',
                                '===============================================',
                                'Hadron state and preset developer system loaded',
                                '===============================================',
                                '    type "help" for command list,', 
                                '    help <command> for details on each command',
                                '    "help introduction" for a command summary',
                                '==============================================='])
        self.commandSummary = '\n'.join(['===============================================',
                                         'Command summary:',
                                         '===============================================',
                                         '    partikkelDsp    : turn on partikkel instrument',
                                         '    parmset         : set parameter value (partikkel single states',
                                         '    chnset          : set Csound chn channel value',
                                         '    singleState     : read or write a partikkel state file',
                                         '    setMaskTable    : set contents of masking tables',
                                         '    importMaskTable : import mask table from tab delimited text file',
                                         '    setModMatrix    : set modulator to parameter routing',
                                         '    preset          : read or write a preset (4xstate) file',
                                         '    presetMode      : select preset or state mode',
                                         '    setSourceWave   : set source waveform for partikkel',
                                         '    i               : standard Csound score line',
                                         '    quit            : exit',
                                         '==============================================='])
        self.chnlist = ['presetX', 'presetY', 'MasterLevel', 'hostTempoBpm', 'LiveSamplingChannel', 'AmpResponse', 'AtckThresh', 'MinThresh', 'RelThresh', 'RelTime']
        self.parmlist = modMatrixMap.parameters
        self.modlist = modMatrixMap.modulators
        self.masklist = ['gainmasks1', 'channelmasks1', 'wavemasks1', 'freqstartmasks1', 'freqendmasks1', 'fmampmasks1']
        self.funclist = ['1','2','3','4']
        self.rw  = ['read', 'write']

        try:
            readline.read_history_file('historyfile')
        except IOError:
            pass
        import atexit
        atexit.register(readline.write_history_file, 'historyfile')
    
        self.statesDir = ''

    def do_introduction(self, arg):
        print self.commandSummary

    def help_introduction(self):
        print self.commandSummary
                
    def completedefault(self, text, line, begidx, endidx):
        return ['introduction']

    def emptyline(self):
        pass

    def do_partikkelDsp(self, arg):
        try:
            if int(arg) == 1:
                csMessages.csoundInputMessage('i 251 0 -1')
            elif int(arg) == 0:
                csMessages.csoundInputMessage('i -251 0 1')
            else:
                raise Exception ('invalid argument')
        except:
            print 'syntax error', arg
            self.onecmd('help partikkelDsp')
            
    def help_partikkelDsp(self):
        print '==============================================='
        print '    syntax: partikkelDsp state'
        print '    turn the partikkel instr on (1) or off (0)'
        print '==============================================='

    def do_chnset(self, arg):
        try:
            name, value = arg.split(' ')
            csMessages.sendControlToCsound(name, float(value))
        except:
            print 'syntax error', arg
            self.onecmd('help chnset')

    def complete_chnset(self, text, line, begidx, endidx):
        if not text:
            completions = self.chnlist[:]
        else:
            completions = [ c
                            for c in self.chnlist
                            if c.startswith(text)
                            ]
        return completions

    def help_chnset(self):
        print '==============================================='
        print '    syntax: chnset name value'
        print '    set a chn channel value in Csound (use only for parameters not stored in states)'
        print '==============================================='

    def do_chnget(self, arg):
        try:
            value = csMessages.getChnValue(arg)
            print 'chn %s has value %f'%(arg, value)
        except:
            print 'syntax error', arg
            self.onecmd('help chnget')

    def complete_chnget(self, text, line, begidx, endidx):
        if not text:
            completions = self.chnlist[:]
        else:
            completions = [ c
                            for c in self.chnlist
                            if c.startswith(text)
                            ]
        return completions

    def help_chnget(self):
        print '==============================================='
        print '    syntax: chnget name'
        print '    get a chn channel value in Csound'
        print '==============================================='

    def do_chnlist(self, arg):
        try:
            csMessages.listCsoundBusChannels()
        except:
            print 'syntax error'
            self.onecmd('help chnlist')

    def help_chnlist(self):
        print '==============================================='
        print '    syntax: chnlist (no arg)'
        print '    list all Csound chn channels'
        print '==============================================='

    def do_parmset(self, arg):
        try:
            name, value = arg.split(' ')
            print name, value
            try:
                pNum = modMatrixMap.parameters.index(name)
            except:
                print 'unknown parameter', parameter
                return
            csMessages.csoundInputMessage('i 104 0 1 "%s" %s'%(name, value))
        except:
            print 'syntax error', arg
            self.onecmd('help parmset')

    def complete_parmset(self, text, line, begidx, endidx):
        if not text:
            completions = self.parmlist[:]
        else:
            completions = [ p
                            for p in self.parmlist
                            if p.startswith(text)
                            ]
        return completions

    def help_parmset(self):
        print '==============================================='
        print '    syntax: parmset name value'
        print '    set a parameter value (in master state slot 0, and single state in slot -1)'
        print '==============================================='

    def do_parmget(self, arg):
        try:
            try:
                pNum = modMatrixMap.parameters.index(arg)
            except:
                print 'unknown parameter', parameter
                return
            csMessages.csoundInputMessage('i 106 0 1 "%s"'%arg)
        except:
            print 'syntax error', arg
            self.onecmd('help parmget')

    def complete_parmget(self, text, line, begidx, endidx):
        if not text:
            completions = self.parmlist[:]
        else:
            completions = [ p
                            for p in self.parmlist
                            if p.startswith(text)
                            ]
        return completions

    def help_parmget(self):
        print '==============================================='
        print '    syntax: parmget name'
        print '    get a parameter value (in master state slot 0, and single state in slot -1)'
        print '==============================================='

    def do_singleState(self, arg):
        try:
            rw = arg.split(' ')[0]
            if not (((len(arg.split(' ')) == 3) and (rw == 'read')) or ((len(arg.split(' ')) == 2) and (rw == 'write'))):
                raise Exception(arg)
        except:
            print 'syntax error', arg
            self.onecmd('help singleState')
            return
        if rw == 'write':
            try:
                filename = arg.split(' ')[1]
                csMessages.csoundInputMessage('i 71 0 1 "%s"'%(self.statesDir+'/'+filename))
            except:
                print 'syntax error', arg
        elif rw == 'read':
            try:
                filename = arg.split(' ')[1]
                presetSlot = int(arg.split(' ')[-1])
                if 0 <= presetSlot <= 3:
                    csMessages.csoundInputMessage('i 72 0 1 "%s" %i'%(self.statesDir+'/'+filename, presetSlot))
                elif presetSlot == -1:
                    csMessages.csoundInputMessage('i 70 0 1 "%s"'%(self.statesDir+'/'+filename))
                else:
                    print 'state slot must be in range -1 to 3'
            except:
                print 'syntax error', arg
                self.onecmd('help singleState')

    def complete_singleState(self, text, line, begidx, endidx):
        if not text:
            completions = self.rw[:]
        if len(re.findall(' ', line)) == 1:
            completions = [ rw
                            for rw in self.rw
                            if rw.startswith(text)
                            ]
        elif len(re.findall(' ', line)) == 2:
            theFullList = os.listdir(os.getcwd()+'/states/'+self.statesDir)
            theList = []
            for item in theFullList:
                if ".spst" in item:
                    theList.append(item)
            completions = [ f
                            for f in theList
                            if f.startswith(text)
                            ]
        return completions
        
    def help_singleState(self):
        print '==============================================='
        print '    syntax: singleState read/write filename slot'
        print '    read or write a single state (single preset), the slot argument is only used for reading and can be omitted when writing'
        print '    slot sets the master state slot to load the state into (0,1,2,3), use slot -1 for single state playback (when not in master preset mode)'
        print '==============================================='

    def do_singleState_TXT(self, arg):
        try:
            if len(arg.split(' ')) != 2:
                raise Exception(arg)
        except:
            self.onecmd('help singleState_TXT')
            return
        rw, filename = arg.split(' ')
        filename = 'states_txt/'+self.statesDir+'/'+filename
        if rw == 'write':
            f = file(filename, 'w')
            giSinglePreset = csMessages.getChnValue('giSinglePreset')
            for p in modMatrixMap.parameters:
                if p == 'PresetVersionNumber':
                    line = p + '\t' + str(csMessages.getChnValue('giPresetVersion')) + '\n'
                else:
                    line = p + '\t' + str(csMessages.TableGet(int(giSinglePreset), int(modMatrixMap.parameters.index(p)))) + '\n'
                f.write(line)
            giModScale1 = csMessages.getChnValue('giModScale1')
            giNumParameters = csMessages.getChnValue('giNumParameters')
            for m in modMatrixMap.modulators:
                modNum = modMatrixMap.modulators.index(m)
                for p in modMatrixMap.parameters:
                    pNum = modMatrixMap.parameters.index(p)  
                    index = (modNum*giNumParameters)+pNum
                    value = csMessages.TableGet(int(giModScale1), int(index))
                    if not value == 0.0:
                        line = m + '\t to \t' + p + '\t' + str(value) + '\n'
                        f.write(line)
            f.close()        
        elif rw == 'read':
            try:
                f = file(filename, 'r')
                #csMessages.csoundInputMessage('i 101 0 1')  # clear modulation matrix and mask tables
                for line in f:
                    if not '\t to \t' in line:  # if it's not a modulator matrix line, it is a parameter assignment line
                        p,v = line.split('\t')
                        csMessages.csoundInputMessage('i 104 0 1 "%s" %s'%(p,v))
                        time.sleep(0)
                    else:
                        m = line.split('\t to \t')[0]
                        p,v = line.split('\t to \t')[1].split('\t')
                        assignment = m + '\t' + 'to' + '\t' + p 
                        csMessages.csoundInputMessage('i 102 0 1 "%s" %s'%(assignment, v))
                        time.sleep(0)
                f.close()
            except:
                print 'no file %s ?'%filename
                self.onecmd('help singleState_TXT')
    
    def complete_singleState_TXT(self, text, line, begidx, endidx):
        if not text:
            completions = self.rw[:]
        if len(re.findall(' ', line)) == 1:
            completions = [ rw
                            for rw in self.rw
                            if rw.startswith(text)
                            ]
        elif len(re.findall(' ', line)) == 2:
            theFullList = os.listdir(os.getcwd()+'/states_txt/'+self.statesDir)
            theList = []
            for item in theFullList:
                if ".txt" in item:
                    theList.append(item)
            completions = [ f
                            for f in theList
                            if f.startswith(text)
                            ]
        return completions

    def help_singleState_TXT(self):
        print '==============================================='
        print '    syntax: singleState_TXT read/write filename'
        print '    read or write a single state (single preset) TXT file, ' 
        print '    the slot argument (as in the singleState command) is NOT USED for text state files'
        print '    Text state files can only be imported to slot -1 (single state mode)'
        print '    **warning: no tables are included in the text files, '
        print '    this means that masking tables are not saved, also, '
        print '    any tables currently in memory are not overwritten when loading a state.'
        print '    this can lead to cross contamination of states'
        print '==============================================='

    def do_setStatesDir(self, arg):    
        # set the states dir
        self.statesDir = arg
        
    def complete_setStatesDir(self, text, line, begidx, endidx):
        dirList = []
        for f in os.listdir(os.getcwd()+'/states'):
            if os.path.isdir(os.getcwd()+'/states/'+f):
                dirList.append(f)
        completions = [ f
                        for f in dirList
                        if f.startswith(text)
                        ]
        return completions

    def help_setStatesDir(self):    
        print '==============================================='
        print '    syntax: setStatesdir dir'
        print '    Set the directory where Hadron will look for state files'
        print '==============================================='

    def do_setMaskTable(self, arg):
        try:
            maskTable, AorB = arg.split(' ')[:2]
            if AorB == 'A': 
                AorBnum = 1
            else: AorBnum = 2
            tableValues = []
            items = arg.split(' ')
            for value in items:
                try:
                    v = float(value)
                    tableValues.append(v)
                except:
                    pass
            scoreString = 'i 80 0 1 "%s" %i' %(maskTable, AorBnum)
            for v in tableValues:
                scoreString += ' %f'%v
            csMessages.csoundInputMessage(scoreString)
        except:
            print 'syntax error', arg
            self.onecmd('help setMaskTable')

    def complete_setMaskTable(self, text, line, begidx, endidx):
        if not text:
            completions = self.masklist[:]
        else:
            completions = [ m
                            for m in self.masklist
                            if m.startswith(text)
                            ]
        return completions

    def help_setMaskTable(self):
        print '==============================================='
        print '    syntax: setMaskTable tablename A/B start end v1 v2 v3 v4 ...'
        print '    set masking table (see partikkel in csound manual)'
        print '    the masking types are gainmasks, channelmasks, wavemasks, freqstartmasks, freqendmasks, fmampmasks'
        print '    a number in the mask table name represents partikkel instance, e.g. gainmasks1, in this version only one instance is used'
        print '    A or B selects mask table (a separate parameter (e.g. gainmasks1Morf) value controls morphing between A and B)'
        print '    Recommendation: use a mask length of 60, as this allows smooth interpolation between mask sequences of length 1,2,3,4,5 and 6)'
        print '    NOTE: this method will only work in presetMode = state'
        print '==============================================='

    def do_importMaskTable(self, arg):
        if len(arg.split(' ')) != 3:
            print len(arg.split(' '))
            print 'syntax error', arg
            self.onecmd('help importMaskTable')
            return
        try:
            csMessages.csoundInputMessage('i 79 0 1 "%s"' %(arg))
        except:
            print 'syntax error', arg
            self.onecmd('help importMaskTable')

    def complete_importMaskTable(self, text, line, begidx, endidx):
        if not text:
            completions = self.masklist[:]
        if len(re.findall(' ', line)) == 1:
            completions = [ m
                            for m in self.masklist
                            if m.startswith(text)
                            ]
        elif len(re.findall(' ', line)) == 2:
            completions = ['A']
        else:
            completions = useReadlineDefault
        return completions

    def help_importMaskTable(self):
        print '==============================================='
        print '    syntax: importMaskTable tablename A/B filename'
        print '    import mask table data from tab delimited text file,'
        print '    use data to set masking table (see partikkel in csound manual)'
        print '    the masking types are gainmasks, channelmasks, wavemasks, freqstartmasks, freqendmasks, fmampmasks'
        print '    a number in the mask table name represents partikkel instance, e.g. gainmasks1, in this version only one instance is used'
        print '    A or B selects mask table (a separate parameter (e.g. gainmasks1Morf) value controls morphing between A and B)'
        print '    Recommendation: (when editing mask files) use a mask length of 60, '
        print '    as this allows smooth interpolation between mask sequences of length 1,2,3,4,5 and 6).'
        print '==============================================='

    def do_exportMaskTable(self, arg):
        if len(arg.split(' ')) != 3:
            print len(arg.split(' '))
            print 'syntax error', arg
            self.onecmd('help exportMaskTable')
            return
        try:
            csMessages.csoundInputMessage('i 78 0 1 "%s.msk"' %(arg))
        except:
            print 'syntax error', arg
            self.onecmd('help exportMaskTable')

    def complete_exportMaskTable(self, text, line, begidx, endidx):
        if not text:
            completions = self.masklist[:]
        if len(re.findall(' ', line)) == 1:
            completions = [ m
                            for m in self.masklist
                            if m.startswith(text)
                            ]
        elif len(re.findall(' ', line)) == 2:
            completions = ['A']
        else:
            completions = useReadlineDefault
        return completions

    def help_exportMaskTable(self):
        print '==============================================='
        print '    syntax: exportMaskTable tablename A/B filename'
        print '    export mask table data to text file (Csound ftsave format).'
        print '    The file will be saved to /mask_files with a .msk file type'
        print '==============================================='

    def do_exportFuncTable(self, arg):
        if len(arg.split(' ')) != 2:
            print len(arg.split(' '))
            print 'syntax error', arg
            self.onecmd('help exportFuncTable')
            return
        try:
            func_no, name = arg.split(' ')
            print func_no, name
            csMessages.csoundInputMessage('i 107 0 1 %i "%s.func"' %(int(func_no), name))
        except:
            print 'syntax error (2)', arg
            self.onecmd('help exportFuncTable')

    def complete_exportFuncTable(self, text, line, begidx, endidx):
        if not text:
            completions = self.funclist[:]
        if len(re.findall(' ', line)) == 1:
            completions = [ m
                            for m in self.funclist
                            if m.startswith(text)
                            ]
        else:
            completions = useReadlineDefault
        return completions

    def help_exportFuncTable(self):
        print '==============================================='
        print '    syntax: exportFuncTable func_no filename'
        print '    export func table data to text file (Csound ftsave format).'
        print '    The file will be saved to /func_files'
        print '==============================================='

    def do_setTransFuncTable(self, arg):
        try:
            scoreString = 'i 105 0 1' 
            for value in arg.split(' '):
                scoreString += ' %f'%float(value)
            csMessages.csoundInputMessage(scoreString)
        except:
            print 'syntax error', arg
            self.onecmd('help setTransFuncTable')

    def complete_setTransFuncTable(self, text, line, begidx, endidx):
        completions = ['n']
        return completions

    def help_setTransFuncTable(self):
        print '==============================================='
        print '    syntax: setTransFuncTable num gen v1 v2 v3 v4 ....'
        print '    set modulator transfer function table'
        print '    the transfer function number corresponds to modulator name Func1, Func2, Func3 or Func4'
        print '    the gen number is one of the standard Csound gen numbers'
        print '    the values (v1 v2 ...) are the standard data arguments according to the selected gen routine'
        print '    The table length is currently 8193'
        print '    NOTE: this method will only work in presetMode = state'
        print '==============================================='

    def do_setModMatrix(self, arg):
        try:
            modulator, parameter, scale = arg.split(' ')
            assignment = modulator + '\tto\t' + parameter
            csMessages.csoundInputMessage('i 102 0 1 "%s" %s'%(assignment, scale))
        except:
            print 'syntax error', arg
            self.onecmd('help setModMatrix')

    def complete_setModMatrix(self, text, line, begidx, endidx):
        if not text:
            completions = self.modlist[:]
        if len(re.findall(' ', line)) == 1:
            completions = [ m
                            for m in self.modlist
                            if m.startswith(text)
                            ]
        else:
            completions = [ p
                            for p in self.parmlist
                            if p.startswith(text)
                            ]
        return completions
        
    def help_setModMatrix(self):
        print '==============================================='
        print '    syntax: setModMatrix modulator parameter amount'
        print '    set the amount (scaling) of influence from modulator to parameter'
        print '==============================================='

    def do_getModMatrix(self, arg):
        try:
            modulator, parameter = arg.split(' ')
            assignment = modulator + '\tto\t' + parameter
            csMessages.csoundInputMessage('i 120 0 1 "%s"'%(assignment))
        except:
            print 'syntax error', arg
            self.onecmd('help getModMatrix')

    def complete_getModMatrix(self, text, line, begidx, endidx):
        if not text:
            completions = self.modlist[:]
        if len(re.findall(' ', line)) == 1:
            completions = [ m
                            for m in self.modlist
                            if m.startswith(text)
                            ]
        else:
            completions = [ p
                            for p in self.parmlist
                            if p.startswith(text)
                            ]
        return completions

    def help_getModMatrix(self):
        print '==============================================='
        print '    syntax: getModMatrix modulator parameter'
        print '    print the value for a point in the modulation matrix'
        print '==============================================='

    def do_clearTables(self, arg):
        csMessages.csoundInputMessage('i 100 0 1')
        csMessages.csoundInputMessage('i 101 0 1')
        
    def help_clearTables(self):
        print '==============================================='
        print '    syntax: clearTables'
        print '    clear modulation matrix and mask tables'
        print '==============================================='
                
    def do_preset(self, arg):
        try: 
            rw = arg.split(' ')[0]
            filename = arg.split(' ')[1]
            if rw == 'read': readWrite = 1
            elif rw == 'write': readWrite = 0
            else: 
                print 'read or write?'
                return
            print 'i 73 0 1 "%s" %i'%(filename, readWrite)
            csMessages.csoundInputMessage('i 73 0 1 "%s" %i'%(filename, readWrite))
        except:
            print 'syntax error', arg
            self.onecmd('help preset')

    def complete_preset(self, text, line, begidx, endidx):
        if not text:
            completions = self.rw[:]
        if len(re.findall(' ', line)) == 1:
            completions = [ rw
                            for rw in self.rw
                            if rw.startswith(text)
                            ]
        elif len(re.findall(' ', line)) == 2:
            theFullList = os.listdir(os.getcwd()+'/presets')
            theList = []
            for item in theFullList:
                if ".mpst" in item:
                    theList.append(item)
            completions = [ f
                            for f in theList
                            if f.startswith(text)
                            ]
        return completions

    def help_preset(self):
        print '==============================================='
        print '    syntax: preset read/write, filename'
        print '    read or write a master preset file'
        print '==============================================='

    def do_presetMode(self, arg):
        try:
            if not arg in ['preset','state']:
                raise Exception(arg)
            if arg == 'preset':
                csMessages.csoundInputMessage('i 74 0 -1')
            elif arg == 'state':
                csMessages.csoundInputMessage('i -74 0 1')
        except:
            print 'syntax error', arg
            self.onecmd('help presetMode')

    def complete_presetMode(self, text, line, begidx, endidx):
        if not text:
            completions = ['preset','state']
        if len(re.findall(' ', line)) == 1:
            completions = [ ps
                            for ps in ['preset','state']
                            if ps.startswith(text)
                            ]
        return completions

    def help_presetMode(self):
        print '==============================================='
        print '    syntax: presetMode, preset/state'
        print '    if mode == state, enable the single state mode, used for programming parameter states'
        print '    if mode == preset, enable the master preset mode with interpolation between 4 single states'
        print '==============================================='

    def do_setSourceWave(self, arg):
        try:
            instance, waveslot, soundname = arg.split(' ')
            csMessages.csoundInputMessage('i 20 0 1 %s %s "%s"'%(instance, waveslot, soundname))
        except:
            print 'syntax error', arg
            self.onecmd('help setSourceWave')
        
    def complete_setSourceWave(self, text, line, begidx, endidx):
        if not text and len(re.findall(' ', line)) == 1:
            completions = ['1 1']
        elif not text and len(re.findall(' ', line)) == 2:
            completions = ['1']
        else:
            theFullList = os.listdir(os.getcwd()+'/samples')
            theList = ['Sine', 'Triangle', 'Square', 'Saw', 'Pulse']
            for item in theFullList:
                if '.wav' in item or '.WAV' in item:
                    theList.append(item)
            theList.extend(['audioInput','segment_0'])
            completions = [ f
                            for f in theList
                            if f.startswith(text)
                            ]
        return completions

    def help_setSourceWave(self):
        print '==============================================='
        print '    syntax: setSourceWave instance waveslot "soundname"'
        print '    sets one of the four source waveform for partikkel, the waveslot argument has range 1 to 4'
        print '    instance can only be 1 in this version'
        print '==============================================='
        
    def do_liveSampling(self, arg):
        try:
            arg = int(arg)
            if not arg in [0,1]:
                raise Exception(arg)
            if arg == 1:
                csMessages.csoundInputMessage('i 51 0 -1')
            if arg == 0:
                csMessages.csoundInputMessage('i -51 0 1')
        except:
            print 'syntax error', arg
            self.onecmd('help liveSampling')

    def help_liveSampling(self):
        print '==============================================='
        print '    syntax: liveSampling state'
        print '    turn on or off the live sampling function, state can be 1 or 0'
        print '==============================================='

    def do_i(self, arg):
        csMessages.csoundInputMessage('i %s'%arg)

    def help_i(self):
        print '==============================================='
        print '    syntax: i p1 p2 p3 ....'
        print '    input standard Csound score line'
        print '==============================================='
        
    def do_enable_ampDisp_FLTK(self, arg):
        if arg > 0:
            csMessages.csoundInputMessage('i 399 0 -1')
        else:
            csMessages.csoundInputMessage('i -399 0 1')

    def help_enable_ampDisp_FLTK(self):
        print '==============================================='
        print '    syntax: enable_ampDisp state'
        print '    When using the (separate) FLTK GUI to control state interpolation and expression faders,'
        print '    the general signal level of Hadron can also be displayed on a meter in the FLTK window.'
        print '    State can be 0 or 1.'
        print '==============================================='

    def do_convertPresetVersion(self, arg):
        textfiles, binaryfiles = getPresetFilenames()
        # do not convert the default state, we assume this one to be converted manually
        textfiles.remove('default.txt')
        #binaryfiles.remove('default.spst')
        # check if any states exist only in one of the formats        
        dofiles = []
        strayTextfiles = []
        strayBinaryfiles = []
        for item in textfiles:
            if item.split('.')[0]+'.spst' in binaryfiles:
                dofiles.append(item.split('.')[0])
            else:
                strayTextfiles.append(item)
        for item in binaryfiles:
            if not item.split('.')[0]+'.txt' in textfiles:
                strayBinaryfiles.append(item)
        # get current preset version number (number to update all states to)
        f = open('states_txt/default.txt', 'r')
        presetVersion = f.readline().split('\t')[1].rstrip('\n')
        print 'update all states to version %s ?' %presetVersion
        print 'WARNING: back up files to be converted before proceeding!'
        action = raw_input()
        if not action in ['yes', 'y']:
            print '...skipping update'
            return
        # then import and convert
        #0. clear mask tables, mod matrix, and mod func tables
        #1. load default text state with new parameter configuration
        #2. load old (to be imported) text state, overwriting relevant parameter values
        #3. save text state, using same name (when saving a text state, the preset version parameter is also updated in the file)
	    #4. load old binary state file
        #5. load text state as saved in stage 3 (modified with new parameter configuration, using default values for new parameters)
	    #6. save binary state to file
        for dofile in dofiles:
            #clear tables
            csMessages.csoundInputMessage('i 100 0 1') # clear modmatrix
            csMessages.csoundInputMessage('i 101 0 1') # clear mask tables
            csMessages.csoundInputMessage('i 105 0 1 1 7 0 8193 1') # clear mod transfer func
            csMessages.csoundInputMessage('i 105 0 1 2 7 0 8193 1')
            csMessages.csoundInputMessage('i 105 0 1 3 7 0 8193 1')
            csMessages.csoundInputMessage('i 105 0 1 4 7 0 8193 1')
            txt = dofile + '.txt'
            bin = dofile + '.spst'
            print '*'
            time.sleep(0.5)
            self.onecmd('singleState_TXT read default.txt') #1. load default text state with new parameter configuration
            time.sleep(0.5)
            print 'reading text state... states_txt/%s'%txt
            self.onecmd('singleState_TXT read %s'%txt) #2. load old (to be converted) text state
            print 'converting ...'
            time.sleep(0.5)
            print 'writing text state... states_txt/%s'%txt
            self.onecmd('singleState_TXT write %s'%txt) #3. save text state, using same name
            time.sleep(0.5)
            print '*'
            print 'reading binary state... states/%s'%bin
            self.onecmd('singleState read %s -1'%bin) #4. load old binary state file
            time.sleep(0.5)
            csMessages.csoundInputMessage('i 100 0 1') # clear modmatrix
            print 'converting ...'
            time.sleep(0.5)
            self.onecmd('singleState_TXT read %s'%txt) #5. load text state as saved in stage 3
            time.sleep(0.5)
            print 'writing binary state... states/%s'%bin
            self.onecmd('singleState write %s'%bin) #6. save binary state to file
        if len(strayTextfiles) > 0: 
            print 'stray text files', strayTextfiles
            print '*** do you want to write stray text files to binary ?'
            action = raw_input()
            if action in ['yes', 'y']:
                for txt in strayTextfiles:
                    self.onecmd('singleState read default.spst -1') # load default binary state file
                    time.sleep(0.5)
                    self.onecmd('singleState_TXT read %s'%txt) # load stray text state file
                    time.sleep(0.5)
                    bin = txt.split('.txt')[0]+'.spst'
                    print 'writing...', 'singleState write states/%s'%bin
                    self.onecmd('singleState write %s'%bin) #save text state, using same prefix name
        if len(strayBinaryfiles) > 0: 
            print 'stray binary files', strayBinaryfiles
            print '*** do you want to write stray binary files to text ?'
            action = raw_input()
            if action in ['yes', 'y']:
                for bin in strayBinaryfiles:
                    self.onecmd('singleState read %s -1'%bin) # load stray binary state file
                    time.sleep(0.5)
                    txt = bin.split('.spst')[0]+'.txt'
                    print 'writing...', 'singleState_TXT write states_txt/%s'%txt
                    self.onecmd('singleState_TXT write %s'%txt) #save text state, using same prefix name
        print 'conversion complete'
                    
    def help_convertPresetVersion(self):
        print '==============================================='
        print '    syntax: convertPresetVersion'
        print '    Update state files to current preset version number.'
        print '    When the parameter configuration is updated, old states can not be loaded correctly unless converted to the new format.'
        print '    This operation may take some time to complete.'
        print '    If a state file only exist in only one of the formats (.txt and .spst), it will not be converted,'
        print '    any stray binary or text state files (not converted) are reported when the process is done,'
        print '==============================================='

    def do_exportBinaryStateToText(self, arg):
        textfiles, binaryfiles = getPresetFilenames()
        icount = 0
        for bin in binaryfiles:
            if len(bin.split('.spst')) == 2: # if it's a .spst file
                print 'Processing ', bin
                self.onecmd('singleState read %s -1'%bin) # load binary state file
                time.sleep(0.5)
                txt = bin.split('.spst')[0]+'.txt'
                print 'writing...', 'singleState_TXT write states_txt/%s'%txt
                self.onecmd('singleState_TXT write %s'%txt) #save text state, using same prefix name
                icount += 1
        print 'Processed %i files'%icount

    def help_exportBinaryStateToText(self):
        print '==============================================='
        print '    syntax: exportBinaryStateToText'
        print '    Write all binary state files to text.'
        print '==============================================='

    def do_updateBinaryStateFromText(self, arg):
        textfiles, binaryfiles = getPresetFilenames()
        icount = 0
        for bin in binaryfiles:
            if len(bin.split('.spst')) == 2: # if it's a .spst file
                print 'Processing ', bin
                self.onecmd('singleState read %s -1'%bin) # load binary state file
                time.sleep(0.5)
                txt = bin.split('.spst')[0]+'.txt'
                print 'reading parameters from text...'
                self.onecmd('singleState_TXT read %s'%txt) #read text state, using same prefix name
                time.sleep(0.5)
                print 'Saving updated ', bin
                self.onecmd('singleState write %s'%bin) # save binary state file
                icount += 1
        print 'Processed %i files'%icount

    def help_updateBinaryStateFromText(self):
        print '==============================================='
        print '    syntax: updateBinaryStateFromText'
        print '    Update all parameters in binary state with values read from text state.'
        print '==============================================='

    def do_quit(self, arg):
        readline.write_history_file('historyfile')
        print 'quitting...'
        return True

    def help_quit(self):
        print '==============================================='
        print '    syntax: quit',
        print '    -- terminates the application'
        print '==============================================='
    
    #shortcuts
    do_q = do_quit
    do_stop = do_quit

### utilities
def getPresetFilenames(statesDir):
    """
    Get a list of the state files.
    
    Actually two lists are generated, one with the state text files (states_txt dir),
    and one with the binary state files (state directory).
    When processing is done, the lists are compared, and any stray files are reported
    
    @param self: The object pointer.
    @return: A list of files in the directory
    """
    textfiles = os.listdir('states_txt/'+statesDir)
    # check that they are valid text file names
    for f in textfiles:
        if len(re.findall('.txt|.TXT', f)) == 0:
            textfiles.remove(f) 
    binaryfiles = os.listdir('states/'+statesDir)
    # check that they are valid state file names
    for f in binaryfiles:
        if len(re.findall('.spst|.SPST', f)) == 0:
            binaryfiles.remove(f) 
    return textfiles, binaryfiles
