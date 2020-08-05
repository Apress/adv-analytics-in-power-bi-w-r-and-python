library(tidycensus)
library(tidyverse)

census_api_key("aXXXXXXXXXXXXXXXXXXXf")

cns_vars <- c(`Total`="B06001_001E",`Under 5`="B06001_002E",`5 to 17`="B06001_003E",`18 to 24`="B06001_004E",`25 to 34`="B06001_005E",`35 to 44`="B06001_006E",`45 to 54`="B06001_007E",`55 to 59`="B06001_008E",`60 and 61`="B06001_009E",`62 to 64`="B06001_010E",`65 to 74`="B06001_011E",`75+`="B06001_012E")

get_data <- function(x) {
  df <- suppressMessages(get_acs(
    geography = "county",
    state = "IN", 
    variables = cns_vars, 
    survey = "acs1",
    year = x,
    output = "wide"
  ))%>%
    mutate(Year = x)
}

years <- 2015:2017

IN_POP_BY_COUNTY_BY_AGE <- map_df(years, get_data)