library(tidyverse)
library(lubridate)

setwd("C:/Users/ryanw/OneDrive - Diesel Analytics/Professional/Clients/Apress/Book/Part2_ShapingData/Chapter09/QuadChart")

chartData <- 
  lakers %>%
  filter(
    (player != "" & team == "LAL" & 
     result == "made" & 
    etype %in% c("shot","free throw")
    ) | 
    (player != "" & 
     team == "LAL" & 
     etype == "rebound")
    ) %>%
  mutate(
    rebound = ifelse(etype == "rebound",1,0)
  ) %>%
  group_by(game_type, period, player) %>%
  summarize(
    `Total Points` = sum(points), 
    Rebounds = sum(rebound)
  ) %>%
  rename(
    `Game Type` = game_type, 
    Period = period, 
    Player = player
  )

write_csv(chartdata, "chartData.csv")



