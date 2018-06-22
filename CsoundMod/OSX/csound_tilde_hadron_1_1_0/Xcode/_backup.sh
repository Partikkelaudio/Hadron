#!/bin/sh

project=csound_tilde
temp=$project.temp
date=`eval date +%Y_%m_%d`
tarfile=$project.$date.tar
bzip2file=$project.$date.tar.bz2

cd ..

mkdir $temp

mkdir $temp/src
cp $project/src/* $temp/src

mkdir $temp/src_backup
cp $project/src_backup/* $temp/src_backup

mkdir $temp/tests
cp $project/tests/* $temp/tests

mkdir $temp/csound~.xcodeproj
cp $project/csound~.xcodeproj/* $temp/csound~.xcodeproj

mkdir $temp/English.lproj
cp $project/English.lproj/* $temp/English.lproj

cp $project/* $temp
rm $temp/csound~.sdf

tar -cvf $tarfile $temp
bzip2 -c -v $tarfile > $bzip2file
rm $tarfile
rm -r $temp

cp $bzip2file /h/BACKUPS

