#!/usr/bin/env python3
# MonoBehaviour of Borg (c) Karim Vergnes <me@thesola.io>
# Scans through a Unity assets dir and dumps all MonoBehaviour

import os
import json
import UnityPy as U

def patch_mbehaviours(patchdir: str, assetdir: str):
    for root, dirs, files in os.walk(assetdir):
        for f in files:
            if (f[-8:] != ".unity3d"
                and f[:-1] != "level"): continue
            dpath = os.path.join(root, f)
            ppath = os.path.join(root.replace(assetdir, patchdir), f)
            print(f"##### Patching {dpath}:")
            env = U.load(dpath)
            count = 0
            for prt, pdr, pfis in os.walk(ppath):
                for pfi in pfis:
                    idx = int(pfi[:-5])
                    pfipath = os.path.join(prt, pfi)
                    with open(pfipath) as pfile:
                        newtree = json.load(pfile)
                        env.objects[idx].save_typetree(newtree)
                        count += 1
            print(f"##### Replaced {count} MonoBehaviours")


def main():
    patch_mbehaviours("./patches", "./work")

if __name__ == "__main__":
    main()
