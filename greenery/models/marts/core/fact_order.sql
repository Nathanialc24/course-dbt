{{
  config(
    materialized='table'
  )
}}

select 
     orders.user_id
    , orders.order_id
    , orders.promo_id
    , orders.address_id
    , orders.delivered_at
    , orders.created_at
    , promo.status as promo_status
    , sum(orders.order_cost) as order_cost
    , sum(orders.order_total) as order_total
    , sum(promo.discount) as promo_discount
    , sum(orders.shipping_cost) as shipping_cost
from {{ ref('stg_orders') }} as orders
left join {{ ref('stg_promos') }} as promo 
using (promo_id)
group by 1,2,3,4,5,6,7

