library(here)
library(dplyr)
library(stringr)
library(tidyr)

# import the data
source(here("R", "data_import.R"))

#------------------------------------------#
#### ------------SNAC_K------------------####
#------------------------------------------#


## ---------------##
#---SPSS file----#
## ---------------##
sav_names <- neartools::bulk_import(db_dir, file_type = "sav")$tb_name

# change the column name
for (i in 1:length(sav_names)) {
  cat(
    "Table name is:", sav_names[i], ";",
    "Column name is:", colnames(get(sav_names[i])), "\n"
  )
  assign(sav_names[i], get(sav_names[i]) %>%
    rename(id = 1, smoke = 2, hypo = 3))
  cat(
    "Table name is:", sav_names[i], ";",
    "Column name is:", colnames(get(sav_names[i])), "\n"
  )
}


# add 'db' and 'group' columns
for (i in 1:length(sav_names)) {
  prefix <- sub(".*_K_(.*)_smoking(.+)", "\\1", sav_names[i])
  temp_tibb <- get(sav_names[i]) %>%
    mutate(db = "SNAC_K", .after = id) %>%
    mutate(group = prefix, .after = db)
  assign(sav_names[i], temp_tibb)
}

# row bind
temp_df <- get(sav_names[1])
for (i in 2:length(sav_names)) {
  temp_df <- bind_rows(temp_df, get(sav_names[i]))
}

summary.factor(temp_df$group)

SNAC_K_merge <- temp_df

SNAC_K_merge %>% View()


range(SNAC_K_merge$id)

# check the cohort freq in the SPSS files
SNAC_K_merge %>%
  filter(grepl("C1", group)) %>%
  group_by(group) %>%
  summarise(factor = summary.factor(group))

snac_k_sav_long <- SNAC_K_merge %>%
  filter(grepl("C1", group)) %>%
  arrange(id)

summary.factor(snac_k_sav_long$group)

# add the wave variable to snac_k_sav_long


wave_ref_long <- wave_ref %>%
  pivot_longer(contains("cohort"),
    names_to = c(".value", "fas"),
    names_sep = "_",
    values_drop_na = TRUE
  ) %>%
  mutate(wave = recode(fas,
    fas1 = "wave1",
    fas2 = "wave2",
    fas3 = "wave3",
    fas4 = "wave4",
    fas5 = "wave5"
  )) %>%
  # mutate(cohort = as.numeric(cohort)) %>%
  # mutate(group = recode(cohort,
  #                       `10` = "C1_B",
  #                       `11`= "C1")) %>%
  rename(id = 1)

snac_k_sav_long <- snac_k_sav_long %>%
  mutate(wave = recode(group,
    C1_B = "wave1",
    C1_F1 = "wave2",
    C1_F2 = "wave3",
    C1_F3 = "wave4",
    C1_F4 = "wave5",
    C1_F5 = "wave6"
  ))
snac_k_sav_long
# write.csv(snac_k_sav_long, row.names = TRUE, file = here("data", "export", "snac_k", "snac_k_sav_long.csv"))

## ---------------##
#---STATA file----#
## ---------------##


range(snac_k$Lopnr)
range(snac_k_sav_long$id)
snac_k_sav_long %>%
  arrange(id) %>%
  View()
# confirm that the STATA lopnrs are from cohort 1.
# next step: combine STATA and SPSS
colnames(snac_k)

snac_k_dta_long <- snac_k %>%
  pivot_longer(contains("wave"),
    names_to = c(".value", "wave"),
    names_sep = "_",
    values_drop_na = TRUE
  ) %>%
  relocate(wave:Date, .before = sex)

snac_k_dta_long %>%
  filter(is.na(Date) & !is.na(dementia))
# there are 8 obs have dementia but not interview date

# write.csv(snac_k_dta_long, row.names = TRUE, file = here("data", "export", "snac_k", "snac_k_dta_long.csv"))

snac_k_dta_long %>%
  arrange(Lopnr, Date)

# join "dementia education sex" and "hypertension smoke" by "wave"
snac_k_merge_long <- snac_k_sav_long %>%
  left_join(snac_k_dta_long, by = c("id" = "Lopnr", "wave" = "wave")) %>%
  relocate(wave:Date, .after = group)
snac_k_merge_long <- snac_k_merge_long %>%
  select(-group)
snac_k_merge_long
# write.csv(snac_k_merge_long, row.names = TRUE, file = here("data", "export",  "snac_k_merge_long.csv"))
# #----------------------------------------------#
# #### --------------LNU SWEOLD----------------####
# #----------------------------------------------#
#
year_check_lnu_sweold <- function(variable) {
  filtered_name <- lnu_sweold %>%
    select(contains(variable)) %>%
    colnames(.)
  filtered_number <- sub("[a-z]*([0-9]*)", "\\1", filtered_name)
  v_length <- length(filtered_name)
  return(list(
    "length" = v_length,
    "related_variable_name" = filtered_name,
    "extracted_year_number" = filtered_number
  ))
}


