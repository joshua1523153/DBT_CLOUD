{{ config(materialized='table', schema='gold') }}

WITH customers AS (
    SELECT * FROM {{ ref('stg_customers') }}
),

transactions AS (
    SELECT * FROM {{ ref('stg_transactions') }}
)

SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_full_name,
    c.country,
    COUNT(t.transaction_id) AS total_transactions,
    SUM(CASE WHEN t.transaction_type = 'DEPOSIT' THEN t.amount ELSE 0 END) AS total_deposited,
    SUM(CASE WHEN t.transaction_type = 'WITHDRAWAL' THEN ABS(t.amount) ELSE 0 END) AS total_withdrawn,
    SUM(t.amount) AS current_balance
FROM customers c
LEFT JOIN transactions t ON c.customer_id = t.customer_id
GROUP BY 1, 2, 3
