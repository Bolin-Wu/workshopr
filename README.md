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


## Tidyverse
[Bolin](https://staff.ki.se/people/bolin-wu) introduces useful data manipulation functions in daily work tasks:

- %>% syntax
- **join** data frames (*join function*)
- **transform** data shape (*pivot_longer*)
- **filter** variables based on name pattern (*select*)
- **extract** the label from DTA and SPSS in R (*filter*)
- **check** missing values (*summarise & across*)
- **mutate data** based on column types (*mutate & across*)
- **bin** variables by percentiles (*cut*)
- **assign** function 

The slide is [here](https://github.com/Bolin-Wu/workshopr/blob/main/material/2023_intermediate/tidyverse_RMD_session/slides/index.pdf) and the code is [here](https://github.com/Bolin-Wu/workshopr/blob/main/material/2023_intermediate/tidyverse_RMD_session/rscript/tidyverse_2023.R).


## R markdown
[Bolin](https://staff.ki.se/people/bolin-wu) explains the basic uses of R markdown and its integration into daily work:

- markdown 
- yaml heading 
- code chunk options
- live code demo

The slide is [here](https://github.com/Bolin-Wu/workshopr/blob/main/material/2023_intermediate/tidyverse_RMD_session/slides/index.pdf).

One can use `workshopr::get_rmd_2023()` in R to retrieve rmd templates.

