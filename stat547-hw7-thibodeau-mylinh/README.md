# README - stat547-hw7-thibodeau-mylinh

# IN PROGRESS

# About me

Dear reader,

I hope you will enjoy reading my STAT545/547 homework :) I am a Medical Genetics resident and master student in bioinformatics and my topic of research is cancer genomics. 

I have been trying to find innovative ways to come up with genomic datasets that can fulfill the homework requirements. Please don't get distracted by the specific aspects of genomic terms, but focus on the underlying structure of the data. Genomic data is quite similar to other data types (e.g. gene names are strings, just like the countries of Gapminder).


Thank you for your time!
Regards,
My Linh Thibodeau

# Source of data

For this homework, I will be using open access complete set of cancer somatic mutations from: 

Alexandrov, L. B. et al. Signatures of mutational processes in human cancer. 500, 415–421 (2013).


# HOMEWORK FILES TO REVIEW

* Homework 7 RMD file 
* Homework 7 MD file 

I have a scratch-space in each subfolder of my repository, which contains manually saved data files or intermediate files to do my homework. It keeps my repository folders more tidy. 

### Some issues encoutered during this homework

* Oops, I did it again: I decided to use cancer somatic mutations (and mutational signatures) for this assignment, but I didn't think about the fact that it would be difficult to find a biologically plausible linear regression model to fit the data. Indeed, very much like in [homework 4](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat545-hw4-thibodeau-mylinh), I forgot that the lack of a "time variable" (years in Gapminder) could cause significant issues in trying to complete the exercises.
* 

***

## Newly acquired skills or knowledge

Below are some examples of things I learned, but the list is not exhaustive as I have detailed my process comments inside my homework 7.

1. It's easier to start small before moving on to more complex things. I missed that point again unfortunately, and it took me a lot a lot a lot of time to do this homework. Hopefully, next time, I will plan better before starting coding.
2. My understanding is that if you have some code that saves output to files in individual scripts, you can not use the "clean" function in the Makefile to clean these files. Clean only applies
