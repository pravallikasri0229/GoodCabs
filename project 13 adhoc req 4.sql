WITH RankedCities AS (
    SELECT
        dim_city.city_name,
        SUM(fact_passenger_summary.new_passengers) AS total_new_passengers,
        RANK() OVER (ORDER BY SUM(new_passengers) DESC) AS rank_high,
        RANK() OVER (ORDER BY SUM(new_passengers) ASC) AS rank_low
    FROM
        fact_passenger_summary
    JOIN dim_city 
        ON dim_city.city_id = fact_passenger_summary.city_id
    GROUP BY
        dim_city.city_name
)
SELECT
    city_name,
    total_new_passengers,
    CASE
        WHEN rank_high <= 3 THEN 'Top 3'
        WHEN rank_low <= 3 THEN 'Bottom 3'
    END AS city_category
FROM
    RankedCities
WHERE
    rank_high <= 3 OR rank_low <= 3; 
