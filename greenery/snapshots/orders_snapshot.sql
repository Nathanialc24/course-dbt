{% snapshot orders_snapshot %}

  {{
    config(
      target_schema='dbt_nathan_c',
      unique_key='order_id',
      strategy='check',
      check_cols=['status'],
    )
  }}

  select * from {{ source('tutorial', 'orders') }}

{% endsnapshot %} 