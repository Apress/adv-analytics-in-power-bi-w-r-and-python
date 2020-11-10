import pandas as pd
import re
import os

def mask_text (unmask_text):
    phone_pattern = \
        r"([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"
    ssn_pattern = r"\d{3}-\d{2}-\d{4}"
    cleanned_text = re.sub(
        phone_pattern, "XXX-XXX-XXXX", unmask_text)
    cleanned_text = re.sub(
        ssn_pattern, "XXX-XX-XXXX", cleanned_text)
    return cleanned_text

os.chdir("<path to folder that contains the Comments.csv file")
df = pd.read_csv("Comments.csv")
df.Comment = df.Comment.apply(mask_text)
df
