WITH flattened_device_data AS (
    SELECT 
        device_name::TEXT,
        (data -> 'temperature')::FLOAT AS temperature,
        (data -> 'humidity')::FLOAT AS humidity ,
        (data -> 'status')::text AS device_status,
        (data -> 'location' ->> 'latitude')::FLOAT AS latitude,
        (data -> 'location' ->> 'longitude')::FLOAT AS longitude
    FROM 
        {{ source('iot_data','device_data') }},
        jsonb_array_elements(data -> 'sensors' ) AS sensor_data
),

flattened_device_info AS (
    SELECT 
        device_name::TEXT,
        (info -> 'manufacturer')::TEXT AS manufacturer,
        (info -> 'model')::TEXT AS model,
        (info -> 'firmware_version')::TEXT AS firmware_version,
        (info -> 'ip_address')::TEXT AS ip_address
    FROM 
        {{ source('iot_data','device_info') }}
        
),

all_sensor_info AS (
    SELECT DISTINCT 
        flattened_device_data.device_name,
        flattened_device_info.manufacturer,
        flattened_device_info.model,
        flattened_device_info.firmware_version,
        flattened_device_info.ip_address,
        flattened_device_data.latitude,
        flattened_device_data.longitude,
        flattened_device_data.temperature,
        ((flattened_device_data.temperature * 9.0/5.0) + 32) AS temperature_in_fahrenheit,
        flattened_device_data.humidity

    FROM 
        flattened_device_data
    INNER JOIN flattened_device_info 
    ON flattened_device_data.device_name = flattened_device_info.device_name
)

SELECT * FROM all_sensor_info