import os
import pandas as pd 

os.chdir("C:/Users/ryanwade44/Downloads/Advanced Analytics in Power BI with R and Python/Chapterx03/R_Code")
goodemails_raw = pd.read_csv("./Data/EmailAddresses.csv")

email_pattern = "^([a-zA-Z][\\w\\_]{4,20})\\@([a-zA-Z0-9.-]+)\\.([a-zA-Z]{2,3})$"

goodemails = goodemails_raw[
    goodemails_raw["Email"].str.match(email_pattern)]