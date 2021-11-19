#!/usr/bin/env python3
# MonoBehaviour of Borg (c) Karim Vergnes <me@thesola.io>
# Scans through a Unity assets dir and dumps all MonoBehaviour

import os
import UnityPy as U

def map_mbehaviours(do, where: str):
    for root, dirs, files in os.walk(where):
        for f in files:
            fpath = os.path.join(root, f)
            print(f"##### In {fpath}:")
            env = U.load(fpath)
            scanned = 0
            matched = 0
            for obj in env.objects:
                if obj.type.name == "MonoBehaviour" and obj.serialized_type.nodes:
                    try:
                        tree = do(obj.read_typetree())
                        #obj.save_typetree(tree)
                        matched += 1
                    except:
                        pass # oh no
                    scanned += 1
            print(f"##### Found {scanned} MonoBehaviours, matched {matched}.")

def ttree_print_mText(tree):
    print(f"m_Text: {tree['m_Text']}")

def ttree_print_omakeTitle(tree):
    for page in tree['pages']:
        for item in page['items']:
            print(f"omakeTitle: {item['title']}")

def main():
    map_mbehaviours(ttree_print_omakeTitle, "./romfs/Data")

if __name__ == "__main__":
    main()
