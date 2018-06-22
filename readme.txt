Hadron state and preset developer system
Oeyvind Brandtsegg 2010 - obrandts@gmail.com
Author's web site: http://oeyvind.teks.no/

License:
The Hadron state and preset developer system is licenced for educational and noncommercial purposes only. 
To obtain a license for any other use, you must contact the author.

Exceptions:
The Hadron Particle Synthesizer, as can be found in the "/inc" directory from this file, is covered by a LGPL Licence.
The Max For Live devices HadronForLive.amxd and HadronMidiSender.amxd is also released under the LGPL license, these files are found under M4L in the source, and are copied to the Live Library upon insstallation of Hadron.
The LGPL license can be found in the file lgpl-3.0.txt

The Hadron parameters states and presets as can be found in the "/presets" and "presets-release" are covered by a proprietary license, you can obtain a license for personal use by buying the states via partikkelaudio.com


System requirements:
Python 2.6
Csound 5.12

To start the system, run:
python main.py 

set command line options here:
csoundCommandline.py

Send a few midi notes to hadron and you should hear sound

To exit, type:
quit

To edit a state you must be in "state" mode:
presetMode state

To set the working directory for states (read/write, both binary and text versions of state files):
setStatesDir [dir]
... where dir refers to a subdirectory of /states
... text states reside similarly under /states_txt

To load a state:
singleState read [state name] -1

To load a text state:
singleState_TXT read [state name]

To write states files, replace read with write above
e.g.
singleState read [state name]
(no -1 slot)

To record audio out:
i398 0 10
(10 seconds)

