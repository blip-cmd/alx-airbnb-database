# Index Performance Analysis

This document describes the impact of adding indexes to high-usage columns in the User, Booking, and Property tables.

## Steps

1. **Identify high-usage columns**: Columns frequently used in WHERE, JOIN, or ORDER BY clauses.
2. **Create indexes**: See `database_index.sql` for the SQL commands.
3. **Measure performance**: Use EXPLAIN or ANALYZE to compare query plans and execution times before and after adding indexes.

## Example

### Before Index
```sql
EXPLAIN SELECT * FROM bookings WHERE user_id = 123;
```

### After Index
```sql
EXPLAIN SELECT * FROM bookings WHERE user_id = 123;
```

Compare the query plan and cost. Indexes should reduce scan cost and improve performance for large tables.

## See Also
- `database_index.sql` for the actual CREATE INDEX statements.
