USE [SentimentAnalysisDB]
GO

/****** Object:  StoredProcedure [dbo].[getSentiments_Python]    Script Date: 2/12/2020 7:25:54 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[getSentiments_Python]
AS

BEGIN

      DECLARE @PythonScript nvarchar(max);
      DECLARE @Query nvarchar(max);
      DECLARE @InputDFName nvarchar(128) = 'dfInput';
      DECLARE @OutputDFName nvarchar(128) = 'dfOutput';

      SET @Query = 'SELECT ID, [text] FROM dbo.SentimentData'

      SET @PythonScript = '
import pandas as pd
from microsoftml import rx_featurize, get_sentiment

sentiment_scores = rx_featurize(
    data=dfInput,
    ml_transforms=[get_sentiment(cols=dict(scores="text"))])

dfOutput = sentiment_scores
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
             [text] [varchar](8000),
             [score] [float]
            )
        )

END
GO


