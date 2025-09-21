with source as (
    select *
    from {{ ref('user_account_reactivations') }}
),

stg_user_acc_reactivations as (

    select 
        user_id
        , reopened_timestamp as account_reopened_at -- casting & adding _at suffix
    from source

)

select * 
from stg_user_acc_reactivations
