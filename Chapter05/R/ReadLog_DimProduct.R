library(tidyverse)
library(RODBC)
library(lubridate)

table_name <- "DimProduct"
sql <- paste0(
    "SELECT * FROM dbo.",
    table_name)

conn <- odbcConnect(dsn = "SQLServer2017")
df_read <- sqlQuery(channel = conn, query = sql)

datestamp <- now()
num_records <- nrow(df_read)

list_insert <- list(
    "DATESTAMP" = datestamp, 
    "TABLENAME" = table_name, 
    "NUM_RECORDS" = num_records)

df_insert <- as_data_frame(list_insert)

sqlSave(
    channel = conn, 
    dat = df_insert, 
    tablename = "LoadHistoryLog", 
    append = TRUE, 
    rownames=FALSE)

odbcClose(conn)