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

| Task         | tidyr/dplyr function | reshape2 function   | base R                  |
|--------------|----------------------|---------------------|-------------------------|
| 1. Group     | group\_by            | "cast"              | "aggregate(~ group)"    |
| 2. Split     | spread, ?separate    | dcast               | table                   |
| 3. Stack     | gather               | melt                | "stack"                 |
| 4. Join      | \_join functions     | reshape::merge\_all | merge, cbind, rbind     |
| 5. Subset    | filter, extract      | NA                  | df\[which()\] or subset |
| 6. Transpose | gather/spread        | dcast/melt          | data.frame(t())         |
| 7. Sort      | arrange              |                     |                         |

-   *Note1. I have put in quotation marks the functions that I do not recommend for the specific task, because although there are some ways around it, they are no the simplest/fastest way to get the solution in my opinion.*
-   *Note2. In reshape2, acast() is for a array/vector/matrix output, and dcast for a data.frame output. I have put dcast for simplicity in the table, but acast can also be used.*
-   *Note3. When a backslash separate 2 functions in the table (e.g. gather/spread), it mean that they may need to be combined to complete the Task.*

------------------------------------------------------------------------

Let's make a small table to illustrate the different funcitons.

``` r
d1 <- read.table("small_dataframe_example.txt",sep = "\t", header = TRUE)
d1 %>%
  kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
gene.type
</th>
<th style="text-align:left;">
gene
</th>
<th style="text-align:left;">
expression
</th>
<th style="text-align:right;">
copy.number
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
TP53
</td>
<td style="text-align:left;">
very.low
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
FLCN
</td>
<td style="text-align:left;">
average
</td>
<td style="text-align:right;">
4
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
SBHD
</td>
<td style="text-align:left;">
very.low
</td>
<td style="text-align:right;">
3
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
RB1
</td>
<td style="text-align:left;">
low
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
KRAS
</td>
<td style="text-align:left;">
very.high
</td>
<td style="text-align:right;">
5
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
EGFR
</td>
<td style="text-align:left;">
high
</td>
<td style="text-align:right;">
0
</td>
</tr>
</tbody>
</table>
(1) GROUP
---------

Objective: group gene.type and copy.state, when count the number of rows (pairs) and the sum of the copy.number for each pair.

### Tidyr

``` r
gr_tidy <- select(d1, gene.type, expression, copy.number) %>%
  group_by(gene.type, expression) %>%
  summarize(Nrows = n(), SumCol.copy.number = sum(copy.number))
gr_tidy %>% kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
gene.type
</th>
<th style="text-align:left;">
expression
</th>
<th style="text-align:right;">
Nrows
</th>
<th style="text-align:right;">
SumCol.copy.number
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
high
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
very.high
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
5
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
average
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
4
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
low
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
very.low
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
3
</td>
</tr>
</tbody>
</table>
### Reshape

``` r
gr_resh <- d1 %>%
  select(gene.type, expression, copy.number) %>%
  dcast(gene.type+expression ~ expression) %>%
  melt(varnames = c("gene.type", "expression"), value.name = "Nrows", na.rm =TRUE) %>%
  filter(Nrows !=0) %>%
  select(gene.type, expression, Nrows)
```

    ## Using copy.number as value column: use value.var to override.

    ## Aggregation function missing: defaulting to length

    ## Using gene.type, expression as id variables

``` r
gr_resh %>% kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
gene.type
</th>
<th style="text-align:left;">
expression
</th>
<th style="text-align:right;">
Nrows
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
average
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
high
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
low
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
very.high
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
very.low
</td>
<td style="text-align:right;">
2
</td>
</tr>
</tbody>
</table>
Note. Using reshape is a very convoluted way to do group data, Tidyr is better for these data manipulations.

``` r
aggregate(gene.type~expression, d1, length)  %>% kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
expression
</th>
<th style="text-align:right;">
gene.type
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
average
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
high
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
low
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
very.high
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
very.low
</td>
<td style="text-align:right;">
2
</td>
</tr>
</tbody>
</table>
``` r
aggregate(. ~expression, d1, length)  %>% kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
expression
</th>
<th style="text-align:right;">
gene.type
</th>
<th style="text-align:right;">
gene
</th>
<th style="text-align:right;">
copy.number
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
average
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
high
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
low
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
very.high
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
very.low
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
2
</td>
</tr>
</tbody>
</table>
``` r
tapply(d1$gene.type, d1$expression, FUN=length)
```

    ##   average      high       low very.high  very.low 
    ##         1         1         1         1         2

Note. Again, base R is not ideal to pursue grouping. I was not able to obtain the wanted table, and since Tidyr offers better alternative, I won't pursue further base R for grouping.

(2) SPLIT
---------

Objective: transform the Nrows column (count of gene.type-expression pairs) of gr\_tidy so that each group (TS, ONC) is represented by one row, each expression category by one column, and the numbers (Nrows of gr\_tidy) represent the number of occurence in each pair (gene.type-expression).

### Tidyr

``` r
split_tidy <- gr_tidy %>%
  group_by(gene.type, expression) %>%
  select(gene.type, Nrows) %>%
  spread(key=expression, value = Nrows)
