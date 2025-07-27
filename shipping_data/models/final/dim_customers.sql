{{ config(materialized='table') }}

with base as (
    select distinct
        order_id,
        customer_age,
        gender,
        income_level
    from {{ ref('int_shipping_flat') }}
),

final as (
    select
        order_id,
        customer_age,
        gender,
        income_level
    from base
)

select * from final