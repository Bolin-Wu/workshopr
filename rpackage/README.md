
<!-- README.md is generated from README.Rmd. Please edit that file -->

# workshopr

<!-- badges: start -->
<!-- badges: end -->

The goal of `workshopr` is to make example data and script easily
accessible.

# Installation

You can install the development version of workshopr from
[GitHub](https://github.com/Bolin-Wu/workshopr):

``` r
install.packages("remotes")
remotes::install_github("Bolin-Wu/workshopr", subdir = "rpackage", force = TRUE)
```

# Data

``` r
workshopr::fake_data 
```

# R script

## Loop

Load the example code (further update expected):

    workshopr::get_code_2023(session = "loop")

## Tidyverse & Rmarkdown

Author: [Bolin](https://staff.ki.se/people/bolin-wu).

Load example R code:

    workshopr::get_code_2023(session = "tidyverse")

Get the rmd templates with html and word output:

    workshopr::get_rmd_2023(output_file = "html")
    workshopr::get_rmd_2023(output_file = "word")

# Issues

You can raise bug reports
[here](https://github.com/Bolin-Wu/workshopr/issues).
