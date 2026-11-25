select
    account_id,
    customer_id,
    sum(signed_amount) as current_balance,
    count(*)           as txn_count,
    max(txn_ts)        as last_txn_at
from {{ ref('fct_transactions') }}
group by account_id, customer_id