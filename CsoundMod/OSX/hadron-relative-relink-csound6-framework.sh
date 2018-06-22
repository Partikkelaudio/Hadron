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

path="/Users/berntisak/Code/Hadron/hadron/CsoundMod/OSX_framework/Relative_linked" # Path to framework
output="/Applications"											# Hadron installation path

cd $path



echo "$n$n Performing re-linking $n"


install_name_tool -id @loader_path/../Resources/CsoundLib64.framework/Versions/6.0/CsoundLib64 $path/CsoundLib64.framework/Versions/6.0/CsoundLib64

install_name_tool -change /Library/Frameworks/CsoundLib64.framework/Versions/6.0/CsoundLib64 @loader_path/../Resources/CsoundLib64.framework/Versions/6.0/CsoundLib64 $path/CsoundLib64.framework/Versions/6.0/libcsnd6.6.0.dylib

#ln -sf $path/CsoundLib64.framework/Versions/6.0/CsoundLib64 @loader_path/../Resources/CsoundLib64.framework/CsoundLib64

readOne


install_name_tool -id @loader_path/../Resources/CsoundLib64.framework/Versions/6.0/libcsnd6.6.0.dylib $path/CsoundLib64.framework/Versions/6.0/libcsnd6.6.0.dylib


readOne



#### ----------------------------------------------- ####



otool -L $path/CsoundLib64.framework/Versions/6.0/CsoundLib64
otool -L $path/CsoundLib64.framework/Versions/6.0/libcsnd6.6.0.dylib