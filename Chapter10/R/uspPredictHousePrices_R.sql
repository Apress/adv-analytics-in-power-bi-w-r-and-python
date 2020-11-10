CREATE PROCEDURE [dbo].[uspPredictHousePrices_R] 

AS 

BEGIN 
 
  -- Define variables
  DECLARE @model varbinary(max) = 
      (SELECT MODEL 
       FROM [dbo].[Models] 
       WHERE ModelName = 'R Model');
  DECLARE @RScript nvarchar(max);
  DECLARE @Query nvarchar(max);
  DECLARE @InputDFName nvarchar(25);
  DECLARE @OutputDFName nvarchar(25);

  -- Define source data
  SET @Query='
			SELECT [crim], [rm], [tax], [lstat]
			FROM [dbo].[BostonHousingInfo]'

  -- R script to score data 
  SET @RScript = N'			
bhmodel_deserialized <- 
  unserialize(as.raw(bhmodel_serialized));
model_data <- dfInputData
pred_medv <- 
  predict(bhmodel_deserialized, model_data)

dfOutputData <- 
  cbind(model_data, pred_medv)'			

  SET @InputDFName = 'dfInputData'
  SET @OutputDFName = 'dfOutputData'
  
  EXEC sp_execute_external_script 
			 @language = N'R'
			,@script = @RScript 	
			,@input_data_1 = @Query
      ,@input_data_1_name = @InputDFName
		  ,@output_data_1_name = @OutputDFName
			,@params = N'@bhmodel_serialized varbinary(max)'
			,@bhmodel_serialized = @model   
  WITH RESULT SETS((
       [crim] float
      ,[rm] float
      ,[tax] float
			,[lstat] float
			,[pred_medv] float
  )); 
 
END