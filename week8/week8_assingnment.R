BiocManager::install("zellkonverter")
library("zellkonverter")
library("HDF5Array") 
library("scuttle")
library("scater")
library("scran")
library("ggplot2")
library("clusterProfiler")
BiocManager::install("org.Mm.eg.db")
library("org.Mm.eg.db")


## Exercise 1 - Load DATA

setwd("~/qb26-answers/week8")
kidney <- readH5AD("kidney_10x.h5ad", reader="R")
kidney

assay( kidney, "X", withDimnames=FALSE ) <- as( H5SparseMatrix( "kidney_10x.h5ad", "raw/X" ), "dgCMatrix" )
assayNames(kidney) <- "counts"

rowData(kidney)
rownames(kidney) <- rowData(kidney)$feature_name
kidney <- logNormCounts(kidney)

# Question 1: Inspect the kidney SingleCellExperiment object (0.5 pt)

# How many genes are quantitated (should be >10,000)?
kidney
## 17,943 genes

# How many cells are in the dataset?
## 21647 cells

# What dimension reduction datasets are present?
## X_pca, X_tsne, X_umap

## Inspect Cell metadata

#Question 2: Inspect the available cell metadata (0.5 pt)

# How many columns are there in colData(kidney)?
colData(kidney)
## 29 columns of metadata

# Which three column names reported by colnames() seem most interesting? Briefly explain why.
## to me the interesting ones aer cell_type, disease, sizeFactor. This would allow us to explore which cell types have what expression, the disease state that could contribute to altered expression, and how that cell's expression varies across the other cells sampled

# Plot cells according to X_umap using plotReducedDim() and colouring by cell_type
plotReducedDim(kidney, "X_umap", color_by = "cell_type")

### Exercise 2: explore gene level statistics

counts(kidney)
rowSums(counts(kidney))
genecounts <- rowSums(counts(kidney))

#Question 3: Explore the genecounts distribution (1 pt)
# What is the mean and median genecount according to summary()? What might you conclude from these numbers?
summary(genecounts)
## mean = 8349, median = 1212. That the mean is skewed right with a smaller number of genes that have very high expression counts

# What are the three genes with the highest expression after using sort()? What do the gene names stand for?
sort(genecounts, decreasing = TRUE)[1:3]
## Malat1 (Metastasis Associated Lung Adenocarcinoma Transcript 1), Gpx3 (Glutathione Peroxidase 3), Kap (Kidney Androgen-Regulated Protein) 

#Question 4a: Explore the total expression in each cell across all genes (0.5 pt)

# Create a vector named cellcounts using colSums()
counts(kidney)
colSums(counts(kidney))
cellcounts <- colSums(counts(kidney))
# Create a histogram of cellcounts using hist()
hist(cellcounts)
# What is the mean number of counts per cell?
summary(cellcounts) # mean = 6921
# How would you interpret the cells with much higher total counts (>10,000)?
# I'd say that they're either doublet reads or dying cells with excessive MT gene expression

# Question 4b: Explore the number of genes detected in each cell (0.5 pt)

# Create a vector named celldetected using colSums() but this time on counts(kidney)>0
celldetected <- colSums(counts(kidney)>0)
# Create a histogram of celldetected using hist()
hist(celldetected)
# What is the mean number of genes detected per cell?
summary(celldetected) # 1982
# What fraction of the total number of genes does this represent?
1982/17943 = 0.1104609

## Explore Stress Gene reads

stress <- c( "Fos", "Fosb", "Jun", "Junb", "Egr1", "Atf3", "Ier2", "Hspa1a", "Hspa1b" )
stress %in% rownames(kidney)

df <- perCellQCMetrics(kidney, subsets=list(Stress=stress))
df
df <- as.data.frame(df)
summary(df)
## the means for sum and detected line up!

colData(kidney)
colData(kidney) <- cbind( colData(kidney), df )

