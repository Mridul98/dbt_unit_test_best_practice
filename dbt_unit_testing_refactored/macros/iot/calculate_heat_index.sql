
{% macro heat_index_in_fahrenheit(hi_coefficients_model,sensor_info_model,convert_to_celcius=False) %}

    ROUND((hi_coefficients_model.c1 + 
    hi_coefficients_model.c2 * sensor_info_model.temperature_in_fahrenheit + 
    hi_coefficients_model.c3 * sensor_info_model.humidity + 
    hi_coefficients_model.c4 * sensor_info_model.temperature_in_fahrenheit * sensor_info_model.humidity + 
    hi_coefficients_model.c5 * POWER(sensor_info_model.temperature_in_fahrenheit, 2) + 
    hi_coefficients_model.c6 * POWER(sensor_info_model.humidity, 2) + 
    hi_coefficients_model.c7 * POWER(sensor_info_model.temperature_in_fahrenheit, 2) * sensor_info_model.humidity + 
    hi_coefficients_model.c8 * sensor_info_model.temperature_in_fahrenheit * POWER(sensor_info_model.humidity, 2) + 
    {% if convert_to_celcius == True %}
    hi_coefficients.c9 * POWER(sensor_info.temperature_in_fahrenheit, 2) * POWER(sensor_info.humidity, 2))-32) * 5.0/9.0)::NUMERIC,1)
    {% else %}
    hi_coefficients_model.c9 * POWER(sensor_info_model.temperature_in_fahrenheit, 2) * POWER(sensor_info_model.humidity, 2))::NUMERIC,1)
    {% endif %}
    
{% endmacro %}