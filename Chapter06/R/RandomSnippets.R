library(tidycensus)
library(tidyverse)

census_api_key("<census api key>", overwrite = FALSE, install = FALSE)

v17 <- load_variables(2017, "acs5", cache = TRUE)

race_vars <- filter(v17, concept == "RACE")
