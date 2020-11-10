library(tidyverse)
library(geosphere)

setwd("<path to folder where the EmployeeList file is located>")
EmployeeList <- read_csv("EmployeeList.csv")

EmployeeList <- 
  EmployeeList %>%
  rowwise() %>%
  mutate(
    `Geosphere Function` =
        distHaversine(
            c(lon_EmployeeAddress, lat_EmployeeAddress),
            c(lon_TerminalAddress, lat_TerminalAddress)
            ) / 1609.34
  )