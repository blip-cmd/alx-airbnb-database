# Query Optimization Report

## Initial Query
Retrieves all bookings with user, property, and payment details using multiple joins.

## Performance Analysis
- Use `EXPLAIN` to analyze the query plan.
- Inefficiencies may include:
  - Selecting all columns (`SELECT *`) increases data transfer and memory usage.
  - Unnecessary joins or lack of indexes can cause full table scans.

## Refactored Query
- Select only required columns to reduce data size.
- Ensure indexes exist on join columns (`user_id`, `property_id`, `booking_id`).
- Use `LEFT JOIN` only where necessary (e.g., payments may not exist for all bookings).

## EXPLAIN Example
```sql
EXPLAIN SELECT b.id AS booking_id, b.created_at, u.id AS user_id, u.name, p.id AS property_id, p.title, pay.id AS payment_id, pay.amount
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id;
```

## Conclusion
Refactoring and indexing can significantly improve query performance.
