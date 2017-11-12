# clean tab separated format for easier data manipulation
setwd("/Users/mylinh/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/ftp.sanger.ac.uk/pub/cancer/AlexandrovEtAl/somatic_mutation_data")
mut_ALL <- read.table("ALL/ALL_clean_somatic_mutations_for_signature_analysis.txt", col.names = c("sample", "type", "chr", "start", "end", "ref", "alt", "note"), sep="\t")
mut_aml <- read.table("AML/AML_clean_somatic_mutations_for_signature_analysis.txt", col.names = c("sample", "type", "chr", "start", "end", "ref", "alt", "note"), sep="\t")
mut_breast <- read.table("Breast/Breast_clean_somatic_mutations_for_signature_analysis_apr15.txt", col.names = c("sample", "type", "chr", "start", "end", "ref", "alt", "note"), sep="\t")
mut_crc <- read.table("Colorectum/Colorectum_clean_somatic_mutations_for_signature_analysis.txt", col.names = c("sample", "type", "chr", "start", "end", "ref", "alt", "note"), sep="\t")
mut_gbm <- read.table("glioblastoma/Glioblastoma_clean_somatic_mutations_for_signature_analysis.txt", col.names = c("sample", "type", "chr", "start", "end", "ref", "alt", "note"), sep="\t")

setwd("/Users/mylinh/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/somatic_mutations_formated_files")
write.table(mut_ALL, "mut_ALL.tsv", quote = FALSE, sep = "\t", row.names = FALSE)
write.table(mut_aml, "mut_aml.tsv", quote = FALSE, sep = "\t", row.names = FALSE)
write.table(mut_breast, "mut_breast.tsv", quote = FALSE, sep = "\t", row.names = FALSE)
write.table(mut_crc, "mut_crc.tsv", quote = FALSE, sep = "\t", row.names = FALSE)
write.table(mut_gbm, "mut_gbm.tsv", quote = FALSE, sep = "\t", row.names = FALSE)