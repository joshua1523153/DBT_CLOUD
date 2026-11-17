{{ config(materialized='view', schema='silver') }}

SELECT
    TRIM(transaction_id) AS transaction_id,
    TRIM(account_id) AS account_id,
    TRIM(customer_id) AS customer_id,
    amount,
    UPPER(TRIM(transaction_type)) AS transaction_type,
    -- Handle inconsistent date formats
    CASE 
        WHEN transaction_date LIKE '%-%-%' AND LENGTH(transaction_date) = 10 AND POSITION('-', transaction_date) = 5 THEN TO_DATE(transaction_date, 'YYYY-MM-DD')
        ELSE TO_DATE(transaction_date, 'DD-MM-YYYY')
    END AS transaction_date
FROM {{ source('banking_bronze', 'raw_transactions') }}
