SELECT *
FROM {{ ref('int_shipping_flat') }}
WHERE income_level NOT IN ('Low', 'Middle', 'High') OR income_level IS NULL
