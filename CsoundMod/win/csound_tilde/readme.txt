To compile csound~ for hadron on windows

- use csound~_v1.0.7 source
- use Max SDK ver 5.1.1
* replace csound~.c with the one found here
* replace dllmain_win.c with the one found here
* use csound~.vcproj found here
* The precompiled csound~_hadron will look for our Csound version in $HADRONPATH/Csound_Hadron (/bin)


* If you update Csound, run the commands in csound~build_pexports.bat to create export libraries to be used when compiling csound~


Update for for csound~1.10
- use csound~_v1.10 source
- use Max SDK ver 5.1.1
* replace (4) source files with the ones found here (in /src)
* use csound~.vcproj found here
* The precompiled csound~_hadron will look for our Csound version in $HADRONPATH/Csound_Hadron (/bin)
* If you update Csound, run the commands in csound~build_pexports.bat to create export libraries to be used when compiling csound~
