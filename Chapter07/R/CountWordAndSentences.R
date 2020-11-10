library(tidyverse)
library(stringr)

setwd("<file path to where the file is located>")

df <- read_csv("yelp_training_set_review_sample.csv")

df <-
  df %>%
  select(id, business_categories, business_review_count, business_stars, business_state,business_type,stars,text) %>%
  mutate(word_count = str_count(text, boundary("word")), sent_count = str_count(text, boundary("sentence")))
