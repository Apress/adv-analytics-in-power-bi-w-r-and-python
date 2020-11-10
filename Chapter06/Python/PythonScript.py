import pandas as pd
import censusdata

cns_vars = [
    "B06001_001E","B06001_002E","B06001_003E","B06001_004E",
    "B06001_005E","B06001_006E","B06001_007E","B06001_008E",
    "B06001_009E","B06001_010E","B06001_011E","B06001_012E"
    ] 

geographies = [('state', '18'),('county', '*')]

IN_POP_BY_COUNTY_BY_AGE = censusdata.download(
    'acs5', 2015, censusdata.censusgeo(geographies), 
    cns_vars)

IN_POP_BY_COUNTY_BY_AGE = IN_POP_BY_COUNTY_BY_AGE.reset_index()

new_names = {
    'index':'Geography','B06001_001E':'Total',
    'B06001_002E':'Under 5','B06001_003E':'5 to 17',
    'B06001_004E':'18 to 24','B06001_005E':'25 to 34',
    'B06001_006E':'35 to 44','B06001_007E':'45 to 54',
    'B06001_008E':'55 to 59','B06001_009E':'60 and 61',
    'B06001_010E':'62 to 64','B06001_011E':'65 to 74',
    'B06001_012E':'75+'
    }

IN_POP_BY_COUNTY_BY_AGE = 
IN_POP_BY_COUNTY_BY_AGE.rename(columns=new_names)
