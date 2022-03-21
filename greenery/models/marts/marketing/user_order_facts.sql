{{
  config(
    materialized='table'
  )
}}


with orders as (

    select * 
    from {{ ref('stg_orders') }}
    
)

, users as (

    select * 
    from {{ ref('stg_users') }}

)

select
    users.user_id
    , users.first_name
    , users.last_name
    , users.phone_number
    , users.created_at
    , users.updated_at
    , orders.tracking_id
    , orders.order_cost
    , orders.shipping_cost
    , orders.order_total
    , orders.shipping_service
    , orders.estimated_delivery_at
    , orders.delivered_at
from users 
left join orders
using(user_id)