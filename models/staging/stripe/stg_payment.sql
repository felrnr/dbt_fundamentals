WITH payment AS (
    SELECT 
        id AS payment_id
        , orderid AS order_id
        , paymentmethod
        , status
        , amount/100 as amount
        , created AS payment_date
    FROM raw.stripe.payment
)

SELECT *
FROM payment
