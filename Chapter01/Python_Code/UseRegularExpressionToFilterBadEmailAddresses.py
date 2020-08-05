import os
import pandas as pd 

goodemails_raw = pd.read_csv("./Data/EmailAddresses.csv")
email_pattern = "^([a-zA-Z][\\w\\_]{4,20})\\@([a-zA-Z0-9.-]+)\\.([a-zA-Z]{2,3})$"
goodemails = goodemails_raw[goodemails_raw["Email"].str.match(email_pattern)]
