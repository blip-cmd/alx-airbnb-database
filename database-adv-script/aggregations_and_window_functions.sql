-- =====================================================
-- Aggregations and Window Functions
-- =====================================================
-- This file contains SQL queries using aggregation and window functions
-- for analyzing data in the Airbnb database
-- Author: ALX Student
-- Date: 2025-10-01
-- =====================================================

-- 1. Find the total number of bookings made by each user using COUNT and GROUP BY
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_price) AS total_spent,
    AVG(b.total_price) AS average_booking_value,
    MIN(b.start_date) AS first_booking_date,
    MAX(b.start_date) AS last_booking_date
FROM User u
LEFT JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name, u.email
ORDER BY total_bookings DESC, total_spent DESC;

-- 2. Use window functions to rank properties based on total bookings
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.price_per_night,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_price) AS total_revenue,
    AVG(r.rating) AS average_rating,
    -- Window functions for ranking
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_row_number,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank,
    DENSE_RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_dense_rank,
    -- Partition by location for local rankings
    ROW_NUMBER() OVER (PARTITION BY p.location ORDER BY COUNT(b.booking_id) DESC) AS local_rank
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
LEFT JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name, p.location, p.price_per_night
ORDER BY total_bookings DESC;

-- 3. Advanced window functions: Running totals and moving averages
SELECT 
    b.booking_id,
    b.start_date,
    b.total_price,
    u.first_name,
    u.last_name,
    -- Running total of bookings
    SUM(b.total_price) OVER (ORDER BY b.start_date) AS running_total,
    -- Moving average of last 3 bookings
    AVG(b.total_price) OVER (ORDER BY b.start_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_3,
    -- Lag and Lead functions
    LAG(b.total_price, 1) OVER (ORDER BY b.start_date) AS previous_booking_price,
    LEAD(b.total_price, 1) OVER (ORDER BY b.start_date) AS next_booking_price
FROM Booking b
JOIN User u ON b.user_id = u.user_id
ORDER BY b.start_date;

-- 4. Percentile functions and quartiles
SELECT 
    p.property_id,
    p.name,
    p.price_per_night,
    COUNT(b.booking_id) AS total_bookings,
    -- Percentile rankings
    PERCENT_RANK() OVER (ORDER BY p.price_per_night) AS price_percentile,
    CUME_DIST() OVER (ORDER BY p.price_per_night) AS price_cumulative_distribution,
    -- Quartiles using NTILE
    NTILE(4) OVER (ORDER BY p.price_per_night) AS price_quartile,
    NTILE(4) OVER (ORDER BY COUNT(b.booking_id)) AS booking_quartile
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name, p.price_per_night
ORDER BY p.price_per_night;

-- 5. Monthly booking analysis with window functions
SELECT 
    YEAR(b.start_date) AS booking_year,
    MONTH(b.start_date) AS booking_month,
    COUNT(*) AS monthly_bookings,
    SUM(b.total_price) AS monthly_revenue,
    -- Compare with previous month
    LAG(COUNT(*), 1) OVER (ORDER BY YEAR(b.start_date), MONTH(b.start_date)) AS prev_month_bookings,
    LAG(SUM(b.total_price), 1) OVER (ORDER BY YEAR(b.start_date), MONTH(b.start_date)) AS prev_month_revenue,
    -- Year-to-date running total
    SUM(COUNT(*)) OVER (PARTITION BY YEAR(b.start_date) ORDER BY MONTH(b.start_date)) AS ytd_bookings,
    SUM(SUM(b.total_price)) OVER (PARTITION BY YEAR(b.start_date) ORDER BY MONTH(b.start_date)) AS ytd_revenue
FROM Booking b
GROUP BY YEAR(b.start_date), MONTH(b.start_date)
ORDER BY booking_year, booking_month;
