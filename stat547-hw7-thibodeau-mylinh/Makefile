all: mut_sig_plot.html 

clean:
	rm -f mut_sig_raw.txt mut_sig.tsv mut_sig_v2.tsv mut_sig_ordered_by_sig3.rds mut_sig_plot.html

mut_sig_raw.txt:
	curl -o mut_sig_raw.txt ftp://ftp.sanger.ac.uk/pub/cancer/AlexandrovEtAl/signatures.txt

mut_sig.tsv: mut_sig_raw.txt
	Rscript mut_sig_clean.R

#mut_ALL.tsv mut_aml.tsv mut_breast.tsv mut_medulloblastoma.tsv mut_pancreas.tsv: 
	#Rscript read_clean_cancer_text_files.R

pancreas_mut_v2.tsv pancreas_mut.tsv:
	Rscript read_clean_genome_text_files.R
	
mut_sig_ordered_by_sig3.rds: mut_sig.tsv mut_sig_reorder.R
	Rscript mut_sig_reorder.R

mut_sig_v2.tsv: mut_sig.tsv mut_sig_tables.R pancreas_mut.tsv pancreas_mut_v2.tsv
	Rscript mut_sig_tables.R
	
mut_sig_plot.html: mut_sig.tsv mut_sig_v2.tsv pancreas_mut.tsv pancreas_mut_v2.tsv mut_sig_ordered_by_sig3.rds mut_sig_plot.Rmd 
	Rscript -e 'rmarkdown::render("mut_sig_plot.Rmd")'