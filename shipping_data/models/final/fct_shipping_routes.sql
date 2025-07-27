{{ config(materialized='table') }}

with base as (
    select
        order_id,
        ship_mode,
        source_state,
        destination,
        transit_time,
        weight_lbs,
        ship_date
    from {{ ref('int_shipping_flat') }}
),

final as (
    select
        order_id,
        ship_mode,
        source_state,
        destination,
        transit_time,
        weight_lbs,
        ship_date
    from base
)

select * from final
