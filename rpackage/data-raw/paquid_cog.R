
# usethis::use_package("readr", "Suggests")


paquid_cog = readr::read_csv("data-raw/paquid_cog.csv",
                             col_select = c(-1))

usethis::use_data(paquid_cog, overwrite = TRUE)
