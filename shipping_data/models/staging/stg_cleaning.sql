{{ config(materialized='table') }}

with raw as (
    select *, row_number() over () as row_num
    from {{ source('staging', 'stg_unclean_data') }}
), 

renamed as (
    select
        col1  as order_id,
        col2  as consumer_first_class,
        col3  as consumer_same_day,
        col4  as consumer_second_class,
        col5  as consumer_standard_class,
        col6  as consumer_total,
        col7  as corporate_first_class,
        col8  as corporate_same_day,
        col9  as corporate_second_class,
        col10 as corporate_standard_class,
        col11 as corporate_total,
        col12 as home_office_first_class,
        col13 as home_office_same_day,
        col14 as home_office_second_class,
        col15 as home_office_standard_class,
        col16 as home_office_total,
        col17 as source_state,
        col18 as destination,
        col19 as ship_date,
        col20 as weight_lbs,
        col21 as transit_time,
        col22 as customer_age,
        col23 as gender,
        col24 as income_level,
        -- Add total as numeric sum (null-safe)
        (
            coalesce(col6::numeric, 0) +
            coalesce(col11::numeric, 0) +
            coalesce(col16::numeric, 0)
        ) as total
    from raw
    where row_num > 3
)

select * from renamed