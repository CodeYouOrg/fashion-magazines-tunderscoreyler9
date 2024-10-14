WITH orders_query AS (
    SELECT 
        orders.customer_id,
        subscriptions.price_per_month,
        subscriptions.subscription_length
    FROM orders
    JOIN subscriptions
        ON orders.subscription_id = subscriptions.subscription_id
    WHERE subscriptions.description = 'Fashion Magazine'
    AND orders.order_status = 'unpaid'
)
SELECT 
    customers.customer_name AS 'Customer', 
    printf('$%.2f', SUM(orders_query.price_per_month * orders_query.subscription_length)) AS 'Amount Due'
FROM customers
JOIN orders_query
    ON customers.customer_id = orders_query.customer_id
GROUP BY customers.customer_name;