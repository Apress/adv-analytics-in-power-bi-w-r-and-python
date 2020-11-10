# Input load. Please do not change #
setwd("C:/Users/ryanw/OneDrive - Diesel Analytics/Professional/Clients/Apress/Book/Part2_ShapingData/Chapter09/QuadChart")
`dataset` = read.csv('input.csv', check.names = FALSE, encoding = "UTF-8", blank.lines.skip = FALSE);
# Original Script. Please update your script content here and once completed copy below section back to the original editing window
##############################

library(tidyverse)
library(ggrepel)
library(ggthemes)
library(scales)
library(stringi)

noPlayerDups <- length(unique(dataset$Player)) == length(dataset$Player)
currentColumns <- sort(colnames(dataset))
requiredColumns <- c("Player", "Rebounds", "Total Points")
columnTest <- isTRUE(all.equal(currentColumns, requiredColumns))

if (noPlayerDups & columnTest) {
  
  chart.title <- "LA Lakers player comparison"
  chartsubtitle <- "(2008 - 2009 Season)"
  chart_source <- "Source:  lubridate package"
  
  graph_data <-
    dataset %>%
    mutate(
      Scaled.Rebounds = 
        round(rescale(Rebounds, to = c(-10, 10)), 1)
      ,Scaled.TotalPoints = 
        round(rescale(`Total Points`, to = c(-10, 10)), 1)
    )
  
  p <- ggplot(graph_data, aes(x = Scaled.Rebounds, y = Scaled.TotalPoints)) +
    geom_point() +
    geom_label_repel(aes(label = Player), size = 4, show.legend = FALSE) +
    geom_hline(yintercept = 0) +
    geom_vline(xintercept = 0) +
    
    # quad labels
    annotate("text", x = -5, y = -11, label = "Average", alpha = 0.2, size = 6) +
    annotate("text", x = -5, y = 11, label = "High Scorer", alpha = 0.2, size = 6) +
    annotate("text", x = 5, y = -11, label = "High Rebounder", alpha = 0.2, size = 6) +
    annotate("text", x = 5, y = 11, label = "Beast Mode", alpha = 0.2, size = 6) +
    
    # Squares for quad labels
    annotate("rect", xmin = -3.5, xmax = -6.5, ymin = -11.5, ymax = -10.5, alpha = .2) +
    annotate("rect", xmin = -3.5, xmax = -6.5, ymin = 10.5, ymax = 11.5, alpha = .2) +
    annotate("rect", xmin = 3.5, xmax = 6.5, ymin = -11.5, ymax = -10.5, alpha = .2) +
    annotate("rect", xmin = 3.5, xmax = 6.5, ymin = 10.5, ymax = 11.5, alpha = .2) +
    
    # Shade lower left quadrant
    annotate("rect", xmin = -Inf, xmax = 0.0, ymin = -Inf, ymax = 0, alpha = 0.1, fill = "lightskyblue") +
    
    # Shade upper right quadrant
    annotate("rect", xmin = 0.0, xmax = Inf, ymin = 0.0, ymax = Inf, alpha = 0.1, fill = "lightskyblue") +
    
    # Titles
    xlab(bquote("Reboounding" ~ symbol('\256'))) +
    ylab(bquote("Scoring" ~ symbol('\256'))) +
    #ggtitle(chart.title, subtitle = chartsubtitle) +
    labs(title = chart.title, subtitle = chartsubtitle, caption = chart_source) +
    
    # Prettying things up
    theme_tufte() +
    theme(
      plot.title = element_text(hjust = 0.5, size = 25)
      , plot.subtitle = element_text(hjust = 0.5, size = 20) 
      , panel.border = element_rect(colour = "black", size = 2, fill = NA)
      , axis.title.x = element_text(hjust = 0.1, size = 18)
      , axis.title.y = element_text(hjust = 0.1, size = 18)
    ) +
    scale_x_continuous(labels = NULL, breaks = NULL) +
    scale_y_continuous(labels = NULL, breaks = NULL) 
  
  p
  
} else {
  
  plot.new()
  title("The data supplied did not meet the requirements of the chart.")

}