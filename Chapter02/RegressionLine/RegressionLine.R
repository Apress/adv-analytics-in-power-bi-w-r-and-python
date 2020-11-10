# Input load. Please do not change #
setwd("C:/Users/ryanw/OneDrive - Diesel Analytics/Professional/Clients/Apress/Book/Part2_ShapingData/Chapter09/RegressionLine/")
`dataset` = read.csv('input.csv', check.names = FALSE, encoding = "UTF-8", blank.lines.skip = FALSE);
# Original Script. Please update your script content here and once completed copy below section back to the original editing window #
# The following code to create a dataframe and remove duplicated rows is always executed and acts as a preamble for your script: 

# dataset <- data.frame(height, weight)
# dataset <- unique(dataset)

# Paste or type your script code here:
library(tidyverse)
library(ggthemes)

currentColumns <- sort(colnames(dataset))
requiredColumns <- c("height", "weight")
columnTest <- isTRUE(all.equal(currentColumns, requiredColumns))

if (columnTest) {

  chartdata <- dataset

  ggplot(chartdata, aes(x = weight, y = height)) +
    geom_point() +
    geom_smooth(method='lm') +
    ggtitle(
      "Average Weight by Heights for American Women",
      subtitle = "(with added regression line and confidence interval)"
    ) +
    theme_tufte() +
    theme(
      axis.title = element_text(size = 20),
      plot.title = element_text(size = 30),
      plot.subtitle = element_text(size = 20)
    )

} else {
  
  plot.new()
  title("The data supplied did not meet the requirements of the chart.")
  
}