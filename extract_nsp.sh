#!/bin/bash
# Extract Yurucamp NSP (c) Karim Vergnes <me@thesola.io>
# This script automatically pulls the titlekey from the tik file found in the
# NSP bundle, and extracts it down to the required ROMFS

DIR=$(realpath $(dirname $0))

hactool -x $1 --pfs0dir=$DIR/work -t pfs0
hactool -x $DIR/work/97105c79474118d294c8808a22f39bd3.nca \
    --titlekey=$(xxd -ps -s0x180 -l16 $DIR/work/0100d12014fc2000000000000000000b.tik) \
    --romfsdir=work

rm work/*.{nca,tik,cert}
