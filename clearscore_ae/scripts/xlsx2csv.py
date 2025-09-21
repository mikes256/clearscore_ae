import pandas as pd

df_excel = pd.read_excel('/workspaces/clearscore_ae/clearscore_ae/data/ae_sample_db.xlsx')
print(df_excel.isnull().sum().sum())

df_excel.to_csv('/workspaces/clearscore_ae/clearscore_ae/seeds/ae_sample_db.csv', index=False)

df_csv = pd.read_csv('/workspaces/clearscore_ae/clearscore_ae/seeds/ae_sample_db.csv')
print(df_csv.isnull().sum().sum())