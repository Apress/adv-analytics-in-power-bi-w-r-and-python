# Input load. Please do not change #
setwd("C:/Users/ryanw/OneDrive - Diesel Analytics/Professional/Clients/Apress/Book/Part2_ShapingData/Chapter09/Forecast")
`dataset` = read.csv('input.csv', check.names = FALSE, encoding = "UTF-8", blank.lines.skip = FALSE);
# Original Script. Please update your script content here and once completed copy below section back to the original editing window #
# The following code to create a dataframe and remove duplicated rows is always executed and acts as a preamble for your script: 

# dataset <- data.frame(Year, Quarter, Month, Day, Lamar Jackson)
# dataset <- unique(dataset)

# Paste or type your script code here:
library(tidyverse)
library(prophet)
library(ggthemes)
library(gridExtra)
library(lubridate)
library(rlang)

# I needed to load rlang. Look into this package.

currentColumns <- sort(colnames(dataset))
requiredColumns <- c("Date", "Page Views", "Page Views (Log10)", "Quarterback")
columnTest <- isTRUE(all.equal(currentColumns, requiredColumns))

qb <- unique(dataset$Quarterback)

if (length(qb) == 1 & columnTest) {
  
  chartTitle <- paste0(qb, "'s Wikipedia page views forecast analysis")
  
  dfPageViews <-
    dataset %>%
    mutate(Date = ymd(Date)) %>%
    rename(ds = Date, y = `Page Views (Log10)`)
  
  m <- prophet(dfPageViews, yearly.seasonality=TRUE)
  
  future <- make_future_dataframe(m, periods = 365)
  
  forecast <- predict(m, future)
  
  p1 <- plot(m, forecast) + ggtitle(chartTitle) + theme_few()
  p <- prophet_plot_components(m, forecast)
  
  p2 <- p[[1]] + theme_few() 
  p3 <- p[[2]] + theme_few()
  p4 <- p[[3]] + theme_few()
  p5 <- grid.arrange(p1, p2, p3, p4, nrow =4)
  p5

} else {
  
  plot.new()
  title("The data supplied did not meet the requirements of the chart.")
  
}
  
