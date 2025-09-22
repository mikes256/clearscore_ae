# clearscore_ae

![alt text](<Screenshot 2025-09-22 at 23.27.04.png>)

# Purpose
This model provides a complete and accurate view of ClearScore’s external user accounts for marketing campaign targeting. It consolidates key user attributes, account status, and marketing opt-in flags into one table.

| Column               | Description                                                  |
|----------------------|--------------------------------------------------------------|
| `user_id`            | Unique identifier for each user                              |
| `email`              | Normalised email address                                     |
| `gender`             | User-reported gender                                         |
| `date_of_birth`      | Date of birth (for age-based segmentation)                   |
| `country_code`       | ISO country code                                             |
| `created_at`         | Timestamp when account was created                           |
| `last_updated_time`  | Timestamp of last account update                             |
| `account_closed_at`  | Timestamp when account was closed (if applicable)            |
| `account_reopened_at`| Timestamp when account was reopened (if applicable)          |
| `user_opt_in_marketing` | Boolean flag indicating marketing consent                 |
| `user_opt_in_at`     | Timestamp of most recent opt-in                              |
| `is_closed`          | Derived flag: true if account is closed                      |
| `is_reopened`        | Derived flag: true if account was reopened                   |
| `mart_built_at`      | Timestamp when this dataset was generated                    |

----------

# Initial Thoughts
before i started i considered how the marketing team might use the data, the best angles of the data and how they could potentially leverage the maximum use case from the `ae_sample_db`.

# methodology
1. python module which converts `.xlsx` to `.csv`, important this is tracked for version control and not just added as an untraceable file extension
- created a raw_data dir which keeps the raw `.xlsx` and used a conversion `.py` module for the file conversion into the dbt seeds dir.
1. dbt allows for `.csv` files using the dbt seed command
2. created multiple staging source of truth models
3. added very light transformation to the staging model and all models written in modular ctes
4. added dbt tests and descriptions to the stg models
5. consolidated all staging relevant user data into one intermediate canonical row per user
6. used LEFT JOINs to preserve user coverage and avoid dropping records due to missing joins
7. filtered out internal users using a clean WHERE clause on is_internal_user
8. aggregated source tables to ensure one row per user - deduplication
9. casted dates and timestamps explicitly & standardised booleans for consistency
10. in the marts added flags (`is_closed`, `is_reopened`) to support campaign logic
11. included `mart_built_at` and `last_seen_ts` for auditability and freshness tracking
12. added source freshness check 
13. added incremental model set up so as data scales there will not be a full table refresh but instead an append to the dataset

# debugging
1. converting `ae_sample_db.xlsx` to `ae_sample_db.csv` but ensuring no data is loss or changed
2. decided if i wanted to join from early or later on in the transformation
3. ensuring `is_internal_user = 'False'`

# considerations
1. used user_acc as a fact table and all attribute sheets a dimensions table creating a star schema
2. added another external datasource to enrich the data
3. add a `recency_segmentation` which would capture if `last_seen_ts` has occured in the last 30, 60 or 90 day interval catogorising users based on their activity.