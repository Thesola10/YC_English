#!/usr/bin/env python3
# Inucode (c) Karim Vergnes <me@thesola.io>
# it's just a XOR cipher with exact-match policy.
# thx Joseph John

import os
import sys

def parallel(fun, ls):
    try:
        from p_tqdm import p_umap
        return p_umap(fun, ls)
    except:
        import multiprocessing
        return multiprocessing.Pool().map(fun, ls)

def repeated_key_xor(infile, outfile, key):
    inf = open(infile, "rb+")
    pt = inf.read()
    len_key = len(key)
    encoded = []

    for i in range(0, len(pt)):
        if pt[i] == key[i % len_key]:
            encoded.append(pt[i])
            continue
        else:
            encoded.append(pt[i] ^ key[i % len_key])
    with open(outfile, "wb+") as out:
        out.write(bytes(encoded))
    inf.close()

mydir = os.path.dirname(__file__)
patchdir = os.path.join(mydir, "patches", "Data", "StreamingAssets", "scrpt.cpk")
outdir = os.path.join(mydir, "work", "Data", "StreamingAssets", "scrpt.cpk.contents")
patches = os.listdir(patchdir)

def patch_one_file(f):
    repeated_key_xor( os.path.join(patchdir, f)
                    , os.path.join(outdir,os.path.splitext(f)[0])
                    , b'hogehoge66')

if __name__ == '__main__':
    parallel(patch_one_file, patches)