```

    ## Adding missing grouping variables: `expression`

``` r
split_tidy %>% kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
gene.type
</th>
<th style="text-align:right;">
average
</th>
<th style="text-align:right;">
high
</th>
<th style="text-align:right;">
low
</th>
<th style="text-align:right;">
very.high
</th>
<th style="text-align:right;">
very.low
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
2
</td>
</tr>
</tbody>
</table>
### Reshape

``` r
split_resh <- gr_tidy %>%
  dcast(gene.type~expression, value.var = "Nrows")
split_resh %>% kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
gene.type
</th>
<th style="text-align:right;">
average
</th>
<th style="text-align:right;">
high
</th>
<th style="text-align:right;">
low
</th>
<th style="text-align:right;">
very.high
</th>
<th style="text-align:right;">
very.low
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
2
</td>
</tr>
</tbody>
</table>
### Base R

``` r
split_R <- with(d1, table(gene.type, expression))
split_R %>% kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
average
</th>
<th style="text-align:right;">
high
</th>
<th style="text-align:right;">
low
</th>
<th style="text-align:right;">
very.high
</th>
<th style="text-align:right;">
very.low
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
2
</td>
</tr>
</tbody>
</table>
(3) STACK
---------

Objective: display split\_resh in a way such that all possible gene.type-expression pairs are displayed in col1 and col2, which col3 returns the count of such pairs (Nrows)

### Tidyr

``` r
stack_tidy <- split_resh %>%
  gather(key = variable, value = expression, very.low, low,  average, very.high, high)
stack_tidy %>% kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
gene.type
</th>
<th style="text-align:left;">
variable
</th>
<th style="text-align:right;">
expression
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
very.low
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
very.low
</td>
<td style="text-align:right;">
2
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
low
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
low
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
average
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
average
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
very.high
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
very.high
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
high
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
high
</td>
<td style="text-align:right;">
NA
</td>
</tr>
</tbody>
</table>
### Reshape

``` r
stack_resh <- melt(split_resh, id="gene.type") %>%
  arrange(gene.type)
stack_resh %>% kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
gene.type
</th>
<th style="text-align:left;">
variable
</th>
<th style="text-align:right;">
value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
average
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
high
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
low
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
very.high
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
very.low
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
average
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
high
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
low
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
very.high
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
very.low
</td>
<td style="text-align:right;">
2
</td>
</tr>
</tbody>
</table>
Or also:

``` r
stack_resh2 <- d1 %>% dcast(gene.type~expression) %>% melt()
```

    ## Using copy.number as value column: use value.var to override.

    ## Aggregation function missing: defaulting to length

    ## Using gene.type as id variables

``` r
stack_resh2 %>% kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
gene.type
</th>
<th style="text-align:left;">
variable
</th>
<th style="text-align:right;">
value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
average
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
average
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
high
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
high
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
low
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
low
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
very.high
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
very.high
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
very.low
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
very.low
</td>
<td style="text-align:right;">
2
</td>
</tr>
</tbody>
</table>
``` r
stack(split_resh)
```

    ## Warning in stack.data.frame(split_resh): non-vector columns will be ignored

    ##    values       ind
    ## 1      NA   average
    ## 2       1   average
    ## 3       1      high
    ## 4      NA      high
    ## 5      NA       low
    ## 6       1       low
    ## 7       1 very.high
    ## 8      NA very.high
    ## 9      NA  very.low
    ## 10      2  very.low

Note. Base R can provide the number of possible gene.type-expression pairs, but will only return two columns: values (concatenation of vectors in d1) and ind (factor from which the vector originated in d1), so it's not a very intuitive method.

------------------------------------------------------------------------

Let's prepare another dataset (d2) for the following exercises.

``` r
d2 <- read.table("small_dataframe_example_2.txt",sep = "\t", header = TRUE)
d2 %>% kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
gene
</th>
<th style="text-align:left;">
IHC
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
TP53
</td>
<td style="text-align:left;">
absent
</td>
</tr>
<tr>
<td style="text-align:left;">
FLCN
</td>
<td style="text-align:left;">
normal
</td>
</tr>
<tr>
<td style="text-align:left;">
SBHD
</td>
<td style="text-align:left;">
absent
</td>
</tr>
<tr>
<td style="text-align:left;">
RB1
</td>
<td style="text-align:left;">
absent
</td>
</tr>
<tr>
<td style="text-align:left;">
KRAS
</td>
<td style="text-align:left;">
strong
</td>
</tr>
<tr>
<td style="text-align:left;">
EGFR
</td>
<td style="text-align:left;">
normal
</td>
</tr>
<tr>
<td style="text-align:left;">
PALB2
</td>
<td style="text-align:left;">
normal
</td>
</tr>
</tbody>
</table>

