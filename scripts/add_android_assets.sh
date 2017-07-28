#!/bin/bash
SRC=~/Google Drive/Design/assets/android
DST=~/Google\ Drive/Dev/pw-android/app/src/main/res

cp -R $SRC/* $DST
cd $DST
git add .
echo "Files copied"
