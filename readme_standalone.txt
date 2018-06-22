Hadron Particle Synthesizer, Standalone Csound version
Oeyvind Brandtsegg 2011 - obrandts@gmail.com
Author's web site: http://www.partikkelaudio.com http://oeyvind.teks.no/

License:
The Hadron Particle Synthesizer, Standalone Csound version is released under a LGPL license.
The full text of the LGPL license can be found in the file lgpl-3.0.txt

System requirements:
Csound 5.18 or higher

To start the system, run:
csound Hadron_Csound_Standalone.csd

You will most probably need to adjust the audio and midi in/out settings to reflect your system configuration. 
These settings can be found on line 3 of the file "Hadron_Csound_Standalone.csd"

To use Hadron as a midi controlled synthesizer:
Send a few midi notes to hadron and you should hear sound. 
The default setup loaded will set up Hadron as a midi synth, and it will only make sound on midi input.
(see below how to use it without any midi input, e.g. as an audio effect)

Source audio and parameter state settings can be made in the file "hadron_cs_standalone_sco.inc".

You will most probably need to adjust the audio and midi in/out settings to reflect your system configuration. These settings can be found on line 3 of the file "Hadron_Csound_Standalone.csd" Documentation of the command line flags can be found in the Csound manual (http://www.csounds.com/manual/), the most important ones being:
-odac (selection of audio output card, e.g. -odac5 to use the fifth card on your system)
-M (selection of midi input device, as above, e.g. -M3 uses the third midi input device on your system)
If you are unsure of the device numbering on your system, the devices Csound could detect are listed in the console when you run it.
* If you are not on Windows, ou will also want to change the -+rtmidi=mme setting to something appropriate for your system (I guess you could omit it to use the default for your system, or try "-+rtmidi=alsa" (no quotes) or jack or whatever you use)
* Here's an example for a basic OSX command line:
-odac -M -b2048 -B4096 -f


How to select states and source waveforms:
Source audio and parameter state settings can be made in the file "hadron_cs_standalone_sco.inc".
If you want to run Hadron as an audio effect, you can use these statements in “hadron_cs_standalone_sco.inc”:
i20 3 1 1 1 "audioInput"
i20 3 1 1 2 "audioInput"
i20 3 1 1 3 "audioInput"
i20 3 1 1 4 "audioInput"

;****************
; load states, use number 0,1,2,3 for the four state slots
i 72 1.5 1 "fxGrainFlanger.spst" 0
i 72 1.5 1 "fxLowpassRand.spst" 1
i 72 1.5 1 "fxTwinPeaks.spst" 2
i 72 1.5 1 "fxGrainFlanger2.spst" 3

The fx states does not require midi note input and will make sound at all times when Hadron is running (and audio is present at the audio input)
To see all available states, look for files in the /states directory. All .spst files are Hadron states.
See also the html documentation in /docs/index.html for more info about the different states.