#!/bin/bash

DIR=$(realpath $(dirname $0))

mkdir -p $DIR/work/Data/StreamingAssets/scrpt.cpk.contents \
         $DIR/out/contents/0100D12014FC200/romfs/Data/StreamingAssets

if which -p parallel >/dev/null 2>&1
then
    for file in $DIR/patches/Data/StreamingAssets/scrpt.cpk/*.json
    do echo $file
    done | parallel --progress --bar python3 $DIR/inucode.py {} $DIR/work/Data/StreamingAssets/scrpt.cpk.contents/{/.}
else
    for file in $DIR/patches/Data/StreamingAssets/scrpt.cpk/*.json
    do
      {
        echo "Encoding $(basename $file)"
        python3 $DIR/inucode.py $file $DIR/work/Data/StreamingAssets/scrpt.cpk.contents/$(basename $file | head -c-6)
      } &
    done
    wait $(jobs -p) # Wait for all encoders to finish before bundling.
fi

wine $DIR/3rdparty/cpkmakec.exe \
        Z:$DIR/work/Data/StreamingAssets/scrpt.cpk.contents \
        Z:$DIR/out/contents/0100D12014FC200/romfs/Data/StreamingAssets/scrpt.cpk  \
        -mode=FILENAME                              \
        -code=UTF-8                                 \
        -align=2048

rm -rf $DIR/work/Data/StreamingAssets/scrpt.cpk.contents
