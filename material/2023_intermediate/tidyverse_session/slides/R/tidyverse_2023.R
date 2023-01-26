## ----------------------------------------------------------------------
# run the install command if did not do it before
# install.packages('remotes')
# remotes::install_github("Bolin-Wu/workshopr", subdir = "rpackage", force = TRUE)

# load the package
library(workshopr)
library(tidyverse)
library(here)


## ----check data--------------------------------------------------------
head(fake_snack_df)


## ----check column names------------------------------------------------
sort(colnames(fake_snack_df))


## ----start small-------------------------------------------------------
fake_snack_df %>% 
  select(contains("Date"))


## ----pivot date--------------------------------------------------------

# check pivot_longer() documentation in R: ?pivot_longer()
fake_snack_df %>% 
  select(Lopnr,contains("Date")) %>% 
  pivot_longer(cols = contains("Date"),
               names_to = "wave", names_prefix = "Date",
               values_to = "date")


## ----------------------------------------------------------------------
fake_snack_df %>% 
  select(Lopnr,contains("dementia")) %>% 
  pivot_longer(cols = contains("dementia"),
               names_to = "wave", names_prefix = "dementia",
               values_to = "dementia")

