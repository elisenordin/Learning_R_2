library(tidyverse)
library(NHANES)

# Looking at data ---------------------------------------------------------

# Briefly glimpse contents of dataset
glimpse(NHANES)

select(NHANES, Age)
select(NHANES, Age, Weight, BMI)
select(NHANES, -HeadCirc)
select(NHANES, starts_with("BP"))
