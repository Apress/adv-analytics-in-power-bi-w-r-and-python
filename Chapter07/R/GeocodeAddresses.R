library(tidyverse)
library(ggmap)

register_google(key = "<put API key here>")

setwd("<path to folder where the EmployeeList file is located>")
EmployeeList <- read_csv("EmployeeList.csv")

EmployeeList <- 
  EmployeeList %>%
  mutate_geocode(EmployeeAddress, sensor = FALSE) %>%
  rename(lon_EmployeeAddress = lon, lat_EmployeeAddress = lat) %>%
  mutate_geocode(TerminalAddress, sensor = FALSE) %>%
  rename(lon_TerminalAddress = lon, lat_TerminalAddress = lat)

write_csv(EmployeeList, "EmployeeList.csv")
