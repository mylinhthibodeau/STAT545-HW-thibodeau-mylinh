summary\_file
================
My Linh Thibodeau
2017-11-11

Library and reading tables

``` r
suppressMessages(suppressWarnings(library(tidyverse)))
knitr::opts_chunk$set(fig.width=12, fig.height=9)
library(knitr)
library(kableExtra)
```

    ## Warning: package 'kableExtra' was built under R version 3.4.2

``` r
options(knitr.table.format = "html")
mut_sig <- read.table("mut_sig.tsv", header = TRUE, sep = "\t")
ref_mut_sig_ordered_by_sig3 <- readRDS("somatic_mutations_formated_files/ref_mut_sig_ordered_by_sig3.rds")
mut_sig_gather <- read.table("mut_sig_gather.tsv", header = TRUE, sep="\t")
ALL_mut_gather <- read.table("somatic_mutations_formated_files/ALL_mut_gather.tsv", header = TRUE, sep = "\t")
aml_mut_gather <- read.table("somatic_mutations_formated_files/aml_mut_gather.tsv", header = TRUE, sep = "\t")
breast_mut_gather <- read.table("somatic_mutations_formated_files/breast_mut_gather.tsv", header = TRUE, sep = "\t")
medullo_mut_gather <- read.table("somatic_mutations_formated_files/medulloblastoma_mut_gather.tsv", header = TRUE, sep = "\t")
pancreas_mut_gather <- read.table("somatic_mutations_formated_files/pancreas_mut_gather.tsv", header = TRUE, sep = "\t")
all_cancer_types_mut <- read.table("somatic_mutations_formated_files/all_cancer_types_mut.tsv", header = TRUE, sep = "\t")
all_cancer_types_mut_with_ref_sig <- read.table("somatic_mutations_formated_files/all_cancer_types_mut_with_ref_sig.tsv", sep = "\t", header = TRUE)
all_cancer_mutations_per_snv_sig_score <- read.table("somatic_mutations_formated_files/all_cancer_mutations_per_snv_sig_score.tsv", header = TRUE, sep = "\t")
all_cancer_types_mut_proportion_signatures <-  read.table("somatic_mutations_formated_files/all_cancer_types_mut_proportion_signatures.tsv", header = TRUE, sep = "\t")
all_cancer_types_stats <- read.table("statistics/all_cancer_types_stats.tsv", header = TRUE, sep = "\t")
```

DATA INFORMATION
================

For this homework, I will be using open access complete set of cancer somatic mutations from:

Alexandrov, L. B. et al. Signatures of mutational processes in human cancer. 500, 415–421 (2013).

### Please note that I deliberately broke down each step of this homework in very small chunks/steps/scripts to make this material more "generalizable", which will allow me to use them for my research work as well.

------------------------------------------------------------------------

This files will contain a narrative of homework 7 and some helpful notes regarding my process.

Download the data
=================

I started by using curl shell script in my Makefile to download the complete set of cancer somatic mutations (see Makefile for details):

    mut_sig_raw.txt:
        curl -o mut_sig_raw.txt ftp://ftp.sanger.ac.uk/pub/cancer/AlexandrovEtAl/signatures.txt

I am also using my `mut_sig_clean.R` script to format the data. I performed that step to remove empty spaces from the column names because this would create problems with variable manipulation later.

Perform exploratory analyses
============================

Tasks:

-   Bring the data in as data frame.
-   Save a couple descriptive plots to file with highly informative names.
-   Reorder the continents based on life expectancy. You decide the details. Sort the actual data in a deliberate fashion. You decide the details, but this should at least implement your new continent ordering.
-   Write the Gapminder data to file(s), for immediate and future reuse.

**Please note that I did not complete the 5 tasks above in the order suggested because it made more sense to proceed in the order outlined below with my dataset ! **

The original format of the reference mutation signature is:

``` r
mut_sig %>% arrange(Somatic.Mutation.Type) %>% head(5) %>% kable()
```

