with sales as (
    select * 
    from {{ ref('stg_raw__sales') }}
),

product as (
    select * 
    from {{ ref('stg_raw__product') }}
)

select
    s.orders_id,
    s.products_id,
    s.date_date,
    s.quantity,
    s.revenue,
    p.purchase_price,
    CAST(s.quantity AS FLOAT64) * CAST(p.purchase_price AS FLOAT64) AS purchase_cost,
    s.revenue - (CAST(s.quantity AS FLOAT64) * CAST(p.purchase_price AS FLOAT64)) AS margin
from sales s
left join product p
    on s.products_id = p.products_id