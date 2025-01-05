SELECT 
    c.city_name AS City_Name,
    d.month_name AS Month_Name,
    COUNT(t.trip_id) AS Actual_Trips,
    tg.total_target_trips AS Target_Trips,
    CASE 
        WHEN COUNT(t.trip_id) > tg.total_target_trips THEN 'Above Target'
        ELSE 'Below Target'
    END AS Performance_Status,
    ROUND(((COUNT(t.trip_id) - tg.total_target_trips) * 100.0 / tg.total_target_trips), 2) AS Percentage_Difference
FROM 
    trips_db.fact_trips t
JOIN 
    trips_db.dim_city c ON t.city_id = c.city_id
JOIN 
    trips_db.dim_date d ON t.date = d.date
JOIN 
    targets_db.monthly_target_trips tg ON t.city_id = tg.city_id AND d.start_of_month = tg.month
GROUP BY 
    c.city_name, d.month_name, tg.total_target_trips
ORDER BY 
    c.city_name, d.month_name;
