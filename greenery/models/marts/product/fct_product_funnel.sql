{{
  config(
    materialized='table'
  )
}}

with events as (
    
    select * from {{ ref('stg_events') }}

)

, visits AS (
    SELECT session_id
          , event_type
          , created_at
    FROM events
    WHERE event_type IN ('page_view','add_to_cart', 'checkout')
    GROUP BY 1,2,3
    order by 1,2,3
)

/*curious to see this, but i dont think its necessary. */
, visit_recency as (

    select
        session_id
        , event_type
        , created_at
        , row_number() over (partition by session_id,event_type order by created_at desc) as recency

    from visits

)

, calculating_values as (

    select 
        count(distinct case when event_type in ('page_view','add_to_cart', 'checkout') and recency = 1 then session_id
        end) as level_one
        , count(distinct case when event_type in ('add_to_cart', 'checkout')  then session_id
        end) as level_two
        , count(distinct case when event_type in ('checkout') then session_id
        end) as level_three
    from visit_recency
)

, final_table as(

select 
  'funnel step 1: page_view / add_to_cart / checkout' as step,
  level_one as sessions
from calculating_values

union all

select
  'funnel step 2: add_to_cart / checkout' as step,
  level_two as sessions
from calculating_values

union all

select
  'funnel step 3: checkout' as step,
  level_three as sessions
from calculating_values
)

, lag as (

    select *
    , lag(sessions,1) OVER ()-sessions as sessions_dropped_from_previous_funnel
    , round((1.0 - sessions::numeric / lag(sessions, 1) over ()), 2) as drop_off_rate
from final_table
)

select * from lag