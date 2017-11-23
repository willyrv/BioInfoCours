
#################################################

# Lire le fichier
crossData <- read.table("./dataSet_1.ped", stringsAsFactors = FALSE)

# Enlever les colonnes avec une valeur constante
allelesList <- apply(crossData[, -c(1:6)], MARGIN = 2, table)
nbAlleles <- unlist(lapply(allelesList, FUN = length))
nb_onlyHetSNPs <- sum(nbAlleles == 1)
print(paste("Il y a", nb_onlyHetSNPs, "SNPs avec que d'heterozygotes"))

cleanedCrossData <- crossData[, c(rep(TRUE,6), nbAlleles > 1) ]
write.table(cleanedCrossData, "./dataSet1_clean.ped", col.names = FALSE, 
            row.names = FALSE, quote = FALSE)



library(LEA)
# Céation d'un dossier pour les analyses
dir.create("LEA_analyses")

# Convertir au format lfmm (le format d'entree pour LEA)
ped2lfmm("./dataSet1_clean.ped", "./LEA_analyses/dataSet_1.lfmm")
setwd("LEA_analyses")


pc = pca("./dataSet_1.lfmm", scale = TRUE)

# create file: tuto.tracyWidom - tracy-widom test information.
tw = tracy.widom(pc)

# display p-values for the Tracy-Widom tests (first 5 pcs).
tw$pvalues[1:5]


# Le code est les meme que dans la vignette du LEA 
