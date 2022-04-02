{{
  config(
    materialized='table'
  )
}}

SELECT 
  event_id
  , session_id
  , user_id
  , event_type
  , page_url
  , order_id
  , product_id
  , created_at
FROM {{ source('tutorial', 'events') }}