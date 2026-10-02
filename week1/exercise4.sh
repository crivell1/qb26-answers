bedtools intersect -c -a hg19-kc.bed -b snps-chr1.bed | sort -k5nr | head 
# chr1    245912648       246670581       ENST00000490107.6_7     5445
# chr1    6845513 7829766 ENST00000303635.12_9    5076
# chr1    237205483       237997288       ENST00000366574.7_7     4586
# chr1    193442353       194167841       ENST00000656143.2_4     4265
# chr1    48998525        50489626        ENST00000371839.6_9     4003
# chr1    215796232       216596790       ENST00000307340.8_12    3898
# chr1    245318286       245872734       ENST00000407071.7_12    3752
# chr1    71861625        72748222        ENST00000357731.10_7    3670
# chr1    82678096        83313888        ENST00000650063.1_5     3563
# chr1    240938813       241520505       ENST00000440928.6_9     3340

## ENST00000490107.6_7 
## SYMD3
## hg19 chr1:245,912,644-246,580,711 
## Size: 668,068
## Total Exon Count: 12
## The gene is massive at 668,068 bases and covers a lot of space, not surprising that covering that much area would lead to having a higher number of SNPs in there. Also seems to be a tumor surpressor gene

bedtools sample -n 20 -seed 42 -i snps-chr1.bed > snps-samples.bed
#> head snps-samples.bed
# chr1    247118389       247118390       rs61852577      0       +
# chr1    11839540        11839541        rs200540772     0       +
# chr1    36733538        36733539        rs12726228      0       +
# chr1    201437831       201437832       rs35383942      0       +
# chr1    174840899       174840900       rs1883139       0       -
# chr1    19020850        19020851        rs71645417      0       +
# chr1    189602916       189602917       rs6672054       0       +
# chr1    19821839        19821840        rs2088825       0       +
# chr1    164976172       164976173       rs11325393      0       +
# chr1    20821533        20821534        rs74720529      0       +

bedtools sort -i snps-samples.bed > snps_srted-ex4.bed
#> head snps_srted-ex4.bed      
# chr1    3810505 3810506 rs78397137      0       +
# chr1    11638083        11638084        rs6698664       0       +
# chr1    11839540        11839541        rs200540772     0       +
# chr1    19020850        19020851        rs71645417      0       +
# chr1    19821839        19821840        rs2088825       0       +
# chr1    20821533        20821534        rs74720529      0       +
# chr1    22371064        22371065        rs10917130      0       +
# chr1    36733538        36733539        rs12726228      0       +
# chr1    51041899        51041900        rs77222361      0       +
# chr1    55741406        55741407        rs572651962     0       +


bedtools sort -i hg19-kc.bed > hg19-kc_srted-ex4.bed
# For some reason piping into the head function doesn't work here, so I just ran the command and then ran head on the output file. and tail to verify no extra lines were added.

#> head hg19-kc_srted-ex4.bed
# chr1    10369   10582   ENST00000833856.1_2
# chr1    11425   14409   ENST00000832828.1_1
# chr1    12009   13670   ENST00000450305.2_3
# chr1    14360   29367   ENST00000831158.1_1
# chr1    14695   24886   ENST00000488147.2_6
# chr1    29553   31097   ENST00000473358.1_6
# chr1    34612   37523   ENST00000834251.1_1
# chr1    36525   40778   ENST00000833573.1_2
# chr1    51890   63526   ENST00000832531.1_2
# chr1    52472   53312   ENST00000606857.1_3

#>tail hg19-kc_srted-ex4.bed
# chrY    59213895        59276439        ENST00001146174.1_1
# chrY    59284788        59291993        ENST00000850734.1_2
# chrY    59311662        59311996        ENST00000711266.1_2
# chrY    59318040        59318920        ENST00000711267.1_2
# chrY    59330321        59345688        ENST00001146185.1_1
# chrY    59336888        59354907        ENST00000711268.1_2
# chrY    59347285        59349549        ENST00000850824.2_3
# chrY    59353631        59358045        ENST00000711285.2_2
# chrY    59358327        59361716        ENST00000850701.2_2
# chrY    59358334        59360548        ENST00000711270.1_2

#> bedtools closest -d -t first -b hg19-kc_srted-ex4.bed -a snps_srted-ex4.bed | cut -f 11 | sort | head -n 20
# I did this and counted ^ but if you want to avoid counting...
bedtools closest -d -t first -a snps_srted-ex4.bed -b hg19-kc_srted-ex4.bed | cut -f 11 | grep -x "0" | wc -l
# 15

bedtools closest -d -t first -a snps_srted-ex4.bed -b hg19-kc_srted-ex4.bed | cut -f 11 | sort -n
# 0
# 0
# 0
# 0
# 0
# 0
# 0
# 0
# 0
# 0
# 0
# 0
# 0
# 0
# 0
# 1664
# 4407
# 6336
# 15658
# 22944

## how many are in a gene? 
# 15 SNPs on the list are in a gene
## what are the ranges for the ones not in a gene?
# 22944 - 1664 = 21280
