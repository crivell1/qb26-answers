#!/usr/bin/env python3

# in bash:
## pip install pysam
import pysam

vcf = pysam.VariantFile("/Users/cmdb/qb26-answers/week2/variants/biallelic.vcf")

af_file = open("AF.txt", "w")
gt_long = open("gt_long.txt", "w")
gt_long.write("sample,chrom,pos,gt\n")

for record in vcf:
    if record.chrom == "chrM":
        continue
    else:
        af_value = (str(record.info["AF"][0]))
        af_file.write(af_value+"\n")

        for sample in record.samples:
            #gt_long.write()
            if (str(record.samples[sample]["GT"][0])) == "None" or None: 
                continue
            else:
                gt_long.write(f'{sample},{record.chrom},{str(record.pos)},{str(record.samples[sample]["GT"][0])}\n')

af_file.close()
gt_long.close()




