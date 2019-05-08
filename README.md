Identification of GATA3 expression partners in human morula cells
================
Gregorio Alanis-Lobato

Description of the project
--------------------------

We integrated single cell RNA-sequencing (scRNA-seq) time course data from two 
different studies, which interrogate the transcriptome of human pre-implantation 
embryos at different stages. The dataset from Yan et al. (ENA study ID: 
PRJNA153427) measures gene expression of individual cells from the Oocyte to the 
Late Blastocyst stage, whereas the dataset from Petropoulos et al. (ENA study 
ID: PRJEB11202) does it from the 8-cell to the Late Blastocyst stage. Also, we 
considered the scRNA-seq data from Blakeley et al. (ENA study ID: PRJNA277181), 
which assayed the transcriptome of the three cell lineages of the human 
blastocyst (epiblast, primitive endoderm and trophectoderm).

`SingleCellExperiment` objects with the raw counts from each one of these 
datasets are provided in the `data` folder of this repository.

We focused on trophectoderm cells with gene expressions of the GATA3 gene above 
the median in Blakeley’s dataset. Next, we used package `MGFR v1.8.1` to detect 
genes whose expression is high in all the selected trophectoderm samples 
compared to the epiblast and primitive endoderm samples. Then, we looked at the 
expression of the resulting list of genes at the Morula stage using the integrated 
scRNA-seq data from Yan and Petropoulos. Finally, genes with average expression 
above 0 at the Morula stage were selected to study the Pearson and Spearman 
correlation of their expression profile against the profile of GATA3 at the same 
developmental stage. Functional enrichment analysis of the selected genes was 
performed with `enrichR v1.0`.

To identify genes with the opposite trend, we centered our attention on the 10% 
of the Morula samples with the lowest gene expression levels of GATA3. Genes with 
average expression at least two-fold higher than that of GATA3 in these samples 
were shortlisted for correlation analysis against the expression profile of 
GATA3 at the Morula stage as above.

Pre-requisites
--------------

The bioinformatic pipeline that we prepared requires the following software packages:

-   R v3.5.2
    -   Bioconductor v3.8
        -   SummarizedExperiment v1.12.0
        -   SingleCellExperiment v1.4.1 
        -   scran v1.10.2 
        -   scater v1.10.1 
        -   MGFR v1.8.1  
    -   dplyr v0.8.0.1 
    -   readr v1.3.1
    -   cowplot v0.9.4
    -   ggplot2 v3.1.1 
    -   ggrepel v0.8.0
    -   DrImpute v1.1
    -   enrichR v1.0 
    
How to use
----------

To use this pipeline, knit the provided `R Markdown` files in the following
order:

-   00a_data_processing.Rmd
-   00b_data_processing.Rmd
-   01_gata3_in_TE_YP.Rmd
-   02_enrichment_YP.Rmd 
-   03_gata3neg_YP.Rmd

The R script named 04_corr_analysis.R can be used with any list of genes to 
generate correlation plots between genes of interest and GATA3 at the morula 
stage.

