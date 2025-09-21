import pandas as pd

# Load the Excel file
excel_path = '/workspaces/clearscore_ae/clearscore_ae/raw_data/ae_sample_db.xlsx'
excel_file = pd.ExcelFile(excel_path)

for sheet_name in excel_file.sheet_names:
    df = pd.read_excel(excel_file, sheet_name=sheet_name)
    print(f"{sheet_name}: (.xlsx) Missing values = {df.isnull().sum().sum()}")

    csv_path = f'/workspaces/clearscore_ae/clearscore_ae/seeds/{sheet_name}.csv'
    df.to_csv(csv_path, index=False)

    df_check = pd.read_csv(csv_path)
    print(f"{sheet_name} (.csv): Missing values = {df_check.isnull().sum().sum()}")
