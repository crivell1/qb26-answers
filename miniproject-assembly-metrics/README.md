# Miniproject Assembly Metrics
Comparing the C. remanei assemblies and calculating metrics

Oregon_1 (filesize: 115M):
https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA248909/caenorhabditis_remanei.PRJNA248909.WBPS19.genomic.fa.gz

Oregon_2 (filesize: 121M)
https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA248911/caenorhabditis_remanei.PRJNA248911.WBPS19.genomic.fa.gz

WormBase (filesize: 141M)
https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA53967/caenorhabditis_remanei.PRJNA53967.WBPS19.genomic.fa.gz

Oregon_3 (filesize: 127M)
https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA577507/caenorhabditis_remanei.PRJNA577507.WBPS19.genomic.fa.gz

fasta.py
https://raw.githubusercontent.com/bxlab/cmdb-quantbio/refs/heads/main/resources/code/fasta.py

## Instructions

To analyze the assembly metrics of an unzipped FASTA file:
- make the assembly-metrics.py file executable
- run "./assembly-metrics.py {INPUT .fa FILE HERE}"
    - this will give you an output with the contig number, total lengths of all the reads, and average read length
- run the script for each .fa you want to analyze

## Results

Oregon_1 (2014 - earliest genome assembly)
Contig number: 1591,
Total Length: 118549266,
Avg read length: 74512.42363293526

Oregon_2 (2015 genome)
Contig number: 912,
Total Length: 124541912,
Avg read length: 136559.11403508772

WormBase (? gneome - data wasn't on the website with date)
Contig number: 3670,
Total Length: 145442736,
Avg read length: 39630.17329700272

Oregon_3 (2019 genome)
Contig number: 187,
Total Length: 130480874,
Avg read length: 697758.6844919786

From 2014 -> 2019:
 - contig number decreases (less number of reads)
 - total read length increases
 - average read length increased

