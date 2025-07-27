SELECT *
FROM {{ ref('int_shipping_flat') }}
WHERE ship_date < DATE '2011-01-01'
   OR ship_date > DATE '2014-12-31'
   OR ship_date IS NULL
