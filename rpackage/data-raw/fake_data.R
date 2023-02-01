## code to prepare `fake_data` dataset goes here
fake_data = haven::read_dta("data-raw/fake data.dta")

usethis::use_data(fake_data, overwrite = TRUE)
