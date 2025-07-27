{{ config(materialized='table') }}

select
    order_id,
    min(ship_date) as ship_date,
    sum(value) as order_value,
    min(weight_lbs) as weight_lbs,
    min(transit_time) as transit_time,
    min(source_state) as source_state,
    min(destination) as destination
from {{ ref('int_shipping_flat') }}
group by order_id