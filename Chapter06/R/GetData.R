library(tidycensus)
library(tidyverse)

census_api_key("adf9111a430221eb10f5bb5b76f15b250578b7af", overwrite = FALSE, install = FALSE)
cns_vars <- c("B02001_002","B02001_003","B02001_004","B02001_005","B02001_006","B02001_007","B02001_008")

population_rawdata <- 
  suppressMessages(
    get_acs(
      geography = "county",
      variables = cns_vars, 
      survey = "acs5",
      year = 2017,
      output = "wide"
    )
  )

write_csv(population_rawdata,"population_rawdata.csv")
