# README - stat547-hw6-thibodeau-mylinh

# IN PROGRESS

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

I found a few stack overflow discussions on this topic, it seems like I am not the only one experiencing issues with this package and trying to knitr either to an md or a pdf document. Here are some references: [discuss pdflatex](https://stackoverflow.com/questions/25856362/pandoc-document-conversion-failed-with-error-43-pdflatex-the-memory-dump-file), discuss update of markdown [here](http://rmarkdown.rstudio.com/tufte_handout_format.html#comment-1582377678) with `devtools::install_github("rstudio/rmarkdown")`. All of these solutions suggested online did not allow knitr to reach completion, neither for pdf nor html (which would be required to see the stringr view output). 

I ended up using [this suggestion here](https://stackoverflow.com/questions/25856362/pandoc-document-conversion-failed-with-error-43-pdflatex-the-memory-dump-file), which seemed to resolve the problems above with the yaml as followed:
```
title: "stat547-hw06-thibodeau-mylinh"
output:  
pdf_document: 
    latex_engine: xelatex
```

Other resources of information: [here](https://support.rstudio.com/hc/en-us/articles/200532247) on Sweave/pdf latex, [here](https://support.rstudio.com/hc/en-us/articles/200552056-Using-Sweave-and-knitr) on knitr, and [here](http://rmarkdown.rstudio.com/pdf_document_format.html) on yaml format.

What did not work?

* Then I also had Pandoc error 67, and [this stack overflow discussion](https://stackoverflow.com/questions/41284863/pandoc-document-conversion-failed-with-error-67). I still don't know what that one was about, but most of the time, I was getting "error 43"
* I was trying to also be able to see the stringr "view" output, and this stack overflow discussion [here](https://stackoverflow.com/questions/43440383/include-viewer-output-in-pdf) suggested to use `always_allow_html: yes`, but that did not work for me.

## Newly acquired skills or knowledge

Below are some examples of things I learned, but the list is not exhaustive as I have detailed my process comments inside my homework 6.

1. Manipulate character data. I completed the first assignment with stringr, which took a very long time as the list of exercises is quite exhaustive. I have learned many functions of stringr.
2. Stringr and view functions. In order for the peer reviewers to see the output of these functions, they need to look at the pdf I created or to clone my repository to see the html file.
3. SSL certificate and downloading data from internet. I have learned that curl is required for this type of tasks, which led me to learn some Unix bash command to update curl and finally found out that the issue is sometimes a problem at the source (the GDC database in my case).
4. Nested lists are difficult to manipulate: tibbles and data frames are so much better.
