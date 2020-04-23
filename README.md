<!-- README.md is generated from README.Rmd. Please edit that file -->

mineDisProt
===========

The package mineDisProt was developed to extract data from unstructured
or semi-structured formats and compile into matrices or data frames more
amenable to analysis of intrinsically disorder (ID).

In proteins, intrinsic disorder (ID) is a phenomenon that describes the
lack of a stable, or ordered, tertiary structure while still maintaining
physiologic functions. Informatics tools, such as those provided by
PONDR\](<a href="http://www.pondr.com/" class="uri">http://www.pondr.com/</a>)
and [PONDR-FIT](http://original.disprot.org/pondr-fit.php) make it easy
to analyze a protein sequence for intrinsic disorder; however, this task
can become tedious if one has tens or even hundreds of sequences to
analyze.

My goal in developing `mineDisProt` was to simplify the data collection
process so you can focus on the analysis of your data set.

Installation
------------

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("vanbibn/mineDisProt")
```

Examples
--------

First, we need to load the package.

``` r
library(mineDisProt)
## basic example code
```

### extract\_pondr()

This function extracts numerical data from text porduced by the VLXT,
VL3, and VSL2 disorder predictors from the Predictor of Natural
Disordered Regions [PONDR](http://www.pondr.com/). For each protien
sequence, the data from the Raw Output of all three predictors were
pasted into a `.txt` file.

``` r
pondr_data <- extract_pondr("inst/extdata/pondr_text/")

# here we will view the data from the VLXT predictor
pondr_data[,1:6]
#>        resid.VLXT dis_rgns.VLXT n_dis.VLXT lg_rgn.VLXT pct.VLXT avg.VLXT
#> A4D2B8        440            10        190          49    43.18   0.4250
#> A8MQ11        134             4         48          17    35.82   0.3672
#> B4DYI2       1134            20        704         118    62.08   0.5658
#> H3BSY2        632            12        483         158    76.42   0.6594
#> O14715       1765            34        582          59    32.97   0.3516
#> P0C2Y1        421             8        209          71    49.64   0.4933
#> P0DPF3       1111            17        701         118    63.10   0.5753
#> Q5VU36       1347            28        710         107    52.71   0.5038
#> Q5VYP0       1347            29        714         107    53.01   0.5085
#> Q86XG9        351             5        258          93    73.50   0.6479
```

###### You may get warnings about “incomplete final line found \[in the text file\].”

### extract\_pondr.noVL3()

This is a version of `extract_pondr()`, except the raw data for the VL3
predictor is missing from the raw data text files.

``` r
extract_pondr.noVL3("inst/extdata/pondr_text_withoutVL3/")
#>            resid.VLXT dis_rgns.VLXT n_dis.VLXT lg_rgn.VLXT pct.VLXT avg.VLXT
#> A0A087WVF3        549             9        249         104    45.36   0.4753
#> A6NDS4            549             9        247         104    44.99   0.4739
#> D6RF30            607            11        451         206    74.30   0.6678
#> F8WBI6            632             9        452         104    71.52   0.6309
#> H3BPF8            625            10        462         132    73.92   0.6618
#> I6L899            631            10        428         104    67.83   0.6078
#> O60309           1634            18        980         238    59.98   0.5547
#> P0CJ92            632             9        464         157    73.42   0.6521
#> Q6DHY5            549             9        248         104    45.17   0.4738
#> Q96QE4            947            11        483         169    51.00   0.4719
#>            resid.VSL2 dis_rgns.VSL2 n_dis.VSL2 lg_rgn.VSL2 pct.VSL2 avg.VSL2
#> A0A087WVF3        549             8        276         104    50.27   0.5166
#> A6NDS4            549             8        276         104    50.27   0.5197
#> D6RF30            607             4        571         295    94.07   0.8188
#> F8WBI6            632             5        585         305    92.56   0.8027
#> H3BPF8            625             3        586         468    93.76   0.8106
#> I6L899            631             6        574         305    90.97   0.7882
#> O60309           1634            14       1231         792    75.34   0.6865
#> P0CJ92            632             5        576         308    91.14   0.8186
#> Q6DHY5            549             8        276         104    50.27   0.5188
#> Q96QE4            947            10        579         330    61.14   0.6086
```

### extract\_pondrFIT()

This function extracts the relevant data from the temporaty URL produced
by analyzing a protein sequence in the
[PONDR-FIT](http://original.disprot.org/pondr-fit.php) protein disorder
meta-predictor. It then calculates average and percent disorder scores
from the per-residue scores. Before using this function, URLs should be
collected and put in a `.csv` file with the UniProt ID in the first
column and URL in the second.

``` r
extract_pondrFIT("inst/extdata/pondrfit-url.csv")
#> # A tibble: 10 x 5
#>    UniprotID url                             meanDisorder percentDisorder length
#>    <chr>     <chr>                                  <dbl>           <dbl>  <int>
#>  1 Q13401    http://original.disprot.org/te~        0.318          0.185     168
#>  2 A8MQ11    http://original.disprot.org/te~        0.346          0.201     134
#>  3 Q6ZUB1    http://original.disprot.org/te~        0.584          0.618    1445
#>  4 P0DKV0    http://original.disprot.org/te~        0.621          0.690    1188
#>  5 Q5VYP0    http://original.disprot.org/te~        0.508          0.516    1347
#>  6 Q5VVP1    http://original.disprot.org/te~        0.515          0.519    1343
#>  7 P0C874    http://original.disprot.org/te~        0.449          0.438     917
#>  8 Q9BSJ1    http://original.disprot.org/te~        0.211          0.0841    452
#>  9 A7E2F4    http://original.disprot.org/te~        0.725          0.861     631
#> 10 H3BSY2    http://original.disprot.org/te~        0.720          0.840     632
```

###### You may get messages about “Parsed with column specification:”.

### extract\_string()

Extract data on the quantity of protein interactions given by
[STRING](https://string-db.org/) with the minimum number of interactions
at medium (0.4), high (0.7), and highest (0.9) confidence.

``` r
string_data <- extract_string("inst/extdata/string/")

# here are the interaction data for each protein at the 0.4 confidence level
string_data[,1:6]
#>            num_nodes.0.4 num_edges.0.4 avg_node_degree.0.4
#> A0A087WVF3            25            39                3.12
#> A6NKT7                59           440               14.90
#> A6NMS7                21            44                4.19
#> O14715                59           343               11.60
#> P0DJD0                42           290               13.80
#> P0DJD1                81          1373               33.90
#> Q3BBV0                29            74                5.10
#> Q6ZQQ2                14            26                3.71
#> Q7Z3J3                34           235               13.80
#> Q99666                63           355               11.30
#>            avg_local_clustering_coef.0.4 expected_num_edges.0.4
#> A0A087WVF3                         0.937                     26
#> A6NKT7                             0.819                     83
#> A6NMS7                             0.869                     21
#> O14715                             0.860                     88
#> P0DJD0                             0.839                     60
#> P0DJD1                             0.772                    153
#> Q3BBV0                             0.955                     29
#> Q6ZQQ2                             0.862                     14
#> Q7Z3J3                             0.871                     49
#> Q99666                             0.843                     88
#>            PPI_enrichment_p-value.0.4
#> A0A087WVF3                   9.06e-03
#> A6NKT7                             NA
#> A6NMS7                       9.10e-06
#> O14715                             NA
#> P0DJD0                             NA
#> P0DJD1                             NA
#> Q3BBV0                       1.74e-12
#> Q6ZQQ2                       1.66e-03
#> Q7Z3J3                             NA
#> Q99666                             NA
```

###### You may get some warnings like “NAs introduced by coercion” if your protein is missing data at higher confidence levels.

------------------------------------------------------------------------

Note: In future versions of this package, I hope to fully automate the
data collection process.
