Hadron state editor for Cabbage
Oeyvind Brandtsegg 2016 - obrandts@gmail.com

License:
The Hadron state and preset developer system is licenced for educational and noncommercial purposes only. 
To obtain a license for any other use, you must contact the author.

Exceptions:
The Hadron Particle Synthesizer, as can be found in the "/inc" directory from this file, is covered by a LGPL Licence.
The Max For Live devices HadronForLive.amxd and HadronMidiSender.amxd is also released under the LGPL license, these files are found under MFL in the source, and are copied to the Live Library upon installation of Hadron.
The LGPL license can be found in the file lgpl-3.0.txt

The Hadron parameters states and presets as can be found in the "/states" directory and its subdirectories are covered by a proprietary license, you can obtain a license for personal use by buying the states via partikkelaudio.com

Usage:
You need Cabbage version 1.0.0.3 or higher

1. Start Cabbage, load the HadronCabbageEditor.csd
2. Select source sounds and states
3. If you want to edit a state, you must have the XY pad cursor in the lower left corner. 
4. To enter edit more, use the "editor" button in the upper left of the GUI
5. States loaded into the lower left corner of the XY pad are now ready for editing.
6. All gui parameters can be tweakend via the corresponding slider
7. Modmatrix assignments can be done in the "Modmatrix edit" text field. Format is: Source Target Amount.
Watch the csound console output to see that the source and target names are accepted. Errors printed for nonrecognized names.
8. Mask files can be imported via the "Mask file import/export" GUI controls. Select the mask type (combo box), and mask A or B (combobox). Then type the mask filename (without .msk extension), and hit the "import" button to load the file. Files are loaded from the Hadron root directory. Mask export can be done in a similar manner.
9. Function tables (for modulator shape functions) can be edited via  the "Table edit" text field. Hit the "!" button to update the display.
10. Save you state! In the lower left corner you fine the controls for saving states. Type a file name in the text field, then hit enter. You will see the state name printed in the csound console. Your state is not saved yet! Hit the "save" button to save the state. The states are written to the ./states directory.
11. NOTE! The Hadron state editor does not ask before overwriting any files it writes. Nor does it ask you to save changes on exit. You're basically on your own. 