library(tidyverse)
library(jsonlite)
library(httr)

# Set working directory
setwd("<path to folder where MyKey.R is located>")

# Add the mykey variable to our session
source("./MyKey.R")

# Read in the yelp data and add "en" for the language class
yelp_data <- read_csv("./Data/yelp_training_set_review_sample.csv")

yelp_data <-
  yelp_data %>%
  transmute(language = "en", id, text) %>%
  sample_n(3) #

# Get API endpoint
api_end_point <- "https://eastus.api.cognitive.microsoft.com/text/analytics/v2.1/sentiment"

# Get the data needed for scoring from out yelp data set and convert it to JSON
request_body <- yelp_data
request_body_json <- toJSON(list(documents = request_body))

# Call the API to get our sentiment scores
result <-
  POST(
    api_end_point,
    body = request_body_json,
    add_headers(
      .headers =
        c(
          "Content-Type" = "application/json", 
          "Ocp-Apim-Subscription-Key" = mykey
        )
    )		
  )

# Extract the dataframe from the list and combine it to the original dataset
yelp_data_with_scores <-
  fromJSON(content(result, as = "text"))[["documents"]] %>%
  mutate(id = as.numeric(id)) %>%
  inner_join(yelp_data, by = "id") %>%
  select(id, text, score)