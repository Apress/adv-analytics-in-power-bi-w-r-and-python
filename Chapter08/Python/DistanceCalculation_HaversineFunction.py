import pandas as pd 
import os
from haversine import haversine

os.chdir(r"<file path to folder that contains EmployeeList.csv>")
EmployeeList = pd.read_csv("EmployeeList.csv")

def useHaversine(row):
    point_one = \
        (row["lat_EmployeeAddress"], row["lon_EmployeeAddress"])
   
    point_two = \
        (row["lat_TerminalAddress"], row["lon_TerminalAddress"])

    return haversine(point_one, point_two, unit="mi")

EmployeeList["Haversine Function Result"] = \
    EmployeeList.apply(lambda row: useHaversine(row), axis=1)

