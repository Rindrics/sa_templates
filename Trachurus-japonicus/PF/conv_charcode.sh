#!/usr/bin/sh

dir="./files_to_edit/"
filelist=`ls $dir`
for i in $filelist
do
    nkf -w --overwrite $dir$i
done
