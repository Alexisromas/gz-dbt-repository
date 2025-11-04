with orders_margin as (
    select * 
    from {{ ref('int_orders_margin') }}
),

ship as (
    select 
        orders_id,
        shipping_fee,
        logcost,
        CAST(ship_cost AS FLOAT64) as ship_cost
    from {{ ref('stg_raw__ship') }}
)

select
    o.orders_id,
    o.date_date,
    o.margin + s.shipping_fee - s.logcost - s.ship_cost as operational_margin
from orders_margin o
left join ship s
    on o.orders_id = s.orders_id
order by o.orders_id