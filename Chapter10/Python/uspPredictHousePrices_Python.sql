CREATE PROCEDURE [dbo].[uspPredictHousePrices_Python]
AS
BEGIN
  
  DECLARE @model VARBINARY(max) = 
      (SELECT MODEL 
       FROM [dbo].[Models] 
       WHERE ModelName = 'Python Model');
  DECLARE @PythonScript nvarchar(max);
  DECLARE @Query nvarchar(max);
  DECLARE @InputDFName nvarchar(25);
  DECLARE @OutputDFName nvarchar(25);

  -- Define source data
  SET @Query='SELECT [crim], [rm], [tax], [lstat]
			  FROM [dbo].[BostonHousingInfo]'

  -- Python script to score data 
  SET @PythonScript = N'
import pickle
from sklearn import linear_model

bhmodel_deserialized = pickle.loads(bhmodel_serialized)
pred_medv = bhmodel_deserialized.predict(dfInputData)
dfOutputData = dfInputData 
dfOutputData["pred_medv"] = pred_medv
'
  SET @InputDFName = 'dfInputData'
  SET @OutputDFName = 'dfOutputData'

  EXECUTE sp_execute_external_script 
         @language = N'Python'
        ,@script = @PythonScript
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
END;