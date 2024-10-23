# merging and processing the data downloaded from GEPliver
# bulk19 is not in the analisis
rm(list=ls())

library(tidyverse)

# load in the data
bulk15 <- read.table("raw_data/downloadFile?fileName=Download%2FHuman Bulk%2Fexpr%2FBulk15_expr.txt", sep = "\t", head = T)
bulk21 <- read.table("raw_data/downloadFile?fileName=Download%2FHuman Bulk%2Fexpr%2FBulk21_expr.txt", sep = "\t", head = T)
bulk23 <- read.table("raw_data/downloadFile?fileName=Download%2FHuman Bulk%2Fexpr%2FBulk23_expr.txt", sep = "\t", head = T)
bulk26 <- read.table("raw_data/downloadFile?fileName=Download%2FHuman Bulk%2Fexpr%2FBulk26_expr.txt", sep = "\t", head = T) # this is TCGA but not in the main cohort
bulk19 <- read.table("raw_data/downloadFile?fileName=Download%2FHuman Bulk%2Fexpr%2FBulk26_expr.txt", sep = "\t", head = T) # also TCGA, need ot filter to only samples on in the main cohort
TCGA <- get(load("/storage/kuijjerarea/romana/TCGAmofa/june_2024_run/liver_omics_no_pca.Rda"))
TCGA <- TCGA[["expression"]]

#load in metadata
clin15 <- read.table("raw_data/downloadFile?fileName=Download%2FHuman Bulk%2Fmeta%2FBulk15_meta.txt", sep = "\t", head = T)
clin21 <- read.table("raw_data/downloadFile?fileName=Download%2FHuman Bulk%2Fmeta%2FBulk21_meta.txt", sep = "\t", head = T)
clin23 <- read.table("raw_data/downloadFile?fileName=Download%2FHuman Bulk%2Fmeta%2FBulk23_meta.txt", sep = "\t", head = T)
clin26 <- read.table("raw_data/downloadFile?fileName=Download%2FHuman Bulk%2Fmeta%2FBulk26_meta.txt", sep = "\t", head = T)
clin19 <- read.table("raw_data/downloadFile?fileName=Download%2FHuman Bulk%2Fmeta%2FBulk19_meta.txt", sep = "\t", head = T)

# set first column (gene name) as rownames
rownames(bulk15) <- bulk15$gene
rownames(bulk21) <- bulk21$gene
rownames(bulk23) <- bulk23$gene
rownames(bulk26) <- bulk26$gene
rownames(bulk19) <- bulk19$gene

# remove the gene name as a column and convert to matrix
bulk15 <- as.matrix(bulk15[,-1])
bulk21 <- as.matrix(bulk21[,-1])
bulk23 <- as.matrix(bulk23[,-1])
bulk26 <- as.matrix(bulk26[,-1])
bulk19 <- as.matrix(bulk19[,-1])

# for the TCGA data, filter to only samples not in the main cohort
tcga_main <- colnames(TCGA)
samples_19 <- colnames(bulk19)[-1]
samples_26 <- colnames(bulk26)

# remove the last character from the gep samples to match the main cohort id lengts
samples_19 <- str_sub(samples_19, end = -2)
samples_26 <- str_sub(samples_26, end = -2)

# find any common samples
common_19 <- intersect(tcga_main, samples_19)
common_26 <- intersect(tcga_main, samples_26)

# select only samples not in common
if (length(common_19) > 0) {
    bulk19 <- bulk19[, !common_19]
}

if (length(common_26 > 0)) {
    bulk26 <- bulk26[, !common_26]
}

# bind into one matrix
exp <- cbind(bulk15, bulk26, bulk23, bulk21)

# filter to only the genes also in the TCGA dataset
# first have to process the stupid gene names in the TCGA data
genes <- rownames(TCGA)
genes <- str_replace(genes,"\\|.*", "")
genes <- str_replace(genes, "\\..*", "")
genes_overlap <- intersect(genes, rownames(exp))
exp <- exp[genes_overlap,]

# log transform the data
exp2 <- log2(exp + 1)

# sample list
samples <- colnames(exp)

# combine clinical data
clin <- rbind(clin15, clin26, clin23, clin21)

# overlap exp data with panda priors

# read in priors
prior <- read.table("lioness/input/panda_prior.txt", sep = "\t", head = F)
ppi <- read.table("lioness/input/ppi2015_freeze.txt", sep = "\t", head = F)

# get common genes
genes_common <- intersect(genes_overlap, prior[,2])
exp_li <- exp2[genes_common, ]
prior2 <- prior[which(prior[,2] %in% genes_common), ]

# get common tfs
tf_common <- intersect(prior[,1], c(ppi[,1], ppi[,2]))
ppi2 <- ppi[which(ppi[,1] %in% tf_common & ppi[,2] %in% tf_common),]
prior2 <- prior[which(prior2[,1] %in% tf_common),]



# write files
write.table(exp, quote = F, sep = "\t", file = "exp.txt")
write.table(exp2, quote = F, sep = "\t", file = "exp_log.txt")
write.table(exp_li, quote = F, sep = "\t", file = "lioness/input/exp.txt", col.names = F)
write.table(prior2, quote = F, sep = "\t", file = "lioness/input/prior.txt", col.names = F, row.names = F)
write.table(ppi2, quote = F, sep = "\t", file = "lioness/input/ppi.txt", col.names = F, row.names = F)
write.table(samples, quote = F, sep = "\t", file = "lioness/input/sampleorder.txt", row.names = F, col.names = F)
write.table(clin, quote = F, sep = "\t", file = "clin.txt", row.names = FALSE)

