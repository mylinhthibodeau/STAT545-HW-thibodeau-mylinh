all: stat545-hw05-thibodeau-mylinh.html

chek2_head.txt:
	head /Users/mylinh/Desktop/chek2-data-trial-stat545/chek2-rna-expression-cnv-data.txt > chek2_head.txt

chek2_tab.txt: chek2_head.txt
	tr -d '\r' <$< >$@

chek2_tab_length.txt: chek2_tab.txt
	awk '{print length}' $< >$@

stat545-hw05-thibodeau-mylinh.html: chek2_tab_length.txt stat545-hw5-thibodeau-mylinh/stat545-hw05-thibodeau-mylinh.Rmd
	Rscript -e 'rmarkdown::render("stat545-hw5-thibodeau-mylinh/stat545-hw05-thibodeau-mylinh.Rmd")'
