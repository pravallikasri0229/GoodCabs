WITH MonthlyRepeatRate AS (
    SELECT 
        c.city_name,
        ps.month,
        ps.total_passengers,
        ps.repeat_passengers,
        ROUND((ps.repeat_passengers * 100.0) / ps.total_passengers, 2) AS monthly_repeat_passenger_rate
    FROM 
        trips_db.fact_passenger_summary ps
    JOIN 
        trips_db.dim_city c ON ps.city_id = c.city_id
),
CityWideRepeatRate AS (
    SELECT 
        city_name,
        SUM(repeat_passengers) AS total_repeat_passengers,
        SUM(total_passengers) AS total_passengers,
        ROUND((SUM(repeat_passengers) * 100.0) / SUM(total_passengers), 2) AS city_repeat_passenger_rate
    FROM 
        trips_db.fact_passenger_summary ps
    JOIN 
        trips_db.dim_city c ON ps.city_id = c.city_id
    GROUP BY 
        city_name
)
SELECT 
    m.city_name,
    m.month,
    m.total_passengers,
    m.repeat_passengers,
    m.monthly_repeat_passenger_rate,
    cwr.city_repeat_passenger_rate
FROM 
    MonthlyRepeatRate m
JOIN 
    CityWideRepeatRate cwr ON m.city_name = cwr.city_name
ORDER BY 
    m.city_name, m.month;
