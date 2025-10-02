-- =====================================================
-- Practice Subqueries
-- =====================================================
-- This file contains SQL subqueries for the Airbnb database
-- Includes both non-correlated and correlated subqueries
-- Author: ALX Student
-- Date: 2025-10-01
-- =====================================================

-- 1. Non-correlated subquery: Find all properties where the average rating is greater than 4.0
-- This subquery calculates the average rating for each property
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.price_per_night,
    (SELECT AVG(r.rating) 
     FROM Review r 
     WHERE r.property_id = p.property_id) AS avg_rating
FROM Property p
WHERE p.property_id IN (
    SELECT r.property_id
    FROM Review r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
)
ORDER BY avg_rating DESC;

-- Alternative approach using correlated subquery
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.price_per_night
FROM Property p
WHERE (
    SELECT AVG(r.rating)
    FROM Review r
    WHERE r.property_id = p.property_id
) > 4.0;

-- 2. Correlated subquery: Find users who have made more than 3 bookings
-- This subquery counts bookings for each user
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    (SELECT COUNT(*) 
     FROM Booking b 
     WHERE b.user_id = u.user_id) AS total_bookings
FROM User u
WHERE (
    SELECT COUNT(*)
    FROM Booking b
    WHERE b.user_id = u.user_id
) > 3
ORDER BY total_bookings DESC;

-- 3. Additional subquery: Find properties that have never been booked
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.price_per_night
FROM Property p
WHERE p.property_id NOT IN (
    SELECT DISTINCT b.property_id
    FROM Booking b
    WHERE b.property_id IS NOT NULL
);

-- 4. Subquery with EXISTS: Find users who have written at least one review
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM User u
WHERE EXISTS (
    SELECT 1
    FROM Review r
    WHERE r.user_id = u.user_id
);
