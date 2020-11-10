CREATE PROCEDURE [dbo].[AddModel_R]  
@ModelName varchar(50),
@Model_Serialized nvarchar(max)

AS  
BEGIN
	
	SET NOCOUNT ON;

	-- Declare the variables
	DECLARE @Model_Binary varbinary(max);
	
	-- Converts the model to a varbinary data type. 
	SELECT @Model_Binary = convert(varbinary(max),@Model_Serialized,2) 
    
	-- Inserts the values that were passed to the stored procedure and the variables that were 
	-- created above to a record in the Models table
	INSERT INTO [dbo].[Models](ModelName, MODEL) 
	VALUES (@Modelname, @Model_Binary)
	  
END