library(tidyverse)
library(stringr)

setwd("C:/Users/ryanw/Downloads/Chapter05/Chapter05/Data")

mask_text <- function(unmask_text){
  phone_pattern = "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"
  ssn_pattern = "\\d{3}-\\d{2}-\\d{4}"
  cleanned_text <- str_replace(unmask_text, pattern = phone_pattern, replacement = "XXX-XXX-XXXX")
  cleanned_text <- str_replace(cleanned_text, pattern = ssn_pattern, replacement = "XXX-XX-XXXX")
  return(cleanned_text)
}

df <- read_csv("Comments.csv")

df <- 
  df %>%
  mutate(Comment = mask_text(Comment))
