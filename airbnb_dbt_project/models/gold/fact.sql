
{% set configs = [
    {
        "model_name" : "obt",
        "columns" : "GOLD_obt.BOOKING_ID, GOLD_obt.LISTING_ID, GOLD_obt.HOST_ID, GOLD_obt.TOTAL_AMOUNT, GOLD_obt.SERVICE_FEE, GOLD_obt.CLEANING_FEE, GOLD_obt.ACCOMMODATES, GOLD_obt.BEDROOMS, GOLD_obt.BATHROOMS, GOLD_obt.PRICE_PER_NIGHT, GOLD_obt.RESPONSE_RATE",
        "alias" : "GOLD_obt"
    },
    {
        "model_name" : "dim_listings",
        "columns" : "DIM_listings.SOME_COLUMN", -- Added example column
        "alias" : "DIM_listings",
        "join_condition" : "GOLD_obt.listing_id = DIM_listings.listing_id"
    },
    {
        "model_name" : "dim_hosts",
        "columns" : "DIM_hosts.SOME_COLUMN", -- Added example column
        "alias" : "DIM_hosts",
        "join_condition" : "GOLD_obt.host_id = DIM_hosts.host_id"
    }
] %}

SELECT
    {% for config in configs if config['columns'] != "" %}
        {{ config['columns'] }}{% if not loop.last %},{% endif %}
    {% endfor %}
FROM
    {% for config in configs %}
    {% if loop.first %}
      {{ ref(config['model_name']) }} AS {{ config['alias'] }}
    {% else %}
        LEFT JOIN {{ ref(config['model_name']) }} AS {{ config['alias'] }}
        ON {{ config['join_condition'] }}
    {% endif %}
    {% endfor %}