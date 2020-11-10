library(tidyverse)
library(scales)

#https://dplyr.tidyverse.org/reference/select.html
# Talk about Data types


setwd("C:/Users/ryanw/Downloads/Advanced Analytics in Power BI with R and Python (3)/Chapter06/R")
population_data <- read_csv("population_rawdata.csv")

# Verify that E stands for estimates and M stands for margin of error

popdata_estimates <- 
  select(population_data, County, State, B02001_002E, 
         B02001_003E, B02001_004E, B02001_005E, B02001_006E, 
         B02001_007E, B02001_008E)

popdata_estimates <- select(population_data, County, State, ends_with("E"))


popdata_rename <-
  rename(
    popdata_estimates, 
    `White` = B02001_002E,
    `Black` = B02001_003E,
    `American Indian` = B02001_004E,
    `Asian` = B02001_005E,
    `Pacific Islander` = B02001_006E,
    `Other Race` = B02001_007E,
    `Two or More Races` = B02001_008E
  )


# Calcuated Columns
popdata_rowtotals <-
  mutate(popdata_rename, 
         All = White + Black + `American Indian` + Asian + `Pacific Islander` + `Other Race` + `Two or More Races`)

popdata_rowtotals <-
  mutate(popdata_rename, 
         All = rowSums(popdata_rename[3:9]))
View(popdata_rowtotals)

popdata_percents <-
  mutate(popdata_rename, 
         `Percent White` = White / (White + Black + `American Indian` + Asian + `Pacific Islander` + `Other Race` + `Two or More Races`),
         `Percent Black` = Black / (White + Black + `American Indian` + Asian + `Pacific Islander` + `Other Race` + `Two or More Races`),
         `Percent American Indian` = `American Indian` / (White + Black + `American Indian` + Asian + `Pacific Islander` + `Other Race` + `Two or More Races`),
         `Percent Asian` = Asian / (White + Black + `American Indian` + Asian + `Pacific Islander` + `Other Race` + `Two or More Races`),
         `Percent Pacific Islander` = `Pacific Islander` / (White + Black + `American Indian` + Asian + `Pacific Islander` + `Other Race` + `Two or More Races`),
         `Percent Other Race` = `Other Race` / (White + Black + `American Indian` + Asian + `Pacific Islander` + `Other Race` + `Two or More Races`),
         `Percent Two or More Races` = `Two or More Races` / (White + Black + `American Indian` + Asian + `Pacific Islander` + `Other Race` + `Two or More Races`)
         )

popdata_percents <-
  mutate(popdata_rename, 
         `Percent White` = White / rowSums(popdata_rename[3:9]),
         `Percent Black` = Black / rowSums(popdata_rename[3:9]),
         `Percent American Indian` = `American Indian` / rowSums(popdata_rename[3:9]),
         `Percent Asian` = Asian / rowSums(popdata_rename[3:9]),
         `Percent Pacific Islander` = `Pacific Islander` / rowSums(popdata_rename[3:9]),
         `Percent Other Race` = `Other Race` / rowSums(popdata_rename[3:9]),
         `Percent Two or More Races` = `Two or More Races` / rowSums(popdata_rename[3:9])
  )

popdata_percents_transumte <-
  transmute(popdata_rename,
         County,
         State,
         `Percent White` = White / rowSums(popdata_rename[3:9]),
         `Percent Black` = Black / rowSums(popdata_rename[3:9]),
         `Percent American Indian` = `American Indian` / rowSums(popdata_rename[3:9]),
         `Percent Asian` = Asian / rowSums(popdata_rename[3:9]),
         `Percent Pacific Islander` = `Pacific Islander` / rowSums(popdata_rename[3:9]),
         `Percent Other Race` = `Other Race` / rowSums(popdata_rename[3:9]),
         `Percent Two or More Races` = `Two or More Races` / rowSums(popdata_rename[3:9])
  )
View(popdata_percents_transumte)

popdata_percents_transumte <-
  transmute(popdata_rename,
            County,
            State,
            `Percent White` = percent(White / rowSums(popdata_rename[3:9])),
            `Percent Black` = percent(Black / rowSums(popdata_rename[3:9])),
            `Percent American Indian` = percent(`American Indian` / rowSums(popdata_rename[3:9])),
            `Percent Asian` = percent(Asian / rowSums(popdata_rename[3:9])),
            `Percent Pacific Islander` = percent(`Pacific Islander` / rowSums(popdata_rename[3:9])),
            `Percent Other Race` = percent(`Other Race` / rowSums(popdata_rename[3:9])),
            `Percent Two or More Races` = percent(`Two or More Races` / rowSums(popdata_rename[3:9]))
  )
View(popdata_percents_transumte)


popdata_bw <-
  transmute(popdata_rename, 
         County,
         State,
         White,
         Black,
         `Black and White` = rowSums(popdata_rename[,c(3,4)])
  )
View(popdata_bw)

popdata_bw <-
  transmute(popdata_rename, 
         County,
         State,
         White,
         Black,
         `Black and White` = rowSums(popdata_rename[,c("White","Black")])
  )
View(popdata_bw)

# Talk about chaining here


popdata_group <-
  popdata_rename %>%
  group_by(State) %>%
  summarize(
    White = sum(White, na.rm=TRUE), 
    Black = sum(Black, na.rm=TRUE), 
    `American Indian`= sum(`American Indian`, na.rm=TRUE), 
    Asian = sum(Asian, na.rm=TRUE), 
    `Pacific Islander`= sum(`Pacific Islander`, na.rm=TRUE), 
    `Other Race` = sum(`Other Race`, na.rm=TRUE), 
    `Two or More Races` = sum(`Two or More Races`, na.rm=TRUE),
    `Number of Counties`=n())
View(popdata_group)

popdata_group <-
  popdata_rename %>%
  group_by(State) %>%
  summarize_if(is.numeric, sum, na.rm = TRUE)
View(popdata_group)


popdata_unpivot <-
  popdata_group %>%
  pivot_longer(
    !State,
    names_to = "Race",
    values_to = "Population"
  )
View(popdata_unpivot)


chart_data <-
  popdata_unpivot %>%
  filter(State == "Michigan") %>%
  transmute(Race=fct_reorder(Race, Population), Population)

ggplot(data = chart_data, aes(x=Race, y=Population, label=comma(Population))) +
  geom_bar(stat="Identity", fill="red") + 
  geom_label() +
  coord_flip() +
  scale_y_continuous(labels=NULL) +
  theme_minimal() +
  labs(
    title = "Main Title"
    ,subtitle = "Sub Title"
    ,caption = "My Caption"
  )