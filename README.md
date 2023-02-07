# Introduction to R workshop
Welcome to the Github repo for the R workshop in KI. This repo contains all necessary material and information for the course.

# R package
The course has its own R package `workshopr`. The aim is to make example data and script easily accessible. To install the package just run the following code in R studio:

1. `install.packages("remotes")`
2. `remotes::install_github("Bolin-Wu/workshopr", subdir = "rpackage", force = TRUE)`

# Workshop 2022
This workshop focuses on beginner level.  The slides are  [here](https://github.com/Bolin-Wu/workshopr/blob/main/material/2022_beginner/slide.pdf) and R code is [here](https://github.com/Bolin-Wu/workshopr/blob/main/material/2022_beginner/example.R).

# Workshop 2023
This workshop focuses at intermidiate level.

## Loop
[Ashley Tate](https://staff.ki.se/people/ashley-tate) leads this session. 
Get her example code:

```
workshopr::get_code_2023(session = "loop")
```

## Tidyverse
[Bolin](https://staff.ki.se/people/bolin-wu) leads this session. The slide is available [here](https://github.com/Bolin-Wu/workshopr/blob/main/material/2023_intermediate/tidyverse_RMD_session/slides/index.pdf).

Get the example data:

```
workshopr::fake_data
```

Get example R code:
```
workshopr::get_code_2023(session = "tidyverse")
```

## R markdown

Get the rmd templates with html and word output:

```
workshopr::get_rmd_2023(output_file = "html")
workshopr::get_rmd_2023(output_file = "word")
```