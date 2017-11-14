# library needed
suppressMessages(suppressWarnings(library(tidyverse)))
suppressMessages(suppressWarnings(library(broom)))

all_cancer_types_mut_with_ref_sig <- read.table("somatic_mutations_formated_files/all_cancer_types_mut_with_ref_sig.tsv", sep = "\t", header = TRUE)

