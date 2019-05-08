
library(readr)
library(dplyr)
library(cowplot)
library(SingleCellExperiment)

# Based on a given list of genes, this script generates correlation plots 
# against the expression profile of GATA3 at the Morula stage

# Yan & Petropoulos integrated dataset ------------------------------------

load("data/SCE_yan_pet.RData")

# Positive correlation
genes <- c("GRHL2", "KRT18", "CLDN4", "RAB20", "RAB25",
           "PTGES", "TFEB", "PLAC8",
           "VGLL4",
           "ATP6V0A4", "ATP6V1B1", "ATP6V1C2", "FXYD4", "SLC7A2")

# Negative correlation
# genes <- c("BAG4", "DUXA", "CBX5", "DPPA3", "PHF5A", "DCAF13", "TOX4", "AMD1",
#            "ZNF207", "DUSP3", "HMGN1", "ARID3B", "RLF", "MDM2", "KLF17", "DPRX",
#            "TMEM92", "ARGFX", "KIAA1191", "TGS1", "ILF2", "DAB2")

expr <- logcounts(yp_sce)[c(genes, "GATA3"), yp_sce$cell_alias == "Morula"]
tb <- tibble(gata3 = expr["GATA3", ], gene = numeric(ncol(expr)))

p <- list()

# Generate GATA3 vs other gene correlation plots
for(i in 1:length(genes)){
  tb$gene <- expr[genes[i], ]
  pear <- round(cor(tb$gata3, tb$gene), 3)
  spear <- round(cor(tb$gata3, tb$gene, method = "spearman"), 3)
  
  p[[i]] <- ggplot(tb, aes(gata3, gene)) + 
    geom_point(size = 2.5) +
    geom_smooth(method = "lm", colour = "black") +
    labs(x = "GATA3 expr. (Morula)", y = paste0(genes[i], " expr. (Morula)"),
         title = paste0("n = ", ncol(expr), 
                        ", Pearson's r = ", pear,
                        ", Spearman's rho = ", spear)) +
    theme_bw()
}

cl <- 3
rw <- (length(p) %/% cl) + (length(p) %% cl)
plot_grid(plotlist = p, nrow = rw, ncol = cl)
