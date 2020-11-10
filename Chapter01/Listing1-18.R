library(tidyverse)

set.seed(1)

plot.data <-
    diamonds %>%
    filter(color == "D") %>%
    sample_n(200)

ggplot(plot.data, aes(x=carat, y=price)) +
    geom_point() +
    geom_smooth(method ="lm") +
    labs(title = "geom_point & geom_smooth") +
    theme_minimal()