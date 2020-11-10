library(tidyverse)
library(stringr)

setwd("C:/Users/ryanw/OneDrive - Diesel Analytics/Professional/Clients/Apress/Book/Part2_ShapingData/Chapter5/Misc")

monitoredProducts <- function(x){
  pattern = "^(561769|561394)(?=(01|22|39)(A|B))"
  mp = str_extract(x, pattern = pattern)
  return_value = ifelse(is.na(mp),"Not Monitored", mp)
  return(return_value)
}

df <- read_csv("ProductionOrders.csv")

df <-
  df %>%
  mutate(`Monitored Products` = monitoredProducts(SKU))
