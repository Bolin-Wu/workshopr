## ----setup, include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, comment = NA, purl = TRUE)
options(
  htmltools.dir.version = FALSE,
  htmltools.preserve.raw = FALSE
)


## ---- eval=FALSE---------------------------------------------------------------------
install.packages("remotes")
remotes::install_github("Bolin-Wu/workshopr",
  subdir = "rpackage",
  force = TRUE
)


## ---- message=FALSE------------------------------------------------------------------
library(workshopr)
library(tidyverse)


## ------------------------------------------------------------------------------------
fake_snack_df %>%
  select(Lopnr, Date_wave1)


## ----continue example----------------------------------------------------------------
fake_snack_df %>%
  select(Lopnr, Date_wave1) %>%
  filter(Date_wave1 > "1800-01-01") %>%
  slice(1:5)


## ------------------------------------------------------------------------------------
# From  `dplyr` documentation:
df1 <- tibble(x = 1:3)
df2 <- tibble(
  x = c(1, 1, 2),
  y = c("first", "second", "third")
)
df1 %>% left_join(df2)


## ----check data----------------------------------------------------------------------
head(fake_snack_df, n = 5)


## ----check column names--------------------------------------------------------------
sort(colnames(fake_snack_df))


## ----start small---------------------------------------------------------------------
fake_snack_df %>%
  select(contains("Date")) %>%
  slice(1:5)


## ---- eval=FALSE---------------------------------------------------------------------
?tidyr::pivot_longer()


## ----pivot date----------------------------------------------------------------------
fake_snack_df %>%
  select(Lopnr, contains("Date")) %>%
  pivot_longer(
    cols = contains("Date"),
    names_to = "wave", values_to = "date",
    names_prefix = "Date"
  )


## ------------------------------------------------------------------------------------
fake_snack_df %>%
  select(Lopnr, contains("dementia")) %>%
  pivot_longer(
    cols = contains("dementia"),
    names_to = "wave", names_prefix = "dementia",
    values_to = "dementia"
  )




## ---- eval=FALSE---------------------------------------------------------------------
?select()


## ---- eval=FALSE---------------------------------------------------------------------
fake_snack_df %>%
  select(starts_with("Date"))


## ---- eval=FALSE---------------------------------------------------------------------
fake_snack_df %>%
  select(contains("Date") & contains("wave"))


## ---- eval=FALSE---------------------------------------------------------------------
fake_snack_df %>%
  select(matches("Date_wave\\d"))


## ---- eval=FALSE---------------------------------------------------------------------
view(fake_snack_df)


## ---- eval=FALSE---------------------------------------------------------------------
str(fake_snack_df)


## ------------------------------------------------------------------------------------
label_char <- sjlabelled::get_label(fake_snack_df)
label_char




## ------------------------------------------------------------------------------------
label_df <- tibble::rownames_to_column(as.data.frame(label_char), "variable")
label_df <- tibble::as_tibble(label_df)
label_df


## ------------------------------------------------------------------------------------
label_df %>%
  filter(grepl("dementia", label_char))


## ------------------------------------------------------------------------------------
label_df %>%
  filter(grepl("wave", variable))


## ------------------------------------------------------------------------------------
sum(is.na(fake_snack_df$Date_wave1))


## ----Count NA in multiple columns----------------------------------------------------
fake_snack_df %>%
  summarise(across(
    where(lubridate::is.Date),
    ~ sum(is.na(.))
  ))




## ------------------------------------------------------------------------------------
fake_snack_df %>%
  mutate(across(is.numeric, ~ round(., digits = 2)))


## ------------------------------------------------------------------------------------
fake_snack_df %>%
  transmute(education, edu_bin = cut(education,
    breaks = 3,
    labels = c("low", "medium", "high")
  ))


## ---- eval=FALSE---------------------------------------------------------------------
df_names <- c()
set.seed(2023)
for (i in 1:4) {
  df_names[i] <- paste0("edu_", i)
  assign(df_names[i], sample.int(3, 10, replace = T))
  # print the result
  cat(
    "The df name is: ", df_names[i], "\n",
    "its value is: ", get(df_names[i]), "\n"
  )
}

