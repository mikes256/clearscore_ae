with source as (
    select *
    from {{ ref('user_account') }}
),

stg_user_acc as (
    select 
        user_id
        , email
        , created_timestamp::timestamp as created_at -- casting & adding _at suffix
        , last_updated::date as last_updated_time -- casting & adding _time suffix
        , internal_user as is_internal_user -- adding is_ prefix to binary columns
    from source

)

select * 
from stg_user_acc