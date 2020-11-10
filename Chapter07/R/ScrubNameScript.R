library(tidyverse)
library(stringr)

setwd("<file path to DimEmployee.csv file>")

nameWithOrWithoutMiddleInitial = "(^[A-Z][a-z]{1,10}\\s[a-zA-Z]\\s[A-Z][a-z]{1,10}$)|(^[A-Z][a-z]{1,10}\\s[A-Z][a-z]{1,10}$)"

df <- read_csv("DimEmployee.csv")

df <-
  df %>%
  mutate(Name = str_extract(Name, nameWithOrWithoutMiddleInitial))