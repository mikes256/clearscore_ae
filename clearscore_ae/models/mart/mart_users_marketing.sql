{{ config(
    materialized = 'incremental',
    unique_key = 'user_id',
    incremental_strategy = 'append'
) }}

with core as (
    select *
    from {{ ref('int_users_acc__core') }}
)

select 
    user_id
    , gender
    , date_of_birth
    , email
    , created_at
    , last_updated_time
    , account_closed_at
    , account_reopened_at
    , marketing_opt_in as user_opt_in_marketing
    , user_opt_in_at
    , case
        when account_closed_at is null then false
        else true
    end as is_closed
    , case
        when account_reopened_at is null then false
        else true
    end as is_reopened
    , current_timestamp as mart_built_at
from core

{% if is_incremental() %}
  where last_updated_time > (select max(last_updated_time) from {{ this }})
{% endif %}