import pandas as pd
import numpy as np 
import os
from math import cos, sin, atan2, pi, sqrt, pow

def ComputeDist(row):
    R = 6371 / 1.609344 #radius in mile
    delta_lat = row["lat_TerminalAddressGC"] - row["lat_EmployeeAddress"]
    delta_lon = row["lon_TerminalAddress"] - row["lon_EmployeeAddress"]
    degrees_to_radians = pi / 180.0
    a1 = sin(delta_lat / 2 * degrees_to_radians)
    a2 = pow(a1,2)
    a3 = cos(row["lat_EmployeeAddress"] * degrees_to_radians)
    a4 = cos(row["lat_TerminalAddress"] * degrees_to_radians)
    a5 = sin(delta_lon / 2 * degrees_to_radians)
    a6 = pow(a5,2)
    a = a2 + a3 * a4 * a6
    c = 2 * atan2(sqrt(a), sqrt(1 - a))
    d = R * c
    return d

os.chdir("<path to folder where the EmployeeList file is located>")
EmployeeList = pd.read_csv("EmployeeList_Python.csv")

EmployeeList["Custom Function"] = EmployeeList.apply(lambda row: ComputeDist(row), axis=1)
