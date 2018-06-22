#!/usr/bin/python
# -*- coding: latin-1 -*-

""" 
Read Csound include files, make a map (names&numbers) of modulators and parameters

@author: Øyvind Brandtsegg
@contact: obrandts@gmail.com
@license: GPL
@requires: csnd
"""


modulatorFile = file('inc/modulatorNumbering.inc', 'r')
parameterFile = file('inc/parameterNumbering.inc', 'r')
modulators = []
parameters = []

for line in modulatorFile:
    #if it has 'chnset' in it we have a modulator name on the line
    if 'chnset' in line:
        name = line.split('"')[1][1:] #isolate the name and get rid of the "i" at the beginning of the name
        modulators.append(name)
for line in parameterFile:
    #if it has 'chnset' in it we have a parameter name on the line
    if 'chnset' in line:
        name = line.split('"')[1][1:] #isolate the name and get rid of the "i" at the beginning of the name
        parameters.append(name)

print '***'
print 'list of modulators'
i=0        
for m in modulators:
    print i, m
    i += 1
print '***'

#f = file('tempEdit.inc', 'w')
print 'list of parameters'
i=0
#p = 'available'
#f.write('\t' + 'chnset' + '\t' + str(i) + ', \"%s\"\n'%p)
#i = 1
for p in parameters: 
    print i, p
    #f.write('\t' + 'chnset' + '\t' + str(i) + ', \"i%s\"\n'%p)
    i += 1
print '***'
