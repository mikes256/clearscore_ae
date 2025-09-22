with source as (
    select *
    from {{ ref('user_marketing_preferences') }}
),

stg_user_mrktng_p as (

    select 
        user_id
        , marketing_opt_in
        , timestamp::timestamp as user_opt_in_at -- casting & adding _at suffix
    from source 
)

select *
from stg_user_mrktng_p