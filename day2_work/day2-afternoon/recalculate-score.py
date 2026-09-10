#!/usr/bin/env python3


import sys

fs = open(sys.argv[1])

for line in fs:
    line = line.rstrip("\n").split("\t")
    #print(line)
    start = int(line[1])
    stop = int(line[2])
    exp_score = int(line[4])

    new_score = exp_score * ( stop - start )

    if line[5] == "-":
        new_score = new_score*(-1)
    elif line[5] == "+":
        new_score = abs(new_score)

    line[4] = str(new_score)
    #print(line)
    restored_line = "\t".join(line) #+ "\n"
    print(restored_line)

    
fs.close()


    