------------------------------------------------------------------------

(4) JOIN
--------

Objective: join d1 and d2 according to the common column gene.

### Tidyr

Only one joining example below, but for the complete dplyr join functions cheatsheet, please go [HERE]() !

#### left\_join()

``` r
join_tidy <- left_join(d1, d2, by = "gene")
```

    ## Warning: Column `gene` joining factors with different levels, coercing to
    ## character vector

``` r
join_tidy %>% kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
gene.type
</th>
<th style="text-align:left;">
gene
</th>
<th style="text-align:left;">
expression
</th>
<th style="text-align:right;">
copy.number
</th>
<th style="text-align:left;">
IHC
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
TP53
</td>
<td style="text-align:left;">
very.low
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:left;">
absent
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
FLCN
</td>
<td style="text-align:left;">
average
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
normal
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
SBHD
</td>
<td style="text-align:left;">
very.low
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:left;">
absent
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
RB1
</td>
<td style="text-align:left;">
low
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
absent
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
KRAS
</td>
<td style="text-align:left;">
very.high
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:left;">
strong
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
EGFR
</td>
<td style="text-align:left;">
high
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:left;">
normal
</td>
</tr>
</tbody>
</table>
### Base R

``` r
join_R <- merge(d1, d2)
join_R %>% kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
gene
</th>
<th style="text-align:left;">
gene.type
</th>
<th style="text-align:left;">
expression
</th>
<th style="text-align:right;">
copy.number
</th>
<th style="text-align:left;">
IHC
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
EGFR
</td>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
high
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:left;">
normal
</td>
</tr>
<tr>
<td style="text-align:left;">
FLCN
</td>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
average
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
normal
</td>
</tr>
<tr>
<td style="text-align:left;">
KRAS
</td>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
very.high
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:left;">
strong
</td>
</tr>
<tr>
<td style="text-align:left;">
RB1
</td>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
low
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
absent
</td>
</tr>
<tr>
<td style="text-align:left;">
SBHD
</td>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
very.low
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:left;">
absent
</td>
</tr>
<tr>
<td style="text-align:left;">
TP53
</td>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
very.low
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:left;">
absent
</td>
</tr>
</tbody>
</table>
(5) SUBSET
----------

Objective: only take the data for the ONC gene.type.

### Tidyr

