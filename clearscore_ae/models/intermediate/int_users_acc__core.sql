with stg_attributes as (
    select * 
    from {{ ref('stg_sample_db__user_acc_attributes') }}
),

stg_closures as (
    select * 
    from {{ ref('stg_sample_db__user_acc_closures') }}
),

stg_reactivations as (
    select * 
    from {{ ref('stg_sample_db__user_acc_reactivations') }}
),

stg_users as (
    select * 
    from {{ ref('stg_sample_db__user_acc') }}
),

stg_marketing_preference as (
    select * 
    from {{ ref('stg_sample_db__user_mrktng_preferences') }}
)

select
    a.user_id
    , a.gender
    , a.country_code
    , a.date_of_birth
    , u.email
    , u.created_at
    , u.last_updated_time
    , u.is_internal_user
    , c.account_closed_at 
    , r.account_reopened_at
    , m.marketing_opt_in
    , m.user_opt_in_at
from stg_attributes a
left join stg_closures c
  on a.user_id = c.user_id
left join stg_reactivations r
  on a.user_id = r.user_id
left join stg_users u
  on a.user_id = u.user_id
left join stg_marketing_preference m
  on a.user_id = m.user_id
where u.is_internal_user = 'False' -- all internal users are ommitted from the data at this stage
