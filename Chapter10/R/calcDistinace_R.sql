USE [SentimentAnalysisDB]
GO

/****** Object:  StoredProcedure [dbo].[calcDistance_R]    Script Date: 2/12/2020 7:15:02 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[calcDistance_R]
AS

BEGIN

      DECLARE @RScript nvarchar(max);
      DECLARE @Query nvarchar(max);
      DECLARE @InputDFName nvarchar(128) = 'dfInput';
      DECLARE @OutputDFName nvarchar(128) = 'dfOutput';

      SET @Query = 'SELECT ID, AddressA, AddressB, lon_AddressA, lat_AddressA, lon_AddressB, lat_AddressB
                    FROM [dbo].[Destinations]'

      SET @RScript = '
		library(tidyverse)

		ComputeDist <-
			function(addressA_long, addressA_lat, addressB_long, addressB_lat) {
				R <- 6371 / 1.609344 #radius in mile
				delta_lat <- addressB_lat - addressA_lat
				delta_long <- addressB_long - addressA_long
				degrees_to_radians = pi / 180.0
				a1 <- sin(delta_lat / 2 * degrees_to_radians)
				a2 <- as.numeric(a1) ^ 2
				a3 <- cos(addressA_lat * degrees_to_radians)
				a4 <- cos(addressB_lat * degrees_to_radians)
				a5 <- sin(delta_long / 2 * degrees_to_radians)
				a6 <- as.numeric(a5) ^ 2
				a <- a2 + a3 * a4 * a6
				c <- 2 * atan2(sqrt(a), sqrt(1 - a))
				d <- R * c
				return(d)
			}

		dfOutput <- 
		dfInput %>%
		mutate(
			Distance =
				round(ComputeDist(lon_AddressA, lat_AddressA, lon_AddressB, lat_AddressB), 1)
		)
		'

      EXEC sp_execute_external_script
             @language = N'R'
            ,@input_data_1 = @Query
            ,@input_data_1_name = @InputDFName
            ,@output_data_1_name = @OutputDFName
            ,@script = @RScript

      WITH RESULT SETS (
            (             
             [ID] [bigint],
             [AddressA] [varchar](50),
             [AddressB] [varchar](50),
             [lon_AddressA] [decimal](10,8),
             [lat_AddressA] [decimal](10,8),
             [lon_AddressB] [decimal](10,8),
             [lat_AddressB] [decimal](10,8),
			 [Distance] [decimal](4,1)
            )
        )

END
GO