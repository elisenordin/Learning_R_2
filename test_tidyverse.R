library(tidyverse)
library(NHANES)

# Looking at data ---------------------------------------------------------

# Briefly glimpse contents of dataset
glimpse(NHANES)

select(NHANES, Age)
select(NHANES, Age, Weight, BMI)
select(NHANES, -HeadCirc)
select(NHANES, starts_with("BP"))

# All columns ending in letters "Day"
select(NHANES, ends_with("Day"))

select(NHANES, contains("Age"))

# Save the selected columns as a new data frame
# Recall the style guide for naming objects
nhanes_small <- select(
  NHANES, Age, Gender, BMI, Diabetes,
  PhysActive, BPSysAve, BPDiaAve, Education
)

# Fixing variable names ---------------------------------------------------

# View the new data frame
nhanes_small


# Rename all columns to snake case
nhanes_small <- rename_with(nhanes_small, snakecase::to_snake_case)

# Have a look at the data frame
nhanes_small

nhanes_small <- rename(nhanes_small, sex = gender)
nhanes_small


# Pipeing -----------------------------------------------------------------
colnames(nhanes_small)
nhanes_small %>%
  colnames()

nhanes_small %>%
  select(phys_active) %>%
  rename(physically_active = phys_active)


nhanes_small %>%
  select(bp_sys_ave)

nhanes_small %>%
  select(education)

nhanes_small <- nhanes_small %>%
  rename(
    bp_sys = bp_sys_ave,
    bp_dia = bp_dia_ave
  )

# select(nhanes_small, bmi, contains("age"))

nhanes_small %>%
  select(bmi, age)

# blood_pressure <- select(nhanes_small, starts_with("bp_"))
# rename(blood_pressure, bp_systolic = bp_sys)

nhanes_small %>%
  select(starts_with("bp_")) %>%
  rename(bp_systolic = bp_sys)


# Filtering rows ----------------------------------------------------------
nhanes_small %>%
  filter(phys_active == "No")
nhanes_small %>%
  filter(bmi >= 25 & phys_active == "No")
dim(n)
dim(nhanes_small)

nhanes_small %>%
  filter(bmi == 25 | phys_active == "No")



# Arranging rows ----------------------------------------------------------

# Arranging data by age in ascending order
nhanes_small %>%
  arrange(age)

nhanes_small %>%
  arrange(education)

# Mutating columns --------------------------------------------------------
nhanes_small %>%
  mutate(age_months = age * 12)

nhanes_small %>%
  mutate(logged_bmi = log(bmi))

nhanes_small_update <- nhanes_small %>%
  mutate(
    age_months = age * 12,
    logged_bmi = log(bmi),
    age_weeks = age_months * 4,
    age_ = ifelse(age >= 30, "old", "young")
  )



# 1. BMI between 20 and 40, with diabetes
nhanes_small %>%
  filter(bmi >= 20 & bmi <= 40 & diabetes == "Yes")


nhanes_small %>%
  mutate(mean_arterial_pressue = (2 * bp_dia) + bp_sys) / 3
nhanes_small %>%
  mutate(young_child = ifelse(age <= 6, "yes", "no"))



# Summarizing -------------------------------------------------------------
nhanes_small %>%
  summarise(max_bmi = max(bmi))

nhanes_small %>%
  summarise(max_bmi = max(bmi, na.rm = TRUE))

nhanes_small %>%
  summarise(
    max_bmi = max(bmi, na.rm = TRUE),
    min_bmi = min(bmi, na.rm = TRUE)
  )


# 1.
# nhanes_small %>%
#     summarise(mean_bp_sys = ___,
#               mean_age = ___)

# 2.
nhanes_small %>%
  summarise(
    max_bp_dia = bp_dia, na.rm = TRUE,
    min_bp_dia = bp_sys, na.rm = TRUE
  )

nhanes_small %>%
  group_by(diabetes) %>%
  summarise(
    mean_age = mean(age, na.rm = TRUE),
    mean_bmi = mean(bmi, na.rm = TRUE)
  )


nhanes_small %>%
  # Recall ! means "NOT", so !is.na means "is not missing"
  filter(!is.na(diabetes)) %>%
  group_by(diabetes) %>%
  summarise(
    mean_age = mean(age, na.rm = TRUE),
    mean_bmi = mean(bmi, na.rm = TRUE)
  )

nhanes_small %>%
  filter(!is.na(diabetes)) %>%
  group_by(diabetes, phys_active) %>%
  summarise(
    mean_age = mean(age, na.rm = TRUE),
    mean_bmi = mean(bmi, na.rm = TRUE)
  )


nhanes_small %>%
    filter(!is.na(diabetes)) %>%
    group_by(diabetes, phys_active) %>%
    summarise(mean_age = mean(age, na.rm = TRUE),
              mean_bmi = mean(bmi, na.rm = TRUE)) %>%
    ungroup()


readr::write_csv(
    nhanes_small,
    here::here("data/nhanes_small.csv")
)
