{{ config(materialized='table') }}

with base as (
    select
        f.ship_mode,
        c.gender,
        c.income_level,
        avg(c.customer_age) as avg_customer_age,
        count(distinct c.order_id) as customer_count
    from {{ ref('fct_shipping_routes') }} f
    join {{ ref('dim_customers') }} c using(order_id)
    group by 1, 2, 3
)

select * from base
