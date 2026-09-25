## Holding Unix Commands and Answers for Week 2 Assignment

# Question 1.1 Why is the SAM file so much larger than the FASTQ file it came from? Why is the BAM file so much smaller than the SAM file?
The .sam file is larger because it its not a compressed file, while the fastq was compressed. 
The bam file is smaller because it is a compressed version of a sam file - a binary compressed form

# Question 1.2 ${my_sample} appears four times in the bwa mem command. Write out that command exactly as bash would run it on the third trip through the loop, with every variable replaced by its value.
The command is: bwa mem -t 4 -R "@RG\tID:${my_sample}\tSM:${my_sample}" ../genomes/sacCer3.fa ~/qb26-answers/week2/BYxRM/fastq/${my_sample}.fq.gz > ${my_sample}.sam

The computer would have the variable as A01_23 on its third iteration through the loop, it would read as follows:
bwa mem -t 4 -R "@RG\tID:A01_23\tSM:A01_23" ../genomes/sacCer3.fa ~/qb26-answers/week2/BYxRM/fastq/A01_23.fq.gz > A01_23.sam