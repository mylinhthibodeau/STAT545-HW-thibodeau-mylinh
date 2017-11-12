suppressMessages(library(tidyverse))
setwd("~/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/")
mut_sig <- read.table("mut_sig.tsv", header = TRUE, sep ="\t")
mut_sig_v2 <- mut_sig %>%
	group_by(Substitution.Type, Trinucleotide, Somatic.Mutation.Type) %>%
	gather(key = Signature, value = Score, Signature.1A, Signature.1B, Signature.2, Signature.3, Signature.4, Signature.5, Signature.6, Signature.7, Signature.8, Signature.9, Signature.10, Signature.11, Signature.12, Signature.13, Signature.14, Signature.15, Signature.16, Signature.17, Signature.18, Signature.19, Signature.20, Signature.21, Signature.R1, Signature.R2, Signature.R3, Signature.U1, Signature.U2)
write_tsv(mut_sig_v2, "mut_sig_v2.tsv")
pancreas_mut <- read.table("somatic_mutations_formated_files/pancreas_mut.tsv", header = TRUE, sep = "\t")
pancreas_mut_v2 <- pancreas_mut %>%
	group_by(Mutation.Type) %>%
	gather(key=case_id, value =  number, APGI_1839:APGI_2353) 
write_tsv(pancreas_mut_v2, "somatic_mutations_formated_files/pancreas_mut_v2.tsv")