<table>
<thead>
<tr>
<th style="text-align:left;">
Substitution.Type
</th>
<th style="text-align:left;">
Trinucleotide
</th>
<th style="text-align:left;">
Somatic.Mutation.Type
</th>
<th style="text-align:right;">
Signature.1A
</th>
<th style="text-align:right;">
Signature.1B
</th>
<th style="text-align:right;">
Signature.2
</th>
<th style="text-align:right;">
Signature.3
</th>
<th style="text-align:right;">
Signature.4
</th>
<th style="text-align:right;">
Signature.5
</th>
<th style="text-align:right;">
Signature.6
</th>
<th style="text-align:right;">
Signature.7
</th>
<th style="text-align:right;">
Signature.8
</th>
<th style="text-align:right;">
Signature.9
</th>
<th style="text-align:right;">
Signature.10
</th>
<th style="text-align:right;">
Signature.11
</th>
<th style="text-align:right;">
Signature.12
</th>
<th style="text-align:right;">
Signature.13
</th>
<th style="text-align:right;">
Signature.14
</th>
<th style="text-align:right;">
Signature.15
</th>
<th style="text-align:right;">
Signature.16
</th>
<th style="text-align:right;">
Signature.17
</th>
<th style="text-align:right;">
Signature.18
</th>
<th style="text-align:right;">
Signature.19
</th>
<th style="text-align:right;">
Signature.20
</th>
<th style="text-align:right;">
Signature.21
</th>
<th style="text-align:right;">
Signature.R1
</th>
<th style="text-align:right;">
Signature.R2
</th>
<th style="text-align:right;">
Signature.R3
</th>
<th style="text-align:right;">
Signature.U1
</th>
<th style="text-align:right;">
Signature.U2
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACA
</td>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:right;">
0.0112
</td>
<td style="text-align:right;">
0.0104
</td>
<td style="text-align:right;">
0.0105
</td>
<td style="text-align:right;">
0.0240
</td>
<td style="text-align:right;">
0.0365
</td>
<td style="text-align:right;">
0.0149
</td>
<td style="text-align:right;">
0.0017
</td>
<td style="text-align:right;">
4e-04
</td>
<td style="text-align:right;">
0.0368
</td>
<td style="text-align:right;">
0.0120
</td>
<td style="text-align:right;">
0.0007
</td>
<td style="text-align:right;">
2e-04
</td>
<td style="text-align:right;">
0.0077
</td>
<td style="text-align:right;">
0.0007
</td>
<td style="text-align:right;">
0.0001
</td>
<td style="text-align:right;">
0.0013
</td>
<td style="text-align:right;">
0.0161
</td>
<td style="text-align:right;">
0.0018
</td>
<td style="text-align:right;">
0.0500
</td>
<td style="text-align:right;">
0.0107
</td>
<td style="text-align:right;">
0.0013
</td>
<td style="text-align:right;">
1e-04
</td>
<td style="text-align:right;">
0.0210
</td>
<td style="text-align:right;">
0.0137
</td>
<td style="text-align:right;">
0.0044
</td>
<td style="text-align:right;">
0.0105
</td>
<td style="text-align:right;">
0.0221
</td>
</tr>
<tr>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACC
</td>
<td style="text-align:left;">
A\[C&gt;A\]C
</td>
<td style="text-align:right;">
0.0092
</td>
<td style="text-align:right;">
0.0093
</td>
<td style="text-align:right;">
0.0061
</td>
<td style="text-align:right;">
0.0197
</td>
<td style="text-align:right;">
0.0309
</td>
<td style="text-align:right;">
0.0089
</td>
<td style="text-align:right;">
0.0028
</td>
<td style="text-align:right;">
5e-04
</td>
<td style="text-align:right;">
0.0287
</td>
<td style="text-align:right;">
0.0067
</td>
<td style="text-align:right;">
0.0010
</td>
<td style="text-align:right;">
1e-03
</td>
<td style="text-align:right;">
0.0047
</td>
<td style="text-align:right;">
0.0001
</td>
<td style="text-align:right;">
0.0042
</td>
<td style="text-align:right;">
0.0040
</td>
<td style="text-align:right;">
0.0097
</td>
<td style="text-align:right;">
0.0003
</td>
<td style="text-align:right;">
0.0076
</td>
<td style="text-align:right;">
0.0074
</td>
<td style="text-align:right;">
0.0024
</td>
<td style="text-align:right;">
7e-04
</td>
<td style="text-align:right;">
0.0065
</td>
<td style="text-align:right;">
0.0046
</td>
<td style="text-align:right;">
0.0047
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
0.0123
</td>
</tr>
<tr>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACG
</td>
<td style="text-align:left;">
A\[C&gt;A\]G
</td>
<td style="text-align:right;">
0.0015
</td>
<td style="text-align:right;">
0.0016
</td>
<td style="text-align:right;">
0.0013
</td>
<td style="text-align:right;">
0.0019
</td>
<td style="text-align:right;">
0.0183
</td>
<td style="text-align:right;">
0.0022
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
0e+00
</td>
<td style="text-align:right;">
0.0017
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
0.0003
</td>
<td style="text-align:right;">
0e+00
</td>
<td style="text-align:right;">
0.0017
</td>
<td style="text-align:right;">
0.0001
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
0.0000
</td>
<td style="text-align:right;">
0.0022
</td>
<td style="text-align:right;">
0.0000
</td>
<td style="text-align:right;">
0.0017
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
0.0000
</td>
<td style="text-align:right;">
0e+00
</td>
<td style="text-align:right;">
0.0000
</td>
<td style="text-align:right;">
0.0048
</td>
<td style="text-align:right;">
0.0003
</td>
<td style="text-align:right;">
0.0000
</td>
<td style="text-align:right;">
0.0028
</td>
</tr>
<tr>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACT
</td>
<td style="text-align:left;">
A\[C&gt;A\]T
</td>
<td style="text-align:right;">
0.0063
</td>
<td style="text-align:right;">
0.0067
</td>
<td style="text-align:right;">
0.0037
</td>
<td style="text-align:right;">
0.0172
</td>
<td style="text-align:right;">
0.0243
</td>
<td style="text-align:right;">
0.0092
</td>
<td style="text-align:right;">
0.0019
</td>
<td style="text-align:right;">
4e-04
</td>
<td style="text-align:right;">
0.0300
</td>
<td style="text-align:right;">
0.0068
</td>
<td style="text-align:right;">
0.0092
</td>
<td style="text-align:right;">
2e-04
</td>
<td style="text-align:right;">
0.0046
</td>
<td style="text-align:right;">
0.0002
</td>
<td style="text-align:right;">
0.0296
</td>
<td style="text-align:right;">
0.0057
</td>
<td style="text-align:right;">
0.0088
</td>
<td style="text-align:right;">
0.0032
</td>
<td style="text-align:right;">
0.0181
</td>
<td style="text-align:right;">
0.0074
</td>
<td style="text-align:right;">
0.0029
</td>
<td style="text-align:right;">
6e-04
</td>
<td style="text-align:right;">
0.0058
</td>
<td style="text-align:right;">
0.0081
</td>
<td style="text-align:right;">
0.0034
</td>
<td style="text-align:right;">
0.0112
</td>
<td style="text-align:right;">
0.0118
</td>
</tr>
<tr>
<td style="text-align:left;">
C&gt;G
</td>
<td style="text-align:left;">
ACA
</td>
<td style="text-align:left;">
A\[C&gt;G\]A
</td>
<td style="text-align:right;">
0.0018
</td>
<td style="text-align:right;">
0.0051
</td>
<td style="text-align:right;">
0.0048
</td>
<td style="text-align:right;">
0.0216
</td>
<td style="text-align:right;">
0.0097
</td>
<td style="text-align:right;">
0.0117
</td>
<td style="text-align:right;">
0.0013
</td>
<td style="text-align:right;">
0e+00
</td>
<td style="text-align:right;">
0.0085
</td>
<td style="text-align:right;">
0.0048
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
7e-04
</td>
<td style="text-align:right;">
0.0031
</td>
<td style="text-align:right;">
0.0018
</td>
<td style="text-align:right;">
0.0001
</td>
<td style="text-align:right;">
0.0011
</td>
<td style="text-align:right;">
0.0048
</td>
<td style="text-align:right;">
0.0016
</td>
<td style="text-align:right;">
0.0014
</td>
<td style="text-align:right;">
0.0058
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
5e-04
</td>
<td style="text-align:right;">
0.0038
</td>
<td style="text-align:right;">
0.0024
</td>
<td style="text-align:right;">
0.0012
</td>
<td style="text-align:right;">
0.0044
</td>
<td style="text-align:right;">
0.0108
</td>
</tr>
</tbody>
</table>
1.  I am using my `mut_sig_tables.Rmd` script bring the mutational signatures in as a data frame. I am using the gather function of tidyverse to create a new dataframe table which will facilitate making plots later. I saved the output of this new data frame to mut\_sig\_gather.tsv.

``` r
mut_sig_gather %>% arrange(Somatic.Mutation.Type) %>% head(5) %>% kable()
```

<table>
<thead>
<tr>
<th style="text-align:left;">
Substitution.Type
</th>
<th style="text-align:left;">
Trinucleotide
</th>
<th style="text-align:left;">
Somatic.Mutation.Type
</th>
<th style="text-align:left;">
Signature
</th>
<th style="text-align:right;">
Score
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACA
</td>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
Signature.1A
</td>
<td style="text-align:right;">
0.0112
</td>
</tr>
<tr>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACA
</td>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
Signature.1B
</td>
<td style="text-align:right;">
0.0104
</td>
</tr>
<tr>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACA
</td>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
Signature.2
</td>
<td style="text-align:right;">
0.0105
</td>
</tr>
<tr>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACA
</td>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
Signature.3
</td>
<td style="text-align:right;">
0.0240
</td>
</tr>
<tr>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACA
</td>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
Signature.4
</td>
<td style="text-align:right;">
0.0365
</td>
</tr>
</tbody>
</table>
Note. This allows us to know how much each Somatic.Mutation.Type contributes to each signature.

1.  Here are some initial plots

![mutation\_scores\_for\_all\_snv\_facet\_signature](plots/mutation_scores_for_all_snv_facet_signature.pdf)

![mutation\_scores\_for\_all\_snv\_type\_facet\_signature\_colored\_snv](plots/mutation_scores_for_all_snv_type_facet_signature_colored_snv.pdf)

![cancer\_type\_sig\_compare\_plots](plots/cancer_type_sig_compare_plots.pdf)

![all\_cancer\_types\_mut\_geompoint](plots/all_cancer_types_mut_geompoint.pdf)

1.  In this section, I am using the mut\_sig\_plot.Rmd script to create some plots, which I save in the subfolder called plots. I am reordering the Somatic.Mutation.Type (e.g. A\[C&gt;A\]A, A\[C&gt;A\]C, etc.) according to their Signature.3 Score.

``` r
ref_mut_sig_ordered_by_sig3 %>% head(5) %>% kable()
```

