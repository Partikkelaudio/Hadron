To create a hadron64-version of csound64.dll:

* Build a compact csound64.dll using 64-bit mingw (no audio, no opcodes, static libraries, etc.). 
* Copy csound64.dll to \bin64. Copy include files to ìnclude.
* Rename csound64.dll to csound64_hadron64.dll
* Run: gendef csound64_hadron64.dll
* Edit "csound64_hadron64.def" in a text editor: Replace csound64.dll with csound64_hadron64.dll
* Run: "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin\lib.exe" /machine:x64 /def:csound64_hadron64.def

Only the *.dll and *.lib file is needed. The rest can be deleted.