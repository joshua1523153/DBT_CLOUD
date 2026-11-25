select
    customer_id,
    initcap(first_name)             as first_name,
    initcap(last_name)              as last_name,
    lower(email)                    as email,
    city,
    kyc_status,
    updated_at
from {{ source('bank_raw', 'customers') }}