year_check_lnu_sweold(variable = "edulevel")
year_check_lnu_sweold(variable = "eduyrs")
year_check_lnu_sweold(variable = "high")
year_check_lnu_sweold(variable = "smok")
year_check_lnu_sweold(variable = "sex")
# # 92 is an extra year for hypertension, education years and levels.
#
# year_check_lnu_sweold(variable = "smoke")
# # smoke 2004 is missing.
# year_check_lnu_sweold(variable = "sex")
# # sex 1968 is missing.
year_check_lnu_sweold(variable = "by")$related_variable_name
#
#
# check duplicated ID
# neartools::fix_dup_id(lnu_sweold, id_str = "ID")
#
# for multiple byear columns contain 'NA'
# find the non-NA byear
lnu_sweold_byear <- lnu_sweold %>%
  select(ID, contains("by")) %>%
  # select the second non-NA, because the first NA is ID column
  mutate(birth_year = apply(., 1, function(x) na.omit(x)[2]), .after = ID) %>%
  select(ID, birth_year)
#
# # edu year
# lnu_sweold %>%
#   select(ID, contains("eduyrs")) %>%
#   View()
#
lnu_sweold_eduyr <- lnu_sweold %>%
  select(ID, contains("eduyrs")) %>%
  pivot_longer(eduyrs1968:eduyrs2014,
    names_to = "q_year", names_prefix = "[a-z]*",
    values_to = "edu_year",
    values_drop_na = TRUE
  )

lnu_sweold_edul <- lnu_sweold %>%
  select(ID, contains("edulevel")) %>%
  pivot_longer(contains("edulevel"),
    names_to = "q_year", names_prefix = "[a-z]*",
    values_to = "edu_level",
    values_drop_na = TRUE
  )

summary.factor(lnu_sweold_edul$edu_level)

lnu_sweold_highbp <- lnu_sweold %>%
  select(ID, contains("high")) %>%
  pivot_longer(contains("high"),
    names_to = "q_year", names_prefix = "[a-z]*",
    values_to = "highbp"
  ) %>%
  mutate(highbp = as.numeric(highbp)) %>%
  drop_na("highbp")


summary.factor(lnu_sweold_highbp$highbp)

lnu_sweold_sex <- lnu_sweold %>%
  select(ID, contains("sex")) %>%
  pivot_longer(contains("sex"),
    names_to = "q_year", names_prefix = "[a-z]*",
    values_to = "sex",
    values_drop_na = TRUE
  )



lnu_sweold_smoke <- lnu_sweold %>%
  select(ID, contains("smok")) %>%
  pivot_longer(contains("smok"),
    names_to = "q_year", names_prefix = "[a-z]*",
    values_to = "smok",
    values_drop_na = TRUE
  )

lnu_sweold_merge_long <- lnu_sweold_eduyr %>%
  left_join(lnu_sweold_byear, by = "ID") %>%
  left_join(lnu_sweold_edul, by = c("ID", "q_year")) %>%
  left_join(lnu_sweold_sex, by = c("ID", "q_year")) %>%
  left_join(lnu_sweold_smoke, by = c("ID", "q_year")) %>%
  left_join(lnu_sweold_highbp, by = c("ID", "q_year")) %>%
  mutate(db = "LNU_SWEOLD", .after = ID) %>%
  rename(
    id = ID,
    smoke = smok,
    hypo = highbp
  )
colnames(snac_k_merge_long)
colnames(lnu_sweold_merge_long)
summary.factor(lnu_sweold_merge_long$q_year)
write.csv(lnu_sweold_merge_long, row.names = TRUE, file = here("data", "export", "lnu_sweold_merge_long.csv"))


# there are 4 participant's gender changed
diff_sex_id <- lnu_sweold_sex %>%
  group_by(ID) %>%
  summarise(count = n_distinct(sex)) %>%
  filter(count != 1 & !is.na(ID)) %>%
  pull(ID)
diff_sex_id
lnu_sweold_sex %>%
  filter(ID %in% diff_sex_id)

lnu_sweold %>%
  filter(is.na(ID))



# #----------------------------------------------#
# #### --------------CAIDE----------------####
# #----------------------------------------------#

colnames(caide)
summary.factor(caide$terv46)
summary.factor(caide$terv48)



# quit smoke
caide %>%
  filter(q67 == 2 & q69 == 3)


caide %>%
  filter(terv45 == 2 & terv48 == 3) # this one I am not really sure

