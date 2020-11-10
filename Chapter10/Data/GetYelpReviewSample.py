import pandas as pd 
import numpy as np
import os 

os.chdir("<path to your working directory where the yelp_review.csv data set is located>")

dfYelpReviews = pd.read_csv("yelp_review.csv")
dfYelpReviewsSample = dfYelpReviews.sample(200, random_state = 1)
dfYelpReviewsSample["id"] = np.arange(len(dfYelpReviewsSample))
dfYelpReviewsSample = dfYelpReviewsSample[["id","text"]] 
dfYelpReviewsSample.to_csv("yelp_review_sample.csv", index = False)