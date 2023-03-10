
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

Author: [Xin Xia](https://ki-su-arc.se/staff/xin-xia/).

``` r
workshopr::fake_data 
```

# R script

Please see below to retrieve code used in this workshop.

## Loop

Author: [Ashley Tate](https://staff.ki.se/people/ashley-tate).

Load the example code:

    workshopr::get_code_2023(session = "loop")

## Tidyverse & Rmarkdown

Author: [Bolin Wu](https://staff.ki.se/people/bolin-wu).

Load example R code:

    workshopr::get_code_2023(session = "tidyverse")

Get the rmd templates with html and word output:

    workshopr::get_rmd_2023(output_file = "html")
    workshopr::get_rmd_2023(output_file = "word")

# Issues

You can raise bug reports
[here](https://github.com/Bolin-Wu/workshopr/issues).
