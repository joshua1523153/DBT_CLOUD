{{ config(materialized='view', schema='silver') }}

SELECT
    TRIM(customer_id) AS customer_id,
    INITCAP(TRIM(first_name)) AS first_name,
    INITCAP(TRIM(last_name)) AS last_name,
    LOWER(TRIM(email)) AS email,
    UPPER(TRIM(country)) AS country,
    CONVERT_TIMEZONE('UTC', created_at)::TIMESTAMP_NTZ AS created_at_utc
FROM {{ source('banking_bronze', 'raw_customers') }}
