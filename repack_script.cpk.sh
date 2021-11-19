#!/bin/bash

DIR=$(realpath $(dirname $0))

mkdir -p $DIR/work/Data/StreamingAssets

wine $DIR/3rdparty/cpkmakec.exe \
        Z:$DIR/patches/scrpt.cpk                    \
        Z:$DIR/work/Data/StreamingAssets/scrpt.cpk  \
        -mode=FILENAME                              \
        -code=UTF-8                                 \
        -align=2048
