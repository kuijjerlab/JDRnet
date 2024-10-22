################################################################################
## This script converts gene names from entrez IDs to HGNC and then overlaps ###
## with motif and ppi priors to result in data that is ready for panda/lioness #
################################################################################
rm(list=ls())
library(data.table)

cancers <- dir("/storage/kuijjerarea/romana/TCGAmofa/cantini_benchmark/momix-notebook/data/cancer") #nolint


#' @name map_gene_ids
#' @description Function that uses biomart to map gene IDs
#' @param genes A vector with gene IDs to be mapped.
#' @param mappings A vector of length 2 containing the filter/attribute
#'  pair to use formapping. These should be valid biomaRt filters/attreibutes.
#' (e.g. c("entrezgene_id", "hgnc") to convert entrez IDs to HGNC symbols).
#' @param mart A character string indicating what mart to use. This must be a
#' valid biomaRt mart. Default "ensembl".
#' @param dataset Which dataset to use. This must be a valid biomaRt dataset.
#' Default is "hsapiens_gene_ensembl".
#'
#' @seealso \code{\link{biomaRt::useMart}}
#' @seealso \code{\link{biomaRt::listFilters}}
#' @seealso \code{\link{biomaRt::listAttributes}}

map_gene_ids <- function(genes, mappings, mart = "ensembl",
                         dataset = "hsapiens_gene_ensembl") {
    # get mart
    mart <- useMart(biomart = mart, dataset = dataset)

    # map
    mapping <- getBM(attributes = mappings[2], filters = mappings[1],
                     values = genes, mart = mart)

    return(mapping)
}

#' @names remove_after_character
#' @description Remves all characters from a string after a given character,
#' including that character.
#' @param string String to be edited.
#' @param character Character to be used. Special characters must be escaped.
#'
#' @returns An edited string

remove_after_character <- function(string, character) {
# Split the string into parts using the specified character
  parts <- strsplit(string, character)[[1]]

  # Check if the split produced more than one part
  if (length(parts) > 1) {
    # return the first part joined together using the specified character
    return(paste(parts[1], collapse = character))
  } else {
    # If there's only one part, return the original string
  return(string)
  }
}

for (i in cancers) {
    # load expression
    exp <- data.frame(fread(paste0("/storage/kuijjerarea/romana/TCGAmofa/cantini_benchmark/momix-notebook/data/cancer/", #nolint
                        i, "/log_exp"))) # nolint

    # load panda priors
    prior <- data.frame(fread("/storage/kuijjerarea/romana/TCGAmofa/MOFAnet_dev/network_code/input/panda_prior.txt")) # nolint
    ppi <- data.frame(fread("/storage/kuijjerarea/romana/TCGAmofa/MOFAnet_dev/network_code/input/ppi2015_freeze.txt")) # nolint

    # remove everything but the gene symbols
    genes <- exp$probe
    genes <- sapply(genes, remove_after_character, character = "\\.")
    genes <- sapply(genes, remove_after_character, character = "\\|")

    exp$probe <- genes

    # only keep unique genes
    exp <- exp[!duplicated(exp$probe), ]
    genes <- genes[!duplicated(genes)]
    names(genes) <- NULL

    # make gene names row names
    rownames(exp) <- exp$probe
    exp <- exp[, -1]

    # intersect with prior
    idx <- intersect(genes, unique(prior[, 2]))
    exp <- exp[idx, ]
    prior2 <- prior[which(prior[, 2] %in% idx), ]

    # intersect priors
    idx_pri <- intersect(prior2[, 1], ppi[, 1])
    idx_pri <- intersect(idx_pri, ppi[, 2])
    ppi2 <- ppi[which(ppi[, 1] %in% idx_pri), ]
    ppi2 <- ppi[which(ppi[, 2] %in% idx_pri), ]

    sampleorder <- colnames(exp)

    # output files
    write.table(prior2,
                file = paste0("/storage/kuijjerarea/romana/TCGAmofa/cantini_benchmark/momix-notebook/data/cancer/", #nolint
                              i, "/prior.txt"), quote = FALSE, row.names = FALSE, col.names = FALSE, sep = "\t") #nolint
    write.table(ppi2,
                file = paste0("/storage/kuijjerarea/romana/TCGAmofa/cantini_benchmark/momix-notebook/data/cancer/", #nolint
                              i, "/ppi.txt"), quote = FALSE, row.names = FALSE, col.names = FALSE, sep = "\t") #nolint
    write.table(exp,
                file = paste0("/storage/kuijjerarea/romana/TCGAmofa/cantini_benchmark/momix-notebook/data/cancer/", #nolint
                              i, "/log_exp_fil.txt"), quote = FALSE, row.names = TRUE, col.names = FALSE, sep = "\t") #nolint
    write.table(sampleorder,
                file = paste0("/storage/kuijjerarea/romana/TCGAmofa/cantini_benchmark/momix-notebook/data/cancer/", #nolint
                              i, "/sampleorder.txt"), quote = FALSE, row.names = FALSE, col.names = FALSE, sep = "\t") #nolint

}