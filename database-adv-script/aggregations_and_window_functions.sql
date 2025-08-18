-- 1. Find the total number of bookings made by each user
SELECT user_id, COUNT(*) AS total_bookings
FROM bookings
GROUP BY user_id;

-- 2. Rank properties based on the total number of bookings they have received
SELECT p.*, b.total_bookings,
       RANK() OVER (ORDER BY b.total_bookings DESC) AS property_rank
FROM properties p
LEFT JOIN (
    SELECT property_id, COUNT(*) AS total_bookings
    FROM bookings
    GROUP BY property_id
) b ON p.id = b.property_id;
