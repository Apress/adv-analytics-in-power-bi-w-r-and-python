import pandas as pd
import re
import os

os.chdir(r"<file to the DimEmployee.csv file>")
df = pd.read_csv("DimEmployee.csv")

nameWithOrWithoutMiddleInitial = re.compile(r'([A-Z][a-z]{1,10}\s[a-zA-Z]\s[A-Z][a-z]{1,10})|([A-Z][a-z]{1,10}\s[A-Z][a-z]{1,10})')

def scrubName(name):
    m = nameWithOrWithoutMiddleInitial.fullmatch(name)
    if m:
        return m.group(0)
    else:
        return None

df["Name"] = df.Name.apply(scrubName)