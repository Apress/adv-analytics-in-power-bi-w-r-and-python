import pandas as pd
import re
import os

os.chdir("<path to ProductionOrders.csv file>")
pattern = re.compile(r"^(561769|561394)(?=(01|22|39)(A|B)\d{1}$)")

def monitoredProducts(sku):

    m = pattern.match(sku)
    if m == True:
        return m.group(0)
    else:
        return "Not Moinitored"

df = pd.read_csv("ProductionOrders.csv")

df["Monitored Products"] = df["SKU"].apply(monitoredProducts)
