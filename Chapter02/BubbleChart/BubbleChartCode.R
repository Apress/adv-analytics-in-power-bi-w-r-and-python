# Input load. Please do not change #
setwd("C:/Users/ryanw/OneDrive - Diesel Analytics/Professional/Clients/Apress/Book/Part2_ShapingData/Chapter09/BubbleChart")
`dataset` = read.csv('input.csv', check.names = FALSE, encoding = "UTF-8", blank.lines.skip = FALSE);
# Original Script. Please update your script content here and once completed copy below section back to the original editing window #
# The following code to create a dataframe and remove duplicated rows is always executed and acts as a preamble for your script: 

# dataset <- data.frame(ID, Year, FN, LN, Weight, Height, Rusing Yards, Division, Conference)
# dataset <- unique(dataset)

# Paste or type your script code here:
library(tidyverse)
library(ggrepel)
library(ggthemes)

currentColumns <- sort(colnames(dataset))
requiredColumns <- c("Conference", "Division", "FN", "Height", "ID", "LN", "Rusing Yards", "Weight", "Year")
columnTest <- isTRUE(all.equal(currentColumns, requiredColumns))
reportYear <- unique(dataset$Year)

if(length(reportYear) == 1 & columnTest) {
  
  chartData <-
    dataset %>%
    mutate(Name = paste0(substring(FN,1,1),". ", LN))
  
  divisonColors <- c("East"="#56B4E9", "West"="#33FAFF", "North"="#F0E442", "South"="#8B8D8D")
  conferenceColors <-  c("USL"="#000000", "AL"="#FC4E07")
  chartTitle <- paste("Runningback Quad Chart for", reportYear, sep = " ")
  
  p <- ggplot(
    chartData, 
    aes(
      x = Weight, y = Height, size = `Rusing Yards`, 
      color = Conference, fill = Division, stroke = 2,
      label = Name
    )
  ) +
    geom_point(shape = 21) +
    geom_text_repel(size = 5) +
    scale_color_manual(values = conferenceColors) +
    scale_fill_manual(values = divisonColors) +
    ggtitle(chartTitle) + 
    theme_few()
  p
  
} else{
  
  plot.new()
  title("The data supplied did not meet the requirements of the chart.")    
  
}