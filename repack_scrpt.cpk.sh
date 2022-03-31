#!/bin/bash

DIR=$(realpath $(dirname $0))

mkdir -p $DIR/work/Data/StreamingAssets/scrpt.cpk.contents \
         $DIR/out/contents/0100D12014FC2000/romfs/Data/StreamingAssets

python3 $DIR/inucode.py

wine $DIR/3rdparty/cpkmakec.exe \
        Z:$DIR/work/Data/StreamingAssets/scrpt.cpk.contents \
        Z:$DIR/out/contents/0100D12014FC2000/romfs/Data/StreamingAssets/scrpt.cpk  \
        -mode=FILENAME                              \
        -code=UTF-8                                 \
        -align=2048

rm -rf $DIR/work/Data/StreamingAssets/scrpt.cpk.contents