caide %>%
  filter(f_terve60 == 1 & f_terve63 != 3) %>%
  select(contains("f_ter"))

caide %>%
  filter(f_terve61 == 2 & f_terve63 == 3) %>%
  select(id, f_terve61, f_terve63)


# difference between terv46 and terv48
caide %>%
  select(id, terv45, terv46, terv48)
# problematic, e.g. contradiction value of terv46 and 48 for id = 4 abd 5
# 2 [tupakoi säännöllisesti]     3 [en lainkaan]

##### --------- fix smoking ------#####
#------------ baseline -----------#

attributes(snac_k_merge_long$smoke)$labels
attributes(lnu_sweold_merge_long$smoke)$labels

# it seems that I need to harmonize CAIDE smoking first
caide %>%
  select(id, time, age_base, base_date, starts_with("q")) %>%
  pivot_longer(starts_with("q"),
    names_prefix = "q",
    names_to = "smoke_variable", values_to = "smoke_value"
  )
# ---------------------------#
# q67
# Have you ever been smoking:
#   1: no
# 2: yes
# q68a (1322 NAs)
# Have you ever smoked regularly
# 1: no
# 2: yes
# q69
# Current smoking
# 1: regularly
# 2: randomly
# 3: not at all
# ---------------------------#

# harmonization: never smoke = 1, quit smoke = 2 , smoke sometimes = 3, smoke regularly = 4

# baseline
caide_smoke_1 <- caide %>%
  select(id, starts_with("q")) %>%
  mutate(h_smoke_1 = case_when(
    q67 == 1 ~ 1,
    q67 == 2 & q69 == 3 ~ 2,
    q69 == 2 ~ 3,
    q69 == 1 ~ 4,
    TRUE ~ NA_real_
  ))

# %>%
#   pull(h_smoke_1) %>%
#   summary.factor()
# %>%
#   summarise(across(everything(), ~ sum(is.na(.))))

caide_smoke_1 %>%
  select(id, h_smoke_1)




# follow up 1

#--------------------------#
# FIRST F-Up
#
# terv45
# Smoking:
#   1: no
# 2: yes
#
# terv46:
#   Regular smoking
# 1: Don't smoke normally
# 2: Smoke normally
#
# terv48
# Regular smoking
# 1: Yes every day
# 2: Yes occasionally
# 3: Not at all

# harmonization: never smoke = 1, quit smoke = 2 , smoke sometimes = 3, smoke regularly = 4
#--------------------------#

# FU1
caide_smoke_2 <- caide %>%
  select(id, starts_with("terv")) %>%
  mutate(h_smoke_2 = case_when(
    terv45 == 1 ~ 1,
    terv45 == 2 & terv48 == 3 ~ 2,
    # terv45 == 2 & (terv46 == 1|terv48 == 2) ~ 3,
    terv45 == 2 & terv46 == 1 ~ 3,
    # terv48 == 1 ~ 4,
    terv48 != 3 ~ 4,
    TRUE ~ NA_real_
  ))

# %>%
#   pull(h_smoke_2) %>%
#   summary.factor()

# %>%
#   summarise(across(everything(), ~ sum(is.na(.))))
# this one is problematic with terv46 and terv48,
# need to wait for Shireen's reply


#-------------------------------------------------#
# 2nd F-Up
#
# f_terve60
# Have you ever smoked?
#   1: No
# 2: Yes
#
# f_terve61
# Have you ever smoked regularly?
#   1: I haven't smoked regularly
# 2: I have smoked regularly
#
# f_terve63
# Do you currently smoke (cigarettes, cigars, pipe)?
# Current smoking:
# 1: Yes, every day
# 2: Yes, occasionally
# 3: Not at all
#
# f_terve64
# How many days a week do you usually smoke?
# 1: 7 days a week
# 2: 5-6 days a week
# 3: 2-4 days a week
# 5: Less often than once a week
# 6: I don't smoke at all

# harmonization: never smoke = 1, quit smoke = 2 , smoke sometimes = 3, smoke regularly = 4
#-------------------------------------------------#

# FU2

caide_smoke_3 <- caide %>%
  select(id, starts_with("f_terv")) %>%
  mutate(h_smoke_3 = case_when(
    f_terve60 == 1 ~ 1,
    f_terve60 == 2 & f_terve63 == 3 ~ 2,
    # terv45 == 2 & (terv46 == 1|terv48 == 2) ~ 3,
    f_terve60 == 2 & f_terve63 == 2 ~ 3,
    # terv48 == 1 ~ 4,
    f_terve63 == 1 ~ 4,
    TRUE ~ NA_real_
  ))

# %>%
#   pull(h_smoke_3) %>%
#   summary.factor()

