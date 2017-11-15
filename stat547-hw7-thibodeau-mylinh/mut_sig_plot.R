# set working directory
setwd("~/Desktop/STAT545-HW-thibodeau-mylinh/stat547-hw7-thibodeau-mylinh/")

# get library/packages
suppressMessages(suppressWarnings(library(tidyverse)))
suppressMessages(suppressWarnings(knitr::opts_chunk$set(fig.width=13, fig.height=8)))
suppressMessages(suppressWarnings(library(ggpmisc)))
suppressMessages(suppressWarnings(library(nnls)))
library(devtools)
suppressMessages(suppressWarnings(library(forcats)))
library(ggthemes)
library(grid)

# read the tables needed for plots
mut_sig <- read.table("mut_sig.tsv", header = TRUE, sep = "\t")
ref_mut_sig_ordered_by_sig3 <- readRDS("somatic_mutations_formated_files/ref_mut_sig_ordered_by_sig3.rds")
mut_sig_gather <- read.table("mut_sig_gather.tsv", header = TRUE, sep="\t")
ALL_mut_gather <- read.table("somatic_mutations_formated_files/ALL_mut_gather.tsv", header = TRUE, sep = "\t")
aml_mut_gather <- read.table("somatic_mutations_formated_files/aml_mut_gather.tsv", header = TRUE, sep = "\t")
breast_mut_gather <- read.table("somatic_mutations_formated_files/breast_mut_gather.tsv", header = TRUE, sep = "\t")
medullo_mut_gather <- read.table("somatic_mutations_formated_files/medulloblastoma_mut_gather.tsv", header = TRUE, sep = "\t")
pancreas_mut_gather <- read.table("somatic_mutations_formated_files/pancreas_mut_gather.tsv", header = TRUE, sep = "\t")
all_cancer_types_mut <- read.table("somatic_mutations_formated_files/all_cancer_types_mut.tsv", header = TRUE, sep = "\t")
all_cancer_types_mut_with_ref_sig <- read.table("somatic_mutations_formated_files/all_cancer_types_mut_with_ref_sig.tsv", sep = "\t", header = TRUE)

# Note. The multiplot_function was taken from the R cookbook: http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
	require(grid)
	
	# Make a list from the ... arguments and plotlist
	plots <- c(list(...), plotlist)
	
	numPlots = length(plots)
	
	# If layout is NULL, then use 'cols' to determine layout
	if (is.null(layout)) {
		# Make the panel
		# ncol: Number of columns of plots
		# nrow: Number of rows needed, calculated from # of cols
		layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
			ncol = cols, nrow = ceiling(numPlots/cols))
	}
	
	if (numPlots==1) {
		print(plots[[1]])
		
	} else {
		# Set up the page
		grid.newpage()
		pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
		
		# Make each plot, in the correct location
		for (i in 1:numPlots) {
			# Get the i,j matrix positions of the regions that contain this subplot
			matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
			
			print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
				layout.pos.col = matchidx$col))
		}
	}
}

# PLOT

## Plot 1

Signature3_plot_unordered <- mut_sig %>%
	group_by(Somatic.Mutation.Type) %>%
	ggplot(aes(x=Somatic.Mutation.Type, y=Signature.3)) +
	ggtitle("Unordered Somatic.Mutation.Type according to Signature.3 score") +
	geom_point(aes(size = Signature.12)) + theme(
		plot.title= element_text(color = "grey44", size=24, face="bold"),
		text = element_text(size=8), axis.text.x = element_text(angle=45, hjust=1))
Signature3_plot <- ref_mut_sig_ordered_by_sig3 %>%
	group_by(Somatic.Mutation.Type) %>%
	ggplot(aes(x=Somatic.Mutation.Type, y=Signature.3)) +
	ggtitle("Ordered Somatic.Mutation.Type according to Signature.3 score") +
	geom_point(aes(size = Signature.12)) + theme(
		plot.title= element_text(color = "grey44", size=24, face="bold"),
		text = element_text(size=8), axis.text.x = element_text(angle=45, hjust=1))
pdf("plots/Signature3_compare_plots.pdf", width = 13, height = 7)
multiplot(Signature3_plot_unordered, Signature3_plot) 
dev.off()

# Note (for code above). I was able to save the output of the multiplot function to a pdf file based on the suggestion of this Stack overflow discussion: https://stackoverflow.com/questions/11721401/r-save-multiplot-to-file

# Ploting data from the reference table of somatic signatures

## Plot 2

mut_sig_facet <- mut_sig_gather %>%
	group_by(Signature) %>%
	ggplot(aes(x=Somatic.Mutation.Type, y=Score)) + 
	geom_point(aes(color=Score)) +
	scale_colour_gradient(low="blue", high="red") +
	facet_wrap(~Signature) +
	ggtitle("Mutation scores according to Somatic.Mutation.Type and panel according to Signature type") + 
	theme(
		plot.title= element_text(color = "grey44", size=24, face="bold"),
		text = element_text(size=12), axis.text.x = element_blank(), 
		axis.ticks.x=element_blank(),
		panel.background = element_rect(fill = "white"),
		panel.border = element_rect(fill=NA))
