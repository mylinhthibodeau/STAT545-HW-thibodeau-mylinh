all: mut_sig_plot.html

mut_sig_raw.txt:
	curl -o mut_sig_raw.txt ftp://ftp.sanger.ac.uk/pub/cancer/AlexandrovEtAl/signatures.txt

mut_sig.tsv: mut_sig_raw.txt
	Rscript mut_sig_clean.R

mut_sig_ordered_by_sig3.rds: mut_sig.tsv mut_sig_reorder.Rmd
	Rscript -e 'rmarkdown::render("mut_sig_reorder.Rmd")'

mut_sig_plot.html: mut_sig.tsv mut_sig_plot.Rmd
	Rscript -e 'rmarkdown::render("mut_sig_plot.Rmd")'