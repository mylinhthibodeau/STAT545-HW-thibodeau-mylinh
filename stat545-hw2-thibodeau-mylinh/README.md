# README - HOMEWORK 2 FOR STAT545
My Linh Thibodeau

I would like your reading to be as pleasant as possible.  
![cat reading](/scratch-space/cat_read.gif)  

***  
## FOLDERS OR FILES IN THIS REPOSITORY
### OUTPUT = github_document  
[gapminder-exploration-phase2-output-github](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat545-hw2-thibodeau-mylinh/gapminder-exploration-phase2-output-github)   
- [gapminder-exploration-phase2-output-github.Rmd](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/blob/master/stat545-hw2-thibodeau-mylinh/gapminder-exploration-phase2-output-github/gapminder-exploration-phase2-output-github.Rmd)  
- [gapminder-exploration-phase2-output-github.md](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/blob/master/stat545-hw2-thibodeau-mylinh/gapminder-exploration-phase2-output-github/gapminder-exploration-phase2-output-github.md)  
- [gapminder-exploration-phase2-output-github_files/figure-markdown_github-ascii_identifiers](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat545-hw2-thibodeau-mylinh/gapminder-exploration-phase2-output-github/gapminder-exploration-phase2-output-github_files/figure-markdown_github-ascii_identifiers)  

### OUTPUT = pdf_document  
[gapminder-exploration-phase2-output-pdf](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat545-hw2-thibodeau-mylinh/gapminder-exploration-phase2-output-pdf)  
- [gapminder-exploration-phase2-output-pdf.Rmd](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/blob/master/stat545-hw2-thibodeau-mylinh/gapminder-exploration-phase2-output-pdf/gapminder-exploration-phase2-output-pdf.Rmd)  
- [gapminder-exploration-phase2.pdf](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/blob/master/stat545-hw2-thibodeau-mylinh/gapminder-exploration-phase2-output-pdf/gapminder-exploration-phase2.pdf)  
- [gapminder-exploration-phase2.tex](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/blob/master/stat545-hw2-thibodeau-mylinh/gapminder-exploration-phase2-output-pdf/gapminder-exploration-phase2.tex)  
- [gapminder-exploration-phase2_files/figure-latex/](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat545-hw2-thibodeau-mylinh/gapminder-exploration-phase2-output-pdf/gapminder-exploration-phase2_files/figure-latex)  

***

## The curse of stubbornness 
Unfortunately, I was born with a curse called stubbornness, which leads me to look for answers relentlessly to the detriment of efficiency. 

For example, I have struggled with the folder organization of git and github repositories, and therefore, when I noted I was not able to add the reading cat gif above, I have to figure out why. Well now I understand that it is better to put my images and git into a [separate folder](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/scratch-space) to keep my workspace clean, and then I can put the path of this space relative to the master origin.

# Summary of homework 2 process  
## Reading, reading, reading  

I have been reading from a lot of different resources in order to learn how to complete this homework on gapminder data exploration and use of tidyverse packages:
- STAT545: course material covered on [class 4](http://stat545.com/cm004_claim-repo-test-drive-rmd.html), [class 5](http://stat545.com/cm005_tidyverse-tibbles.html) and [class 6](http://stat545.com/cm006_tibbles-dplyr-ggplot2.html)  
- Wikipedia: [wiki page on tibble](http://www.sthda.com/english/wiki/tibble-data-format-in-r-best-and-modern-way-to-work-with-your-data)
- RMarkdown [website on LaTeX options](http://rmarkdown.rstudio.com/pdf_document_format.html), which I have [installed](http://tug.org/mactex/), as well as [pandoc website](http://pandoc.org/installing.html), as I thought it might also reveal useful in the future.  
- [Tidyverse website](http://ggplot2.tidyverse.org/reference/)  
- A lot of blogs on the use of tidyverse in data science, for example this one on the [dplyr functions (e.g. select)](https://info201-s17.github.io/book/introduction-to-the-dplyr-package.html), this one on [summarise() function](http://www.datacarpentry.org/R-genomics/04-dplyr.html), this one on [filter combined to grepl function](https://stackoverflow.com/questions/22850026/filtering-row-which-contains-a-certain-string-using-dplyr) and this one on the [join functions](http://www.datacarpentry.org/R-genomics/04-dplyr.html) of dplyr.   

*You might be wondering why I have taken such an interest in reading on novel functions such as grepl and join. The reason is that I need to use R and it's functionalities to carry some genomic data analyses in the short term period.*  

## HOMEWORK 2 - BRIEF NARATIVE  
Please note that the brief narrative below is not exhaustive and you may refer to the Rmd and pdf files for more details.  
### Note: All the work was completed in the [gapminder-exploration-phase2.Rmd](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/blob/master/stat545-hw2-thibodeau-mylinh/gapminder-exploration-phase2.Rmd) file, but please do use this [MUCH prettier pdf knitted file](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/blob/master/stat545-hw2-thibodeau-mylinh/gapminder-exploration-phase2.pdf)  
*Please note that although the hyperlinks are present in the pdf file, I was not able to highlight them in a different colors, so it is nonot obvious to the reader when they are present in the text.*  

1. Review courses notes and material  
2. Reading from diverse resources (see above)    
3. Gapminder data exploration in RStudio  
**Functions explored in more detail**
- characterize the dataset: class(), typeof(), str(), summary(), ncol(), nrow(), dim(), min(), max(), range(), distinct()  
4. Gapminder data manipulation in RStudio  
**Functions explored in more detail**  
- manipulate the data: select(), arrange(), mutate(), filter(), group_by()  
5. Gapminder data - plotting with ggplot2  
**Functions explored in more detail**  
- plot the data: ggplot(), geom_point(), geom_line(), geom_smooth(), facet_wrap(), geom_boxplot(), stat_summary(), geom_freqpoly(), geom_histogram()  
* characterize the dataset: class(), typeof(), str(), summary(), ncol(), nrow(), dim(), min(), max(), range(), distinct()  
4. Gapminder data manipulation in RStudio  
**Functions explored in more detail**   
* manipulate the data: select(), arrange(), mutate(), filter(), group_by()  
5. Gapminder data - plotting with ggplot2  
**Functions explored in more detail**  
* plot the data: ggplot(), geom_point(), geom_line(), geom_smooth(), facet_wrap(), geom_boxplot(), stat_summary(), geom_freqpoly(), geom_histogram()  

## ISSUES - EXAMPLES  
**Here are somes examples of issues or challenges I experienced**  
* I found it challenging to understand the required input for each function. Although the help documentation of RStudio is very helpful, even after reading some help pages (e.g. geom_bar), I still had a hard time to understand the mapping/aes() required.  
* The arrange() function has posed difficulties when dealing with my research dataset. Even after applying it to my data, when I plot my dataset, the data "returns" to being "disorganized" (not ordered according to the column specified).  
* I found it difficult to plot summary statistics and I had to read several blogs and consult diverse websites to understand the basic functions.  
* I sometimes find myself confused about the recommended readings and the optional readings, which may explain why I only realized recently the existence of this very useful [stat545 general homework guideline](http://stat545.com/hw00_homework-guidelines.html). Although it is recommended to knitr the Rmd file to a github_document output, since I had already completed a one with pdf_document output, I decided to keep both versions for learning purposes.  
