## ----install package, results= FALSE, eval= FALSE------------------------------------------------------------
## install.packages("remotes")
## remotes::install_github("Bolin-Wu/workshopr",
##   subdir = "rpackage",
##   force = TRUE
## )


## ----load package, results= FALSE----------------------------------------------------------------------------
library(workshopr)
library(tidyverse)
library(here)


## ------------------------------------------------------------------------------------------------------------
fake_data %>%
  select(Lopnr, Date_wave1)


## ----continue example----------------------------------------------------------------------------------------
fake_data %>%
  select(Lopnr, Date_wave1) %>%
  filter(Date_wave1 > "2002-01-01") %>%
  slice(1:5)


## ------------------------------------------------------------------------------------------------------------
# From  `dplyr` documentation:
df1 <- tibble(x = 1:3)
df2 <- tibble(
  x = c(1, 1, 2),
  y = c("first", "second", "third")
)
df1 %>% left_join(df2)


## ----check data----------------------------------------------------------------------------------------------
head(fake_data, n = 5)


## ----check column names--------------------------------------------------------------------------------------
sort(colnames(fake_data))


## ----start small---------------------------------------------------------------------------------------------
fake_data %>%
  select(contains("Date")) %>%
  slice(1:5)


## ---- eval=FALSE---------------------------------------------------------------------------------------------
## ?tidyr::pivot_longer()


## ----pivot date----------------------------------------------------------------------------------------------
fake_data %>%
  select(Lopnr, contains("Date")) %>%
  pivot_longer(
    cols = contains("Date"),
    names_to = "wave", values_to = "date",
    names_prefix = "Date"
  )


## ------------------------------------------------------------------------------------------------------------
fake_data %>%
  select(Lopnr, contains("dementia")) %>%
  pivot_longer(
    cols = contains("dementia"),
    names_to = "wave", names_prefix = "dementia",
    values_to = "dementia"
  )




## ---- eval=FALSE---------------------------------------------------------------------------------------------
## ?select()


## ---- eval=FALSE---------------------------------------------------------------------------------------------
## fake_data %>%
##   select(starts_with("Date"))


## ---- eval=FALSE---------------------------------------------------------------------------------------------
## fake_data %>%
##   select(contains("Date") & contains("1"))


## ---- eval=FALSE---------------------------------------------------------------------------------------------
## fake_data %>%
##   select(matches("Date_wave\\d"))


## ---- eval=FALSE---------------------------------------------------------------------------------------------
## view(fake_data)


## ---- eval=FALSE---------------------------------------------------------------------------------------------
## str(fake_data)


## ------------------------------------------------------------------------------------------------------------
label_char <- sjlabelled::get_label(fake_data)
label_char




## ------------------------------------------------------------------------------------------------------------
label_df <- tibble::rownames_to_column(
  as.data.frame(label_char),
  "variable"
)
label_df <- tibble::as_tibble(label_df)
label_df


## ------------------------------------------------------------------------------------------------------------
label_df %>%
  filter(grepl("dementia", label_char))


## ------------------------------------------------------------------------------------------------------------
label_df %>%
  filter(grepl("wave", variable))


## ------------------------------------------------------------------------------------------------------------
sum(is.na(fake_data$Date_wave1))


## ----Count NA in multiple columns----------------------------------------------------------------------------
fake_data %>%
  summarise(across(
    where(lubridate::is.Date),
    ~ sum(is.na(.))
  ))




## ---- message=FALSE, warning=FALSE---------------------------------------------------------------------------
fake_data %>%
  mutate(across(
    where(is.numeric),
    ~ round(., digits = 2)
  ))


## ------------------------------------------------------------------------------------------------------------
fake_data %>%
  transmute(mmse_wave1,
    mmse_wave1_bin = case_when(
      between(mmse_wave1, 0, 9) ~ "Severe dementia",
      between(mmse_wave1, 10, 18) ~ "Moderate dementia",
      between(mmse_wave1, 19, 23) ~ "Mild dementia",
      mmse_wave1 >= 24 ~ "Mild dementia",
      TRUE ~ NA_character_
    )
  )


## ---- eval=FALSE---------------------------------------------------------------------------------------------
## df_names <- c()
## set.seed(2023)
## for (i in 1:4) {
##   df_names[i] <- paste0("edu_", i)
##   assign(df_names[i], sample.int(3, 10, replace = T))
##   # print the result
##   cat(
##     "The df name is: ", df_names[i], "\n",
##     "its value is: ", get(df_names[i]), "\n"
##   )
## }


## ------------------------------------------------------------------------------------------------------------
objects_name <- c(
  "Cohort1_Baseline_BMI", "Cohort1_FU1_BMI", "Cohort1_FU2_BMI",
  "Cohort1FU3_Cohort2FU2", "Cohort2_Baseline_BMI", "envir_name",
  "Gender data request_20230111", "Gender data request_20230116",
  "index", "NEAR_BMI-mortality", "SNAC-K C1 B-F6 cohort file",
  "SNAC-K C1_B", "SNAC-K C1_F1", "SNAC-K C1_F2", "SNAC-K C1_F3",
  "SNAC-K C1_F4", "SNAC-K C1_F5"
)

for (i in 1:length(objects_name)) {
  # assign some values to these objects
  assign(objects_name[i], sample(100, 10))
}


## ------------------------------------------------------------------------------------------------------------
clean_names <- gsub(" |-", "_", objects_name)

for (i in 1:length(clean_names)) {
  assign(clean_names[i], get(objects_name[i]))
}

# just show the first few
clean_names[1:5]






## ---- include = TRUE, eval = FALSE---------------------------------------------------------------------------
## workshopr::get_rmd_2023(
##   name = "pretty_template",
##   output_file = "word"
## )
## workshopr::get_rmd_2023(
##   name = "pretty_template",
##   output_file = "html"
## )

