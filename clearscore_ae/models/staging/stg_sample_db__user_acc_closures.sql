with source as (
    select *
    from {{ ref('user_account_closures') }}
),

stg_user_acc_closures as (

    select 
        user_id
        , closed_timestamp::timestamp as account_closed_at -- casting & adding _at suffix
    from source

)

select *
from stg_user_acc_closures