<table>
<thead>
<tr>
<th style="text-align:left;">
Substitution.Type
</th>
<th style="text-align:left;">
Trinucleotide
</th>
<th style="text-align:left;">
Somatic.Mutation.Type
</th>
<th style="text-align:right;">
Signature.1A
</th>
<th style="text-align:right;">
Signature.1B
</th>
<th style="text-align:right;">
Signature.2
</th>
<th style="text-align:right;">
Signature.3
</th>
<th style="text-align:right;">
Signature.4
</th>
<th style="text-align:right;">
Signature.5
</th>
<th style="text-align:right;">
Signature.6
</th>
<th style="text-align:right;">
Signature.7
</th>
<th style="text-align:right;">
Signature.8
</th>
<th style="text-align:right;">
Signature.9
</th>
<th style="text-align:right;">
Signature.10
</th>
<th style="text-align:right;">
Signature.11
</th>
<th style="text-align:right;">
Signature.12
</th>
<th style="text-align:right;">
Signature.13
</th>
<th style="text-align:right;">
Signature.14
</th>
<th style="text-align:right;">
Signature.15
</th>
<th style="text-align:right;">
Signature.16
</th>
<th style="text-align:right;">
Signature.17
</th>
<th style="text-align:right;">
Signature.18
</th>
<th style="text-align:right;">
Signature.19
</th>
<th style="text-align:right;">
Signature.20
</th>
<th style="text-align:right;">
Signature.21
</th>
<th style="text-align:right;">
Signature.R1
</th>
<th style="text-align:right;">
Signature.R2
</th>
<th style="text-align:right;">
Signature.R3
</th>
<th style="text-align:right;">
Signature.U1
</th>
<th style="text-align:right;">
Signature.U2
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACA
</td>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:right;">
0.0112
</td>
<td style="text-align:right;">
0.0104
</td>
<td style="text-align:right;">
0.0105
</td>
<td style="text-align:right;">
0.0240
</td>
<td style="text-align:right;">
0.0365
</td>
<td style="text-align:right;">
0.0149
</td>
<td style="text-align:right;">
0.0017
</td>
<td style="text-align:right;">
0.0004
</td>
<td style="text-align:right;">
0.0368
</td>
<td style="text-align:right;">
0.0120
</td>
<td style="text-align:right;">
0.0007
</td>
<td style="text-align:right;">
2e-04
</td>
<td style="text-align:right;">
0.0077
</td>
<td style="text-align:right;">
0.0007
</td>
<td style="text-align:right;">
0.0001
</td>
<td style="text-align:right;">
0.0013
</td>
<td style="text-align:right;">
0.0161
</td>
<td style="text-align:right;">
0.0018
</td>
<td style="text-align:right;">
0.0500
</td>
<td style="text-align:right;">
0.0107
</td>
<td style="text-align:right;">
0.0013
</td>
<td style="text-align:right;">
1e-04
</td>
<td style="text-align:right;">
0.0210
</td>
<td style="text-align:right;">
0.0137
</td>
<td style="text-align:right;">
0.0044
</td>
<td style="text-align:right;">
0.0105
</td>
<td style="text-align:right;">
0.0221
</td>
</tr>
<tr>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACC
</td>
<td style="text-align:left;">
A\[C&gt;A\]C
</td>
<td style="text-align:right;">
0.0092
</td>
<td style="text-align:right;">
0.0093
</td>
<td style="text-align:right;">
0.0061
</td>
<td style="text-align:right;">
0.0197
</td>
<td style="text-align:right;">
0.0309
</td>
<td style="text-align:right;">
0.0089
</td>
<td style="text-align:right;">
0.0028
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
0.0287
</td>
<td style="text-align:right;">
0.0067
</td>
<td style="text-align:right;">
0.0010
</td>
<td style="text-align:right;">
1e-03
</td>
<td style="text-align:right;">
0.0047
</td>
<td style="text-align:right;">
0.0001
</td>
<td style="text-align:right;">
0.0042
</td>
<td style="text-align:right;">
0.0040
</td>
<td style="text-align:right;">
0.0097
</td>
<td style="text-align:right;">
0.0003
</td>
<td style="text-align:right;">
0.0076
</td>
<td style="text-align:right;">
0.0074
</td>
<td style="text-align:right;">
0.0024
</td>
<td style="text-align:right;">
7e-04
</td>
<td style="text-align:right;">
0.0065
</td>
<td style="text-align:right;">
0.0046
</td>
<td style="text-align:right;">
0.0047
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
0.0123
</td>
</tr>
<tr>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACG
</td>
<td style="text-align:left;">
A\[C&gt;A\]G
</td>
<td style="text-align:right;">
0.0015
</td>
<td style="text-align:right;">
0.0016
</td>
<td style="text-align:right;">
0.0013
</td>
<td style="text-align:right;">
0.0019
</td>
<td style="text-align:right;">
0.0183
</td>
<td style="text-align:right;">
0.0022
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
0.0000
</td>
<td style="text-align:right;">
0.0017
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
0.0003
</td>
<td style="text-align:right;">
0e+00
</td>
<td style="text-align:right;">
0.0017
</td>
<td style="text-align:right;">
0.0001
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
0.0000
</td>
<td style="text-align:right;">
0.0022
</td>
<td style="text-align:right;">
0.0000
</td>
<td style="text-align:right;">
0.0017
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
0.0000
</td>
<td style="text-align:right;">
0e+00
</td>
<td style="text-align:right;">
0.0000
</td>
<td style="text-align:right;">
0.0048
</td>
<td style="text-align:right;">
0.0003
</td>
<td style="text-align:right;">
0.0000
</td>
<td style="text-align:right;">
0.0028
</td>
</tr>
<tr>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACT
</td>
<td style="text-align:left;">
A\[C&gt;A\]T
</td>
<td style="text-align:right;">
0.0063
</td>
<td style="text-align:right;">
0.0067
</td>
<td style="text-align:right;">
0.0037
</td>
<td style="text-align:right;">
0.0172
</td>
<td style="text-align:right;">
0.0243
</td>
<td style="text-align:right;">
0.0092
</td>
<td style="text-align:right;">
0.0019
</td>
<td style="text-align:right;">
0.0004
</td>
<td style="text-align:right;">
0.0300
</td>
<td style="text-align:right;">
0.0068
</td>
<td style="text-align:right;">
0.0092
</td>
<td style="text-align:right;">
2e-04
</td>
<td style="text-align:right;">
0.0046
</td>
<td style="text-align:right;">
0.0002
</td>
<td style="text-align:right;">
0.0296
</td>
<td style="text-align:right;">
0.0057
</td>
<td style="text-align:right;">
0.0088
</td>
<td style="text-align:right;">
0.0032
</td>
<td style="text-align:right;">
0.0181
</td>
<td style="text-align:right;">
0.0074
</td>
<td style="text-align:right;">
0.0029
</td>
<td style="text-align:right;">
6e-04
</td>
<td style="text-align:right;">
0.0058
</td>
<td style="text-align:right;">
0.0081
</td>
<td style="text-align:right;">
0.0034
</td>
<td style="text-align:right;">
0.0112
</td>
<td style="text-align:right;">
0.0118
</td>
</tr>
<tr>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
CCA
</td>
<td style="text-align:left;">
C\[C&gt;A\]A
</td>
<td style="text-align:right;">
0.0067
</td>
<td style="text-align:right;">
0.0090
</td>
<td style="text-align:right;">
0.0061
</td>
<td style="text-align:right;">
0.0194
</td>
<td style="text-align:right;">
0.0461
</td>
<td style="text-align:right;">
0.0097
</td>
<td style="text-align:right;">
0.0101
</td>
<td style="text-align:right;">
0.0012
</td>
<td style="text-align:right;">
0.0303
</td>
<td style="text-align:right;">
0.0098
</td>
<td style="text-align:right;">
0.0031
</td>
<td style="text-align:right;">
7e-04
</td>
<td style="text-align:right;">
0.0135
</td>
<td style="text-align:right;">
0.0035
</td>
<td style="text-align:right;">
0.0056
</td>
<td style="text-align:right;">
0.0106
</td>
<td style="text-align:right;">
0.0159
</td>
<td style="text-align:right;">
0.0010
</td>
<td style="text-align:right;">
0.0965
</td>
<td style="text-align:right;">
0.0112
</td>
<td style="text-align:right;">
0.0178
</td>
<td style="text-align:right;">
2e-03
</td>
<td style="text-align:right;">
0.0076
</td>
<td style="text-align:right;">
0.3117
</td>
<td style="text-align:right;">
0.0156
</td>
<td style="text-align:right;">
0.0173
</td>
<td style="text-align:right;">
0.0057
</td>
</tr>
</tbody>
</table>
Note. We are still with the original format of the reference signatures here. I have decided to present only one example of ordering the data according to a factor, for more examples, you may refer to previous work from [homework 5](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/blob/master/stat545-hw5-thibodeau-mylinh/stat545-hw05-thibodeau-mylinh.md).

