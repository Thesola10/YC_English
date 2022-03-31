#!/usr/bin/env python3
# Inucode (c) Karim Vergnes <me@thesola.io>
# it's just a XOR cipher with exact-match policy.
# thx Joseph John

import os
import sys

try:
    from p_tqdm import p_umap
except:
    def p_umap(f, l): map(f, l)

def parallel(fun, ls):
    try:
        from p_tqdm import p_umap
        return p_umap(fun, ls)
    except:
        import multiprocessing
        multiprocessing.Pool().map(fun, ls)

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

if __name__ == "__main__":
    mydir = os.path.dirname(__file__)
    patchdir = os.path.join(mydir, "patches", "Data", "StreamingAssets", "scrpt.cpk")
    outdir = os.path.join(mydir, "work", "Data", "StreamingAssets", "scrpt.cpk.contents")
    patches = os.listdir(patchdir)

    parallel( lambda f: repeated_key_xor( os.path.join(patchdir, f)
                                        , os.path.join(outdir,os.path.splitext(f)[0])
                                        , b'hogehoge66')
            , patches)
