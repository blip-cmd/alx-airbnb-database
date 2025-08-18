# Database Performance Monitoring and Refinement

## Monitoring Tools
- Use `EXPLAIN` or `EXPLAIN ANALYZE` (PostgreSQL) or `SHOW PROFILE` (MySQL) to analyze query execution plans.

## Example Monitoring

### Query 1: Bookings by User
```sql
EXPLAIN ANALYZE SELECT * FROM bookings WHERE user_id = 123;
```
- **Observation**: If a sequential scan is used, consider adding an index on `user_id`.

### Query 2: Properties with Reviews
```sql
EXPLAIN ANALYZE SELECT p.*, r.* FROM properties p LEFT JOIN reviews r ON p.id = r.property_id ORDER BY p.id, r.id;
```
- **Observation**: If sorting is slow, consider an index on `reviews(property_id, id)`.

### Query 3: Bookings by Date Range
```sql
EXPLAIN ANALYZE SELECT * FROM bookings WHERE start_date BETWEEN '2025-06-01' AND '2025-06-30';
```
- **Observation**: Partitioning by `start_date` and indexing can improve performance.

## Implemented Changes
- Added indexes on `user_id`, `property_id`, and composite index on `reviews(property_id, id)`.
- Partitioned `bookings` table by `start_date`.

## Results
- Query plans now use indexes and partitions, reducing scan cost and execution time.
- Example: Bookings by user now uses an index scan instead of a sequential scan.

## Conclusion
Continuous monitoring and schema refinement (indexes, partitioning) are essential for optimal database performance.
