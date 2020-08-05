USE [SentimentAnalysisDB]
GO

/****** Object:  StoredProcedure [dbo].[calcDistance_Python]    Script Date: 2/12/2020 7:14:53 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[calcDistance_Python]
AS

BEGIN

      DECLARE @PythonScript nvarchar(max);
      DECLARE @Query nvarchar(max);
      DECLARE @InputDFName nvarchar(128) = 'dfInput';
      DECLARE @OutputDFName nvarchar(128) = 'dfOutput';

      SET @Query = 'SELECT 
						 ID
						,d.AddressA
						,d.AddressB
						,lon_AddressA = CAST(d.lon_AddressA AS FLOAT)
						,lat_AddressA = CAST(d.lat_AddressA AS FLOAT)
						,lon_AddressB = CAST(d.lon_AddressB AS FLOAT)
						,lat_AddressB = CAST(d.lat_AddressB AS FLOAT)
                    FROM [dbo].[Destinations] d'

      SET @PythonScript = '
import pandas as pd
import numpy as np 
from math import cos, sin, atan2, pi, sqrt, pow

def ComputeDist(row):
    R = 6371 / 1.609344 #radius in mile
    delta_lat = row["lat_AddressA"] - row["lat_AddressB"]
    delta_lon = row["lon_AddressA"] - row["lon_AddressB"]
    degrees_to_radians = pi / 180.0
    a1 = sin(delta_lat / 2 * degrees_to_radians)
    a2 = pow(a1,2)
    a3 = cos(row["lat_AddressB"] * degrees_to_radians)
    a4 = cos(row["lat_AddressA"] * degrees_to_radians)
    a5 = sin(delta_lon / 2 * degrees_to_radians)
    a6 = pow(a5,2)
    a = a2 + a3 * a4 * a6
    c = 2 * atan2(sqrt(a), sqrt(1 - a))
    d = R * c

    return d

dfOutput = dfInput

dfOutput["Distance"] = dfOutput.apply(lambda row: ComputeDist(row), axis=1)
'

      EXEC sp_execute_external_script
             @language = N'Python'
            ,@input_data_1 = @Query
            ,@input_data_1_name = @InputDFName
            ,@output_data_1_name = @OutputDFName
            ,@script = @PythonScript

      WITH RESULT SETS (
            (             
             [ID] [bigint],
             [AddressA] [varchar](50),
             [AddressB] [varchar](50),
             [lon_AddressA] [FLOAT],
             [lat_AddressA] [FLOAT],
             [lon_AddressB] [FLOAT],
             [lat_AddressB] [FLOAT],
			 [Distance] [FLOAT]
            )
        )

END
GO


