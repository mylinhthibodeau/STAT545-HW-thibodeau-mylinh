# README - stat545-hw5-thibodeau-mylinh

# HOMEWORK FILES TO REVIEW

* Homework 5 RMD file [HERE](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/blob/master/stat545-hw5-thibodeau-mylinh/stat545-hw05-thibodeau-mylinh.Rmd) 
* Homework 5 MD file [HERE](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/blob/master/stat545-hw5-thibodeau-mylinh/stat545-hw05-thibodeau-mylinh.md) - That's the one with the plots and the tables ;) 

I have a scratch-space in each subfolder of my repository, which contains manually saved data files or intermediate files to do my homework. It keeps my repository folders more tidy, but please don't feel oblige to look at it because all the information for marking is in the RMD and MD files! The one for this repository is located [here](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat545-hw5-thibodeau-mylinh/scratch-space).

## Some examples of error messages

I thought is could be useful for the future to track some of the error messages that caused me the most trouble:

**EXAMPLE 1.** 

"Error: `f` must be a factor (or character vector)."

EXPLANATION: This happened when I tried to use functions for factors (e.g. forcats::fct_infreq()), but did not convert appropriately the variable to a factor.

**EXAMPLE 2.** 

```{r}
dget("/Users/mylinh/Desktop/chek2-data-trial-stat545/chek2-rna-expression-cnv-data.txt")
```

Error in parse(file = file, keep.source = keep.source) : /Users/mylinh/Desktop/chek2-data-trial-stat545/chek2-rna-expression-cnv-data.txt:1:9: unexpected symbol 1: chr start ^

EXPLANATION: I believe this issue arise from the fact that the column names have spaces and dget doesn't know how to deal with white spaces. 

**EXAMPLE 3.** 

```{r}
chek2_rna_cnv_f <- read_table2("/Users/mylinh/Desktop/chek2-data-trial-stat545/chek2-rna-expression-cnv-data.txt")
```

**Partial error message pasted below**

Duplicated column names deduplicated: 'copy' => 'copy_1' [12], 'avg' => 'avg_1' [16], 'cna' => 'cna_1' [17], 'gene' => 'gene_1' [19], 'SARC' => 'SARC_1' [32], 'avg' => 'avg_2' [37], 'percentile' => 'percentile_1' [39]

EXPLANATION: I believe that read_table2() also has problems dealing with white spaces: it treated the variable "avg TCGA percentile" as 3 columns, and "avg TCGA norm percentile" as 4 columns. So the function attributed numbers to all the columns starting with "avg" (avg_1, avg_2, etc.) and the ones containing "TCGA" (TCGA_1, TCGA_2). The table was filled with NA values and very messy. 

**Therefore, I decided to keep the same functions that works for me at the moment: read.table() and read.delim() from the R Utils Package.**


## Newly acquired skills or knowledge

* I learned how to manipulate factors with base R and with forcats, which then allowed me to reorder data according to factors, and then make better tables and plots.
* I read the tutorial of Jenny Bryan on ggplot2 and how to make plots, and I learned how to create my own colour function in order to pick and chose the colour scale I want for a specific factor. This can become handy for ploting data and make the data more visually pleasing. 
* I have read some online resources on reading tables in R (like this datacamp website [here](https://www.datacamp.com/community/tutorials/r-tutorial-read-excel-into-r)). 
* I have installed the gdata package, but I have not explored all its functions. I am planning to use the read.xls() functions and explore some of its functions to convert file types (e.g. from excel to tsv).
* You can have general information on a library by typing the format: library(help = "tidyverse")
* It is better to use kable and knitr.table.format as rmarkdown with an output: github_document, because when I used html, it changed my formating ! Therefore, I will go back in all my previous documents to change this in order to avoid any additional formating issues. 
* I explored some parameters of knitr::kable, but I am limited by the fact that html output does not look great on github, so I have to use the format markdown, which has limited options compared to html and latex. 
* The following text copied from the stat545 requirement caused problem with pandoc when I tried to have some html format and insert png image: `[Alt text](/path/to/img.png)`. That is because I needed to write the code between `` symbols in order to be able to print the code statement verbatim.
* I reviewed my homework 5 after the class 013 on October 17/2017 because I definitely did not have the [best practices recommended](http://stat545.com/cm013-notes_and_exercises.html) in place. The proof is that I got rid of no less than 12 variables, including data frames and plots. 
