stat547-hw10-thibodeau-mylinh
================
My Linh Thibodeau
2017-11-29

HOMEWORK 10
-----------

In this homework, I will be working with the Online Mendelian Inheritance of Man - [OMIM](https://omim.org/) data as well as previously used merged data from [DECIPHER](http://decipher.sanger.ac.uk), [Orphanet](http://www.orpha.net) and [HGNC](https://www.genenames.org/cgi-bin/statistics) (see references and [homework 8](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat547-hw8-thibodeau-mylinh) for more information)

Extensive information on the OMIM API is available [here](https://omim.org/help/api), but I will provide a few examples of query and functions to query the API.

**IMPORTANT:** This work is adapted from Dave Tang's tutorial on Getting started with the OMIM api [here](https://davetang.org/muse/2015/03/17/getting-started-with-the-omim-api/).

**IMPORTANT:** An alternative method has been used to retrieve the OMIM API data: I mainly used adapted functions instead of `GET()` from the library httr.

**IMPORTANT:** I spent quite a bit of time trying to make some output files that you guys could see while respecting the protected data restriction of the OMIM API. Please install the packages XML and xml2 in order to be able to take a better look at the OMIM API xml output examples in the [data\_sample folder](%22stat547-hw10-thibodeau-mylinh/data_sample%22), and otherwise, I have put some data samples in the homework, but the aesthetic of it is not great.

Homework 10 - summary of process
--------------------------------

Here is the breakdown of requirements and corresponding sections:

-   Get data from API - Section A (part 1, 2, 3, 4, 5) and Section D (part 1)
-   Clean and tidy into dataframes - Section B (part 2) and Section C and Section D (part 2)
-   Save output to files
    -   protected data has been saved under the data folder - not public (e.g. mim2gene\_and\_inheritance\_DDG2P\_hgnc\_orphadata.tsv)
    -   sample data for reviewers saved under [data\_sample folder](%22stat547-hw10-thibodeau-mylinh/data_sample%22)
-   Use httr and `GET()` - Section F contains some examples of API query using httr. A new function using httr and glue is defined.

Section F contains two very brief examples of purrr exploration, but I opted to build on previous work relating to writing functions instead of purrr nested list applications.

The following requirements from hw10 were unclear to me, and I interpreted them as follow:

-   Traverse pages: obtain API data from different API webpages, which has been completed in this homework.
-   Send an authorization token: since this assignment is focused on how to get web data with an API and not on writing an API (which is beyond what is covered in this course), I interpret that this requirement refers to "obtaining an authorization token and using it to query an API", which has also been completed in this homework. Note that additional effort has been made to respect the restrictions of the OMIM API and that only a sample of data is provided to the reviewers in line with these restrictions.

### New skills acquired

1.  Store API key safely and privately in an .Rprofile file and add the file name to .gitignore file (so that the file will not be pushed to github). This is a way to keep an API key private.
2.  Use an API to make web data query: format of query and particularities relating to the OMIM API format.
3.  Write functions to make API data query: main code was adapted from Dave Tang tutorial Getting started with the OMIM api [here](https://davetang.org/muse/2015/03/17/getting-started-with-the-omim-api/) for main body of the homework, but a I wrote a new function that builds on previous work and uses httr and `GET()` in the final section of the homework.
4.  Read and write/save xml format files.

### What was most difficult?

#### Example 1 - OMIM API

As medical genetics data is multilayered and complex, the OMIM API structure is also very complex to accomodate diverse types of data. Learning how to use the API was a challenge in itself, and it required a significant amount of reading and trials and errors. I don't thik there is a shortcut for that one though, it's just the way it has to be for this kind of data.

#### Example 2 - XML format

I have spent a significant amount of time exploring the diverse functions of library `XML` and library `xml2`, but the structure of xml data is also somewhat difficult to understand.

#### Example 3 - Writing functions and waiting

Although I am becoming more familiar with writing functions, more frequently than I had hoped, I found myself waiting 5 minutes for an API query that didn't return any result in the end.

#### Example 4 - knitr and xml

knitr and xml functions with API key are not compatible: well, at least, it's what I concluded after many hours of trying. Therefore, I opted to save some data samples in a folder in order for the reviewers to be able to see the output of my OMIM API queries.

### What are you most excited about in your future of getting data from the web?

For the future, I would like to design a better way to custom OMIM API data query so that I can make myself a tailored "omim package" that could potentially be used clinically as a diagnostic aid.

Also, I would like to explore other APIs related to medical genetics or genomics, which would allow me to expand my knowledgebase.

### What questions did this raise in your mind?

Many questions were raised, and most of them are discussed above and in my homework 10, but some examples are:

1.  What is the most efficient/simplest way to get data from the web ? Does it depend on the specific type of data?
2.  What are the differences between XML and xml2 packages, and is there an advantage of one over the other, or are they complementary.
3.  How can I use what I learned in stat545/547 for my research and future clinical work? What is the most efficient way to do so?

Some questions are actually still open, and I encourage you to pitch any ideas if you would like:

1.  I have not found any efficient and reliable way to convert more complex xml format data (even after using `xmlToList()`) into a nice dataframe. This is probably due to the complexity of my dataset, and although it is somewhat outside the scope of this course, if you have any suggestions or references to help me, please don't hesitate to provide them to me.
2.  I was unable to use knitr with xml functions using my private API key, so if you have anything on the topic, please don't hesitate to send it my way.
3.  I tried to clean the inheritance data and replace terms with abbreviations, but I was unable to find the most efficient way to remove duplicated terms without losing some data because of the string format, but if you have any suggestions, once again, don't hesitate to let me know.

Thank you for your time and consideration,

Warm regards,

My Linh Thibodea

------------------------------------------------------------------------

References
==========

THIS WORK HAS BEEN COMPLETED FOR LEARNING PURPOSES ONLY
-------------------------------------------------------

SOURCES OF DATA - REFERENCES
----------------------------

-   Online Mendelian Inheritance in Man, OMIM®. McKusick-Nathans Institute of Genetic Medicine, Johns Hopkins University (Baltimore, MD), November 29 2017. World Wide Web URL: <https://omim.org/>
-   Code adapted from Dave Tang tutorial Getting started with the OMIM api [here](https://davetang.org/muse/2015/03/17/getting-started-with-the-omim-api/)
-   DECIPHER: Database of Chromosomal Imbalance and Phenotype in Humans using Ensembl Resources. Firth, H.V. et al (2009). Am.J.Hum.Genet 84, 524-533 (DOI: dx.doi.org/10/1016/j.ajhg.2009.03.010).
-   This homework makes use of genomic data generated by the DECIPHER community. A full list of centres who contributed to the generation of the data is available from <http://decipher.sanger.ac.uk> and via email from <decipher@sanger.ac.uk>. Funding for the project was provided by the Wellcome Trust.
-   Gray KA, Yates B, Seal RL, Wright MW, Bruford EA. genenames.org: the HGNC resources in 2015. Nucleic Acids Res. 2015 Jan;43(Database issue):D1079-85. doi: 10.1093/nar/gku1071. <PMID:25361968>.
-   HGNC Database, HUGO Gene Nomenclature Committee (HGNC), EMBL Outstation - Hinxton, European Bioinformatics Institute, Wellcome Trust Genome Campus, Hinxton, Cambridgeshire, CB10 1SD, UK www.genenames.org (complete HGNC dataset downloaded [here](https://www.genenames.org/cgi-bin/statistics) on November 17/2017).
-   Orphanet: an online database of rare diseases and orphan drugs. Copyright, INSERM 1997. Available at <http://www.orpha.net> Accessed (accessed November 17, 2017).
-   Orphadata: Free access data from Orphanet. © INSERM 1997. Available on <http://www.orphadata.org>. Data version (XML data version en\_product4\_HPO.xml).

GENERAL REFERENCES
------------------

-   stat545 webdata03 lecture 2015 [here](http://stat545.com/webdata03_activity.html)
-   collapse a vector into a string [here](http://r.789695.n4.nabble.com/Concatenating-one-character-vector-into-one-string-td835795.html)
-   capture output use [here](https://stackoverflow.com/questions/27594541/export-a-list-into-a-csv-or-txt-file-in-r)
