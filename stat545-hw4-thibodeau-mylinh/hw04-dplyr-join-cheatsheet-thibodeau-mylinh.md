hw04-dplyr-join-cheatsheet-thibodeau-mylinh
================
My Linh Thibodeau
2017-10-17

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
options(knitr.table.format = "markdown")
```

Essentials of data joining with dplyr - A table is worth a thousand words !
===========================================================================

Matching objectives and functions
=================================

Considering two data.frame d1 and d2
------------------------------------

| Objective                                            | tidyr/dplyr function |
|------------------------------------------------------|----------------------|
| **APPEND/JOIN DATA**                                 | **MUTATING**         |
| 1. Start with d1 and append matching column(s) of d2 | left\_join           |
| 2. Start with d2 and append matching column(s) of d1 | right\_join          |
| 3. Keep overlap d1-d2 based on matching column(s)    | inner\_join          |
| 4. Keep all of d1 and d2                             | full\_join           |
| **FILTER DATA**                                      | **FILTERING**        |
| 5. Keep rows of d1 if there is a match in d2         | semi\_join           |
| 4. Discard rows of d1 if there is a match in d2      | anti\_join           |

### DATASET d1

``` r
d1 <- read.table("scratch-space/small_dataframe_example.txt",sep = "\t", header = TRUE)
d1 %>% kable("markdown") %>% kable_styling()
```

    ## Currently generic markdown table using pandoc is not supported.

| gene.type | gene | expression |  copy.number|
|:----------|:-----|:-----------|------------:|
| TS        | TP53 | very.low   |            0|
| TS        | FLCN | average    |            4|
| TS        | SBHD | very.low   |            3|
| TS        | RB1  | low        |            1|
| ONC       | KRAS | very.high  |            5|
| ONC       | EGFR | high       |            0|

### DATASET d2

``` r
d2 <- read.table("scratch-space/small_dataframe_example_2.txt",sep = "\t", header = TRUE)
d2 %>% kable("markdown") %>% kable_styling()
```

    ## Currently generic markdown table using pandoc is not supported.

| gene  | IHC    |
|:------|:-------|
| TP53  | absent |
| FLCN  | normal |
| SBHD  | absent |
| RB1   | absent |
| KRAS  | strong |
| EGFR  | normal |
| PALB2 | normal |

------------------------------------------------------------------------

MUTATING JOIN
-------------

### (1) left\_join

``` r
left_join(d1, d2, by = "gene") %>% kable("markdown") %>% kable_styling()
```

    ## Warning: Column `gene` joining factors with different levels, coercing to
    ## character vector

    ## Currently generic markdown table using pandoc is not supported.

| gene.type | gene | expression |  copy.number| IHC    |
|:----------|:-----|:-----------|------------:|:-------|
| TS        | TP53 | very.low   |            0| absent |
| TS        | FLCN | average    |            4| normal |
| TS        | SBHD | very.low   |            3| absent |
| TS        | RB1  | low        |            1| absent |
| ONC       | KRAS | very.high  |            5| strong |
| ONC       | EGFR | high       |            0| normal |

### (2) right\_join

``` r
right_join(d1, d2, by = "gene") %>% kable("markdown") %>% kable_styling()
```

    ## Warning: Column `gene` joining factors with different levels, coercing to
    ## character vector

    ## Currently generic markdown table using pandoc is not supported.

| gene.type | gene  | expression |  copy.number| IHC    |
|:----------|:------|:-----------|------------:|:-------|
| TS        | TP53  | very.low   |            0| absent |
| TS        | FLCN  | average    |            4| normal |
| TS        | SBHD  | very.low   |            3| absent |
| TS        | RB1   | low        |            1| absent |
| ONC       | KRAS  | very.high  |            5| strong |
| ONC       | EGFR  | high       |            0| normal |
| NA        | PALB2 | NA         |           NA| normal |

### (3) inner\_join

``` r
inner_join(d1, d2, by = "gene") %>% kable("markdown") %>% kable_styling()
```

    ## Warning: Column `gene` joining factors with different levels, coercing to
    ## character vector

    ## Currently generic markdown table using pandoc is not supported.

| gene.type | gene | expression |  copy.number| IHC    |
|:----------|:-----|:-----------|------------:|:-------|
| TS        | TP53 | very.low   |            0| absent |
| TS        | FLCN | average    |            4| normal |
| TS        | SBHD | very.low   |            3| absent |
| TS        | RB1  | low        |            1| absent |
| ONC       | KRAS | very.high  |            5| strong |
| ONC       | EGFR | high       |            0| normal |

### (4) full\_join

``` r
full_join(d1, d2, by = "gene") %>% kable("markdown") %>% kable_styling()
```

    ## Warning: Column `gene` joining factors with different levels, coercing to
    ## character vector

    ## Currently generic markdown table using pandoc is not supported.

| gene.type | gene  | expression |  copy.number| IHC    |
|:----------|:------|:-----------|------------:|:-------|
| TS        | TP53  | very.low   |            0| absent |
| TS        | FLCN  | average    |            4| normal |
| TS        | SBHD  | very.low   |            3| absent |
| TS        | RB1   | low        |            1| absent |
| ONC       | KRAS  | very.high  |            5| strong |
| ONC       | EGFR  | high       |            0| normal |
| NA        | PALB2 | NA         |           NA| normal |

------------------------------------------------------------------------

FILTERING JOIN
--------------

### (5) semi\_join

``` r
semi_join(d1, d2, by = "gene") %>% kable("markdown") %>% kable_styling()
```

    ## Warning: Column `gene` joining factors with different levels, coercing to
    ## character vector

    ## Currently generic markdown table using pandoc is not supported.

| gene.type | gene | expression |  copy.number|
|:----------|:-----|:-----------|------------:|
| TS        | TP53 | very.low   |            0|
| TS        | FLCN | average    |            4|
| TS        | SBHD | very.low   |            3|
| TS        | RB1  | low        |            1|
| ONC       | KRAS | very.high  |            5|
| ONC       | EGFR | high       |            0|

### (6) anti\_join

``` r
anti_join(d1, d2, by = "gene") %>% kable("markdown") %>% kable_styling()
```

    ## Warning: Column `gene` joining factors with different levels, coercing to
    ## character vector

    ## Currently generic markdown table using pandoc is not supported.

| gene.type | gene | expression |  copy.number|
|:----------|:-----|:-----------|------------:|

------------------------------------------------------------------------

I have omitted explanations in this cheatsheet on purpose
=========================================================

The reason being that I spent a significant amount of time thinking about sample data.frame d1 and d2 and how to show in a visual snapshot what are the differences between the types of dplyr joining functions.

#### If you would like more details explanations, please feel free to refer to the long version of this homework 4 [HERE](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/blob/master/stat545-hw4-thibodeau-mylinh/long-version-stat545-hw04-thibodeau-mylinh.md) !
