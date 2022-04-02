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


---------------------------------------
Week 4 answers:

Part 1:
Can see the Snapshot in the greenery/snapshot model, this is useful to help see how pricing on products has changed over time, as well seeing which items are going in and out of stock.


Part 2: 
the drop off over the funnel stages can be seen in my table by running the query:

select * from dbt_nathan_c.fct_product_funnel

The model to make this is here -> greenery/models/marts/product/fct_product_funnel.sql

The exposure model is here -> greenery/models/exposures.yml

Part 3a:

Our company already uses dbt throughout the whole data science team. I think one think its best asset is the modularity and testing. If used right it can save SO much time.

we have a few models that are pretty important, and go directly to our website's homepage. I would really like to implement a few more test, and even the exposure yml seems pretty nifty.
also the package https://hub.getdbt.com/calogica/dbt_expectations/latest/ looks awesome. I want to explore this.

I went to school for database architecture, and data modeling/ analytics engineering are becoming more and more interesting to me. I think one thing I picked up that was pretty useful was a better understanding of hooks, as well as some of the macros. The innovation seems to only be limited by the creativity here.