{{ config(materialized='table') }}

with joined as (
    select
        d.year,
        d.month,
        d.month_name,
        o.order_value
    from {{ ref('fct_shipping_routes') }} f
    join {{ ref('fct_orders') }} o
      on f.order_id = o.order_id
    join {{ ref('dim_dates') }} d
      on f.ship_date = d.date
),

aggregated as (
    select
        year,
        month,
        month_name,
        sum(order_value) as total_order_value
    from joined
    group by year, month, month_name
)

select * from aggregated
order by year, month
