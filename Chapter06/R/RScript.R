library(tidycensus)
library(tidyverse)

census_api_key("<census api key>", overwrite = FALSE, install = FALSE)
cns_vars <- c("B06001_001E","B06001_002E","B06001_003E","B06001_004E","B06001_005E","B06001_006E","B06001_007E","B06001_008E","B06001_009E","B06001_010E","B06001_011E","B06001_012E")

IN_POP_BY_COUNTY_BY_AGE <- 
  suppressMessages(
    get_acs(
      geography = "county",
      state = "IN", 
      variables = cns_vars, 
      survey = "acs1",
      year = 2015,
      output = "wide"
    )
  )

IN_POP_BY_COUNTY_BY_AGE = 
  rename(
    IN_POP_BY_COUNTY_BY_AGE, 
    `Total`=B06001_001E,`Under 5`=B06001_002E,
    `5 to 17`=B06001_003E,
    `18 to 24`=B06001_004E,
    `25 to 34`=B06001_005E,
    `35 to 44`=B06001_006E,
    `45 to 54`=B06001_007E,
    `55 to 59`=B06001_008E,
    `60 and 61`=B06001_009E,
    `62 to 64`=B06001_010E,
    `65 to 74`=B06001_011E,
    `75+`=B06001_012E
  )