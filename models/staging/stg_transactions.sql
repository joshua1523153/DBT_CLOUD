select
    txn_id,
    account_id,
    txn_type,
    amount,
    txn_ts,
    channel,
    case when txn_type = 'DEPOSIT' then amount
         when txn_type = 'WITHDRAWAL' then -amount
    end as signed_amount
from {{ source('bank_raw', 'transactions') }}