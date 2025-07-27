{{ config(materialized='table') }}

with base as (
    select
        f.ship_mode,
        c.segment,
        avg(f.weight_lbs) as avg_weight,
        min(f.weight_lbs) as min_weight,
        max(f.weight_lbs) as max_weight
    from {{ ref('fct_shipping_routes') }} f
    join {{ ref('int_shipping_flat') }} c using(order_id)
    group by 1, 2
)

select * from base
