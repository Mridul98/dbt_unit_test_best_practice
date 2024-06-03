WITH flattened_device_data AS (
    SELECT 
        device_name::TEXT,
        (data -> 'temperature')::FLOAT AS temperature,
        (data -> 'humidity')::FLOAT AS humidity ,
        (data -> 'status')::text AS device_status,
        (data -> 'location' ->> 'latitude')::FLOAT AS latitude,
        (data -> 'location' ->> 'longitude')::FLOAT AS longitude
    FROM {{ source('iot_data','device_data')}}
),
flattened_device_info AS (
    SELECT 
        device_name::TEXT,
        (info -> 'manufacturer')::TEXT AS manufacturer,
        (info -> 'model')::TEXT AS model,
        (info -> 'firmware_version')::TEXT AS manufacturer,
        (info -> 'ip_address')::TEXT AS manufacturer,
        (jsonb_array_elements(info -> 'sensors')->'type')::TEXT AS sensor_data_type,
        (sensor_data_range -> 'range' ->> 0)::FLOAT AS sensor_data_range_min,
        (sensor_data_range -> 'range' ->> 1)::FLOAT AS sensor_data_range_max,
    FROM {{ source('iot_data','device_info')}}, jsonb_array_elements(info -> 'sensors') AS sensor_data_range
        
)
select * from flattened_device_info