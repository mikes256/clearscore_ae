with stg_attributes as (
    select 
        user_id
        , gender
        , date_of_birth
    from {{ ref('stg_sample_db__user_acc_attributes') }}
),

stg_closures_agg as (
    select
        user_id
        , max(account_closed_at) as account_closed_at
    from {{ ref('stg_sample_db__user_acc_closures') }}
    group by 1
),

stg_reactivations_agg as (
    select
        user_id,
        max(account_reopened_at) as account_reopened_at
    from {{ ref('stg_sample_db__user_acc_reactivations') }}
    group by 1
),

stg_users_agg as (
    select
        user_id
        , max(created_at) as created_at
        , max(last_updated_time) as last_updated_time
        , max(email) as email
    from {{ ref('stg_sample_db__user_acc') }}
    where is_internal_user = 'False' -- all internal users are ommitted from the data at this stage
    group by 1
),

stg_marketing_pref_agg as (
    select
        user_id
        , bool_or(case when marketing_opt_in in ('true','1','yes') then true else false end) as marketing_opt_in
        , max(user_opt_in_at) as user_opt_in_at
    from {{ ref('stg_sample_db__user_mrktng_preferences') }}
    group by 1
)

select
    a.user_id
    , a.gender
    , a.date_of_birth
    , u.email
    , u.created_at
    , u.last_updated_time
    , c.account_closed_at
    , r.account_reopened_at
    , m.marketing_opt_in
    , m.user_opt_in_at
from stg_attributes a
left join stg_closures_agg c  on a.user_id = c.user_id
left join stg_reactivations_agg r on a.user_id = r.user_id
left join stg_users_agg u on a.user_id = u.user_id
left join stg_marketing_pref_agg m on a.user_id = m.user_id
