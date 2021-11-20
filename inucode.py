#!/usr/bin/env python3
# Inucode (c) Karim Vergnes <me@thesola.io>
# it's just a XOR cipher with exact-match policy.
# thx Joseph John

import sys

def repeated_key_xor(key):
    pt = open(sys.argv[1], "rb+").read()
    len_key = len(key)
    encoded = []

    for i in range(0, len(pt)):
        if pt[i] == key[i % len_key]:
            encoded.append(pt[i])
            continue
        else:
            encoded.append(pt[i] ^ key[i % len_key])
    return bytes(encoded)

if __name__ == "__main__":
    sys.stdout.buffer.write(repeated_key_xor(b'hogehoge66'))
