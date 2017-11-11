# README - stat547-hw6-thibodeau-mylinh

# About me

Dear reader,

I hope you will enjoy reading my STAT545/547 homework :) I am a Medical Genetics resident and master student in bioinformatics and my topic of research is cancer genomics. 

I have been trying to find innovative ways to come up with genomic datasets that can fulfill the homework requirements. Please don't get distracted by the specific aspects of genomic terms, but focus on the underlying structure of the data. Genomic data is quite similar to other data types (e.g. gene names are strings, just like the countries of Gapminder).

The Canadian Cancer Research Conference took place in Vancouver from November 5-7/2017 and I unfortunately didn't have as much time as usual to put into this homework (which took a very long time) but I believe I fulfill most of the requirements :)

Thank you for your time!
Regards,
My Linh Thibodeau


# HOMEWORK FILES TO REVIEW

* Homework 6 RMD file [HERE](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/blob/master/stat547-hw6-thibodeau-mylinh/stat547-hw06-thibodeau-mylinh.Rmd)
* Homework 6 PDF file [HERE](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/blob/master/stat547-hw6-thibodeau-mylinh/stat547-hw06-thibodeau-mylinh.pdf) - I was not able to made a "readable" md file because of the stringr view functions and receiving endless error messages, so I have made a pdf for you guys. You can also *clone* my repository and then run the script on your computer, which will allow you to visualize the html output of (latex_engine: xelatex). 

I have a scratch-space in each subfolder of my repository, which contains manually saved data files or intermediate files to do my homework. It keeps my repository folders more tidy. For this specific homework, I also added some data from ontologies to use for illustrating relevant functions in my field of research:

* Gene Ontologies (GO) [here](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat547-hw6-thibodeau-mylinh/GO)
* Human Disease Ontology (DOID) [here](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat547-hw6-thibodeau-mylinh/HumanDiseaseOntology_git)


### Issues with knitr and stringr functions (e.g. str_view()) - I really tried

I got this error message

`! Undefined control sequence.`			
`l.1477 ...lows . to match everything, including \n`			
`pandoc: Error producing PDF`		
`Error: pandoc document conversion failed with error 43`		

I found a few stack overflow discussions on this topic, it seems like I am not the only one experiencing issues with this package and trying to knitr either to an md or a pdf document. Here are some references: [discuss pdflatex](https://stackoverflow.com/questions/25856362/pandoc-document-conversion-failed-with-error-43-pdflatex-the-memory-dump-file), discuss update of markdown [here](http://rmarkdown.rstudio.com/tufte_handout_format.html#comment-1582377678) with:

`devtools::install_github("rstudio/rmarkdown")`. 

All of these solutions suggested online did not allow knitr to reach completion, neither for pdf nor html (which would be required to see the stringr view output). 

I ended up using [this suggestion here](https://stackoverflow.com/questions/25856362/pandoc-document-conversion-failed-with-error-43-pdflatex-the-memory-dump-file), which seemed to resolve the problems above with the yaml as followed:
```
title: "stat547-hw06-thibodeau-mylinh"
output:  
pdf_document: 
    latex_engine: xelatex
```

Other resources of information: [here](https://support.rstudio.com/hc/en-us/articles/200532247) on Sweave/pdf latex, [here](https://support.rstudio.com/hc/en-us/articles/200552056-Using-Sweave-and-knitr) on knitr, and [here](http://rmarkdown.rstudio.com/pdf_document_format.html) on yaml format.

What else did not work?

* Then I also had Pandoc error 67, and [this stack overflow discussion](https://stackoverflow.com/questions/41284863/pandoc-document-conversion-failed-with-error-67). I still don't know what that one was about, but most of the time, I was getting "error 43"
* I was trying to also be able to see the stringr "view" output, and this stack overflow discussion [here](https://stackoverflow.com/questions/43440383/include-viewer-output-in-pdf) suggested to use `always_allow_html: yes`, but that did not work for me.

***

## Newly acquired skills or knowledge

Below are some examples of things I learned, but the list is not exhaustive as I have detailed my process comments inside my homework 6.

1. Manipulate character data: I completed the first assignment with stringr, which took a very long time as the list of exercises is quite exhaustive. I have learned many functions of stringr.
2. Stringr and view functions: To see the output of these functions, you need to look at the pdf I created or to clone my repository to see the html file.
3. SSL certificate and downloading data from internet: I have learned that curl is required for this type of tasks, which led me to learn some Unix bash command to update curl and finally found out that the issue is sometimes a problem at the source (the GDC database in my case).
4. Nested lists are difficult to manipulate: tibbles and data frames are so much better. Try to make your data rectangular as much as possible (even if there is NA/missing values) because nested data appears error prone !
5. R has a new "data frame" format, which is S3 (click [here](http://adv-r.had.co.nz/S3.html) for more information), because from what I understood, it is making an attempt at becoming an object oriented programming language for big data. However, as you probably know, this was not the purpose of R, which was designed as a statistical tool. Python and other programming languages are better suited to deal with more complex data structures. Therefore, I had some limitations in my ability to do the second part of my homework using "real life" data and I would not recommend the use of S3 data type in R because I ran into many unsolvable issues.