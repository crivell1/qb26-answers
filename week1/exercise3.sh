!#/bin/bash/

bedtools intersect -wo -a nhlf-active.bed -b nhlf-repressed.bed | wc -c
       #0
bedtools intersect -wo -a nhek-active.bed -b nhek-repressed.bed | wc -c
       #0
bedtools intersect -u -a nhek-active.bed -b nhlf-active.bed | wc -c 
 #745322    # had to switch it from -wa -> -u to make it add up correclty

bedtools intersect -v -a nhek-active.bed -b nhlf-active.bed | wc -c
  #154383

bedtools intersect -f 1 -a nhek-active.bed -b nhlf-active.bed | head -5
#chr1	25558413	25559413	1_Active_Promoter	0	.	25558413	25559413
#chr1	38273013	38274613	1_Active_Promoter	0	.	38273013	38274613
#chr1	90308212	90309812	1_Active_Promoter	0	.	90308212	90309812
#chr1	109968277	109970077	1_Active_Promoter	0	.	109968277	109970077
#chr1	116915877	116916877	1_Active_Promoter	0	.	116915877	116916877

bedtools intersect -F 1 -a nhek-active.bed -b nhlf-active.bed | head -5
#chr1	19923013	19924213	1_Active_Promoter	0	.	19922613	19924613
#chr1	1309537	1311537	1_Active_Promoter	0	.	1309337	1311537
#chr1	11796213	11797013	1_Active_Promoter	0	.	11796013	11797213
#chr1	28573413	28573613	1_Active_Promoter	0	.	28573413	28573813
#chr1	67894812	67897012	1_Active_Promoter	0	.	67893412	67897412

bedtools intersect -f 1 -F 1 -a nhek-active.bed -b nhlf-active.bed | head -5
#chr1	1051137	1051537	1_Active_Promoter	0	.	1051137	1051537
#chr1	1406537	1408337	1_Active_Promoter	0	.	1406537	1408337
#chr1	1840740	1841540	1_Active_Promoter	0	.	1840740	1841540
#chr1	2516940	2518140	1_Active_Promoter	0	.	2516940	2518140
#chr1	6320613	6320813	1_Active_Promoter	0	.	6320613	6320813

## The chromatin overlap state goes from 100% of nhek-active state to 100% of nhlf-active state to overlaps when they are both completely in the active state for both tissues

bedtools intersect -f 1 -F 1 -a nhek-active.bed -b nhlf-active.bed | head -5
#chr1	1051137	1051537	1_Active_Promoter	0	.	1051137	1051537
#chr1	1406537	1408337	1_Active_Promoter	0	.	1406537	1408337
#chr1	1840740	1841540	1_Active_Promoter	0	.	1840740	1841540
#chr1	2516940	2518140	1_Active_Promoter	0	.	2516940	2518140
#chr1	6320613	6320813	1_Active_Promoter	0	.	6320613	6320813

bedtools intersect -f 0.75 -F 0.75 -a nhek-active.bed -b nhlf-repressed.bed | head -5
#chr2	113540129	113542129	1_Active_Promoter	0	.	113539529	113542129
#chr17	72427205	72428605	1_Active_Promoter	0	.	72427005	72428605

bedtools intersect -f 1 -F 1 -a nhek-repressed.bed -b nhlf-repressed.bed | head -5
#chr1	238137	242737	12_Repressed	0	.	238137	242737
#chr1	1535337	1535737	12_Repressed	0	.	1535337	1535737
#chr1	9067613	9070013	12_Repressed	0	.	9067613	9070013
#chr1	11780413	11783813	12_Repressed	0	.	117804111783813
#chr1	16978613	16982813	12_Repressed	0	.	169786116982813

## Describe the chromatin states across all nine conditions
# active-active is pretty ubiquitous in activation and promotor/enhancer
# active-repressed seems to be heterochromatin and repressed region in NHLF and NHEK is in active-promotor state, the others seem to bounce around between heterochromatin and transisition states.
# The repressed-repressed seem to be all in repressed state surrounded by insulator regions
