import os
import pandas as pd
from dateutil.relativedelta import relativedelta
    
os.chdir("./Data/SalesData")
monthly_reports = os.listdir(".")

d = {'monthly_reports': monthly_reports}
df = pd.DataFrame(d)
df["date_format"] = pd.to_datetime(df.monthly_reports.str.replace(".csv",""))

min_month = df.date_format.max() - relativedelta(months=12)

reports_to_read = df[df["date_format"]>=min_month]

df_output = pd.concat(map(pd.read_csv, reports_to_read["monthly_reports"]))