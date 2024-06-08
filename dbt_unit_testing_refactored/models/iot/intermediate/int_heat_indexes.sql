{% set sensor_info = 'sensor_info' %}
{% set hi_coefficients = 'hi_coefficients' %}

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
    {{ 
        heat_index_in_fahrenheit(
            hi_coefficients_model=hi_coefficients,
            sensor_info_model=sensor_info
        ) 
    }} AS feels_like_in_fahrenheit,
    {{ 
        convert_to_celcius(
            heat_index_in_fahrenheit=heat_index_in_fahrenheit(
                hi_coefficients_model=hi_coefficients,
                sensor_info_model=sensor_info
            )
        ) 
    }} AS feels_like_in_celsius
FROM {{ ref('int_all_sensor_info') }} AS {{ sensor_info }},
{{ ref('stg_heat_index_coefficients')}} as {{ hi_coefficients }}
