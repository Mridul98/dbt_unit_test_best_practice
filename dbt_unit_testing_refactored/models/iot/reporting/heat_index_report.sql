SELECT 
    device_name,
    manufacturer,
    model,
    ip_address,
    latitude,
    longitude,
    temperature_in_celsius,
    temperature_in_fahrenheit,
    feels_like_in_fahrenheit,
    feels_like_in_celsius
FROM {{ ref('int_heat_indexes') }}