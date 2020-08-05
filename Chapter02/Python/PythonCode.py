import os
import pandas as pd

def combine_sheets(excel_file_path):

    xlsx_file = pd.ExcelFile(excel_file_path)
    ws = xlsx_file.sheet_names
    df = pd.concat(pd.read_excel(xlsx_file, sheet_name=ws))

    return df

os.chdir("./ExcelFiles/")
excel_file_paths = os.listdir(".")
combined_workbooks = pd.DataFrame()

for excel_file_path in excel_file_paths:

    combined_workbook = combine_sheets(excel_file_path)
    combined_workbooks = combined_workbooks.append(combined_workbook, ignore_index=True)
