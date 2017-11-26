# clean and format the reference mutational signature file 
mut_sig <- read.table("stat547-hw7-thibodeau-mylinh/mut_sig_raw.txt", header = TRUE, sep = "\t")
write.table(mut_sig, "mut_sig.tsv", quote = FALSE, sep = "\t", row.names = FALSE)

# clean and format the cancer specific mutational signature files
#setwd("~/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/ftp.sanger.ac.uk/pub/cancer/AlexandrovEtAl/mutational_catalogs/genomes")
ALL_mut <- read.table("~/Desktop/ftp.sanger.ac.uk/pub/cancer/AlexandrovEtAl/mutational_catalogs/genomes/ALL/ALL_genomes_mutational_catalog_96_subs.txt", header=TRUE, sep="\t")
aml_mut <- read.table("~/Desktop/ftp.sanger.ac.uk/pub/cancer/AlexandrovEtAl/mutational_catalogs/genomes/AML/AML_genomes_mutational_catalog_96_subs.txt", header=TRUE, sep="\t")
breast_mut <- read.table("~/Desktop/ftp.sanger.ac.uk/pub/cancer/AlexandrovEtAl/mutational_catalogs/genomes/Breast/Breast_genomes_mutational_catalog_96_subs.txt", header=TRUE, sep="\t")
medullo_mut <- read.table("~/Desktop/ftp.sanger.ac.uk/pub/cancer/AlexandrovEtAl/mutational_catalogs/genomes/Medulloblastoma/Medulloblastoma_genomes_mutational_catalog_96_subs.txt", header=TRUE, sep="\t")
pancreas_mut <- read.table("~/Desktop/ftp.sanger.ac.uk/pub/cancer/AlexandrovEtAl/mutational_catalogs/genomes/Pancreas/Pancreas_genomes_mutational_catalog_96_subs.txt", header=TRUE, sep="\t")

#setwd("~/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/somatic_mutations_formated_files")
write.table(ALL_mut, "~/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/somatic_mutations_formated_files/ALL_mut.tsv", quote = FALSE, sep = "\t", row.names = FALSE)
write.table(aml_mut, "~/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/somatic_mutations_formated_files/aml_mut.tsv", quote = FALSE, sep = "\t", row.names = FALSE)
write.table(breast_mut, "~/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/somatic_mutations_formated_files/breast_mut.tsv", quote = FALSE, sep = "\t", row.names = FALSE)
write.table(medullo_mut, "~/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/somatic_mutations_formated_files/medulloblastoma_mut.tsv", quote = FALSE, sep = "\t", row.names = FALSE)
write.table(pancreas_mut, "~/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/somatic_mutations_formated_files/pancreas_mut.tsv", quote = FALSE, sep = "\t", row.names = FALSE)