import os
import pandas as pd
from sklearn.externals import joblib
from sklearn import linear_model

model = joblib.load("./Models/model")
boston_housing = pd.read_csv("./Data/BostonHousingInfo.csv")

model_data = boston_housing[["crim","rm","tax","lstat"]]

pred_medv = model.predict(model_data)

final_output = model_data
final_output["pred_mev"] = pred_medv