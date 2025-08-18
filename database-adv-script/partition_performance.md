# Partitioning Performance Report

## Partitioning Strategy
- The `bookings` table was partitioned by the `start_date` column using range partitioning (e.g., by year).

## Performance Testing
- Queries filtering by `start_date` (e.g., date ranges) were tested using `EXPLAIN` before and after partitioning.
- After partitioning, the query planner scans only the relevant partition(s), reducing I/O and improving performance.

## Observed Improvements
- Significant reduction in query scan cost and execution time for date-based queries.
- Partitioning is especially effective for large tables with frequent range queries on the partitioned column.

## Example
```sql
EXPLAIN SELECT * FROM bookings_partitioned WHERE start_date BETWEEN '2025-06-01' AND '2025-06-30';
```

## Conclusion
Partitioning large tables by date can greatly optimize query performance for time-based queries.
