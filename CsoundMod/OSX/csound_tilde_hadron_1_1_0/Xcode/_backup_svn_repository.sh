#!/bin/sh

date=`eval date +%Y_%m_%d`
svn_repo=/d/Repositories/csound_tilde
svn_backup=/h/BACKUPS/csound_tilde_repository.$date

svnadmin hotcopy $svn_repo $svn_backup
7z a $svn_backup.zip -tzip $svn_backup
rm -r $svn_backup