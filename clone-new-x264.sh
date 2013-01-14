#!/bin/bash

#
mkdir -p download
cd download
if [ ! -d x264 ]; then
    git clone git://git.videolan.org/x264.git
fi

cd x264

#git  pull origin +master:master
if [ "$1" != "" ]; then
    git checkout $1
else # use curent default
    git checkout 9c4ba4b
fi

TARFILE=`./version.sh | grep X264_VERSION |awk '{print "x264-"$4"-"$5".tar.gz"}' | sed 's/\"//g'`

cd ..
tar czf $TARFILE x264

