import pandas as pd 
import os
from haversine import haversine

os.chdir(r"C:\Users\ryanw\Downloads\Chapter06\Chapter06\Data")
EmployeeList = pd.read_csv("EmployeeList.csv")

def useHaversine(row):
    location_one = (row["lat_EmployeeAddress"], row["lon_EmployeeAddress"])
    location_two = (row["lat_TerminalAddress"], row["lon_TerminalAddress"])
    return haversine(location_one, location_two, unit="mi")

EmployeeList["Haversine Function"] = EmployeeList.apply(lambda row: useHaversine(row), axis=1)

