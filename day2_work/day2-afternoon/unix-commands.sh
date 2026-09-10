#!/bin/bash

## question number 1 answers

wc -l ce11_genes.bed
cut -f1 ce11_genes.bed | sort | uniq -c
cut -f6 ce11_genes.bed | sort | uniq -c

## question number 3 answers

cut -f7 GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | sort | uniq -c | sort
    # Whole blood
grep -c RNA GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt
    # 20017
grep -c -v RNA GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt
    # 2935

