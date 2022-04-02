Welcome to your new dbt project!





Week 3 answers:

Question: What is our overall conversion rate?

Query: 

  select 
    count (
    distinct case 
        when event_type = 'checkout' then session_id 
      end
    ) as checkouts,
    count(distinct session_id)  as total_sessions
  from dbt_nathan_c.stg_events

)
select checkouts/total_sessions as cvr from numbers

Answer: 62.5%

Question: What is our conversion rate by product?

Query:

select 
    name, 
    concat(round(sum(add_to_cart_sessions)/ sum(page_view_sessions) * 100,2), '%') as cvr
from dbt_nathan_c.fact_product_event_type
group by name
having name is not null
order by cvr desc

