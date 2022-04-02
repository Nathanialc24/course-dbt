{{
  config(
    materialized='table'
  )
}}

with products as (

    select * from {{ ref( 'dim_products') }}

)

, events as (

    select * from {{ ref( 'dim_events') }}

)

{% set sql_statement %}
    select distinct event_type from {{ ref('dim_events') }}
{% endset %}

{%- set event_types = dbt_utils.get_query_results_as_dict(sql_statement) -%}

select
    products.name
    , product_id 
    {% for event_type in event_types['event_type'] %}
    , count(distinct case when event_type = '{{event_type}}' then session_id end) as {{ dbt_utils.slugify(event_type) }}_sessions
    {% endfor %}
FROM events
left join products using(product_id)
group by products.name, product_id

