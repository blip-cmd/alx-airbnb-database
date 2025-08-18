-- Partition the bookings table by start_date (example for PostgreSQL)
CREATE TABLE bookings_partitioned (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    created_at TIMESTAMP,
    -- ... other columns ...
) PARTITION BY RANGE (start_date);

-- Create partitions for each year (example: 2024, 2025)
CREATE TABLE bookings_2024 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Example query to fetch bookings in a date range
SELECT * FROM bookings_partitioned
WHERE start_date BETWEEN '2025-06-01' AND '2025-06-30';

-- Use EXPLAIN to analyze performance
-- EXPLAIN SELECT * FROM bookings_partitioned WHERE start_date BETWEEN '2025-06-01' AND '2025-06-30';
