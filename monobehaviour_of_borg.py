#!/usr/bin/env python3
# MonoBehaviour of Borg (c) Karim Vergnes <me@thesola.io>
# Scans through a Unity assets dir and dumps all MonoBehaviour

import os
import re
import json
import UnityPy as U

def patch_one_file(objsByID, infile: str, patchroot: str, patches: list, outfile: str):
    patched = False
    for patch in patches:
        parse = re.match(r'^\[(-?[0-9]+)\].json$', patch)
        if not parse: continue

        idx = int(parse.groups()[0])
        patchpath = os.path.join(patchroot, patch)
        print(f"Patching object {idx}")
        with open(patchpath) as pfile:
            newtree = json.load(pfile)
            objsByID[idx].save_typetree(newtree)
        patched = True
    return patched
        

def patch_mbehaviours(patchdir: str, assetdir: str, outdir: str):
    for root, dirs, files in os.walk(assetdir):
        for f in files:
            if (f[-8:] != ".unity3d" and f[:-1] != "level"): continue
            patched = False

            ipath = os.path.join(root, f)
            ppath = os.path.join(root.replace(assetdir, patchdir), f)
            opath = os.path.join(root.replace(assetdir, outdir), f)

            print(f"##### Looking up patches for {ipath}")

            os.makedirs(root.replace(assetdir, outdir), exist_ok=True)
            env = U.load(ipath)
            objsByID = { obj.path_id : obj for obj in env.objects }
            for prt, pdr, pfis in os.walk(ppath):
                patched = patched or patch_one_file(objsByID, ipath, prt, pfis, opath)
                count = len(pfis)

            if (patched):
                print(f" => {opath}")
                with open(opath, "wb+") as ofile:
                    ofile.write(env.file.save())
                print(f"##### Replaced {count} MonoBehaviours")


def main():
    patch_mbehaviours("./patches", "./work", "./out/contents/0100D12014FC200/romfs")

if __name__ == "__main__":
    main()
