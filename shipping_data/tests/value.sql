SELECT *
FROM {{ ref('int_shipping_flat') }}
WHERE value < 0
