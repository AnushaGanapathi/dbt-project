{{ config(materialized='table') }}

with routes as (
    select
        order_id,
        source_state,
        destination,
        ship_mode,
        transit_time,
        weight_lbs
    from {{ ref('fct_shipping_routes') }}
),

orders as (
    select
        order_id,
        order_value
    from {{ ref('fct_orders') }}
),

joined as (
    select
        r.source_state,
        r.destination,
        r.ship_mode,
        o.order_value,
        r.transit_time,
        r.weight_lbs
    from routes r
    left join orders o on r.order_id = o.order_id
    where r.source_state is not null and r.destination is not null 
),

aggregated as (
    select
        source_state,
        destination,
        ship_mode,
        sum(order_value) as total_value,
        avg(transit_time) as avg_transit_time,
        avg(weight_lbs) as avg_weight_lbs,
        source_state || ' → ' || destination as route
    from joined
    group by 1, 2, 3
)

select * from aggregated
WHERE source_state = 'CA'
order by total_value desc
LIMIT 10
