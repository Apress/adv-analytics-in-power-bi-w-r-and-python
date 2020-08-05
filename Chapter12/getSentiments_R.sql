USE [SentimentAnalysisDB]
GO

/****** Object:  StoredProcedure [dbo].[getSentiments_R]    Script Date: 2/12/2020 7:26:00 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[getSentiments_R]
AS

BEGIN

      DECLARE @RScript nvarchar(max);
      DECLARE @Query nvarchar(max);
      DECLARE @InputDFName nvarchar(128) = 'dfInput';
      DECLARE @OutputDFName nvarchar(128) = 'dfOutput';

      SET @Query = 'SELECT ID, [text] FROM dbo.SentimentData'

      SET @RScript = '
            dfInput$text = as.character(dfInput$text)
            sentimentScores <- rxFeaturize(
				data = dfInput,
				mlTransforms = getSentiment(vars = list(SentimentScore = "text"))
			)

            sentimentScores$text <- NULL
            dfOutput <- cbind(dfInput, sentimentScores)'

      EXEC sp_execute_external_script
             @language = N'R'
            ,@input_data_1 = @Query
            ,@input_data_1_name = @InputDFName
            ,@output_data_1_name = @OutputDFName
            ,@script = @RScript

      WITH RESULT SETS (
            (             
             [ID] [bigint],
             [text] [varchar](8000),
             [score] [float]
            )
        )

END
GO


