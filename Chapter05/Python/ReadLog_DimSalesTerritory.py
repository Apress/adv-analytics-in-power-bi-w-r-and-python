import pandas as pd
from sqlalchemy import create_engine 
from datetime import datetime

tablename = "DimSalesTerritory"

conn = create_engine("mssql+pyodbc://SQLServer2017")

df_read = pd.read_sql_table(tablename, conn)

datestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
num_records = df_read.shape[0]

dict_insert = {
    "DATESTAMP":[datestamp], 
    "TABLENAME":[tablename], 
    "NUM_RECORDS":[num_records]}
df_insert = pd.DataFrame.from_dict(dict_insert)

df_insert.to_sql(
	name='LoadHistoryLog', 
	con=conn,
	index=False,
	if_exists = 'append'
)