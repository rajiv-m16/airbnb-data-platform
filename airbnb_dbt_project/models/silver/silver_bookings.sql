{{
  config(
    materialized = 'incremental',
    unique_key = 'BOOKING_ID'
  )
}}

SELECT
    BOOKING_ID,
    LISTING_ID,
    BOOKING_DATE,
    {{ multiply('NIGHTS_BOOKED', 'BOOKING_AMOUNT', 2) }} AS TOTAL_BOOKING_AMOUNT,
    CLEANING_FEE,
    SERVICE_FEE,
    BOOKING_STATUS,
    CREATED_AT
FROM {{ ref('bronze_bookings') }}

{% if is_incremental() %}
  -- Only pull records newer than the most recent record already in this table
  WHERE CREATED_AT > (SELECT MAX(CREATED_AT) FROM {{ this }})
{% endif %}