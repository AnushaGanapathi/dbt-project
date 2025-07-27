{{ config(materialized='table') }}

with dates as (
    select distinct
        ship_date as date
    from {{ ref('int_shipping_flat') }}
    where ship_date is not null
),

final as (
    select
        date,
        extract(year from date) as year,
        extract(month from date) as month,
        extract(day from date) as day,
        extract(dow from date) as day_of_week,
        to_char(date, 'Month') as month_name,
        to_char(date, 'Day') as day_name
    from dates
)

select * from final
