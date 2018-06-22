The difference between osx-hadron-prepare-bundle.sh and osx-hadron-prepare-bundle-automatic.sh is that the former stops for key input after each step.

To compile an installation Hadron folder go through the following steps:
- Open the desired sh file and enter the correct paths for repo, installation path and temporary bundle directory (top of the sh file)
- Run the desired script with the sh command (e.g. "sh osx-hadron-prepare-bundle.sh")

To build an installer package:
/*- Open the newest PackageMaker Document"
- Select "Hadron" under "Hadron core DSP
- Select "Configuration"

- Change the Installpath to the same as in the osx-hadron-prepare-bundle script adding "Hadron"
	e.g. path in script: /Users/berntisak/Music/Projects/Hadron/InstallerBuild
	e.g. path in installer: /Users/berntisak/Music/Projects/Hadron/InstallerBuild/Hadron 
*/
** UPDATE 06.03.12 **
Now there's two different PackageMaker Documents - one for 10.5 and one for 10.6. Remember to update both!