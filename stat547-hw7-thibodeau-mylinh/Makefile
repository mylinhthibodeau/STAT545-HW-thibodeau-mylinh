all: mut_sig_plot.html 

clean:
	rm -f mut_sig_raw.txt mut_sig.tsv mut_sig_gather.tsv mut_sig_ordered_by_sig3.rds mut_sig_plot.html

mut_sig_raw.txt:
	curl -o mut_sig_raw.txt ftp://ftp.sanger.ac.uk/pub/cancer/AlexandrovEtAl/signatures.txt

pancreas_mut.tsv mut_sig.tsv: mut_sig_raw.txt
	Rscript read_clean_genome_text_files.R
	
ref_mut_sig_ordered_by_sig3.rds: mut_sig.tsv mut_sig_reorder.R
	Rscript mut_sig_reorder.R

mut_sig_gather.tsv ALL_mut_gather.tsv aml_mut_gather.tsv breast_mut_gather.tsv medulloblastoma_mut_gather.tsv pancreas_mut_gather.tsv:
	Rscript mut_sig_tables.R

ALL_mut_gather_stat_Mutation.Type.tsv aml_mut_gather_stat_Mutation.Type.tsv breast_mut_gather_stat_Mutation.Type.tsv medullo_mut_gather_stat_Mutation.Type.tsv pancreas_mut_gather_stat_Mutation.Type.tsv:
	Rscript mut_sig_stat.R

mut_sig_plot.html: mut_sig.tsv mut_sig_gather.tsv pancreas_mut.tsv pancreas_mut_gather.tsv ref_mut_sig_ordered_by_sig3.rds mut_sig_plot.Rmd 
	Rscript -e 'rmarkdown::render("mut_sig_plot.Rmd")'