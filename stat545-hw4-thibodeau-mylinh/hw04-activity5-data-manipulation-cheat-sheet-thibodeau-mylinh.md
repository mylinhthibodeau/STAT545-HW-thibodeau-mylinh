hw04-activity5-data-manipulation-cheat-sheet-thibodeau-mylinh
================
My Linh Thibodeau
2017-10-07

``` r
suppressPackageStartupMessages(library(tidyverse))
```

    ## Warning: package 'dplyr' was built under R version 3.4.2

``` r
knitr::opts_chunk$set(fig.width=12, fig.height=9)
library(knitr)
library(kableExtra)
library(reshape2)
```

    ## 
    ## Attaching package: 'reshape2'

    ## The following object is masked from 'package:tidyr':
    ## 
    ##     smiths

``` r
options(knitr.table.format = "html")
```

Essentials of data manipulations in R
=====================================

Matching tasks and functions
============================

| Task            | tidyr function            | reshape2 function     |
|-----------------|---------------------------|-----------------------|
| 1. Group        | group\_by()               | cast()                |
| --------------- | ------------------------- | --------------------- |
| 2. Split        | spread(), separate()      | dcast()               |
| --------------- | ------------------------- | --------------------- |
| 3. Stack        | gather()                  | melt()                |
| --------------- | ------------------------- | --------------------- |
| 4. Join         | \_join functions          | reshape::merge\_all   |
| --------------- | ------------------------- | --------------------- |
| 5. Subset       | filter(), extract()       |                       |
| --------------- | ------------------------- | --------------------- |
| 6. Transpose    | gather()/spread()         |                       |
| --------------- | ------------------------- | --------------------- |
| 7. Sort         | arrange()                 |                       |
| --------------- | ------------------------- | --------------------- |

References Reshape2 manual [here](https://www.rdocumentation.org/packages/reshape2/versions/1.4.2) Reshape reference [here](http://had.co.nz/reshape/), [here](https://stackoverflow.com/questions/8091303/simultaneously-merge-multiple-data-frames-in-a-list) Blog on data manipulation [here](https://www.r-statistics.com/2012/01/aggregation-and-restructuring-data-from-r-in-action/), and [here](http://library.open.oregonstate.edu/computationalbiology/chapter/reshaping-and-joining-data-frames/) Panda can also offer options, as exemplified [here](https://pandas.pydata.org/pandas-docs/stable/merging.html), but I ran out of time to look into this further.
