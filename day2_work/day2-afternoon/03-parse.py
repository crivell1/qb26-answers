#!/usr/bin/env python3 


import sys

fs = open(sys.argv[1])

count = 0
for line in fs:
    if count >= int(sys.argv[2]):
        break
    print ( line.rstrip("\n"))
    count += 1

fs.close()
