{{ config(materialized='table') }}

select
    ship_mode,
    avg(transit_time) as avg_transit_time,
    avg(weight_lbs) as avg_weight,
    count(*) as total_orders
from {{ ref('fct_shipping_routes') }}
group by 1
