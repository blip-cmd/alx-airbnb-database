-- =====================================================
-- Complex Query Optimization
-- =====================================================
-- This file contains complex queries and their optimized versions
-- for the Airbnb database performance analysis
-- Author: ALX Student
-- Date: 2025-10-01
-- =====================================================

-- =====================================================
-- INITIAL COMPLEX QUERY (UNOPTIMIZED)
-- =====================================================
-- Retrieve all bookings with user, property, and payment details
-- This query demonstrates a common reporting pattern but may have performance issues

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price AS booking_amount,
    b.status AS booking_status,
    b.created_at AS booking_created,
    
    -- User details
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    
    -- Property details
    p.property_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.price_per_night,
    
    -- Host details
    host.user_id AS host_id,
    host.first_name AS host_first_name,
    host.last_name AS host_last_name,
    host.email AS host_email,
    
    -- Payment details
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.payment_method
    
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
JOIN User host ON p.host_id = host.user_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;

-- Performance Analysis: Use EXPLAIN to analyze this query
-- EXPLAIN ANALYZE 
-- SELECT ... (above query)

-- =====================================================
-- OPTIMIZED QUERY VERSION 1: Selective Fields
-- =====================================================
-- Reduce data transfer by selecting only necessary fields

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    
    -- User essentials only
    CONCAT(u.first_name, ' ', u.last_name) AS guest_name,
    u.email AS guest_email,
    
    -- Property essentials only
    p.name AS property_name,
    p.location,
    
    -- Host essentials only
    CONCAT(host.first_name, ' ', host.last_name) AS host_name,
    
    -- Payment status
    CASE 
        WHEN pay.payment_id IS NOT NULL THEN 'Paid'
        ELSE 'Unpaid'
    END AS payment_status,
    pay.payment_method
    
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
JOIN User host ON p.host_id = host.user_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;

-- =====================================================
-- OPTIMIZED QUERY VERSION 2: Index-Optimized with Filtering
-- =====================================================
-- Add WHERE clauses to leverage indexes and reduce result set

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    
    CONCAT(u.first_name, ' ', u.last_name) AS guest_name,
    u.email AS guest_email,
    
    p.name AS property_name,
    p.location,
    
    CONCAT(host.first_name, ' ', host.last_name) AS host_name,
    
    pay.payment_method,
    pay.payment_date
    
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
JOIN User host ON p.host_id = host.user_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id

-- Add filtering conditions to leverage indexes
WHERE b.start_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)  -- Recent bookings only
  AND b.status IN ('confirmed', 'completed')                 -- Active bookings only
  AND p.location IS NOT NULL                                 -- Valid properties only

ORDER BY b.start_date DESC
LIMIT 1000;  -- Limit result set size

-- =====================================================
-- OPTIMIZED QUERY VERSION 3: Pagination for Large Results
-- =====================================================
-- Use LIMIT and OFFSET for pagination to handle large datasets

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    
    CONCAT(u.first_name, ' ', u.last_name) AS guest_name,
    p.name AS property_name,
    p.location,
    
    pay.payment_method
    
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id

WHERE b.start_date >= '2025-01-01'
ORDER BY b.start_date DESC
LIMIT 50 OFFSET 0;  -- First page of 50 results

-- =====================================================
-- OPTIMIZED QUERY VERSION 4: Covering Index Query
-- =====================================================
-- Query designed to use covering indexes for maximum performance

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.user_id,
    b.property_id
    
FROM Booking b
WHERE b.start_date BETWEEN '2025-01-01' AND '2025-12-31'
  AND b.status = 'confirmed'
ORDER BY b.start_date DESC, b.booking_id
LIMIT 100;

-- Then join with other tables only for the limited result set
SELECT 
    filtered_bookings.*,
    CONCAT(u.first_name, ' ', u.last_name) AS guest_name,
    p.name AS property_name,
    p.location
FROM (
    SELECT 
        b.booking_id,
        b.start_date,
        b.end_date,
        b.total_price,
        b.status,
        b.user_id,
        b.property_id
    FROM Booking b
    WHERE b.start_date BETWEEN '2025-01-01' AND '2025-12-31'
      AND b.status = 'confirmed'
    ORDER BY b.start_date DESC
    LIMIT 100
) filtered_bookings
JOIN User u ON filtered_bookings.user_id = u.user_id
JOIN Property p ON filtered_bookings.property_id = p.property_id;

-- =====================================================
-- PERFORMANCE COMPARISON QUERIES
-- =====================================================

-- Query to measure execution time
-- SET profiling = 1;
-- [Execute queries here]
-- SHOW PROFILES;

-- Query to analyze execution plan
-- EXPLAIN FORMAT=JSON
-- [Execute queries here]

-- Query to check index usage
-- SHOW STATUS LIKE 'Handler_read%';
