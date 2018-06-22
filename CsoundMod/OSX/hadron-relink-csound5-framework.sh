#!/bin/sh

readOne () {
tput smso
echo "Press any key to return \c"
tput rmso
oldstty=`stty -g`
stty -icanon -echo min 1 time 0
dd bs=1 count=1 >/dev/null 2>&1
stty "$oldstty"
echo
}

n="\n"

path="/Users/berntisak/Music/Projects/Hadron/hadron/CsoundMod/OSX_framework" # Path to framework
output="/Applications"											# Hadron installation path

cd $path



echo "$n$n Performing re-linking $n"

## DOUBLE ##
install_name_tool -id $output/Hadron/Contents/Frameworks/CsoundLib64.framework/Versions/5.2/CsoundLib64 $path/CsoundLib64.framework/Versions/5.2/CsoundLib64
install_name_tool -change /Library/Frameworks/CsoundLib64.framework/Versions/5.2/CsoundLib64 $output/Hadron/Contents/Frameworks/CsoundLib64.framework/Versions/5.2/CsoundLib64 $path/CsoundLib64.framework/Versions/5.2/lib_csnd.dylib

ln -sf $path/CsoundLib64.framework/Versions/5.2/CsoundLib64 $output/Hadron/Contents/Frameworks/CsoundLib64.framework/CsoundLib64 

readOne

## FLOAT ##
#install_name_tool -id $output/Hadron/Contents/Frameworks/CsoundHadronLib.framework/Versions/5.2/lib_csnd.dylib Hadron/Contents/Frameworks/CsoundHadronLib.framework/Versions/5.2/lib_csnd.dylib
## DOUBLE ##
install_name_tool -id $output/Hadron/Contents/Frameworks/CsoundLib64.framework/Versions/5.2/lib_csnd.dylib $path/CsoundLib64.framework/Versions/5.2/lib_csnd.dylib


readOne

install_name_tool -change /usr/local/lib/libsndfile.1.dylib $output/Hadron/Contents/libsndfile.dylib $path/CsoundLib64.framework/Versions/5.2/lib_csnd.dylib
install_name_tool -change /usr/local/lib/libsndfile.1.dylib $output/Hadron/Contents/libsndfile.dylib $path/CsoundLib64.framework/Versions/5.2/CsoundLib64


## DOUBLE ##
install_name_tool -change /usr/local/lib/libportaudio.2.dylib $output/Hadron/Contents/libportaudio.dylib $path/CsoundLib64.framework/Versions/5.2/lib_csnd.dylib
install_name_tool -change /usr/local/lib/libportaudio.2.dylib $output/Hadron/Contents/libportaudio.dylib $path/CsoundLib64.framework/Versions/5.2/CsoundLib64

## DOUBLE ##
install_name_tool -change libmpadec.dylib $output/Hadron/Contents/libmpadec.dylib $path/CsoundLib64.framework/Versions/5.2/lib_csnd.dylib
install_name_tool -change libmpadec.dylib $output/Hadron/Contents/libmpadec.dylib $path/CsoundLib64.framework/Versions/5.2/CsoundLib64


## DOUBLE ##
install_name_tool -change /usr/local/lib/libfltk.1.1.dylib $output/Hadron/Contents/libfltk.dylib $path/CsoundLib64.framework/Versions/5.2/lib_csnd.dylib
install_name_tool -change /usr/local/lib/libfltk.1.1.dylib $output/Hadron/Contents/libfltk.dylib $path/CsoundLib64.framework/Versions/5.2/CsoundLib64


otool -L $path/CsoundLib64.framework/Versions/5.2/CsoundLib64
otool -L $path/CsoundLib64.framework/Versions/5.2/lib_csnd.dylib

#### ------------------------------------------------   DOUBLE  ------------------------------------------------    ####

#cd ../../../../../../../../ 

# Process plugin double-opcodes dylibs

cd $path/CsoundLib64.framework/Versions/5.2/Resources/Opcodes64

for f in *
do
  echo "---------------- Processing $f file..."
  # take action on each file. $f store current file name

install_name_tool -id $output/Hadron/Contents/Frameworks/CsoundLib64.framework/Versions/5.2/Resources/Opcodes64/$f $f
install_name_tool -change /usr/local/lib/libsndfile.1.dylib $output/Hadron/Contents/libsndfile.dylib $f
install_name_tool -change /usr/local/lib/libportaudio.2.dylib $output/Hadron/Contents/libportaudio.dylib $f
install_name_tool -change /usr/local/lib/libfltk.1.1.dylib $output/Hadron/Contents/libfltk.dylib $f
install_name_tool -change libmpadec.dylib $output/Hadron/Contents/libmpadec.dylib $f
otool -L $f
#  cat $f
done

install_name_tool -change /Library/Frameworks/CsoundLib64.framework/Versions/5.2/CsoundLib64 $output/Hadron/Contents/Frameworks/CsoundLib64.framework/Versions/5.2/CsoundLib64 libmodmatrix.dylib

otool -L libmodmatrix.dylib

otool -L $path/CsoundLib64.framework/Versions/5.2/CsoundLib64
otool -L $path/CsoundLib64.framework/Versions/5.2/lib_csnd.dylib