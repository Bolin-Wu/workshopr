
# usethis::use_package("readr", "Suggests")


paquid_cov = readr::read_csv("data-raw/paquid_cov.csv",
                             col_select = c(-1))

usethis::use_data(paquid_cov, overwrite = TRUE)