``` r
subset_tidy <- d1 %>%
  filter(gene.type == "ONC") 
subset_tidy %>% kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
gene.type
</th>
<th style="text-align:left;">
gene
</th>
<th style="text-align:left;">
expression
</th>
<th style="text-align:right;">
copy.number
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
KRAS
</td>
<td style="text-align:left;">
very.high
</td>
<td style="text-align:right;">
5
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
EGFR
</td>
<td style="text-align:left;">
high
</td>
<td style="text-align:right;">
0
</td>
</tr>
</tbody>
</table>
``` r
subset_resh <- d1 %>% dcast(gene.type~expression) %>% melt(subset = .(gene.type=="ONC"))
```

    ## Using copy.number as value column: use value.var to override.

    ## Aggregation function missing: defaulting to length

    ## Using gene.type as id variables

``` r
View(subset_resh)
```

### Base R

``` r
subset_R <- d1[which(d1$gene.type== 'ONC'),]
subset_R %>% kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:left;">
gene.type
</th>
<th style="text-align:left;">
gene
</th>
<th style="text-align:left;">
expression
</th>
<th style="text-align:right;">
copy.number
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
5
</td>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
KRAS
</td>
<td style="text-align:left;">
very.high
</td>
<td style="text-align:right;">
5
</td>
</tr>
<tr>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
EGFR
</td>
<td style="text-align:left;">
high
</td>
<td style="text-align:right;">
0
</td>
</tr>
</tbody>
</table>
``` r
subset_R2 <- subset(d1, gene.type=='ONC')
subset_R2 %>% kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:left;">
gene.type
</th>
<th style="text-align:left;">
gene
</th>
<th style="text-align:left;">
expression
</th>
<th style="text-align:right;">
copy.number
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
5
</td>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
KRAS
</td>
<td style="text-align:left;">
very.high
</td>
<td style="text-align:right;">
5
</td>
</tr>
<tr>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
EGFR
</td>
<td style="text-align:left;">
high
</td>
<td style="text-align:right;">
0
</td>
</tr>
</tbody>
</table>
(5) TRANSPOSE
-------------

Objective: take the subset\_tidy horizontal table and transpose it to a vertical position such that the rows become columns and vice versa.

### Base R

``` r
transpose_R <- data.frame(t(subset_tidy))
transpose_R %>% kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:left;">
X1
</th>
<th style="text-align:left;">
X2
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
gene.type
</td>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
ONC
</td>
</tr>
<tr>
<td style="text-align:left;">
gene
</td>
<td style="text-align:left;">
KRAS
</td>
<td style="text-align:left;">
EGFR
</td>
</tr>
<tr>
<td style="text-align:left;">
expression
</td>
<td style="text-align:left;">
very.high
</td>
<td style="text-align:left;">
high
</td>
</tr>
<tr>
<td style="text-align:left;">
copy.number
</td>
<td style="text-align:left;">
5
</td>
<td style="text-align:left;">
0
</td>
</tr>
</tbody>
</table>
I note that the columns are called X1 and X2 instead of ONC and ONC. Oh well, we get the general idea anyway !

(7) SORT
--------

Objective: sort the table according to ascending copy.number

### Tidyr

``` r
join_tidy %>%
  arrange(copy.number) %>% kable("html") %>% kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
gene.type
</th>
<th style="text-align:left;">
gene
</th>
<th style="text-align:left;">
expression
</th>
<th style="text-align:right;">
copy.number
</th>
<th style="text-align:left;">
IHC
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
TP53
</td>
<td style="text-align:left;">
very.low
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:left;">
absent
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
EGFR
</td>
<td style="text-align:left;">
high
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:left;">
normal
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
RB1
</td>
<td style="text-align:left;">
low
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
absent
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
SBHD
</td>
<td style="text-align:left;">
very.low
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:left;">
absent
</td>
</tr>
<tr>
<td style="text-align:left;">
TS
</td>
<td style="text-align:left;">
FLCN
</td>
<td style="text-align:left;">
average
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
normal
</td>
</tr>
<tr>
<td style="text-align:left;">
ONC
</td>
<td style="text-align:left;">
KRAS
</td>
<td style="text-align:left;">
very.high
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:left;">
strong
</td>
</tr>
</tbody>
</table>

------------------------------------------------------------------------

### REFERENCES

-   Reshape2 manual [here](https://www.rdocumentation.org/packages/reshape2/versions/1.4.2)
-   Reshape2 intro [here](http://seananderson.ca/2013/10/19/reshape.html)
-   Reshape reference [here](http://had.co.nz/reshape/), [here](https://stackoverflow.com/questions/8091303/simultaneously-merge-multiple-data-frames-in-a-list)
-   Blog on data manipulation [here on r-statistics](https://www.r-statistics.com/2012/01/aggregation-and-restructuring-data-from-r-in-action/), and [here on Oregon University](http://library.open.oregonstate.edu/computationalbiology/chapter/reshaping-and-joining-data-frames/).
-   Panda can also offer options, as exemplified [here](https://pandas.pydata.org/pandas-docs/stable/merging.html), but I ran out of time to look into this further.
-   Aggregate in base R [here](https://stackoverflow.com/questions/1660124/how-to-sum-a-variable-by-group) or [here](https://datascienceplus.com/aggregate-data-frame-r/) or [here](http://www.statmethods.net/management/aggregate.html) Base R stack resource [here](http://www.instantr.com/2012/12/02/stacking-a-dataset-in-r/) and [here](https://stat.ethz.ch/R-manual/R-devel/library/utils/html/stack.html)
-   Base R [subset](http://www.statmethods.net/management/subset.html)
