setwd("~/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/")
#library
suppressMessages(suppressWarnings(library(tidyverse)))
suppressWarnings(suppressMessages(library(knitr)))
suppressWarnings(suppressMessages(library(kableExtra)))
#suppressWarnings(options(knitr.table.format = "markdown"))
# suppressMessages(suppressWarnings(library(dplyr)))

# stats for each cancer type
ALL_mut_gather <- read.table("/Users/mylinh/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/somatic_mutations_formated_files/ALL_mut_gather.tsv", header = TRUE, sep = "\t")
aml_mut_gather <- read.table("/Users/mylinh/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/somatic_mutations_formated_files/aml_mut_gather.tsv", header = TRUE, sep = "\t")
breast_mut_gather <- read.table("/Users/mylinh/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/somatic_mutations_formated_files/breast_mut_gather.tsv", header = TRUE, sep = "\t")
medullo_mut_gather <- read.table("/Users/mylinh/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/somatic_mutations_formated_files/medulloblastoma_mut_gather.tsv", header = TRUE, sep = "\t")
pancreas_mut_gather <- read.table("/Users/mylinh/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/somatic_mutations_formated_files/pancreas_mut_gather.tsv", header = TRUE, sep = "\t")

#breast_mut_gather_group <- breast_mut_gather %>% group_by(case_id)

all_cancer_types_gather_nested <- list(ALL_mut_gather, aml_mut_gather, breast_mut_gather, medullo_mut_gather, pancreas_mut_gather)
# all_cancer_types_gather_nested[2] %>% head()

for (i in seq(1, length(all_cancer_types_gather_nested))){
	d <- as.data.frame(all_cancer_types_gather_nested[i])
	d_group <- d %>% group_by(Mutation.Type)
	some_stat <- d_group %>%
		summarize(mean = mean(number), median = median(number), sd = sd(number))
	write_tsv(some_stat, "statistics/cancer_dataset_stat.tsv")
	#print(some_stat)
	#print(head(d_group))
}	

