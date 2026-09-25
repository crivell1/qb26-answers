## Holding Unix Commands and Answers for Week 2 Assignment

# Question 1.1 Why is the SAM file so much larger than the FASTQ file it came from? Why is the BAM file so much smaller than the SAM file?
The .sam file is larger because it its not a compressed file, while the fastq was compressed. 
The bam file is smaller because it is a compressed version of a sam file - a binary compressed form

# Question 1.2 ${my_sample} appears four times in the bwa mem command. Write out that command exactly as bash would run it on the third trip through the loop, with every variable replaced by its value.
The command is: bwa mem -t 4 -R "@RG\tID:${my_sample}\tSM:${my_sample}" ../genomes/sacCer3.fa ~/qb26-answers/week2/BYxRM/fastq/${my_sample}.fq.gz > ${my_sample}.sam

The computer would have the variable as A01_23 on its third iteration through the loop, it would read as follows:
bwa mem -t 4 -R "@RG\tID:A01_23\tSM:A01_23" ../genomes/sacCer3.fa ~/qb26-answers/week2/BYxRM/fastq/A01_23.fq.gz > A01_23.sam

# Question 2.1 What do the @SQ lines tell you, and how many are there?
The @SQ lines tell you the chromosome that is included in the read file. In the one we checked there are 17 (1 MT chromosome)

# Question 2.2: Pick one alignment from the output above. What chromosome and position did it align to, and what is its CIGAR string? What does that CIGAR string mean?
The first one. Chromosome 1 (chrm I). 76M. That 76 bases were mapped

# Question 2.3: Your read group appears twice: once in the @RG header line, and once as an RG:Z: tag among the optional tags at the end of each alignment. Find both. Where did those values come from, and why does every single read need to carry one?

header one -- @RG     ID:A01_09       SM:A01_09
sample one -- RG:Z:A01_09
This helps verify that each read actually is supposed to be in the sample file under this name. 

# Question 2.4: What fraction of reads mapped to the reference genome? Is that a reasonable number for a yeast sample aligned to the yeast reference?
fraction of reads mapped: 1 , percent of reads mapped: 100%. I think so. Makes sense that the sample organism matches the reference of the species.

# Question 2.5: Several lines of the output are exactly 0, including “properly paired” and “with mate mapped to a different chr”. Why? What does that tell you about how this library was sequenced?
This was not a paired end sequencing allingment - it seems it was single read sequencing.

# Question 2.6: Looking at your 10 samples in this region, which ones appear to carry BY ancestry and which appear to carry RM ancestry? Find the markers at chrI:27915, chrI:28323, chrI:28652, and chrI:29667 in ~/Data/BYxRM/BYxRM_GenoData.txt and check whether your visual call agrees with the published genotypes.
BY ancestry - 09, 24, 31, 39, 62, 63
RM ancestry - 11, 23, 27, 35, 