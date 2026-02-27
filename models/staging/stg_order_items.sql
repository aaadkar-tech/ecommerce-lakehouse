with source as (
    select * from {{ source('olist', 'order_items') }}
),

renamed as (
    select
        order_id,
        order_item_id,
        product_id,
        seller_id,
        shipping_limit_date                     as shipping_limit_at,
        price                                   as item_price,
        freight_value                           as freight_cost,
        price + freight_value                   as total_item_value
    from source
)

select * from renamed