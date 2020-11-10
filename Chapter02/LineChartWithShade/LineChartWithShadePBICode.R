# Input load. Please do not change #
setwd("C:/Users/ryanw/OneDrive - Diesel Analytics/Professional/Clients/Apress/Book/Part2_ShapingData/Chapter09/LineChartWithShade")
`dataset` = read.csv('input.csv', check.names = FALSE, encoding = "UTF-8", blank.lines.skip = FALSE);
# Original Script. Please update your script content here and once completed copy below section back to the original editing window #
# The following code to create a dataframe and remove duplicated rows is always executed and acts as a preamble for your script: 

# dataset <- data.frame(DATE, GetPoliticalLevel, GetPoliticalLevelName)
# dataset <- unique(dataset)

# Paste or type your script code here:
library(tidyverse)
library(ggthemes)
library(scales)

currentColumns <- sort(colnames(dataset))
requiredColumns <- c("GetGDPStat", "GetGDPStatName", "GetPoliticalLevel", "GetPoliticalLevelName", "Year")
columnTest <- isTRUE(all.equal(currentColumns, requiredColumns))

politicalLevelName <- unique(dataset$GetPoliticalLevelName)
gdpStatName <- unique(dataset$GetGDPStatName)

if(length(politicalLevelName) == 1 & length(gdpStatName) == 1 & columnTest) {
  dfPI <- dataset
  
  #Variables for dynamic portions of the chart
  politicalLevelName <- unique(dfPI$GetPoliticalLevelName)
  gdpStatName <- unique(dfPI$GetGDPStatName)
  yAxisName <- paste(gdpStatName, ifelse(gdpStatName == "Actual GDP","(in Billions)",""), sep = " ")
  chartTitle <- paste(gdpStatName, "Analysis", sep = " ") 
  chartSubtitle <- paste(politicalLevelName, "view", sep = " ")
  
  #Get the nuber of 
  dfPI$GetPoliticalLevel <- as.character(dfPI$GetPoliticalLevel)
  runs <- rle(dfPI$GetPoliticalLevel)
  group_id <- rep(seq_along(runs$lengths), runs$lengths)
  
  #Create the data set for shade layer 
  dfShadeInfo <- 
    cbind(dfPI, group_id) %>%
    transmute(group_id, Year, Party = GetPoliticalLevel) %>%
    group_by(group_id, Party) %>%
    summarize(start = min(Year), end = max(Year)+0.99) %>%
    ungroup()
  
  #Create the data set for line chart layer
  dfLineChartInfo <-
    dfPI %>%
    transmute(Year, GetGDPStat)
  
  #Define the shade colors
  partyColors = c("Republican"="red", "Democrat"="blue", "Tie" = "white")

  #Create the visualization
  p <- ggplot() +
       geom_rect(
          data = dfShadeInfo,
          aes(xmin = start, xmax = end, fill = Party),
              ymin = -Inf, ymax = Inf, alpha = 0.4, color = NA
          ) +
       geom_line(data = dfLineChartInfo, aes(x = Year, y = GetGDPStat)) +
       scale_fill_manual(values=partyColors) +
       scale_y_continuous(
         labels=ifelse(gdpStatName == "Actual GDP", comma_format(),percent_format())
       ) +
       ylab(yAxisName) +
       xlab("Year") +
       ggtitle(chartTitle, subtitle = chartSubtitle) +
       theme_economist()

    p 
  } else {
    
    plot.new()
    title("The data supplied did not meet the requirements of the chart.")
    
  }