#!/bin/bash 

cd genomes
cp ~/Data/References/sacCer3/sacCer3.fa.gz .
gunzip sacCer3.fa.gz
bwa index sacCer3.fa

cd ../variants
bwa mem -t 4 -R "@RG\tID:A01_09\tSM:A01_09" ../genomes/sacCer3.fa ~/qb26-answers/week2/BYxRM/fastq/A01_09.fq.gz > A01_09.sam

samtools sort -@ 4 -O bam -o A01_09.bam A01_09.sam
samtools index A01_09.bam

ls -lh

for my_sample in A01_09 A01_11 A01_23
do
    echo "Now processing" ${my_sample}
done

# the 10 segregants we will analyze
for my_sample in A01_09 A01_11 A01_23 A01_24 A01_27 A01_31 A01_35 A01_39 A01_62 A01_63
do
    echo "***" ${my_sample}

    # align reads to the reference genome
    bwa mem -t 4 -R "@RG\tID:${my_sample}\tSM:${my_sample}" ../genomes/sacCer3.fa ~/qb26-answers/week2/BYxRM/fastq/${my_sample}.fq.gz > ${my_sample}.sam

    # sort the alignments by position and convert to BAM
    samtools sort -@ 4 -O bam -o ${my_sample}.bam ${my_sample}.sam

    # index the BAM file
    samtools index ${my_sample}.bam
done