colnames(caide)

caide_smoke_3 %>%
  summarise(across(everything(), ~ sum(is.na(.))))

# merge smoke
caide_smoke_long <- caide_smoke_1 %>%
  left_join(caide_smoke_2, by = "id") %>%
  left_join(caide_smoke_3, by = "id") %>%
  select(id, contains("h_")) %>%
  distinct(id, .keep_all = TRUE) %>%
  pivot_longer(
    cols = starts_with("h_"), names_to = "wave", values_to = "h_smoke",
    names_prefix = "h_smoke_"
  ) %>%
  mutate(wave = as.integer(wave))

# Look good
# Be careful: caide_smoke_2 might need to change


#### --------- fix hypertension ------####
# no any hypertension at baseline
# systolic measure available at wave 2 and wave 3
# diastolic measure only avaialble at wave 3

# sys at wave 2, it has two measures
caide_hyp_sys_1 <- caide %>%
  select(id, starts_with("sys")) %>%
  transmute(
    id = id,
    wave = 2,
    h_hyp_sys_1 = sys1,
    h_hyp_sys_2 = sys2
  ) %>%
  distinct(id, wave,
    .keep_all = TRUE
  )

# sys at wave 3, it has two measures
caide_hyp_sys_2 <- caide %>%
  select(id, starts_with("f_sys")) %>%
  transmute(
    id = id,
    wave = 3,
    h_hyp_sys_1 = f_systo1,
    h_hyp_sys_2 = f_systo2
  ) %>%
  distinct(id, wave,
    .keep_all = TRUE
  )

caide_hyp_sys_long <- caide_hyp_sys_1 %>%
  bind_rows(caide_hyp_sys_2)



#### --------- fix age ------####

caide_age_long <- caide %>%
  select(id, contains("age")) %>%
  pivot_longer(
    cols = -id,
    names_to = "wave", values_to = "age"
  ) %>%
  mutate(wave = case_when(
    wave == "age_base" ~ 1,
    wave == "fu1_age" ~ 2,
    wave == "fu2_age" ~ 3,
    TRUE ~ NA_real_
  )) %>%
  arrange(id, wave) %>%
  distinct(id, wave,
    .keep_all = TRUE
  )

#### --------- fix date ------####
# base date is a confusing 4 digit number
# only pivot longer the dates at wave 2 and wave 3
caide_date_long <- caide %>%
  select(id, matches("fu[12]_date")) %>%
  pivot_longer(
    cols = -id,
    names_to = "wave", values_to = "date"
  ) %>%
  mutate(wave = case_when(
    wave == "fu1_date" ~ 2,
    wave == "fu2_date" ~ 3,
    TRUE ~ NA_real_
  )) %>%
  arrange(id, wave) %>%
  distinct(id, wave,
    .keep_all = TRUE
  )


#### --------- fix dementia ------####

# Problem: do not know dementian belong to which wave
# if 'time' is the indicator for wave, then there is no baseline
caide_dementia_edu_long <- caide %>%
  select(id, time, fup, dem_incl_regs, edu_yrs) %>%
  mutate(wave = case_when(
    time == 1 ~ 2,
    time == 2 ~ 3,
    TRUE ~ NA_real_
  ), .after = id) %>%
  rename(dementia = dem_incl_regs) %>%
  select(id, wave, dementia, edu_yrs) %>%
  arrange(id, wave) %>%
  distinct(id, wave,
    .keep_all = TRUE
  )

#---------------------Merge CAIDE----------------------#

caide_long_names <- ls()[str_detect(string = ls(), pattern = "caide_.*_long")]
caide_long_names
caide_long = caide_age_long %>%
  left_join(get(caide_long_names[2]), by = c('id','wave')) %>%
  left_join(get(caide_long_names[3]), by = c('id','wave')) %>%
  left_join(get(caide_long_names[4]), by = c('id','wave')) %>%
  left_join(get(caide_long_names[5]), by = c('id','wave'))


#
# CAIDE summary:
# * Date: base date is a confusing 4 digit number
# * Hypertension: no hypertension received for baseline.
# * Dementia: no dementia diagnose for baseline (if 'time' is a indicator for waves; there is only time = 1 (FU1) and time = 2 (FU2))
# * Smoking: The received smoking variables are seperate & not consistent across different waves. I made harmonization for smoking: never smoke = 1, quit smoke = 2 , now smoke sometimes = 3, now smoke regularly = 4
#   however, there is a problem that at follow up 1 (wave 2), there are contradictory values for terv46 and terv48.
# * no diea what is fup
# Problems mentioned above have been raise to Shireen.

write.csv(caide_long, row.names = TRUE, file = here("data", "export", "caide_merge_long.csv"))
