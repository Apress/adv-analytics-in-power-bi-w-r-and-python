library(tidyverse)
library(lubridate)

players <- c("Kobe Bryant", "Pau Gasol", "Lamar Odom")
plot.data <- lakers %>%
    filter(result == "made" & team == "LAL" & player %in% players) %>%
    mutate(date = ymd(date)) %>%
    group_by(player, date) %>%
    summarize(points = sum(points))

ggplot(plot.data, aes(x=date,y=points,color=player)) +
    geom_line() +
    labs(title = "geom_line") +
    theme_minimal()