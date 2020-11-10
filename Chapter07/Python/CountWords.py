import pandas as pd  
import os 

os.chdir(r"<file path to the folder where the Yelp file is>")

df = pd.read_csv("yelp_training_set_review_sample.csv")
df["word_count"] = df["text"].str.split().apply(len)