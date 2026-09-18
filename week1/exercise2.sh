#!bin/bash/

### 1 - hg19
wc -l hg19-kc.bed 
# 80309

bedtools intersect -v -a hg19-kc.bed -b hg16-kc.bed | wc -l 
# 42737 genes in 19 and not in 16
#Can also do bedtools intersect -v -a hg19-kc.bed -b hg16-kc.bed | sort | uniq | wc -l
   #42737

# Hg19 was done in 2009 with better sequencing depth and less gaps in the genome

### 2 - hg16
wc -l hg16-kc.bed 
# 21365

bedtools intersect -v -a hg16-kc.bed -b hg19-kc.bed | wc -l
# Can also do: (qb26) cmdb@QUANTBIO-25 week1 % bedtools intersect -v -a hg16-kc.bed -b hg19-kc.bed | sort | uniq | wc -l
    # 3458 genes in 16 and not in 19

### 3
## Hg16 was done in 2003 with poorer sequencing depth. 
# Also cut -f1 hg16-kc.bed | uniq -c gives the counts from each genome 
# and it shows _rand for some and ChrUN for unknown chromosomes
