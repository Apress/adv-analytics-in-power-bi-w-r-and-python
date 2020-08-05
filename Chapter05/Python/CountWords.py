import pandas as pd  
import os 

os.chdir(r"C:\Users\ryanw\OneDrive - Diesel Analytics\Professional\Clients\Apress\Book\Part2_ShapingData\Chapter5\Misc")

df = pd.read_csv("yelp_training_set_review_sample.csv")
df["word_count"] = df["text"].str.split().apply(len)