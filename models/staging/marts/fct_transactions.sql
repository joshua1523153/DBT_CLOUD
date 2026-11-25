select
    t.txn_id,
    t.account_id,
    a.customer_id,
    a.account_type,
    t.txn_type,
    t.amount,
    t.signed_amount,
    t.channel,
    t.txn_ts,
    date(t.txn_ts) as txn_date
from {{ ref('stg_transactions') }} t
left join {{ ref('stg_accounts') }} a
       on t.account_id = a.account_id