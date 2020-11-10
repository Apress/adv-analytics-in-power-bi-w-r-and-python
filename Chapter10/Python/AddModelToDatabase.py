import os
import pyodbc 
import pickle

server = 'DSVM2019' 
database = 'BostonHousingData' 
con = pyodbc.connect(
    'Trusted_Connection=yes', 
    driver = '{SQL Server}',
    server = server, 
    database = database
    )
    
cursor = con.cursor()

model = pickle.load(open("./Models/model.pkl", "rb"))
modelstr = pickle.dumps(model)

cursor.execute(
    "INSERT INTO [dbo].[Models](ModelName, Model) VALUES (?, ?)",
    "Python Model", modelstr
    ) 

con.commit()
con.close()