vcvars32.bat

pexports csound64.dll.5.2 > csound64.def

lib /machine:i386 /def:csound64.def 

pexports pthreadGC2.dll > pthreadGC2.def

lib /machine:i386 /def:pthreadGC2.def

pexports libsndfile-1.dll > libsndfile-1.def

lib /machine:i386 /def:libsndfile-1.def
