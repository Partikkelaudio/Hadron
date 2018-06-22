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

repo="/Users/berntisak/Code/Hadron/hadron"              # Path to Hadron repo
output="/Applications"											# Hadron installation path
build="/Users/berntisak/Code/Hadron/InstallerBuild/Universal"	# Build output path
framework="/Users/berntisak/Code/Hadron/hadron/CsoundMod/OSX_framework"

rm -Rfv $build
mkdir $build

echo "$n Cleaning Hadron folder...$n"
readOne

cd $build
mkdir Hadron
cd Hadron

pwd
readOne
rm -Rfv *

mkdir docs
mkdir Contents
cd Contents
mkdir Frameworks
cd ..
cd ..

echo "$n$n Copying documentation... $n"
readOne

for f in $repo/docs/*.htm
do 
cp -Rfv "$f" $build/Hadron/docs/ 
done

for f in $repo/docs/*.html
do 
cp -Rfv "$f" $build/Hadron/docs/ 
done

cp -Rfv $repo/docs/hadron.css $build/Hadron/docs/ 
cp -Rfv $repo/docs/images $build/Hadron/docs/

echo "$n$n Copying csound files, states, samples and other utility files... $n"

readOne
cp -Rfv $repo/inc/ $build/Hadron/inc
cp -Rfv $repo/states/free $build/Hadron/states
cp -Rfv $repo/samples-release/ $build/Hadron/samples
cp -Rfv $repo/presets/ $build/Hadron/presets
cp -Rfv $repo/Hadron.orc $build/Hadron/
cp -Rfv $repo/Hadron.sco $build/Hadron/
cp -Rfv $repo/licence_HadronParticleSynthesizer.txt $build/Hadron/
cp -Rfv $repo/lgpl-3.0.txt $build/Hadron/
cp -Rfv $repo/readme_standalone.txt $build/Hadron
cp -Rfv $repo/Hadron_Csound_Standalone.csd $build/Hadron
cp -Rfv $repo/hadron_cs_standalone_sco.inc $build/Hadron
cp -Rfv $repo/VST-AU/Builds/MacOSX/hadron_vst.config $build/Hadron


echo "$n Copying csound framework... $n"

readOne

cp -Rfv $framework/CsoundLib64.framework $build/Hadron/Contents/Frameworks/

readOne

echo "$n$n Copying utility dynamic libraries $n"

#cp -v $repo/CsoundMod/OSX_dylibs/libsndfile.dylib $build/Hadron/Contents/libsndfile.dylib
#cp -v $repo/CsoundMod/OSX_dylibs/libportaudio.dylib $build/Hadron/Contents/libportaudio.dylib
#cp -v $repo/CsoundMod/OSX_dylibs/libmpadec.dylib $build/Hadron/Contents/libmpadec.dylib
#cp -v $repo/CsoundMod/OSX_dylibs/liblo.dylib $build/Hadron/Contents/liblo.dylib
#cp -v $repo/CsoundMod/OSX_dylibs/libfltk.dylib $build/Hadron/Contents/libfltk.dylib

cp -v $repo/CsoundMod/OSX_dylibs/libsndfile.dylib $build/Hadron/Contents/libsndfile.dylib
#cp -v $repo/CsoundMod/OSX_dylibs/libportaudio.2.0.0.dylib $build/Hadron/Contents/libportaudio.dylib
#cp -v $repo/CsoundMod/OSX_dylibs/libmpadec.dylib $build/Hadron/Contents/libmpadec.dylib
#cp -v $repo/CsoundMod/OSX_dylibs/liblo.0.6.0.dylib $build/Hadron/Contents/liblo.dylib
#cp -v $repo/CsoundMod/OSX_dylibs/libfltk.1.1.dylib $build/Hadron/Contents/libfltk.dylib

readOne

#install_name_tool -id $output/Hadron/Contents/libsndfile.dylib $build/Hadron/Contents/libsndfile.dylib
#install_name_tool -id $output/Hadron/Contents/libportaudio.dylib $build/Hadron/Contents/libportaudio.dylib
#install_name_tool -id $output/Hadron/Contents/libmpadec.dylib $build/Hadron/Contents/libmpadec.dylib
#install_name_tool -id $output/Hadron/Contents/libfltk.dylib $build/Hadron/Contents/libfltk.dylib

#install_name_tool -id $output/Hadron/Contents/Frameworks/CsoundLib64.framework/Versions/5.2/CsoundLib64 $build/Hadron/Contents/Frameworks/CsoundLib64.framework/Versions/5.2/CsoundLib64
#install_name_tool -change /Library/Frameworks/CsoundLib64.framework/Versions/5.2/CsoundLib64 $output/Hadron/Contents/Frameworks/CsoundLib64.framework/Versions/5.2/CsoundLib64 $build/Hadron/Contents/Frameworks/CsoundLib64.framework/Versions/5.2/lib_csnd.dylib

#install_name_tool -id $output/Hadron/Contents/Frameworks/CsoundLib64.framework/Versions/5.2/lib_csnd.dylib $build/Hadron/Contents/Frameworks/CsoundLib64.framework/Versions/5.2/lib_csnd.dylib

#install_name_tool -change /usr/local/lib/libsndfile.1.dylib $output/Hadron/Contents/libsndfile.dylib $build/Hadron/Contents/Frameworks/CsoundLib64.framework/Versions/5.2/lib_csnd.dylib
#install_name_tool -change /usr/local/lib/libsndfile.1.dylib $output/Hadron/Contents/libsndfile.dylib $build/Hadron/Contents/Frameworks/CsoundLib64.framework/Versions/5.2/CsoundLib64


otool -L $build/Hadron/Contents/libsndfile.dylib
otool -L $build/Hadron/Contents/Frameworks/CsoundLib64.framework/Versions/6.0/lib_csnd.dylib
otool -L $build/Hadron/Contents/Frameworks/CsoundLib64.framework/Versions/6.0/CsoundLib64
#otool -L $build/Hadron/Contents/libportaudio.dylib
#otool -L $build/Hadron/Contents/libmpadec.dylib
#otool -L $build/Hadron/Contents/libfltk.dylib



echo "$n$n Hadron package assembled in $build $n$n----------------------------------"
cd $build/Hadron
ls
echo "$n$n"