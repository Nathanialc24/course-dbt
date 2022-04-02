{{
  config(
    materialized='table'
  )
}}

with events as (

    select * from {{ ref( 'stg_events') }}

)

select 
    event_id
    , session_id
    , user_id
    , event_type
    , page_url
    , order_id
    , product_id
from events