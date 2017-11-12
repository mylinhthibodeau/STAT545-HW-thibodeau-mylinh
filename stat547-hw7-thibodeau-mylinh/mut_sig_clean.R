# clean and format the mutational signature file 

mut_sig <- read.table("mut_sig_raw.txt", header = TRUE, sep = "\t")
write.table(mut_sig, "mut_sig.tsv", quote = FALSE, sep = "\t", row.names = FALSE)