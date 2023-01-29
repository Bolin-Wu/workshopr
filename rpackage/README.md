
<!-- README.md is generated from README.Rmd. Please edit that file -->

# workshopr

<!-- badges: start -->
<!-- badges: end -->

The goal of `workshopr` is to make example data and script easily
accessible.

## Installation

You can install the development version of workshopr from
[GitHub](https://github.com/Bolin-Wu/workshopr) with:

``` r
install.packages("remotes")
remotes::install_github("Bolin-Wu/workshopr", subdir = "rpackage", force = TRUE)
```

## Data

``` r
workshopr::fake_snack_df
```

## R script

### Loop

[Xin Xia](https://ki-su-arc.se/staff/xin-xia/) leads this session. Load
her example code:

    workshopr::get_code_2023(session = "loop")

### Tidyverse & Rmarkdown

[Bolin](https://staff.ki.se/people/bolin-wu) leads this session. Load
the data:

Load example R code:

    workshopr::get_code_2023(session = "tidyverse")

## Issues

You can raise bug reports
[here](https://github.com/Bolin-Wu/workshopr/issues).
