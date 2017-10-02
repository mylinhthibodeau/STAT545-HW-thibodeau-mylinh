# README - stat545-hw3-thibodeau-mylinh

# FOLDERS - SUMMARY 

- Homework 3 Rmd file [HERE](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/blob/master/stat545-hw3-thibodeau-mylinh/stat545-hw03-thibodeau-mylinh.Rmd)
- Homework 3 Md file [HERE](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/blob/master/stat545-hw3-thibodeau-mylinh/stat545-hw03-thibodeau-mylinh.md)

*** 

### Genomic dataset - A few clarifications

* I have tried to introduce some basic explanations about the genomic dataset, but obviously, this is not a genetics course and my objective is to explore and learn how to use R and its packages, not to teach complex notions of cancer genomic analysis. Therefore, I don't expect people to understand what the data and plots represent if they haven't studied in related fields. 
* I would recommend you make abstraction of the underlying biological context and simply try to read this homework based on the variable types (e.g. copy.category is a categorical variable like "gain" or "loss") rather than what they represent.

*SOURCE OF DATA - supplementary files of published article*
Thibodeau, M. L. et al. Genomic profiling of pelvic genital type leiomyosarcoma in a woman with a germline CHEK2:c.1100delC mutation and a concomitant diagnosis of metastatic invasive ductal breast carcinoma. Cold Spring Harb Mol Case Stud mcs.a001628 (2017). doi:10.1101/mcs.a001628  
Open access article and data available [here](http://molecularcasestudies.cshlp.org/content/3/5/a001628.long)  

***

# Summary of homework 3 process  

I annotated quite extensively my homework 3, and it reads fairly like a narrative. Therefore, I will not repeat the same information here and will provide a brief overview of my learning process instead.


## Wow, this was much harder than I expected

Vincenzo Coia has approved my request to use published genomic data for the homework assignments, but it revealed much longer and harduous than I expected. First, there are more online examples of dplyr and ggplot functions on the gapminder dataset than on the type of data I used. Second, the data table I used had more rows (almost 20,000 originally) and it sometimes made R/RStudio crash down. Third, my data table had some missing values, which created some challenges that required a lot of time identify and troubleshoot. 

However, overall, what I learned will be so much more useful for my research in cancer genomics than working with the Gapminder dataset. 

## Newly acquired skills or knowledge

1. Better use of kabble to create tables
2. Deeper understanding of summarize(), arrange(), mutate(), select() and group_by()
3. I installed the packages "labels" and learned how to use some ggplot functions (e.g. geom_bar) with useful labels such as percentages to represent relative proportions.
4. I have read a lot a lot a lot of different resources online, including useful stackoverflow discussions, and I have put all the links in my homework.
5. I have learned a lof from the peer review process in this course, so I thank all the students for participating in this great group learning experience !!