1.  Writing the mutational signatures input/output to files is performed (embedded) in the scripts mentioned above. I have read and written a lot of files in each script. Please refer to the section "Automate the pipeline" below.

------------------------------------------------------------------------

Perform statistical analyses
============================

Tasks:

-   Import the data created in the first script.
-   Make sure your new continent order is still in force. You decide the details.
-   Fit a linear regression of life expectancy on year within each country. Write the estimated intercepts, slopes, and residual error variance (or sd) to file. The R package broom may be useful here.
-   Find the 3 or 4 “worst” and “best” countries for each continent. You decide the details.

As you know, I am using genomic data, so I have to adapt the tasks to my data, so here is what I did:

1.  I am importing and cleaning the data with my script read\_clean\_genome\_text\_files.R:

-   reference mutation signatures (mut\_sig.txt)
-   somatic mutations for 5 types of cancer: ALL, AML, breast, medulloblastoma, pancreas

I have performed the same "gathering" steps as described in the previous section for each cancer type.

``` r
ALL_mut_gather  %>% arrange(Mutation.Type) %>% head(5) %>% kable()
```

<table>
<thead>
<tr>
<th style="text-align:left;">
Mutation.Type
</th>
<th style="text-align:left;">
case\_id
</th>
<th style="text-align:right;">
number
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
33
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]C
</td>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
15
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]G
</td>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]T
</td>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
24
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;G\]A
</td>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
31
</td>
</tr>
</tbody>
</table>
``` r
aml_mut_gather  %>% arrange(Mutation.Type) %>% head(5) %>% kable()
```

<table>
<thead>
<tr>
<th style="text-align:left;">
Mutation.Type
</th>
<th style="text-align:left;">
case\_id
</th>
<th style="text-align:right;">
number
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
X400220
</td>
<td style="text-align:right;">
8
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
X426980
</td>
<td style="text-align:right;">
11
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
X452198
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
X573988
</td>
<td style="text-align:right;">
3
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
X758168
</td>
<td style="text-align:right;">
11
</td>
</tr>
</tbody>
</table>
``` r
breast_mut_gather  %>% arrange(Mutation.Type) %>% head(5) %>% kable()
```

<table>
<thead>
<tr>
<th style="text-align:left;">
Mutation.Type
</th>
<th style="text-align:left;">
case\_id
</th>
<th style="text-align:right;">
number
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
PD3851a
</td>
<td style="text-align:right;">
29
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
PD3890a
</td>
<td style="text-align:right;">
99
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
PD3904a
</td>
<td style="text-align:right;">
114
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
PD3905a
</td>
<td style="text-align:right;">
88
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
PD3945a
</td>
<td style="text-align:right;">
235
</td>
</tr>
</tbody>
</table>
``` r
medullo_mut_gather  %>% arrange(Mutation.Type) %>% head(5) %>% kable()
```

<table>
<thead>
<tr>
<th style="text-align:left;">
Mutation.Type
</th>
<th style="text-align:left;">
case\_id
</th>
<th style="text-align:right;">
number
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
LFS\_MB1
</td>
<td style="text-align:right;">
45
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
LFS\_MB2
</td>
<td style="text-align:right;">
23
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
LFS\_MB4
</td>
<td style="text-align:right;">
24
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
MB1
</td>
<td style="text-align:right;">
6
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
MB101
</td>
<td style="text-align:right;">
82
</td>
</tr>
</tbody>
</table>
``` r
pancreas_mut_gather  %>% arrange(Mutation.Type) %>% head(5) %>% kable()
```

<table>
<thead>
<tr>
<th style="text-align:left;">
Mutation.Type
</th>
<th style="text-align:left;">
case\_id
</th>
<th style="text-align:right;">
number
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
APGI\_1839
</td>
<td style="text-align:right;">
77
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
APGI\_1840
</td>
<td style="text-align:right;">
156
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
APGI\_1956
</td>
<td style="text-align:right;">
59
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
APGI\_1992
</td>
<td style="text-align:right;">
117
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
APGI\_2000
</td>
<td style="text-align:right;">
122
</td>
</tr>
</tbody>
</table>
1.  The Somatic.Mutation.Type of the mut\_sig.tsv (reference data) are still ordered according to Signature.3 values, as illustrated in Signature3\_compare\_plots.pdf

![sig3](plots/Signature3_compare_plots.pdf)

1.  Here, we are not looking at signatures of the reference somatic mutation (mut\_sig.tsv) but we are looking at the Mutation.Type of 5 types of cancer: ALL, AML, breast, medulloblastoma, pancreas.

#### Summary statistics

We will be looking at the mean, median, standard deviation and count of each Mutation.Type in each dataset (we need the "gathered" versions of files for that step).

``` r
all_cancer_types_stats %>% head(10) %>% kable()
```

