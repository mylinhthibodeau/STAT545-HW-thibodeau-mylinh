suppressMessages(library(tidyverse))
setwd("~/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/")
mut_sig <- read.table("mut_sig.tsv", header = TRUE, sep ="\t")
mut_sig_gather <- mut_sig %>%
	group_by(Substitution.Type, Trinucleotide, Somatic.Mutation.Type) %>%
	gather(key = Signature, value = Score, Signature.1A, Signature.1B, Signature.2, Signature.3, Signature.4, Signature.5, Signature.6, Signature.7, Signature.8, Signature.9, Signature.10, Signature.11, Signature.12, Signature.13, Signature.14, Signature.15, Signature.16, Signature.17, Signature.18, Signature.19, Signature.20, Signature.21, Signature.R1, Signature.R2, Signature.R3, Signature.U1, Signature.U2)
write_tsv(mut_sig_gather, "mut_sig_gather.tsv")

ALL_mut <- read.table("somatic_mutations_formated_files/ALL_mut.tsv", header = TRUE, sep = "\t")
ALL_mut_gather <- ALL_mut %>%
	group_by(Mutation.Type) %>%
	gather(key=case_id, value =  number, PD4020a) 
write_tsv(ALL_mut_gather, "somatic_mutations_formated_files/ALL_mut_gather.tsv")

aml_mut <- read.table("somatic_mutations_formated_files/aml_mut.tsv", header = TRUE, sep = "\t")
aml_mut_gather <- aml_mut %>%
	group_by(Mutation.Type) %>%
	gather(key=case_id, value =  number, X400220:X869586) 
write_tsv(aml_mut_gather, "somatic_mutations_formated_files/aml_mut_gather.tsv")

breast_mut <- read.table("somatic_mutations_formated_files/breast_mut.tsv", header = TRUE, sep = "\t")
breast_mut_gather <- breast_mut %>%
	group_by(Mutation.Type) %>%
	gather(key=case_id, value =  number, PD3851a:PD8623a) 
write_tsv(breast_mut_gather, "somatic_mutations_formated_files/breast_mut_gather.tsv")

medullo_mut <- read.table("somatic_mutations_formated_files/medulloblastoma_mut.tsv", header = TRUE, sep = "\t")
medullo_mut_gather <- medullo_mut %>%
	group_by(Mutation.Type) %>%
	gather(key=case_id, value =  number, LFS_MB1:MB99) 
write_tsv(medullo_mut_gather, "somatic_mutations_formated_files/medulloblastoma_mut_gather.tsv")

pancreas_mut <- read.table("somatic_mutations_formated_files/pancreas_mut.tsv", header = TRUE, sep = "\t")
pancreas_mut_gather <- pancreas_mut %>%
	group_by(Mutation.Type) %>%
	gather(key=case_id, value =  number, APGI_1839:APGI_2353) 
write_tsv(pancreas_mut_gather, "somatic_mutations_formated_files/pancreas_mut_gather.tsv")

# Let's make a single data frame for all this data
# First, let's mutate each dataset to add a column containing the cancer type name.
ALL_mut_gather_name <- ALL_mut_gather %>%
	mutate(cancer_type = "ALL")
aml_mut_gather_name <- aml_mut_gather %>%
	mutate(cancer_type = "aml")
breast_mut_gather_name <- breast_mut_gather %>%
	mutate(cancer_type = "breast")
medullo_mut_gather_name <- medullo_mut_gather %>%
	mutate(cancer_type = "medullo")
pancreas_mut_gather_name <- pancreas_mut_gather %>%
	mutate(cancer_type = "pancreas")
# We can save these tables to files in case we need them later
write_tsv(ALL_mut_gather_name, "somatic_mutations_formated_files/ALL_mut_gather_name.tsv")
write_tsv(aml_mut_gather_name, "somatic_mutations_formated_files/aml_mut_gather_name.tsv")
write_tsv(breast_mut_gather_name, "somatic_mutations_formated_files/breast_mut_gather_name.tsv")
write_tsv(medullo_mut_gather_name, "somatic_mutations_formated_files/medullo_mut_gather_name.tsv")
write_tsv(pancreas_mut_gather_name, "somatic_mutations_formated_files/pancreas_mut_gather_name.tsv")

# Then let's join the datasets.
all_cancer_types_mut <- list(ALL_mut_gather_name, aml_mut_gather_name, breast_mut_gather_name, medullo_mut_gather_name, pancreas_mut_gather_name) %>%
	Reduce(function(dtf1, dtf2) full_join(dtf1, dtf2,  by = c("Mutation.Type", "case_id", "number", "cancer_type")), .)
write_tsv(all_cancer_types_mut, "somatic_mutations_formated_files/all_cancer_types_mut.tsv") 

# let's join also the signatures 
all_cancer_types_mut_with_ref_sig <- all_cancer_types_mut %>% left_join(mut_sig, by = c("Mutation.Type"="Somatic.Mutation.Type"))
# View(all_cancer_types_mut_with_ref_sig)
write_tsv(all_cancer_types_mut_with_ref_sig, "somatic_mutations_formated_files/all_cancer_types_mut_with_ref_sig.tsv") 

# What would make more sense is actually to multiply the matrices all_cancer_types (mutation numbers/counts) by the signatures
# That way we can find out what proportion of each Mutation.Type "counts" towards a specific mutation signatures.
# We need a table that is "gathered" so that one column corresponds to the Signature
all_cancer_types_mut_with_ref_sig_gather <- all_cancer_types_mut_with_ref_sig %>% 
	group_by(Mutation.Type) %>%
	gather(key=Signature, value = Score, Signature.1A:Signature.U2)

all_cancer_types_mut_with_ref_sig_gather %>% arrange(cancer_type, Mutation.Type) %>% View()

# For now, let's just assume that the Mutation.Type number is proportionally distributed to each signatures
all_cancer_types_mut_proportion_signatures <- all_cancer_types_mut_with_ref_sig_gather %>% arrange(cancer_type, Mutation.Type) %>%
	group_by(Mutation.Type, case_id) %>%
	mutate(proportion_number_each_sig = (Score/sum(Score))*number)
write_tsv(all_cancer_types_mut_proportion_signatures, "somatic_mutations_formated_files/all_cancer_types_mut_proportion_signatures.tsv")