plotColData(kidney, y = "subsets_Stress_percent", x = "cell_type" ) +
  (theme( axis.text.x=element_text( angle=90, hjust=1, vjust=0.5 ) )) +
  ggsave("2.5_stress_gene_reads.png")

# There seem to be more stress gene reads in mesangial cells and some endothelial cells.
# These cells would be experiencing a lot of blood pressure and looking up what mesangial cells shows they take the brunt of metabolic waste first pass and act as early injury/immune responders in the kidney.

### Exercise 3

marker.info <- scoreMarkers( kidney, colData(kidney)$cell_type )
chosen <- marker.info[["kidney proximal convoluted tubule epithelial cell"]]
ordered <- chosen[order(chosen$mean.AUC, decreasing=TRUE),]
head(ordered[,1:4])

# Question 6a: Evaluate top marker genes (1 pt)

# What are the six top marker genes in the proximal convoluted tubule?
## Gpx, Gatm, Miox, Ndrg1, Aldob, Slc34a1

# Plot the expression of the top marker gene across cell types using plotExpression() and specifying the gene name as the feature and cell_type as the x-axis and submit this plot
top_gene <- rownames(ordered)[1]
plotExpression(kidney, top_gene, x= "cell_type") +
  (theme( axis.text.x=element_text( angle=90, hjust=1, vjust=0.5 ) )) +
  ylab(paste0(top_gene,"expression (logcounts)")) + # I tried concatinating the string like in python... I don't like that R has to do this paste function for strings with variables
  ggsave(paste0(top_gene,"_expression.png"))

goi <- rownames(ordered)[1:200]
ego <- enrichGO( goi, OrgDb=org.Mm.eg.db, keyType="SYMBOL", ont="BP", universe=rownames(kidney) )
head( ego )
dotplot( ego ) +
  ggsave("GO_dotplot_top_prox_cov_tube_ec.png")

## Top go terms:
# small molecule catabolic process
# amino acid metabolic process -
# alpha-amino acid metabolic process

# glutathione peroxidase 3
# glycine amidinotransferase (L-arginine:glycine amidinotransferase)
# myo-inositol oxygenase
# N-myc downstream regulated gene 1
# aldolase B, fructose-bisphosphate
# solute carrier family 34 (sodium phosphate), member 1

# Proteins, salts, and oxygen species seem to be the hot topic here in the prox convoluted tube

chosen_henle <- marker.info[["kidney loop of Henle thick ascending limb epithelial cell"]]
ordered_henle <- chosen_henle[order(chosen_henle$mean.AUC, decreasing=TRUE),]
head(ordered_henle[,1:4])
rownames(ordered_henle)[1:6]
henle_goi <- rownames(ordered_henle)[1:6]
plotExpression(kidney, henle_goi, x= "cell_type") +
  (theme( axis.text.x=element_text( angle=90, hjust=1, vjust=0.5 ) )) +
  ylab("top_henle_gene_expression (logcounts)") + 
  ggsave(("top_henle_gene_expression.png"))


# Which other cell type expresses several of these markers? Looking at the labels, what might explain this?
## Kidney collecting duct epithelial cell, kidney distal convuloted epithelial cell, and kidney loop of henle acessending limb epithelial cell. Those are all the parts of the nephron that are connected after the Bowman's capsule.
# Which marker looks most specific for the thick ascending limb? What drug class targets the protein it encodes?
## Slc12a1 seems to be the most specific, "loop diuretics" seem to be the most common class that act on it. As a solute and ion carrier, these would block reabsorption of ions and keep the kidney excreting them as waste.


henle_200 <- rownames(ordered_henle)[1:200]
hen_ego <- enrichGO( henle_200, OrgDb=org.Mm.eg.db, keyType="SYMBOL", ont="BP", universe=rownames(kidney) )
head( hen_ego )
dotplot( hen_ego )
# top terms and why does this cell need them?
## top terms: gen of precurosoe metabolites, energy derivation by oxidation of organic compounds, cellular respiration, aerobic respiration 
## These cells need constant ATP and energy to pump Na and K into/out of cell - since their job is salt control