ggsave("plots/mutation_scores_for_all_snv_facet_signature.pdf", mut_sig_facet, width = 16, height =12) 

## Plot 3

mut_sig_sub <- mut_sig_gather %>%
	group_by(Substitution.Type) %>%
	ggplot(aes(x=Somatic.Mutation.Type, y=Score)) +
	geom_point(aes(color=Substitution.Type)) +
	ggtitle("Mutation scores according to individual signatures") + 
	theme(
		plot.title= element_text(color = "grey44", size=24, face="bold"),
		text = element_text(size=12), axis.text.x = element_blank(), 
		axis.ticks.x=element_blank(),
		panel.background = element_rect(fill = "white"),
		panel.border = element_rect(fill=NA)) +
	facet_wrap(~Signature) 
ggsave("plots/mutation_scores_for_all_snv_type_facet_signature_colored_snv.pdf", mut_sig_sub, width = 10, height =6) 

# Ploting data from specific cancer types and their somatic mutations

## Plot ALL 
# Note. There is only one case_id in this dataset, so it doesn't make for a very interesting plot. We will focus on the 4 other datasets in this homework.

ALL_mut_p1 <- ALL_mut_gather %>%
	#group_by(case_id) %>%
	ggplot(aes(x=Mutation.Type, y=number)) +
	geom_point(aes(colour=case_id)) +
	ggtitle("Acute lymphoid leukemia - Number of mutations per signatures") + 
	theme(
		plot.title= element_text(color = "grey44", size=24, face="bold"),
		text = element_text(size=10), axis.text.x = element_text(angle=45, hjust=1), 
		axis.ticks.x=element_blank(), 
		panel.background = element_rect(fill = "white"),
		panel.border = element_rect(fill=NA))
ggsave("plots/ALL_mut_p1.pdf", ALL_mut_p1 , width = 18, height =8)

## Plot aml

aml_mut_p1 <- aml_mut_gather %>%
	#group_by(case_id) %>%
	ggplot(aes(x=Mutation.Type, y=number)) +
	geom_point(aes(colour=case_id)) +
	ggtitle("Acute myeloid leukemia - Number of mutations per signatures") + 
	theme(
		plot.title= element_text(color = "grey44", size=24, face="bold"),
		text = element_text(size=10), axis.text.x = element_text(angle=45, hjust=1), 
		axis.ticks.x=element_blank(), 
		panel.background = element_rect(fill = "white"),
		panel.border = element_rect(fill=NA))
ggsave("plots/aml_mut_p1.pdf", aml_mut_p1 , width = 18, height =8)

## Plot breast cancer

breast_mut_p1 <- breast_mut_gather %>%
	#group_by(case_id) %>%
	ggplot(aes(x=Mutation.Type, y=number)) +
	geom_point(aes(colour=case_id)) +
	ggtitle("Breast cancer - Number of mutations per signatures") + 
	theme(
		plot.title= element_text(color = "grey44", size=24, face="bold"),
		text = element_text(size=10), axis.text.x = element_text(angle=45, hjust=1), 
		axis.ticks.x=element_blank(), 
		panel.background = element_rect(fill = "white"),
		panel.border = element_rect(fill=NA))
ggsave("plots/breast_mut_p1.pdf", breast_mut_p1,  width = 18, height =8)

## Plot medulloblastoma cancer

medullo_mut_p1 <- medullo_mut_gather %>%
	#group_by(case_id) %>%
	ggplot(aes(x=Mutation.Type, y=number)) +
	geom_point(aes(colour=case_id)) +
	ggtitle("Medulloblastoma - Number of mutations per signatures") + 
	theme(
		plot.title= element_text(color = "grey44", size=24, face="bold"),
		text = element_text(size=10), axis.text.x = element_text(angle=45, hjust=1), 
		axis.ticks.x=element_blank(), 
		panel.background = element_rect(fill = "white"),
		panel.border = element_rect(fill=NA))
ggsave("plots/medullo_mut_p1.pdf", medullo_mut_p1 , width = 18, height =8)

## Plot pancreas cancer

pancreas_mut_p1 <- pancreas_mut_gather %>%
	#group_by(case_id) %>%
	ggplot(aes(x=Mutation.Type, y=number)) +
	geom_point(aes(colour=case_id)) +
	ggtitle("Pancreas cancer - Number of mutations per signatures") + 
	theme(
		plot.title= element_text(color = "grey44", size=24, face="bold"),
		text = element_text(size=10), axis.text.x = element_text(angle=45, hjust=1), 
		axis.ticks.x=element_blank(), 
		panel.background = element_rect(fill = "white"),
		panel.border = element_rect(fill=NA))
