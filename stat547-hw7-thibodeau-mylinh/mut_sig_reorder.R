suppressMessages(suppressWarnings(library(plyr)))
library(tidyverse)
mut_sig <- read.table("mut_sig.tsv", header = TRUE, sep = "\t")
ref_mut_sig_ordered_by_sig3 <- data.frame(mut_sig)
ref_mut_sig_ordered_by_sig3 <- within(ref_mut_sig_ordered_by_sig3, Somatic.Mutation.Type <- reorder(Somatic.Mutation.Type, Signature.3))
saveRDS(ref_mut_sig_ordered_by_sig3, "ref_mut_sig_ordered_by_sig3.rds")

