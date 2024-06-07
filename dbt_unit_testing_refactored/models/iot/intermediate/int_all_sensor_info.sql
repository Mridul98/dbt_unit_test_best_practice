SELECT DISTINCT 
    device_data.device_name,
    device_info.manufacturer,
    device_info.model,
    device_info.firmware_version,
    device_info.ip_address,
    device_data.latitude,
    device_data.longitude,
    device_data.temperature,
    ((device_data.temperature * 9.0/5.0) + 32) AS temperature_in_fahrenheit,
    device_data.humidity
FROM {{ ref('stg_device_data') }} AS device_data
INNER JOIN {{ ref('stg_device_info') }} AS device_info 
ON device_data.device_name = device_info.device_name
