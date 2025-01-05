WITH Monthlyrevenue AS (
    SELECT 
        c.city_name,
        d.month_name,
        SUM(t.fare_amount) AS revenue
    FROM 
        trips_db.fact_trips t
    JOIN 
        trips_db.dim_city c ON t.city_id = c.city_id
    JOIN 
        trips_db.dim_date d ON t.date = d.date
    GROUP BY 
        c.city_name, d.month_name
),
CityTotalRevenue AS (
    SELECT 
        city_name,
        SUM(revenue) AS total_revenue
    FROM 
        Monthlyrevenue
    GROUP BY 
        city_name
),
CityHighestRevenue AS (
    SELECT 
        m.city_name,
        m.month_name AS highest_revenue_month,
        m.revenue,
        ROUND((m.revenue * 100.0) / ctr.total_revenue, 2) AS percentage_contribution
    FROM 
        Monthlyrevenue m
    JOIN 
        CityTotalRevenue ctr ON m.city_name = ctr.city_name
    WHERE 
        m.revenue = (
            SELECT MAX(revenue)
            FROM Monthlyrevenue mr
            WHERE mr.city_name = m.city_name
        )
)
SELECT 
    city_name,
    highest_revenue_month,
    revenue,
    percentage_contribution
FROM 
    CityHighestRevenue
ORDER BY 
    city_name;
