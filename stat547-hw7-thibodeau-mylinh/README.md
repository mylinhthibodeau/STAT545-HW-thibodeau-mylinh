# README - stat547-hw7-thibodeau-mylinh

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

Homework 7 repository [HERE](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat547-hw7-thibodeau-mylinh)

* Homework 7 summary RMD file [here](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/blob/master/stat547-hw7-thibodeau-mylinh/summary_file.Rmd)
* Homework 7 produced tables files [here](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat547-hw7-thibodeau-mylinh/somatic_mutations_formated_files)
* Homework 7 plots files [here](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat547-hw7-thibodeau-mylinh/plots)
* Homework 7 stats files [here](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat547-hw7-thibodeau-mylinh/statistics)

I also have Homework 7 summary pdf file [here](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/blob/master/stat547-hw7-thibodeau-mylinh/scratch-space/summary_file.pdf), but the visual is not great, sorry for that, I was more preoccupied by trying to get my pipeline working and ran out of time.

I have a scratch-space in each subfolder of my repository, which contains manually saved data files or intermediate files to do my homework. It keeps my repository folders more tidy. 

### Some issues encoutered during this homework

* Oops, I did it again: I decided to use cancer somatic mutations (and mutational signatures) for this assignment, but I didn't think about the fact that it would be difficult to find a biologically plausible linear regression model to fit the data. Indeed, very much like in [homework 4](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat545-hw4-thibodeau-mylinh), I forgot that the lack of a "time variable" (years in Gapminder) could cause significant issues in trying to complete the exercises.

![square_to_circle](scratch-space/fit_a_square_inside_a_circle.jpg)

Source of image [here](https://www.tlnt.com/the-new-hiring-mantra-finding-candidates-with-great-cultural-fit/)

* I updated to macOS High Sierra v10.13.1 and after that, git had disappeared from RStudio. I found that it seems to installed in two different locations on my computer `/usr/bin/git` and `/usr/local/git/bin/git`. I changed the fit version in preferences to the local version, but svn was only in `usr/bin/` so I am expecting this will create a problem in the short term ... but I unfortunately don't have time to address right now.
* I had this error message: `xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun` when trying to run Build, then I re-installed xcode and it worked. 
* I still don't understand why the clean command of my Makefile doesn't get rid of my intermediate files. 
* I tried to download the full somatic mutation sample data repository of Alexandrov et al (2013) [here](ftp://ftp.sanger.ac.uk/pub/cancer/AlexandrovEtAl/) from the Makefile, but despite trying both wget and curl, it didn't work. I decided to show I could use curl to download the reference signatures set, but I downloaded the rest of the repository data through the command line for further analyses.

* I got the following message so often, and that is because there were always mistakes in my code somewhere.

```
Quitting from lines 10-25 (summary_file.Rmd) 
Error in file(file, "rt") : cannot open the connection
Calls: <Anonymous> ... withCallingHandlers -> withVisible -> eval -> eval -> read.table -> file
Execution halted
make: *** [summary_file.html] Error 1

Exited with status 2.
```

* I never succeeded to clean up my intermediate files with the Makefile. Please (pretty please) don't hesitate to tell me why if you know the reason for this? I tried diverse combinations of this code (and at the beginning vs end) and it never worked out:

```
.PHONY: all clean
.DELETE_ON_ERROR:
.SECONDARY:	

clean:
	rm -f mut_sig_raw.txt 
	rm -f mut_sig_gather.tsv 
	rm -f mut_sig.tsv
```

***

## Newly acquired skills or knowledge

Below are some examples of things I learned, but the list is not exhaustive as I have detailed my process comments inside my homework 7.

1. It's easier to start small before moving on to more complex things. Hopefully, next time, I will plan better before starting coding. 
2. Makefile and how to chain input-output sequences between R scripts. I am still working on becoming familiar with the concept of a Makefile, but I know this skill will be very useful.
3. A simple linear regression is not the best model for the type of data I picked. A non-negative least square linear model would be better, and I looked into it, but ran out of time to learn enough to use it.
4. Never change the path to your files, it is extremely error prone.
5. Ideally, don't code if you are (too) tired, because typos and mistakes get everywhere.
