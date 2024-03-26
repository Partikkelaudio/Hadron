To create a hadron32-version of csound64.dll:

* Build a compact csound64.dll using 32-bit mingw (no audio, no opcodes, static libraries, etc.). Copy here.
* Copy csound64.dll to \bin32. Copy include files to ìnclude.
* Rename csound64.dll to csound64_hadron32.dll
* Run: pexports csound64_hadron32.dll > csound64_hadron32.def
* Edit "csound64_hadron32.def" in a text editor: Replace csound64.dll with csound64_hadron32.dll
* Run: "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin\lib.exe" /machine:i386 /def:csound64_hadron32.def

Only the *.dll and *.lib file is needed. The rest can be deleted.