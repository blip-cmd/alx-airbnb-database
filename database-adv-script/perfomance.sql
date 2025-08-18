-- Initial complex query: Retrieve all bookings with user, property, and payment details
SELECT b.*, u.*, p.*, pay.*
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id;

-- Refactored query: Only select necessary columns and use indexes
SELECT b.id AS booking_id, b.created_at, u.id AS user_id, u.name, p.id AS property_id, p.title, pay.id AS payment_id, pay.amount
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id;

-- Use EXPLAIN to analyze performance
-- EXPLAIN SELECT ... (use above queries)
