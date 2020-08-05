# Input load. Please do not change #
setwd("C:/Users/ryanw/OneDrive - Diesel Analytics/Professional/Clients/Apress/Book/Part2_ShapingData/Chapter09/Callout")
`dataset` = read.csv('input.csv', check.names = FALSE, encoding = "UTF-8", blank.lines.skip = FALSE);
# Original Script. Please update your script content here and once completed copy below section back to the original editing window #
# The following code to create a dataframe and remove duplicated rows is always executed and acts as a preamble for your script: 

# dataset <- data.frame(Country Name, Percent Education Expenditure Ranking)
# dataset <- unique(dataset)

# Paste or type your script code here:
library(tidyverse)
library(scales)
library(ggthemes)

currentColumns <- sort(colnames(dataset))
requiredColumns <- c("Country", "Total Expend %", "Year")
columnTest <- isTRUE(all.equal(currentColumns, requiredColumns))
reportYear <- unique(dataset$Year)

if (length(reportYear) == 1 & columnTest) {
  
  plotdata <- 
    dataset %>%
    mutate(
      rank = dense_rank(desc(`Total Expend %`)),
      `Country` = fct_reorder(`Country`, rank, .desc = TRUE), 
      callout = ifelse(rank == 1, TRUE, FALSE)
    ) %>%
    filter(rank <= 7)
  
  countryToAnnotate <- plotdata$`Country`[plotdata$rank == 1]
  minExpenditure <- min(plotdata$`Total Expend %`)
  maxExpenditure <- max(plotdata$`Total Expend %`)
  minCountry <- plotdata$`Country`[which(plotdata$`Total Expend %` == minExpenditure)]
  minCountry <- paste(minCountry, collapse = " & ") 
  maxCountry <- plotdata$`Country`[which(plotdata$`Total Expend %` == maxExpenditure)]
  maxCountry <- paste(maxCountry, collapse = " & ")
  mainTitle = "% of Government Expenditure on Education"
  subTitle = paste("The top 7 ranked countries in", reportYear, sep = " ")
  caption = "Source:  https://databank.worldbank.org/source/world-development-indicators"
  
  label_val <- 
    str_wrap(
      paste(maxCountry, "spent", percent((maxExpenditure/minExpenditure-1)), "more of their expenditures on education than", minCountry, sep = " "),
      width = 35
    )
  
  p <- 
    ggplot(
      data = plotdata, 
      aes(x = `Country`, y = `Total Expend %`, fill = callout, label = percent(`Total Expend %`))
    ) +
    geom_bar(stat="identity", aes(fill = callout)) +
    geom_text(nudge_y = -0.05) +
    scale_y_continuous(limits = c(0,0.75), labels = NULL, breaks = NULL) +
    coord_flip() +
    annotate("text", label = label_val, x = countryToAnnotate[1], y = maxExpenditure + 0.12) +
    labs(title = mainTitle, subtitle = subTitle, caption = caption) +
    xlab(label = NULL) +
    ylab(label = NULL) +
    guides(fill=FALSE) +
    theme_few() +
    theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
  p
  
} else {
  
  plot.new()
  title("The data supplied did not meet the requirements of the chart.")
}