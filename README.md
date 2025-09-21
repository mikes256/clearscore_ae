# clearscore_ae

before i started i considered how the marketing team might use the data, the best angles of the data and how they could potentially leverage the maximum usecase from the sample db.

1. python module which converts `.xlsx` to `.csv`, important this is tracked for version control and not just added as an untraceable file extension
- created a raw_data dir which keeps the `.xlsx` and used a convertion `.py` module for the file conversion into the dbt seeds dir.
1. dbt allows for `.csv` files using the dbt seed command
2. created multiple staging source of truth models
3. added very light transformation to the staging model and all models written in ctes
4. added dbt tests to the stg models


# debugging
1. converting `ae_sample_db.xlsx` to `ae_sample_db.csv` but ensuring no data is loss or changed
2. decided if i wanted to join from early or later on in the transformation