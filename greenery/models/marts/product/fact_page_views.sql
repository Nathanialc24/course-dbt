{{
  config(
    materialized='table'
  )
}}

with events as (
    
    select * from {{ ref('stg_events') }}

)

, users as (
    
    select * from {{ ref('stg_users') }}

)

SELECT
    events.event_id
    , events.session_id
    , events.user_id
    , users.first_name
    , users.last_name
    , users.email
    , events.page_url
    , events.event_type
    , count(distinct events.order_id) as orders
from events
left join users
using(user_id)
where event_type = 'page_view'
group by 1,2,3,4,5,6,7,8