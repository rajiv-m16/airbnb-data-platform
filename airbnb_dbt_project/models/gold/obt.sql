

{% set configs = [
    {
        "model_name" : "silver_bookings",
        "columns": "silver_bookings.*",
        "alias": "silver_bookings"
    },
    {
        "model_name" : "silver_listings",
        "columns": "silver_listings.HOST_ID, silver_listings.PROPERTY_TYPE, silver_listings.ROOM_TYPE, silver_listings.CITY, silver_listings.COUNTRY, silver_listings.ACCOMMODATES, silver_listings.BEDROOMS, silver_listings.PRICE_PER_NIGHT, silver_listings.PRICE_PER_NIGHT_TAG, silver_listings.CREATED_AT AS LISTINGS_CREATED_AT",
        "alias": "silver_listings",
        "join_condition": "silver_bookings.listing_id = silver_listings.listing_id"
    },
    {
        "model_name" : "silver_hosts",
        "columns": "silver_hosts.HOST_NAME, silver_hosts.HOST_SINCE, silver_hosts.IS_SUPERHOST, silver_hosts.RESPONSE_RATE, silver_hosts.RESPONSE_RATE_QUALITY, silver_hosts.CREATED_AT AS HOST_CREATED_AT",
        "alias": "silver_hosts",
        "join_condition": "silver_listings.host_id = silver_hosts.host_id"
    }
] %}

SELECT
    {% for config in configs %}
        {{ config['columns'] }} {% if not loop.last %},{% endif %}
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