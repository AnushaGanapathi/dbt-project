SELECT *
FROM {{ ref('int_shipping_flat') }}
WHERE customer_age IS NOT NULL AND (customer_age < 0 OR customer_age > 100)
