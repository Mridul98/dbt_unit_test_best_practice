SELECT 
    sensor_info.device_name,
    sensor_info.manufacturer,
    sensor_info.model,
    sensor_info.ip_address,
    sensor_info.latitude,
    sensor_info.longitude,
    sensor_info.temperature AS temperature_in_celsius,
    sensor_info.temperature_in_fahrenheit,
    humidity,
    ROUND((hi_coefficients.c1 + 
    hi_coefficients.c2 * sensor_info.temperature_in_fahrenheit + 
    hi_coefficients.c3 * sensor_info.humidity + 
    hi_coefficients.c4 * sensor_info.temperature_in_fahrenheit * sensor_info.humidity + 
    hi_coefficients.c5 * POWER(sensor_info.temperature_in_fahrenheit, 2) + 
    hi_coefficients.c6 * POWER(sensor_info.humidity, 2) + 
    hi_coefficients.c7 * POWER(sensor_info.temperature_in_fahrenheit, 2) * sensor_info.humidity + 
    hi_coefficients.c8 * sensor_info.temperature_in_fahrenheit * POWER(sensor_info.humidity, 2) + 
    hi_coefficients.c9 * POWER(sensor_info.temperature_in_fahrenheit, 2) * POWER(sensor_info.humidity, 2))::NUMERIC,1) AS feels_like_in_fahrenheit,
    ROUND((((hi_coefficients.c1 + 
    hi_coefficients.c2 * sensor_info.temperature_in_fahrenheit + 
    hi_coefficients.c3 * sensor_info.humidity + 
    hi_coefficients.c4 * sensor_info.temperature_in_fahrenheit * sensor_info.humidity + 
    hi_coefficients.c5 * POWER(sensor_info.temperature_in_fahrenheit, 2) + 
    hi_coefficients.c6 * POWER(sensor_info.humidity, 2) + 
    hi_coefficients.c7 * POWER(sensor_info.temperature_in_fahrenheit, 2) * sensor_info.humidity + 
    hi_coefficients.c8 * sensor_info.temperature_in_fahrenheit * POWER(sensor_info.humidity, 2) + 
    hi_coefficients.c9 * POWER(sensor_info.temperature_in_fahrenheit, 2) * POWER(sensor_info.humidity, 2))-32) * 5.0/9.0)::NUMERIC,1) AS feels_like_in_celsius
    
FROM {{ ref('int_all_sensor_info') }} AS sensor_info,
{{ ref('stg_heat_index_coefficients')}} as hi_coefficients
