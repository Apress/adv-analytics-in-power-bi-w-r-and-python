import os
import pandas as pd
import joblib
from sklearn import datasets, linear_model
from sklearn.metrics import mean_squared_error, r2_score
from sklearn.model_selection import train_test_split

os.chdir("..")               
housing = pd.read_csv("./Data/Boston_ModelData.csv")

X = housing[["crim","rm","tax","lstat"]]
y = housing["medv"]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25)

model = linear_model.LinearRegression()
model.fit(X_train, y_train)

y_pred = model.predict(X_test)
print(r2_score(y_test, y_pred)) #At run produced a 0.73 R^2

joblib.dump(model,"model.pkl")