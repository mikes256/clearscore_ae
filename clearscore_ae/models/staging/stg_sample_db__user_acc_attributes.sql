with source as (
    select * 
    from {{ ref('user_account_attributes')}}
),

stg_user_acc_attributes as (
    
    select 
        user_id
        , gender
        , country as country_code -- renamed to add clarity
        , date_of_birth::date
    from source
)

select *
from stg_user_acc_attributes