# outputting the in and out degree in separate files
rm(list = ls())

wd <- "/storage/kuijjerarea/romana/TCGAmofa/cantini_benchmark/momix-notebook/data/cancer/"
#wd <- "/storage/kuijjerarea/romana/TCGAmofa/june_2024_run/liver_val_old/"

#cancers <- c("aml", "breast", "colon", "gbm", "kidney", "liver", "lung",
#            "melanoma", "ovarian", "sarcoma")
cancers <- "breast"

for (i in cancers) {
    print(i)
    # load data
    load(paste0(wd, i, "/degree.RData"))

    save(indegree, file = paste0(wd, i, "/indegree.RData"))
    save(outdegree, file = paste0(wd, i, "/outdegree.RData"))
}