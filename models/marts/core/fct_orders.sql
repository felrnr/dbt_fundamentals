WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
)
, payment AS (
    SELECT * FROM {{ ref('stg_payment') }} 
)
, order_payments AS (
    SELECT 
        order_id,
        SUM(CASE WHEN status = 'success' THEN amount END) AS amount
    FROM payment
    GROUP BY 1
)
, final AS (
    SELECT
        orders.order_id
        , orders.customer_id
        , orders.order_date
        , order_payments.amount
    FROM orders
    LEFT JOIN order_payments
        ON orders.order_id = order_payments.order_id 
)

SELECT *
FROM final
