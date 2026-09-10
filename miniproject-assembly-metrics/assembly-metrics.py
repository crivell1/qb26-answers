#!/usr/bin/env python3

import sys
import fasta

file = open(sys.argv[1])

genomes = fasta.FASTAReader(file)


contig_num = 0 
total_leng = 0

for ident, seq in genomes:
    #print(ident)
    if len(ident) >= 1:
        contig_num += 1
    #print(contig_num)
    if len(seq) >= 0:
        total_leng += len(seq)
    #print(len(seq))
    #print(total_leng)

avg_len = total_leng/contig_num

print(f'Contig number: {contig_num},\nTotal Length: {total_leng},\nAvg read length: {avg_len}')

#print(genomes)


file.close()

