select
    account_id,
    customer_id,
    account_type,
    open_date,
    status as account_status
from {{ source('bank_raw', 'accounts') }}