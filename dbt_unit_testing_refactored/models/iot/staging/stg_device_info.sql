SELECT 
    device_name::TEXT,
    (info ->> 'manufacturer')::TEXT      AS manufacturer,
    (info ->> 'model')::TEXT             AS model,
    (info ->> 'firmware_version')::TEXT  AS firmware_version,
    (info ->> 'ip_address')::TEXT        AS ip_address
FROM 
    {{ source('iot_data','device_info') }}