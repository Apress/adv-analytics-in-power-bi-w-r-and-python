library(tidyverse)
library(stringr)

setwd("<path to the R_Code folder>")
goodemails_raw <- read_csv("./Data/EmailAddresses.csv")

email_pattern <- "^([a-zA-Z][\\w\\_]{4,20})\\@([a-zA-Z0-9.-]+)\\.([a-zA-Z]{2,3})$"

goodemails <-
	goodemails_raw %>%
	filter(str_detect(Email, email_pattern) == TRUE)
