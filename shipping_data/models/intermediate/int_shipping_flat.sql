{{ config(materialized='table') }}

with renamed as (
    select *
    from {{ ref('stg_cleaning') }}
),

unpivoted as (
    select order_id, 'Consumer' as segment, 'First Class' as ship_mode, nullif(consumer_first_class, 'MISSING')::numeric as value
    from renamed where consumer_first_class is not null

    union all
    select order_id, 'Consumer', 'Same Day', nullif(consumer_same_day, 'MISSING')::numeric
    from renamed where consumer_same_day is not null

    union all
    select order_id, 'Consumer', 'Second Class', nullif(consumer_second_class, 'MISSING')::numeric
    from renamed where consumer_second_class is not null

    union all
    select order_id, 'Consumer', 'Standard Class', nullif(consumer_standard_class, 'MISSING')::numeric
    from renamed where consumer_standard_class is not null

    union all
    select order_id, 'Corporate', 'First Class', nullif(corporate_first_class, 'MISSING')::numeric
    from renamed where corporate_first_class is not null

    union all
    select order_id, 'Corporate', 'Same Day', nullif(corporate_same_day, 'MISSING')::numeric
    from renamed where corporate_same_day is not null

    union all
    select order_id, 'Corporate', 'Second Class', nullif(corporate_second_class, 'MISSING')::numeric
    from renamed where corporate_second_class is not null

    union all
    select order_id, 'Corporate', 'Standard Class', nullif(corporate_standard_class, 'MISSING')::numeric
    from renamed where corporate_standard_class is not null

    union all
    select order_id, 'Home Office', 'First Class', nullif(home_office_first_class, 'MISSING')::numeric
    from renamed where home_office_first_class is not null

    union all
    select order_id, 'Home Office', 'Same Day', nullif(home_office_same_day, 'MISSING')::numeric
    from renamed where home_office_same_day is not null

    union all
    select order_id, 'Home Office', 'Second Class', nullif(home_office_second_class, 'MISSING')::numeric
    from renamed where home_office_second_class is not null

    union all
    select order_id, 'Home Office', 'Standard Class', nullif(home_office_standard_class, 'MISSING')::numeric
    from renamed where home_office_standard_class is not null
)

select
    u.order_id,
    u.segment,
    u.ship_mode,
    u.value,
    r.total,
    
    case
    when lower(r.source_state) in ('texas', 'tx') then 'TX'
    when lower(r.source_state) in ('california', 'ca') then 'CA'
    else upper(r.source_state) end as source_state,

    r.destination,
    {{ parse_fuzzy_date("ship_date") }} as ship_date,
    {{ safe_cast('r.weight_lbs', 'numeric') }} as weight_lbs,
    {{ transit_days('transit_time') }} as transit_time,
    case when r.customer_age ~ '^\d+$' and cast(r.customer_age as integer) <= 100 then cast(r.customer_age as integer)
    else null end as customer_age,

    case when lower(r.gender) in ('female', 'f') then 'F'
    when lower(r.gender) in ('male', 'm') then 'M'
    else 'unknown' end as gender,

    case
    when lower(r.income_level) like '%low%' then 'Low'
    when lower(r.income_level) like '%middle%' then 'Middle'
    when lower(r.income_level) like '%high%' then 'High'
    else null end as income_level
    
    from unpivoted u
    left join renamed r
    on u.order_id = r.order_id
