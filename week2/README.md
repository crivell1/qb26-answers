# Holding Unix Commands and Answers for Week 2 Assignment

## Question 1.1 Why is the SAM file so much larger than the FASTQ file it came from? Why is the BAM file so much smaller than the SAM file?
The .sam file is larger because it its not a compressed file, while the fastq was compressed. 
The bam file is smaller because it is a compressed version of a sam file - a binary compressed form

## Question 1.2 ${my_sample} appears four times in the bwa mem command. Write out that command exactly as bash would run it on the third trip through the loop, with every variable replaced by its value.
The command is: bwa mem -t 4 -R "@RG\tID:${my_sample}\tSM:${my_sample}" ../genomes/sacCer3.fa ~/qb26-answers/week2/BYxRM/fastq/${my_sample}.fq.gz > ${my_sample}.sam

The computer would have the variable as A01_23 on its third iteration through the loop, it would read as follows:
bwa mem -t 4 -R "@RG\tID:A01_23\tSM:A01_23" ../genomes/sacCer3.fa ~/qb26-answers/week2/BYxRM/fastq/A01_23.fq.gz > A01_23.sam

## Question 2.1 What do the @SQ lines tell you, and how many are there?
The @SQ lines tell you the chromosome that is included in the read file. In the one we checked there are 17 (1 MT chromosome)

## Question 2.2: Pick one alignment from the output above. What chromosome and position did it align to, and what is its CIGAR string? What does that CIGAR string mean?
The first one. Chromosome 1 (chrm I). 76M. That 76 bases were mapped

## Question 2.3: Your read group appears twice: once in the @RG header line, and once as an RG:Z: tag among the optional tags at the end of each alignment. Find both. Where did those values come from, and why does every single read need to carry one?

header one -- @RG     ID:A01_09       SM:A01_09
sample one -- RG:Z:A01_09
This helps verify that each read actually is supposed to be in the sample file under this name. 

## Question 2.4: What fraction of reads mapped to the reference genome? Is that a reasonable number for a yeast sample aligned to the yeast reference?
fraction of reads mapped: 1 , percent of reads mapped: 100%. I think so. Makes sense that the sample organism matches the reference of the species.

## Question 2.5: Several lines of the output are exactly 0, including “properly paired” and “with mate mapped to a different chr”. Why? What does that tell you about how this library was sequenced?
This was not a paired end sequencing allingment - it seems it was single read sequencing.

## Question 2.6: Looking at your 10 samples in this region, which ones appear to carry BY ancestry and which appear to carry RM ancestry? Find the markers at chrI:27915, chrI:28323, chrI:28652, and chrI:29667 in ~/Data/BYxRM/BYxRM_GenoData.txt and check whether your visual call agrees with the published genotypes.
BY ancestry - 09, 24, 31, 39, 62, 63
RM ancestry - 11, 23, 27, 35, 

## Question 3.1: Open the VCF with less -S and look at the header lines beginning with ##. Then find the #CHROM line. What are the last 10 columns, and where did those names come from?
The last 10 columns are the samples that we are aligning. They came from the list in the text file we made.

## Question 3.2: Why does the ploidy argument matter here? What would a genotype look like if you had told FreeBayes these samples were diploid?
the segregates are a haploid sample, which map only one allele for the read. If it was going for diploid read then it might give a heterozygous count which wouldn't make sense for our model. GT would look like 0/1 or 0/0 or 1/1 if it was diploid.

## Question 4.1: Interpret this figure in two or three sentences in your own words. Does it look as expected? Why or why not? Bonus: what is the name of this distribution?
This is a binomial distribution that shows that most alternate allele positions have frequencies near the mid-range (0.4-0.6). This is expected since our population is a cross of BY + RM parental strains, we have about as good of a chance as inheriting the "reference" or BY genome as we do for inheriting the RM genome. This is a binomial distribution.

## Question 4.2: Do you notice any patterns? What do the transitions indicate?
There are regions of reference aligned and regions of alternate aligned , in large chunks it seems. This shows where the chromosome segment was recombined in some fashion and a specific parental strain shines through.

## Question 4.3: Do the samples that looked like BY in your IGV screenshot from Exercise 2 also look like BY at the left end of chrI here? Do any samples appear to be mostly one parent across the whole genome?
Yes they do, there is more red on the left side of ChrI than blue which is my legend labeling for the reference genome. Not really, they all seem pretty well-mixed to my visual qualification.