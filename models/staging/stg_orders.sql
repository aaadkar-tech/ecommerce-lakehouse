with source as (
    select * from {{ source('olist', 'orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        order_status                                            as status,
        order_purchase_timestamp                                as purchased_at,
        order_approved_at                                       as approved_at,
        order_delivered_carrier_date                            as delivered_to_carrier_at,
        order_delivered_customer_date                           as delivered_to_customer_at,
        order_estimated_delivery_date                           as estimated_delivery_at,

        -- derived fields
        datediff(
            'day',
            order_purchase_timestamp,
            order_delivered_customer_date
        )                                                       as days_to_deliver,

        datediff(
            'day',
            order_estimated_delivery_date,
            order_delivered_customer_date
        )                                                       as delivery_delay_days

    from source
)

select * from renamed