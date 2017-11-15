all: summary_file.html

mut_sig_raw.txt:
	curl -o mut_sig_raw.txt ftp://ftp.sanger.ac.uk/pub/cancer/AlexandrovEtAl/signatures.txt

mut_sig.tsv ALL_sig.tsv aml_sig.tsv breast_mut.tsv medulloblastoma_sig.tsv pancreas_mut.tsv: mut_sig_raw.txt
	Rscript read_clean_genome_text_files.R
	#rm mut_sig_raw.txt
	
ref_mut_sig_ordered_by_sig3.rds: mut_sig.tsv mut_sig_reorder.R
	Rscript mut_sig_reorder.R

mut_sig_gather.tsv ALL_mut_gather.tsv aml_mut_gather.tsv breast_mut_gather.tsv medulloblastoma_mut_gather.tsv pancreas_mut_gather.tsv all_cancer_types_mut.tsv all_cancer_types_mut_with_ref_sig.tsv all_cancer_types_mut_proportion_signatures.tsv all_cancer_types_mut_with_ref_sig_fraction.tsv: mut_sig.tsv ALL_sig.tsv aml_sig.tsv breast_mut.tsv medulloblastoma_sig.tsv pancreas_mut.tsv 
	Rscript mut_sig_tables.R

all_cancer_types_stats.tsv aml_mut_gather_stat_Mutation.Type.tsv breast_mut_gather_stat_Mutation.Type.tsv medullo_mut_gather_stat_Mutation.Type.tsv pancreas_mut_gather_stat_Mutation.Type.tsv: aml_mut_gather.tsv breast_mut_gather.tsv medulloblastoma_mut_gather.tsv pancreas_mut_gather.tsv 
	Rscript mut_sig_stat.R

Signature3_compare_plots.pdf mutation_scores_for_all_snv_facet_signature.pdf mutation_scores_for_all_snv_type_facet_signature.pdf ALL_mut_p1.pdf aml_mut_p1.pdf breast_mut_p1.pdf pancreas_mut_p1.pdf medullo_mut_p1.pdf cancer_type_sig_compare_plots.pdf all_cancer_types_mut_geompoint.pdf p1_linear_Sig3_aml_mutations.pdf p2_linear_Sig3_all_cancer_mutations.pdf p3_linear_Sig3_Sig12.pdf p4_linear_Sig3_Sig12_no_T_C.pdf p5_linear_Sig2_Sig13.pdf: mut_sig.tsv mut_sig_gather.tsv all_cancer_types_mut.tsv ref_mut_sig_ordered_by_sig3.rds ALL_mut_gather_stat_Mutation.Type.tsv aml_mut_gather_stat_Mutation.Type.tsv breast_mut_gather_stat_Mutation.Type.tsv medullo_mut_gather_stat_Mutation.Type.tsv pancreas_mut_gather_stat_Mutation.Type.tsv ref_mut_sig_ordered_by_sig3.rds mut_sig_plot.R 
	Rscript mut_sig_plot.R

summary_file.html: all_cancer_types_stats.tsv mut_sig.tsv mut_sig_gather.tsv all_cancer_types_mut.tsv all_cancer_types_mut_with_ref_sig.tsv all_cancer_types_mut_proportion_signatures.tsv all_cancer_types_mut_with_ref_sig_fraction.tsv mut_sig_gather.tsv ALL_mut_gather.tsv aml_mut_gather.tsv breast_mut_gather.tsv medulloblastoma_mut_gather.tsv pancreas_mut_gather.tsv
	Rscript -e 'rmarkdown::render("summary_file.Rmd")'
	
#clean:
	#rm -f mut_sig_raw.txt

#.PHONY: all clean
#.DELETE_ON_ERROR:
#.SECONDARY:	