SELECT 
    c.city_name,
    COUNT(ft.trip_id) AS total_trips,
    ROUND(SUM(ft.fare_amount) / SUM(ft.distance_travelled_km), 2) AS avg_fare_per_km,
    ROUND(AVG(ft.fare_amount), 2) AS avg_fare_per_trip,
    ROUND((COUNT(ft.trip_id) * 100.0) / SUM(COUNT(ft.trip_id)) OVER (), 2) AS percentage_contribution_to_total_trips
FROM 
    fact_trips ft
JOIN 
    dim_city c ON ft.city_id = c.city_id
GROUP BY 
    c.city_name
ORDER BY 
    total_trips DESC;
