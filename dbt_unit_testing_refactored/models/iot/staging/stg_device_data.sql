SELECT 
    device_name::TEXT,
    (data ->> 'temperature')::FLOAT              AS temperature,
    (data ->> 'humidity')::FLOAT                 AS humidity ,
    (data ->> 'status')::TEXT                    AS device_status,
    (data -> 'location' ->> 'latitude')::FLOAT  AS latitude,
    (data -> 'location' ->> 'longitude')::FLOAT AS longitude
FROM 
    {{ source('iot_data','device_data') }}