SELECT 
    c.city_name AS City_Name,
    ROUND(SUM(CASE WHEN d.trip_count = '2-Trips' THEN d.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(d.repeat_passenger_count), 2) AS `2-Trips`,
    ROUND(SUM(CASE WHEN d.trip_count = '3-Trips' THEN d.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(d.repeat_passenger_count), 2) AS `3-Trips`,
    ROUND(SUM(CASE WHEN d.trip_count = '4-Trips' THEN d.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(d.repeat_passenger_count), 2) AS `4-Trips`,
    ROUND(SUM(CASE WHEN d.trip_count = '5-Trips' THEN d.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(d.repeat_passenger_count), 2) AS `5-Trips`,
    ROUND(SUM(CASE WHEN d.trip_count = '6-Trips' THEN d.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(d.repeat_passenger_count), 2) AS `6-Trips`,
    ROUND(SUM(CASE WHEN d.trip_count = '7-Trips' THEN d.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(d.repeat_passenger_count), 2) AS `7-Trips`,
    ROUND(SUM(CASE WHEN d.trip_count = '8-Trips' THEN d.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(d.repeat_passenger_count), 2) AS `8-Trips`,
    ROUND(SUM(CASE WHEN d.trip_count = '9-Trips' THEN d.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(d.repeat_passenger_count), 2) AS `9-Trips`,
    ROUND(SUM(CASE WHEN d.trip_count = '10-Trips' THEN d.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(d.repeat_passenger_count), 2) AS `10-Trips`
FROM 
    trips_db.dim_repeat_trip_distribution d
JOIN 
    trips_db.dim_city c ON d.city_id = c.city_id
GROUP BY 
    c.city_name
ORDER BY 
    c.city_name;