ggsave("plots/pancreas_mut_p1.pdf", pancreas_mut_p1 , width = 18, height = 8)

## Plot - multiplot

pdf("plots/cancer_type_sig_compare_plots.pdf", width = 30, height = 22)
multiplot(ALL_mut_p1, aml_mut_p1, breast_mut_p1, medullo_mut_p1, pancreas_mut_p1) 
dev.off()

# Note. I have joined the datasets with the mut_sig_tables.R script to perform some group analysis.
## Plot - take a peak at different cancer type

pdf("plots/all_cancer_types_mut_geompoint.pdf", width = 13, height = 9)
all_cancer_types_mut %>%
	group_by(cancer_type) %>%
	ggplot(aes(x=Mutation.Type, y = number)) +
	geom_point(aes(colour=cancer_type), shape=21, alpha = 0.8) +
	ggtitle("Number of mutations according to individual Mutation.Type") + 
	theme(
		plot.title= element_text(color = "grey44", size=24, face="bold"),
		text = element_text(size=10),
		axis.text.x = element_text(angle=45, hjust=1),
		axis.ticks.x=element_blank(),
		panel.background = element_rect(fill = "white"),
		panel.border = element_rect(fill=NA))
dev.off()

# Linear regression plots
# aml, Signature.3 and Mutation.Type number
formula <- y ~ x
p1_linear <- all_cancer_types_mut_with_ref_sig %>%
	filter(cancer_type == "aml") %>%
	group_by(Mutation.Type) %>%
	ggplot(aes(x=Signature.3, y=number)) +
	geom_point(aes(colour = case_id), shape = 21, alpha = 0.8) +
	facet_wrap(~Substitution.Type) +
	stat_smooth(method="lm", se = FALSE, color="black", formula = formula) +
	stat_poly_eq(aes(label = paste(..eq.label.., ..adj.rr.label.., sep = "~~~~")), label.x.npc = "left",
		formula = formula, parse = TRUE, size = 3,
		geom="label")
ggsave("plots/p1_linear_Sig3_aml_mutations.pdf", p1_linear , width = 18, height = 8) 

# aml, Signature.3 and Mutation.Type number - all cancer
p2_linear <- all_cancer_types_mut_with_ref_sig %>%
	group_by(cancer_type, Mutation.Type) %>%
	ggplot(aes(x=Signature.3, y=number)) +
	geom_point(aes(colour = Substitution.Type), shape = 21, alpha = 0.8) +
	facet_wrap(~cancer_type) +
	stat_smooth(method="lm", se = FALSE, color="black", formula = formula) +
	stat_poly_eq(aes(label = paste(..eq.label.., ..adj.rr.label.., sep = "~~~~")), label.x.npc = "left",
		formula = formula, parse = TRUE, size = 3,
		geom="label")
ggsave("plots/p2_linear_Sig3_all_cancer_mutations.pdf", p2_linear , width = 18, height = 8) 

# Signature.3 and Signature.12
p3_linear <- mut_sig %>%
	ggplot(aes(x=Signature.3, y = Signature.12)) +
	geom_point(aes(colour = Substitution.Type)) +
	stat_smooth(method="lm", se = FALSE, color="black", formula = formula) +
	stat_poly_eq(aes(label = paste(..eq.label.., ..adj.rr.label.., sep = "~~~~")), label.x.npc = "left",
		formula = formula, parse = TRUE, size = 3,
		geom="label")
ggsave("plots/p3_linear_Sig3_Sig12.pdf", p3_linear , width = 18, height = 8) 	

# linear regression would be a better fit - remove the Substitution.Type T>C.
formula <- y ~ x
p4_linear <- mut_sig %>%
	filter(Substitution.Type != "T>C") %>%
	ggplot(aes(x=Signature.3, y = Signature.12)) +
	geom_point(aes(colour = Substitution.Type)) +
	stat_smooth(method="lm", se = FALSE, color="black", formula = formula) +
	stat_poly_eq(aes(label = paste(..eq.label.., ..adj.rr.label.., sep = "~~~~")), label.x.npc = "left",
		formula = formula, parse = TRUE, size = 3,
		geom="label")
ggsave("plots/p4_linear_Sig3_Sig12_no_T_C.pdf", p4_linear , width = 18, height = 8) 

# linear regression Signature.2 and Signature.13

p5_linear <- mut_sig %>%
	ggplot(aes(x=Signature.2, y = Signature.13)) +
	geom_point(aes(colour = Substitution.Type)) +
	stat_smooth(method="lm", se = FALSE, color="black", formula = formula) +
	stat_poly_eq(aes(label = paste(..eq.label.., ..adj.rr.label.., sep = "~~~~")), label.x.npc = "left",
		formula = formula, parse = TRUE, size = 3,
		geom="label")
ggsave("plots/p5_linear_Sig2_Sig13.pdf", p5_linear , width = 18, height = 8) 