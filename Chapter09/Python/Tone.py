import json
import pandas as pd
import ast
import os
from ibm_watson import ToneAnalyzerV3
from ibm_watson.tone_analyzer_v3 import ToneInput
from ibm_cloud_sdk_core.authenticators import IAMAuthenticator

authenticator = IAMAuthenticator("<your API key>")

service = ToneAnalyzerV3(
    version='2019-12-22',
    authenticator=authenticator)

service.set_service_url(
    "https://gateway.watsonplatform.net/tone-analyzer/api")

dfDocuments = pd.read_csv(
    "<path to the documents csv file>")  

listReturnedUtterance = []
for index, row in dfDocuments.iterrows():
    submissionText = row["text"].replace("'","")
    submissionText = submissionText[0:500]
    PythonExpression = "[{'text':  '" + submissionText + "'}]"
    Submission = ast.literal_eval(PythonExpression)
    tone_chat = service.tone_chat(Submission).get_result()
    
    utterances = tone_chat["utterances_tone"]

    sad, frustrated, satisfied, excited, \
    polite, impolite, sympathetic, unknown = \
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 

    tones = utterances[0]["tones"]
    for tone in tones:
        toneid = tone["tone_id"]
        if toneid == "sad":
            sad = tone["score"]
        elif toneid == "frustrated":
            frustrated = tone["score"]
        elif toneid == "satisfied":
            satisfied = tone["score"]
        elif toneid == "excited":
            excited = tone["score"]
        elif toneid == "polite":
            polite = tone["score"]
        elif toneid == "impolite":
            impolite = tone["score"]
        elif toneid == "sympathetic":
            sympathetic = tone["score"]
        else:
            unknown = tone["score"] 

    listReturnedUtterance.append(
        [index, sad, frustrated, satisfied, excited, 
        polite, impolite, sympathetic, unknown])

colnames = ["index", "sad", "frustrated", "satisfied", "excited", 
"polite", "impolite", "sympathetic", "unknown"]
dfReturnedUtterance = pd.DataFrame(
    listReturnedUtterance, columns=colnames)

dfOutput = pd.merge(
    dfDocuments, dfReturnedUtterance, 
    how='inner', left_on = 'id', right_on = 'index')

dfOutput = dfOutput[
    ['id', 'text', 'sad', 'frustrated', 'satisfied', 
    'excited', 'polite', 'impolite', 'sympathetic', 'unknown']]