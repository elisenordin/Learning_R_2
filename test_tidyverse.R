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

