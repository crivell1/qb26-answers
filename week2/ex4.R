# Exercise 4 for week 2

# plotting histogram of AF
library(tidyverse)

al_freq <- scan("/Users/cmdb/qb26-answers/week2/AF.txt")
df <- data.frame(al_freq)
ggplot(df, aes(x=al_freq))+
  geom_histogram(bins=11)+
  labs(title = "Allele Frequency",x="frequency of allele",y="count")

gt_long <- read.csv("/Users/cmdb/qb26-answers/week2/gt_long.txt")
df_gt <- data.frame(gt_long)

#just chrom 2
df_gt |> 
  filter(sample=="A01_62",chrom=="chrII") |> 
  ggplot(aes(x=pos,y=1,color=factor(gt))) +
  geom_point() +
  labs(title = "Sample A01_62, chromsome 2") +
  facet_grid(.~chrom, scales = "free_x", space = "free_x")

#all of sample A01_62
df_gt |> 
  filter(sample=="A01_62") |> 
  ggplot(aes(x=pos,y=1,color=factor(gt))) +
  geom_point() +
  labs(title = "Sample A01_62, chromsome 2") +
  facet_grid(.~chrom, scales = "free_x", space = "free_x")

#one sample per row 
df_gt |>
  ggplot(aes(x=pos,y=1,color=factor(gt))) +
  geom_point()+
  facet_grid(sample ~ chrom, scales = "free_x", space = "free_x")+
  ggsave("ancestry.png",width=8, height = 6)





