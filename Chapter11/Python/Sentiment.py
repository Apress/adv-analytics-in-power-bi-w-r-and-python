import pandas as pd
import json
import ast
from pandas.io.json import json_normalize
from azure.cognitiveservices.language.textanalytics import TextAnalyticsClient
from msrest.authentication import CognitiveServicesCredentials

# Sets the necessary variables that are needed for the script
api_key = "<put api key here>"
endpoint = "https://rwtextanalyticsapi.cognitiveservices.azure.com/"
credentials = CognitiveServicesCredentials(api_key)
text_analytics = TextAnalyticsClient(endpoint=endpoint, credentials=credentials)

# Write code to read in data that you want to do sentiment analysis on in a pandas data frame
df = pd.read_csv("<path to yelp_sample.csv>")
df["language"] = "en"

# Convert pandas to json string
documents = df.to_json(orient='records')
documents = ast.literal_eval(documents)
response = text_analytics.sentiment(documents=documents, raw = False)

# Creates an empty list and populates it with the sentiment scores
listSentiments = []
for document in response.documents:
    id = document.id
    score = document.score
    listSentiments.append([id, score])

# Converts the list created above into a data frame
dfSentiments = pd.DataFrame(listSentiments, columns=['ID','Score'])
dfSentiments