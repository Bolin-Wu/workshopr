# Introduction to R workshop
Welcome to the Github repo for the R workshop in KI. This repo contains all necessary material and information for the course.

# R package
The course has its own R package, `workshop`, which aims to make example data and script easily accessible. To install the package, run the following code in R Studio. For more details, please check the '[rpackage](https://github.com/Bolin-Wu/workshopr/tree/main/rpackage)' folder.

1. `install.packages("remotes")`
2. `remotes::install_github("Bolin-Wu/workshopr", subdir = "rpackage", force = TRUE)`

# Workshop 2022
This workshop focuses on the beginner level.  

- The slides are [here](https://github.com/Bolin-Wu/workshopr/blob/main/material/2022_beginner/slide.pdf) 
- R code is [here](https://github.com/Bolin-Wu/workshopr/blob/main/material/2022_beginner/example.R).

# Workshop 2023

- Register link is [here](https://news.ki.se/calendar/r-programming-workshop-2023-intermediate-level). 
- The flyer is [here](https://github.com/Bolin-Wu/workshopr/blob/main/material/2023_intermediate/flyer_R_programming_workshop_2023_intermediate_level.pdf)

This workshop is an extension of workshop in 2022, which focuses on the intermediate level. The topic consists of

* Loop function
* Tidyverse toolkits
* R markdown


## Loop
[Ashley Tate](https://staff.ki.se/people/ashley-tate) leads this session. 

Example code

- View  online [here](https://github.com/Bolin-Wu/workshopr/tree/main/material/2023_intermediate/loop_session)
- Get script directly in R  `workshopr::get_code_2023(session = "loop")`

## Tidyverse
[Bolin Wu](https://staff.ki.se/people/bolin-wu) introduces useful data manipulation functions in daily work tasks:

- %>% syntax
- **join** data frames (*join function*)
- **transform** data shape (*pivot_longer*)
- **filter** variables based on name pattern (*select*)
- **extract** the label from DTA and SPSS in R (*filter*)
- **check** missing values (*summarise & across*)
- **mutate data** based on column types (*mutate & across*)
- **bin** variables by percentiles (*case_when*)
- **assign** function 

Slide 

- Downloadable PDF [here](https://github.com/Bolin-Wu/workshopr/blob/main/material/2023_intermediate/tidyverse_RMD_session/slides/index.pdf) 
- View online html slide [here](https://rpubs.com/bolinwu/rworkshop-intermediate)

Example code

- View  online [here](https://github.com/Bolin-Wu/workshopr/blob/main/material/2023_intermediate/tidyverse_RMD_session/rscript/tidyverse_2023.R) 
- Get script directly in R `workshopr::get_code_2023(session = "tidyverse")`.


## R markdown
[Bolin Wu](https://staff.ki.se/people/bolin-wu) explains the basic uses of R markdown and its integration into daily work:

- markdown 
- yaml heading 
- code chunk options
- live code demo

The slide is [here](https://github.com/Bolin-Wu/workshopr/blob/main/material/2023_intermediate/tidyverse_RMD_session/slides/index.pdf).

To retrieve R markdown templates in R, one can run the following commands in RStudio:

```
workshopr::get_rmd_2023(name = "pdf_example",output_file = "pdf")
workshopr::get_rmd_2023(name = "word_example",output_file = "word")
workshopr::get_rmd_2023(name = "html_example",output_file = "html")
```
Get the final exercise [here](https://github.com/Bolin-Wu/workshopr/blob/main/material/2023_intermediate/tidyverse_RMD_session/slides/rmd/final_exercise.pdf)

## Other resources

- 'stringr' and regex (in r) [cheatsheet](https://evoldyn.gitlab.io/evomics-2018/ref-sheets/R_strings.pdf).
- data transformation with 'dplyr' [cheatsheet](https://nyu-cdsc.github.io/learningr/assets/data-transformation.pdf).
- R markdown [cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf).

