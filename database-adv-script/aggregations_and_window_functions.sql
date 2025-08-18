-- 1. Find the total number of bookings made by each user
SELECT user_id, COUNT(*) AS total_bookings
FROM bookings
GROUP BY user_id;

SELECT p.*, b.total_bookings,
       RANK() OVER (ORDER BY b.total_bookings DESC) AS property_rank,
       ROW_NUMBER() OVER (ORDER BY b.total_bookings DESC) AS property_row_number
FROM properties p
LEFT JOIN (
    SELECT property_id, COUNT(*) AS total_bookings
    FROM bookings
    GROUP BY property_id
) b ON p.id = b.property_id;
