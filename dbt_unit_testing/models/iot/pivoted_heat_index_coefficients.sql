WITH pivoted_heat_index_coefficients AS (
    SELECT
        MAX(CASE WHEN coefficient_name = 'c1' THEN coefficient_value END) AS c1,
        MAX(CASE WHEN coefficient_name = 'c2' THEN coefficient_value END) AS c2,
        MAX(CASE WHEN coefficient_name = 'c3' THEN coefficient_value END) AS c3,
        MAX(CASE WHEN coefficient_name = 'c4' THEN coefficient_value END) AS c4,
        MAX(CASE WHEN coefficient_name = 'c5' THEN coefficient_value END) AS c5,
        MAX(CASE WHEN coefficient_name = 'c6' THEN coefficient_value END) AS c6,
        MAX(CASE WHEN coefficient_name = 'c7' THEN coefficient_value END) AS c7,
        MAX(CASE WHEN coefficient_name = 'c8' THEN coefficient_value END) AS c8,
        MAX(CASE WHEN coefficient_name = 'c9' THEN coefficient_value END) AS c9
        
    FROM {{ source('iot_data','heat_index_coefficients') }}
)

SELECT * FROM pivoted_heat_index_coefficients