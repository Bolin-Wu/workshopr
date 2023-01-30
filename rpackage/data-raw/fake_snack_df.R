## code to prepare `snack_random` dataset goes here
library(tidyverse)
library(sjlabelled)
library(lubridate)
library(missMethods)

# read fake SNAC-K data
fake_snack_df = haven::read_dta("data-raw/snack_random.dta")

# store the label names
label_names <- get_label(fake_snack_df)

# randomize the values again
fake_snack_df <- fake_snack_df %>%
  mutate(across(where(is.numeric), ~ rnorm(n = length(.)))) %>%
  mutate(across(where(is.Date), ~ sample(seq(as.Date("1700/01/01"), as.Date("1850/01/01"), by = "day"), size = length(.)))) %>%
  mutate(Lopnr = sample.int(nrow(fake_snack_df))) %>%
  set_label(label = label_names)

# generate random NA
set.seed(2023)
fake_snack_df <- delete_MCAR(fake_snack_df,
                                         p = seq(0.1, 0.8, length.out = length(fake_snack_df)))


usethis::use_data(fake_snack_df, overwrite = TRUE)
