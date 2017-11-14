setwd("~/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/")
#library
suppressMessages(suppressWarnings(library(tidyverse)))
#suppressWarnings(suppressMessages(library(knitr)))
#suppressWarnings(suppressMessages(library(kableExtra)))
#suppressWarnings(options(knitr.table.format = "markdown"))
#suppressMessages(suppressWarnings(library(dplyr)))

# stats for each cancer type
ALL_mut_gather <- read.table("/Users/mylinh/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/somatic_mutations_formated_files/ALL_mut_gather.tsv", header = TRUE, sep = "\t")
aml_mut_gather <- read.table("/Users/mylinh/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/somatic_mutations_formated_files/aml_mut_gather.tsv", header = TRUE, sep = "\t")
breast_mut_gather <- read.table("/Users/mylinh/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/somatic_mutations_formated_files/breast_mut_gather.tsv", header = TRUE, sep = "\t")
medullo_mut_gather <- read.table("/Users/mylinh/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/somatic_mutations_formated_files/medulloblastoma_mut_gather.tsv", header = TRUE, sep = "\t")
pancreas_mut_gather <- read.table("/Users/mylinh/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/somatic_mutations_formated_files/pancreas_mut_gather.tsv", header = TRUE, sep = "\t")

# There is only one dataset in ALL, so its not as useful to perform "statistical analyses" on it, but just for completeness, I will include it anyway.
# Let's start by looking at the average mutation number for each case_id
ALL_mut_gather_stat_case_id <- ALL_mut_gather %>% 
	group_by(case_id) %>%
	summarize(mean = mean(number), median = median(number), sd = sd(number)) 
write_tsv(ALL_mut_gather_stat_case_id, "statistics/ALL_mut_gather_stat_case_id.tsv")

aml_mut_gather_stat_case_id <- aml_mut_gather %>% 
	group_by(case_id) %>%
	summarize(mean = mean(number), median = median(number), sd = sd(number)) 
write_tsv(aml_mut_gather_stat_case_id, "statistics/aml_mut_gather_stat_case_id.tsv")

breast_mut_gather_stat_case_id <- breast_mut_gather %>% 
	group_by(case_id) %>%
	summarize(mean = mean(number), median = median(number), sd = sd(number)) 
write_tsv(breast_mut_gather_stat_case_id, "statistics/breast_mut_gather_stat_case_id.tsv")

medullo_mut_gather_stat_case_id <- medullo_mut_gather %>% 
	group_by(case_id) %>%
	summarize(mean = mean(number), median = median(number), sd = sd(number)) 
write_tsv(medullo_mut_gather_stat_case_id, "statistics/medullo_mut_gather_stat_case_id.tsv")

pancreas_mut_gather_stat_case_id <- pancreas_mut_gather %>% 
	group_by(case_id) %>%
	summarize(mean = mean(number), median = median(number), sd = sd(number)) 
write_tsv(pancreas_mut_gather_stat_case_id, "statistics/pancreas_mut_gather_stat_case_id.tsv")

# Then let's look at the average mutation number for each Mutation.Type in each cancer dataset

ALL_mut_gather_stat_Mutation.Type <- ALL_mut_gather %>% 
	group_by(Mutation.Type) %>%
	summarize(mean = mean(number), median = median(number), sd = sd(number)) 
write_tsv(ALL_mut_gather_stat_Mutation.Type, "statistics/ALL_mut_gather_stat_Mutation.Type.tsv")

aml_mut_gather_stat_Mutation.Type <- aml_mut_gather %>% 
	group_by(Mutation.Type) %>%
	summarize(mean = mean(number), median = median(number), sd = sd(number)) 
write_tsv(aml_mut_gather_stat_Mutation.Type, "statistics/aml_mut_gather_stat_Mutation.Type.tsv")

breast_mut_gather_stat_Mutation.Type <- breast_mut_gather %>% 
	group_by(Mutation.Type) %>%
	summarize(mean = mean(number), median = median(number), sd = sd(number)) 
write_tsv(breast_mut_gather_stat_Mutation.Type, "statistics/breast_mut_gather_stat_Mutation.Type.tsv")

medullo_mut_gather_stat_Mutation.Type <- medullo_mut_gather %>% 
	group_by(Mutation.Type) %>%
	summarize(mean = mean(number), median = median(number), sd = sd(number)) 
write_tsv(medullo_mut_gather_stat_Mutation.Type, "statistics/medullo_mut_gather_stat_Mutation.Type.tsv")

pancreas_mut_gather_stat_Mutation.Type <- pancreas_mut_gather %>% 
	group_by(Mutation.Type) %>%
	summarize(mean = mean(number), median = median(number), sd = sd(number)) 
write_tsv(pancreas_mut_gather_stat_Mutation.Type, "statistics/pancreas_mut_gather_stat_Mutation.Type.tsv")


# I tried to use a nested data frame and a loop to perform the statistical analyses for all 5 datasets at the same time, 
# but I was unable to figure out how to generate summary stat files with different names (aka, each iteration of loop overwrites the previous one)

'
all_cancer_types_gather_nested <- list(ALL_mut_gather, aml_mut_gather, breast_mut_gather, medullo_mut_gather, pancreas_mut_gather)
for (i in seq(1, length(all_cancer_types_gather_nested))){
	d <- as.data.frame(all_cancer_types_gather_nested[i])
	d_group <- d %>% group_by(Mutation.Type)
	some_stat <- d_group %>%
		summarize(mean = mean(number), median = median(number), sd = sd(number))
	write_tsv(some_stat, "statistics/cancer_dataset_stat.tsv")
	#print(some_stat)
	#print(head(d_group))
}	
'

# Linear regression - use broom package

fit <- lm(mpg ~ wt + qsec, mtcars)
summary(fit)
