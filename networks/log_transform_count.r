library(data.table)
setwd("/storage/kuijjerarea/romana/TCGAmofa/cantini_benchmark/momix-notebook")

# log transform expression and mirna
source("scripts/log2matrix.R")
cancers <- dir("data/cancer")

for (i in cancers) {
    exp_log <- log2matrix(folder = paste0("data/cancer/", i),
                          file = "exp"
    )

    mirna_log <- log2matrix(folder = paste0("data/cancer/", i),
                          file = "mirna"
    )

    write.table(exp_log, file = "exp_log", sep = " ")
    write.table(mirna_log, file = "mirna_log", sep = " ")
}