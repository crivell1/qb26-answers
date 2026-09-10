#!/usr/bin/env python3

import sys

fs = open(sys.argv[1])

fs.readline()
fs.readline()

header = None
for line in fs:
    if header == None:
        header = line.rstrip("\n").split("\t")
    else:
        data_line = line.rstrip("\n").split("\t")
        break

#print(header[:10], data_line[:10])

for position in range(2,len(data_line)):
    #print(position)
    if float(data_line[position]) > 1:
        print(f"{header[position]}, {data_line[position]}")
    else:
        continue

fs.close()