<table>
<thead>
<tr>
<th style="text-align:left;">
Mutation.Type
</th>
<th style="text-align:right;">
mean\_aml
</th>
<th style="text-align:right;">
median\_aml
</th>
<th style="text-align:right;">
sd\_aml
</th>
<th style="text-align:right;">
total\_aml
</th>
<th style="text-align:right;">
mean\_breast
</th>
<th style="text-align:right;">
median\_breast
</th>
<th style="text-align:right;">
sd\_breast
</th>
<th style="text-align:right;">
total\_breast
</th>
<th style="text-align:right;">
mean\_medullo
</th>
<th style="text-align:right;">
median\_medullo
</th>
<th style="text-align:right;">
sd\_medullo
</th>
<th style="text-align:right;">
total\_medullo
</th>
<th style="text-align:right;">
mean\_pancreas
</th>
<th style="text-align:right;">
median\_pancreas
</th>
<th style="text-align:right;">
sd\_pancreas
</th>
<th style="text-align:right;">
total\_pancreas
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:right;">
7.8571429
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:right;">
4.4131837
</td>
<td style="text-align:right;">
55
</td>
<td style="text-align:right;">
70.571429
</td>
<td style="text-align:right;">
48
</td>
<td style="text-align:right;">
65.041000
</td>
<td style="text-align:right;">
8398
</td>
<td style="text-align:right;">
24.73
</td>
<td style="text-align:right;">
16.5
</td>
<td style="text-align:right;">
28.889149
</td>
<td style="text-align:right;">
2473
</td>
<td style="text-align:right;">
121.866667
</td>
<td style="text-align:right;">
98
</td>
<td style="text-align:right;">
74.126211
</td>
<td style="text-align:right;">
1828
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]C
</td>
<td style="text-align:right;">
4.8571429
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
4.4880794
</td>
<td style="text-align:right;">
34
</td>
<td style="text-align:right;">
60.949580
</td>
<td style="text-align:right;">
39
</td>
<td style="text-align:right;">
51.024230
</td>
<td style="text-align:right;">
7253
</td>
<td style="text-align:right;">
19.70
</td>
<td style="text-align:right;">
12.5
</td>
<td style="text-align:right;">
24.634910
</td>
<td style="text-align:right;">
1970
</td>
<td style="text-align:right;">
90.600000
</td>
<td style="text-align:right;">
77
</td>
<td style="text-align:right;">
53.730545
</td>
<td style="text-align:right;">
1359
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]G
</td>
<td style="text-align:right;">
0.8571429
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0.8997354
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
8.747899
</td>
<td style="text-align:right;">
7
</td>
<td style="text-align:right;">
6.891678
</td>
<td style="text-align:right;">
1041
</td>
<td style="text-align:right;">
2.80
</td>
<td style="text-align:right;">
2.0
</td>
<td style="text-align:right;">
3.305948
</td>
<td style="text-align:right;">
280
</td>
<td style="text-align:right;">
12.133333
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:right;">
9.203002
</td>
<td style="text-align:right;">
182
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]T
</td>
<td style="text-align:right;">
5.1428571
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
3.7161168
</td>
<td style="text-align:right;">
36
</td>
<td style="text-align:right;">
54.873950
</td>
<td style="text-align:right;">
33
</td>
<td style="text-align:right;">
50.542909
</td>
<td style="text-align:right;">
6530
</td>
<td style="text-align:right;">
17.72
</td>
<td style="text-align:right;">
11.0
</td>
<td style="text-align:right;">
23.407277
</td>
<td style="text-align:right;">
1772
</td>
<td style="text-align:right;">
81.466667
</td>
<td style="text-align:right;">
66
</td>
<td style="text-align:right;">
60.053389
</td>
<td style="text-align:right;">
1222
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;G\]A
</td>
<td style="text-align:right;">
3.8571429
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
3.8047589
</td>
<td style="text-align:right;">
27
</td>
<td style="text-align:right;">
46.445378
</td>
<td style="text-align:right;">
22
</td>
<td style="text-align:right;">
45.246912
</td>
<td style="text-align:right;">
5527
</td>
<td style="text-align:right;">
13.18
</td>
<td style="text-align:right;">
10.0
</td>
<td style="text-align:right;">
13.096672
</td>
<td style="text-align:right;">
1318
</td>
<td style="text-align:right;">
64.866667
</td>
<td style="text-align:right;">
53
</td>
<td style="text-align:right;">
56.628951
</td>
<td style="text-align:right;">
973
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;G\]C
</td>
<td style="text-align:right;">
1.8571429
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
1.6761634
</td>
<td style="text-align:right;">
13
</td>
<td style="text-align:right;">
28.512605
</td>
<td style="text-align:right;">
17
</td>
<td style="text-align:right;">
24.791287
</td>
<td style="text-align:right;">
3393
</td>
<td style="text-align:right;">
7.44
</td>
<td style="text-align:right;">
7.0
</td>
<td style="text-align:right;">
7.455349
</td>
<td style="text-align:right;">
744
</td>
<td style="text-align:right;">
37.000000
</td>
<td style="text-align:right;">
24
</td>
<td style="text-align:right;">
28.869163
</td>
<td style="text-align:right;">
555
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;G\]G
</td>
<td style="text-align:right;">
0.7142857
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
1.1126973
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:right;">
11.159664
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
13.038394
</td>
<td style="text-align:right;">
1328
</td>
<td style="text-align:right;">
2.37
</td>
<td style="text-align:right;">
2.0
</td>
<td style="text-align:right;">
2.033333
</td>
<td style="text-align:right;">
237
</td>
<td style="text-align:right;">
9.466667
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:right;">
8.078779
</td>
<td style="text-align:right;">
142
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;G\]T
</td>
<td style="text-align:right;">
3.5714286
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
3.1547394
</td>
<td style="text-align:right;">
25
</td>
<td style="text-align:right;">
47.663865
</td>
<td style="text-align:right;">
23
</td>
<td style="text-align:right;">
47.465648
</td>
<td style="text-align:right;">
5672
</td>
<td style="text-align:right;">
10.35
</td>
<td style="text-align:right;">
8.0
</td>
<td style="text-align:right;">
9.976108
</td>
<td style="text-align:right;">
1035
</td>
<td style="text-align:right;">
64.066667
</td>
<td style="text-align:right;">
32
</td>
<td style="text-align:right;">
59.666294
</td>
<td style="text-align:right;">
961
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;T\]A
</td>
<td style="text-align:right;">
18.4285714
</td>
<td style="text-align:right;">
15
</td>
<td style="text-align:right;">
14.3742495
</td>
<td style="text-align:right;">
129
</td>
<td style="text-align:right;">
78.672269
</td>
<td style="text-align:right;">
57
</td>
<td style="text-align:right;">
55.095312
</td>
<td style="text-align:right;">
9362
</td>
<td style="text-align:right;">
31.86
</td>
<td style="text-align:right;">
22.5
</td>
<td style="text-align:right;">
29.770170
</td>
<td style="text-align:right;">
3186
</td>
<td style="text-align:right;">
141.933333
</td>
<td style="text-align:right;">
133
</td>
<td style="text-align:right;">
57.274361
</td>
<td style="text-align:right;">
2129
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;T\]C
</td>
<td style="text-align:right;">
8.1428571
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:right;">
6.3358391
</td>
<td style="text-align:right;">
57
</td>
<td style="text-align:right;">
40.663865
</td>
<td style="text-align:right;">
33
</td>
<td style="text-align:right;">
24.169345
</td>
<td style="text-align:right;">
4839
</td>
<td style="text-align:right;">
16.07
</td>
<td style="text-align:right;">
11.5
</td>
<td style="text-align:right;">
14.968826
</td>
<td style="text-align:right;">
1607
</td>
<td style="text-align:right;">
61.600000
</td>
<td style="text-align:right;">
53
</td>
<td style="text-align:right;">
29.056103
</td>
<td style="text-align:right;">
924
</td>
</tr>
</tbody>
</table>
Note. I wrote some stats tables for individual cancer types, then aggregated them (I peaked at how to make a loop [here](https://www.datacamp.com/community/tutorials/tutorial-on-loops-in-r), but ended up performing the task on individual dataset because I couldn't figure out how to avoid "overwriting" at each loop iteration). The summary statistics tables are available [here](statistics/)

#### Some linear regression modeling

*I have used this website [here](http://varianceexplained.org/r/broom-intro/) discussing broom and variance, and this website [here](https://cran.r-project.org/web/packages/broom/vignettes/broom.html) on some broom vignettes. And that's the moment I realized I didn't have two quantitative variables to perform linear regression modelling. This is a recurring problem with me: I always get into performing the analyses before making sure that the dataset format is appropriate (check this hw04 readme file [here](https://github.com/mylinhthibodeau/STAT545-HW-thibodeau-mylinh/tree/master/stat545-hw4-thibodeau-mylinh) if you want an example).*

So instead of fitting a linear regression of the lifeExp according to year, I will do something slightly different:

#### Merging and ploting linear regression

I will merge the cancer somatic data with the reference signature data, and I will fit a linear regression between Signature.3 and Signature.12 and then Signature.2 and Signature.13 (see [here](http://cancer.sanger.ac.uk/cosmic/signatures) for more details on mutational signatures).

![p3\_linear\_Sig3\_Sig12](plots/p3_linear_Sig3_Sig12.pdf)

Note.1. It looks like the T&gt;C somatic mutation group is the one differing the most between Signature.3 and Signature.12, but otherwise, these two signatures could fit "relatively well" a linear regression model (although this is obviously not the best model for this type of data, because the adjusted R-squared value is below zero = the model does not fit the data very well).

Note.2. The code and format used above to add a label with the linear regression formula used the following references:

-   A stack overflow discussion on [Regression equation](https://stackoverflow.com/questions/37494969/ggplot2-add-regression-equations-and-r2-and-adjust-their-positions-on-plot)
-   The stack overflow discussion on [Label position](https://stackoverflow.com/questions/37254279/dynamic-label-position-stat-poly-eq-and-ggplot2) discussion was also useful.
-   This article of the [cran rstudio website](https://cran.rstudio.com/web/packages/ggpmisc/vignettes/user-guide-1.html) was also used.

``` r
lm(Signature.12 ~ Signature.3, mut_sig) %>% coef()
```

    ## (Intercept) Signature.3 
    ## 0.008322249 0.201064066

Note. We obtain the same Intercept and Signature.3 coefficient than in our plot (see label formula)

Just for fun, I want to check if a linear regression would be a better fit if I remove the Substitution.Type T&gt;C.

![p3\_linear\_Sig3\_Sig12](plots/p3_linear_Sig3_Sig12.pdf) Note. It does seem like the most different values between these two signatures are the T&gt;C Substitution.Type, as our new adjusted R-squared tells us that 15% of the variance of Signature.12 can be explained by Signature.3 if we remove T&gt;C.

Now, let's assess the linear regression model between Signature.2 and Signature.13.

![p5\_linear\_Sig2\_Sig13](plots/p5_linear_Sig2_Sig13.pdf) Note. We do get a very high adjusted R-squared value, and this is because these two signatures are thought to be related to the same underlying mutational processes (see [here](http://cancer.sanger.ac.uk/cosmic/signatures) for more details on mutational signatures). Therefore, we can deduce that the Mutation.Type profiles of Signature.2 and Signature.13 are quite similar.

``` r
lm(Signature.13 ~ Signature.2, mut_sig) %>% coef()
```

    ##  (Intercept)  Signature.2 
    ## -0.001509612  1.144922739

I will also show a plot of the number of mutations for all cancer types according to Signature.3 and see what the linear regression looks like.

![p2\_linear\_Sig3\_all\_cancer\_mutations](plots/p2_linear_Sig3_all_cancer_mutations.pdf)

#### Find the 3 or 4 "worst" or "best" Signature.3 scores for each cancer\_type.

Let's see the cases with the lowest and highest proportion of mutations caused by Signature.3 :

``` r
all_cancer_types_mut_proportion_signatures  %>% 
    group_by(case_id, Signature) %>% 
    filter(Signature=="Signature.3") %>%
    arrange(mutations_per_snv_sig_score) %>%
    head(3) %>% kable()
```

<table>
<thead>
<tr>
<th style="text-align:left;">
case\_id
</th>
<th style="text-align:right;">
total\_number\_mutation\_per\_case
</th>
<th style="text-align:left;">
Mutation.Type
</th>
<th style="text-align:right;">
number
</th>
<th style="text-align:left;">
cancer\_type
</th>
<th style="text-align:left;">
Substitution.Type
</th>
<th style="text-align:left;">
Trinucleotide
</th>
<th style="text-align:left;">
Signature
</th>
<th style="text-align:right;">
Score
</th>
<th style="text-align:right;">
mutations\_per\_snv\_sig\_score
</th>
<th style="text-align:right;">
proportion\_number\_each\_snv\_each\_sig
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
MB28
</td>
<td style="text-align:right;">
44
</td>
<td style="text-align:left;">
C\[T&gt;G\]A
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:left;">
medullo
</td>
<td style="text-align:left;">
T&gt;G
</td>
<td style="text-align:left;">
CTA
</td>
<td style="text-align:left;">
Signature.3
</td>
<td style="text-align:right;">
7e-04
</td>
<td style="text-align:right;">
0.0011407
</td>
<td style="text-align:right;">
2.59e-05
</td>
</tr>
<tr>
<td style="text-align:left;">
MB28
</td>
<td style="text-align:right;">
44
</td>
<td style="text-align:left;">
A\[T&gt;G\]A
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:left;">
medullo
</td>
<td style="text-align:left;">
T&gt;G
</td>
<td style="text-align:left;">
ATA
</td>
<td style="text-align:left;">
Signature.3
</td>
<td style="text-align:right;">
8e-04
</td>
<td style="text-align:right;">
0.0013037
</td>
<td style="text-align:right;">
2.96e-05
</td>
</tr>
<tr>
<td style="text-align:left;">
MB28
</td>
<td style="text-align:right;">
44
</td>
<td style="text-align:left;">
G\[C&gt;T\]G
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:left;">
medullo
</td>
<td style="text-align:left;">
C&gt;T
</td>
<td style="text-align:left;">
GCG
</td>
<td style="text-align:left;">
Signature.3
</td>
<td style="text-align:right;">
9e-04
</td>
<td style="text-align:right;">
0.0014667
</td>
<td style="text-align:right;">
3.33e-05
</td>
</tr>
</tbody>
</table>
``` r
all_cancer_types_mut_proportion_signatures  %>% 
    group_by(case_id) %>% 
    filter(Signature=="Signature.3") %>%
    arrange(desc(mutations_per_snv_sig_score)) %>%
    head(3) %>% kable()
```

<table>
<thead>
<tr>
<th style="text-align:left;">
case\_id
</th>
<th style="text-align:right;">
total\_number\_mutation\_per\_case
</th>
<th style="text-align:left;">
Mutation.Type
</th>
<th style="text-align:right;">
number
</th>
<th style="text-align:left;">
cancer\_type
</th>
<th style="text-align:left;">
Substitution.Type
</th>
<th style="text-align:left;">
Trinucleotide
</th>
<th style="text-align:left;">
Signature
</th>
<th style="text-align:right;">
Score
</th>
<th style="text-align:right;">
mutations\_per\_snv\_sig\_score
</th>
<th style="text-align:right;">
proportion\_number\_each\_snv\_each\_sig
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
PD4120a
</td>
<td style="text-align:right;">
67364
</td>
<td style="text-align:left;">
T\[C&gt;G\]T
</td>
<td style="text-align:right;">
12919
</td>
<td style="text-align:left;">
breast
</td>
<td style="text-align:left;">
C&gt;G
</td>
<td style="text-align:left;">
TCT
</td>
<td style="text-align:left;">
Signature.3
</td>
<td style="text-align:right;">
0.0302
</td>
<td style="text-align:right;">
75.34788
</td>
<td style="text-align:right;">
0.0011185
</td>
</tr>
<tr>
<td style="text-align:left;">
PD4120a
</td>
<td style="text-align:right;">
67364
</td>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:right;">
114
</td>
<td style="text-align:left;">
breast
</td>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACA
</td>
<td style="text-align:left;">
Signature.3
</td>
<td style="text-align:right;">
0.0240
</td>
<td style="text-align:right;">
59.87911
</td>
<td style="text-align:right;">
0.0008889
</td>
</tr>
<tr>
<td style="text-align:left;">
PD4120a
</td>
<td style="text-align:right;">
67364
</td>
<td style="text-align:left;">
C\[C&gt;G\]T
</td>
<td style="text-align:right;">
225
</td>
<td style="text-align:left;">
breast
</td>
<td style="text-align:left;">
C&gt;G
</td>
<td style="text-align:left;">
CCT
</td>
<td style="text-align:left;">
Signature.3
</td>
<td style="text-align:right;">
0.0218
</td>
<td style="text-align:right;">
54.39019
</td>
<td style="text-align:right;">
0.0008074
</td>
</tr>
</tbody>
</table>
Note. This actually makes sense because breast cancer usually has higher Signature.3 due to homologous recombination repair deficiency, often secondary to *BRCA1/BRCA2* loss of function.

------------------------------------------------------------------------

Generate figures
================

No worries here, I have generated plenty of figures.

------------------------------------------------------------------------

Automate the pipeline (see Makefile)
====================================

-   mut\_clean\_genome\_text\_files.R -&gt; takes as input the file mut\_sig\_raw.txt and writes the cleaned up/formated version mut\_sig.txt
-   mut\_sig\_reorder.R -&gt; reorder the mut\_sig.txt Somatic.Mutation.Type according to Signature.3
-   mut\_sig\_tables.R -&gt; uses tidyverse function gather to go from a "wide" to a "long" dataset format and it is also used to perform aggregation taskts, so that the data can be ready for plots later one.
-   mut\_sig\_stat.R -&gt; input the "gathered" dataset files of each cancer type, group by Mutation.Type and outputs files containing summary statistics (mean, median, sd, total)
-   mut\_sig\_plot.R -&gt; input the "gathered" and/or "aggregated" dataset files and produces plots of two types: general data plots, linear modeling plots.
-   summary\_file.Rmd -&gt; this current file is a summary of this homework, and it has for input the output of the scripts previously mentioned.
-   Makefile -&gt; this is the script that runs all the scripts above and coordinate the steps.

------------------------------------------------------------------------

Additional material - optional
==============================

Here are some samples of the data files I have written:

``` r
head(all_cancer_types_mut) %>% kable()
```

<table>
<thead>
<tr>
<th style="text-align:left;">
Mutation.Type
</th>
<th style="text-align:left;">
case\_id
</th>
<th style="text-align:right;">
number
</th>
<th style="text-align:left;">
cancer\_type
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
33
</td>
<td style="text-align:left;">
ALL
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]C
</td>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
15
</td>
<td style="text-align:left;">
ALL
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]G
</td>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
ALL
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]T
</td>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
24
</td>
<td style="text-align:left;">
ALL
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;G\]A
</td>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
31
</td>
<td style="text-align:left;">
ALL
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;G\]C
</td>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:left;">
ALL
</td>
</tr>
</tbody>
</table>
``` r
head(all_cancer_types_mut_with_ref_sig) %>% kable()
```

<table>
<thead>
<tr>
<th style="text-align:left;">
Mutation.Type
</th>
<th style="text-align:left;">
case\_id
</th>
<th style="text-align:right;">
number
</th>
<th style="text-align:left;">
cancer\_type
</th>
<th style="text-align:left;">
Substitution.Type
</th>
<th style="text-align:left;">
Trinucleotide
</th>
<th style="text-align:right;">
Signature.1A
</th>
<th style="text-align:right;">
Signature.1B
</th>
<th style="text-align:right;">
Signature.2
</th>
<th style="text-align:right;">
Signature.3
</th>
<th style="text-align:right;">
Signature.4
</th>
<th style="text-align:right;">
Signature.5
</th>
<th style="text-align:right;">
Signature.6
</th>
<th style="text-align:right;">
Signature.7
</th>
<th style="text-align:right;">
Signature.8
</th>
<th style="text-align:right;">
Signature.9
</th>
<th style="text-align:right;">
Signature.10
</th>
<th style="text-align:right;">
Signature.11
</th>
<th style="text-align:right;">
Signature.12
</th>
<th style="text-align:right;">
Signature.13
</th>
<th style="text-align:right;">
Signature.14
</th>
<th style="text-align:right;">
Signature.15
</th>
<th style="text-align:right;">
Signature.16
</th>
<th style="text-align:right;">
Signature.17
</th>
<th style="text-align:right;">
Signature.18
</th>
<th style="text-align:right;">
Signature.19
</th>
<th style="text-align:right;">
Signature.20
</th>
<th style="text-align:right;">
Signature.21
</th>
<th style="text-align:right;">
Signature.R1
</th>
<th style="text-align:right;">
Signature.R2
</th>
<th style="text-align:right;">
Signature.R3
</th>
<th style="text-align:right;">
Signature.U1
</th>
<th style="text-align:right;">
Signature.U2
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
33
</td>
<td style="text-align:left;">
ALL
</td>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACA
</td>
<td style="text-align:right;">
0.0112
</td>
<td style="text-align:right;">
0.0104
</td>
<td style="text-align:right;">
0.0105
</td>
<td style="text-align:right;">
0.0240
</td>
<td style="text-align:right;">
0.0365
</td>
<td style="text-align:right;">
0.0149
</td>
<td style="text-align:right;">
0.0017
</td>
<td style="text-align:right;">
4e-04
</td>
<td style="text-align:right;">
0.0368
</td>
<td style="text-align:right;">
0.0120
</td>
<td style="text-align:right;">
0.0007
</td>
<td style="text-align:right;">
2e-04
</td>
<td style="text-align:right;">
0.0077
</td>
<td style="text-align:right;">
0.0007
</td>
<td style="text-align:right;">
0.0001
</td>
<td style="text-align:right;">
0.0013
</td>
<td style="text-align:right;">
0.0161
</td>
<td style="text-align:right;">
0.0018
</td>
<td style="text-align:right;">
0.0500
</td>
<td style="text-align:right;">
0.0107
</td>
<td style="text-align:right;">
0.0013
</td>
<td style="text-align:right;">
1e-04
</td>
<td style="text-align:right;">
0.0210
</td>
<td style="text-align:right;">
0.0137
</td>
<td style="text-align:right;">
0.0044
</td>
<td style="text-align:right;">
0.0105
</td>
<td style="text-align:right;">
0.0221
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]C
</td>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
15
</td>
<td style="text-align:left;">
ALL
</td>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACC
</td>
<td style="text-align:right;">
0.0092
</td>
<td style="text-align:right;">
0.0093
</td>
<td style="text-align:right;">
0.0061
</td>
<td style="text-align:right;">
0.0197
</td>
<td style="text-align:right;">
0.0309
</td>
<td style="text-align:right;">
0.0089
</td>
<td style="text-align:right;">
0.0028
</td>
<td style="text-align:right;">
5e-04
</td>
<td style="text-align:right;">
0.0287
</td>
<td style="text-align:right;">
0.0067
</td>
<td style="text-align:right;">
0.0010
</td>
<td style="text-align:right;">
1e-03
</td>
<td style="text-align:right;">
0.0047
</td>
<td style="text-align:right;">
0.0001
</td>
<td style="text-align:right;">
0.0042
</td>
<td style="text-align:right;">
0.0040
</td>
<td style="text-align:right;">
0.0097
</td>
<td style="text-align:right;">
0.0003
</td>
<td style="text-align:right;">
0.0076
</td>
<td style="text-align:right;">
0.0074
</td>
<td style="text-align:right;">
0.0024
</td>
<td style="text-align:right;">
7e-04
</td>
<td style="text-align:right;">
0.0065
</td>
<td style="text-align:right;">
0.0046
</td>
<td style="text-align:right;">
0.0047
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
0.0123
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]G
</td>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
ALL
</td>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACG
</td>
<td style="text-align:right;">
0.0015
</td>
<td style="text-align:right;">
0.0016
</td>
<td style="text-align:right;">
0.0013
</td>
<td style="text-align:right;">
0.0019
</td>
<td style="text-align:right;">
0.0183
</td>
<td style="text-align:right;">
0.0022
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
0e+00
</td>
<td style="text-align:right;">
0.0017
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
0.0003
</td>
<td style="text-align:right;">
0e+00
</td>
<td style="text-align:right;">
0.0017
</td>
<td style="text-align:right;">
0.0001
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
0.0000
</td>
<td style="text-align:right;">
0.0022
</td>
<td style="text-align:right;">
0.0000
</td>
<td style="text-align:right;">
0.0017
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
0.0000
</td>
<td style="text-align:right;">
0e+00
</td>
<td style="text-align:right;">
0.0000
</td>
<td style="text-align:right;">
0.0048
</td>
<td style="text-align:right;">
0.0003
</td>
<td style="text-align:right;">
0.0000
</td>
<td style="text-align:right;">
0.0028
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;A\]T
</td>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
24
</td>
<td style="text-align:left;">
ALL
</td>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACT
</td>
<td style="text-align:right;">
0.0063
</td>
<td style="text-align:right;">
0.0067
</td>
<td style="text-align:right;">
0.0037
</td>
<td style="text-align:right;">
0.0172
</td>
<td style="text-align:right;">
0.0243
</td>
<td style="text-align:right;">
0.0092
</td>
<td style="text-align:right;">
0.0019
</td>
<td style="text-align:right;">
4e-04
</td>
<td style="text-align:right;">
0.0300
</td>
<td style="text-align:right;">
0.0068
</td>
<td style="text-align:right;">
0.0092
</td>
<td style="text-align:right;">
2e-04
</td>
<td style="text-align:right;">
0.0046
</td>
<td style="text-align:right;">
0.0002
</td>
<td style="text-align:right;">
0.0296
</td>
<td style="text-align:right;">
0.0057
</td>
<td style="text-align:right;">
0.0088
</td>
<td style="text-align:right;">
0.0032
</td>
<td style="text-align:right;">
0.0181
</td>
<td style="text-align:right;">
0.0074
</td>
<td style="text-align:right;">
0.0029
</td>
<td style="text-align:right;">
6e-04
</td>
<td style="text-align:right;">
0.0058
</td>
<td style="text-align:right;">
0.0081
</td>
<td style="text-align:right;">
0.0034
</td>
<td style="text-align:right;">
0.0112
</td>
<td style="text-align:right;">
0.0118
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;G\]A
</td>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
31
</td>
<td style="text-align:left;">
ALL
</td>
<td style="text-align:left;">
C&gt;G
</td>
<td style="text-align:left;">
ACA
</td>
<td style="text-align:right;">
0.0018
</td>
<td style="text-align:right;">
0.0051
</td>
<td style="text-align:right;">
0.0048
</td>
<td style="text-align:right;">
0.0216
</td>
<td style="text-align:right;">
0.0097
</td>
<td style="text-align:right;">
0.0117
</td>
<td style="text-align:right;">
0.0013
</td>
<td style="text-align:right;">
0e+00
</td>
<td style="text-align:right;">
0.0085
</td>
<td style="text-align:right;">
0.0048
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
7e-04
</td>
<td style="text-align:right;">
0.0031
</td>
<td style="text-align:right;">
0.0018
</td>
<td style="text-align:right;">
0.0001
</td>
<td style="text-align:right;">
0.0011
</td>
<td style="text-align:right;">
0.0048
</td>
<td style="text-align:right;">
0.0016
</td>
<td style="text-align:right;">
0.0014
</td>
<td style="text-align:right;">
0.0058
</td>
<td style="text-align:right;">
0.0005
</td>
<td style="text-align:right;">
5e-04
</td>
<td style="text-align:right;">
0.0038
</td>
<td style="text-align:right;">
0.0024
</td>
<td style="text-align:right;">
0.0012
</td>
<td style="text-align:right;">
0.0044
</td>
<td style="text-align:right;">
0.0108
</td>
</tr>
<tr>
<td style="text-align:left;">
A\[C&gt;G\]C
</td>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:left;">
ALL
</td>
<td style="text-align:left;">
C&gt;G
</td>
<td style="text-align:left;">
ACC
</td>
<td style="text-align:right;">
0.0026
</td>
<td style="text-align:right;">
0.0043
</td>
<td style="text-align:right;">
0.0031
</td>
<td style="text-align:right;">
0.0109
</td>
<td style="text-align:right;">
0.0054
</td>
<td style="text-align:right;">
0.0073
</td>
<td style="text-align:right;">
0.0012
</td>
<td style="text-align:right;">
0e+00
</td>
<td style="text-align:right;">
0.0037
</td>
<td style="text-align:right;">
0.0023
</td>
<td style="text-align:right;">
0.0003
</td>
<td style="text-align:right;">
3e-04
</td>
<td style="text-align:right;">
0.0015
</td>
<td style="text-align:right;">
0.0014
</td>
<td style="text-align:right;">
0.0000
</td>
<td style="text-align:right;">
0.0001
</td>
<td style="text-align:right;">
0.0024
</td>
<td style="text-align:right;">
0.0016
</td>
<td style="text-align:right;">
0.0017
</td>
<td style="text-align:right;">
0.0019
</td>
<td style="text-align:right;">
0.0022
</td>
<td style="text-align:right;">
8e-04
</td>
<td style="text-align:right;">
0.0046
</td>
<td style="text-align:right;">
0.0018
</td>
<td style="text-align:right;">
0.0015
</td>
<td style="text-align:right;">
0.0065
</td>
<td style="text-align:right;">
0.0074
</td>
</tr>
</tbody>
</table>
``` r
head(all_cancer_mutations_per_snv_sig_score) %>% kable()
```

<table>
<thead>
<tr>
<th style="text-align:left;">
case\_id
</th>
<th style="text-align:right;">
total\_number\_mutation\_per\_case
</th>
<th style="text-align:left;">
Mutation.Type
</th>
<th style="text-align:right;">
number
</th>
<th style="text-align:left;">
cancer\_type
</th>
<th style="text-align:left;">
Substitution.Type
</th>
<th style="text-align:left;">
Trinucleotide
</th>
<th style="text-align:left;">
Signature
</th>
<th style="text-align:right;">
Score
</th>
<th style="text-align:right;">
mutations\_per\_snv\_sig\_score
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
7741
</td>
<td style="text-align:left;">
A\[C&gt;A\]A
</td>
<td style="text-align:right;">
33
</td>
<td style="text-align:left;">
ALL
</td>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACA
</td>
<td style="text-align:left;">
Signature.1A
</td>
<td style="text-align:right;">
0.0112
</td>
<td style="text-align:right;">
3.2110815
</td>
</tr>
<tr>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
7741
</td>
<td style="text-align:left;">
A\[C&gt;A\]C
</td>
<td style="text-align:right;">
15
</td>
<td style="text-align:left;">
ALL
</td>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACC
</td>
<td style="text-align:left;">
Signature.1A
</td>
<td style="text-align:right;">
0.0092
</td>
<td style="text-align:right;">
2.6376741
</td>
</tr>
<tr>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
7741
</td>
<td style="text-align:left;">
A\[C&gt;A\]G
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
ALL
</td>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACG
</td>
<td style="text-align:left;">
Signature.1A
</td>
<td style="text-align:right;">
0.0015
</td>
<td style="text-align:right;">
0.4300556
</td>
</tr>
<tr>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
7741
</td>
<td style="text-align:left;">
A\[C&gt;A\]T
</td>
<td style="text-align:right;">
24
</td>
<td style="text-align:left;">
ALL
</td>
<td style="text-align:left;">
C&gt;A
</td>
<td style="text-align:left;">
ACT
</td>
<td style="text-align:left;">
Signature.1A
</td>
<td style="text-align:right;">
0.0063
</td>
<td style="text-align:right;">
1.8062333
</td>
</tr>
<tr>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
7741
</td>
<td style="text-align:left;">
A\[C&gt;G\]A
</td>
<td style="text-align:right;">
31
</td>
<td style="text-align:left;">
ALL
</td>
<td style="text-align:left;">
C&gt;G
</td>
<td style="text-align:left;">
ACA
</td>
<td style="text-align:left;">
Signature.1A
</td>
<td style="text-align:right;">
0.0018
</td>
<td style="text-align:right;">
0.5160667
</td>
</tr>
<tr>
<td style="text-align:left;">
PD4020a
</td>
<td style="text-align:right;">
7741
</td>
<td style="text-align:left;">
A\[C&gt;G\]C
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:left;">
ALL
</td>
<td style="text-align:left;">
C&gt;G
</td>
<td style="text-align:left;">
ACC
</td>
<td style="text-align:left;">
Signature.1A
</td>
<td style="text-align:right;">
0.0026
</td>
<td style="text-align:right;">
0.7454296
</td>
</tr>
</tbody>
</table>
