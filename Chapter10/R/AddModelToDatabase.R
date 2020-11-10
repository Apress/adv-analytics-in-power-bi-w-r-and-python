library(RODBC)

# Load model into our R session
model <- readRDS("./Models/Model.rds")

# Connects to the database
server.name = "DSVM2019"
db.name = "BostonHousingData"
connection.string = paste(
    "driver={SQL Server}", ";", 
    "server=", server.name, ";", 
    "database=", db.name, ";", 
    "trusted_connection=true", sep = "")
conn <- odbcDriverConnect(connection.string)

# Define parameters
model_name <- "R Model"
modelbin <- serialize(model, NULL)
modelbinstr = paste(modelbin, collapse = "")

# Builds the SQL Statement and execute it 
# using the sqlQuery command
sql_code <- paste0(
    "EXEC AddModel_R ", 
    "@ModelName='", 
    model_name, "', ", 
    "@Model_Serialized='", 
    modelbinstr, "'")
sqlQuery(conn, sql_code)

odbcClose(conn)