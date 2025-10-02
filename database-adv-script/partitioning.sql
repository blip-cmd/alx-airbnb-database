-- =====================================================
-- Table Partitioning for Large Tables
-- =====================================================
-- This file demonstrates table partitioning strategies for the Booking table
-- to optimize query performance on large datasets
-- Author: ALX Student
-- Date: 2025-10-01
-- =====================================================

-- =====================================================
-- MySQL Partitioning Implementation
-- =====================================================
-- Note: MySQL supports partitioning with specific syntax different from PostgreSQL

-- First, let's create a partitioned version of the Booking table
-- We'll partition by RANGE on the start_date column

-- Drop the existing table if recreating (for demonstration)
-- DROP TABLE IF EXISTS Booking_Partitioned;

CREATE TABLE Booking_Partitioned (
    booking_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL CHECK (total_price > 0),
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Check constraint to ensure end_date is after start_date
    CHECK (end_date > start_date)
    
    -- Note: Foreign key constraints may have limitations with partitioned tables
    -- FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    -- FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2020 VALUES LESS THAN (2021),
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- =====================================================
-- Alternative: Monthly Partitioning for High Volume
-- =====================================================
-- For very high-volume systems, monthly partitioning might be more appropriate

CREATE TABLE Booking_Monthly_Partitioned (
    booking_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL CHECK (total_price > 0),
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CHECK (end_date > start_date)
)
PARTITION BY RANGE (TO_DAYS(start_date)) (
    PARTITION p202501 VALUES LESS THAN (TO_DAYS('2025-02-01')),
    PARTITION p202502 VALUES LESS THAN (TO_DAYS('2025-03-01')),
    PARTITION p202503 VALUES LESS THAN (TO_DAYS('2025-04-01')),
    PARTITION p202504 VALUES LESS THAN (TO_DAYS('2025-05-01')),
    PARTITION p202505 VALUES LESS THAN (TO_DAYS('2025-06-01')),
    PARTITION p202506 VALUES LESS THAN (TO_DAYS('2025-07-01')),
    PARTITION p202507 VALUES LESS THAN (TO_DAYS('2025-08-01')),
    PARTITION p202508 VALUES LESS THAN (TO_DAYS('2025-09-01')),
    PARTITION p202509 VALUES LESS THAN (TO_DAYS('2025-10-01')),
    PARTITION p202510 VALUES LESS THAN (TO_DAYS('2025-11-01')),
    PARTITION p202511 VALUES LESS THAN (TO_DAYS('2025-12-01')),
    PARTITION p202512 VALUES LESS THAN (TO_DAYS('2026-01-01')),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- =====================================================
-- Hash Partitioning by User ID
-- =====================================================
-- For load distribution based on user activity

CREATE TABLE Booking_Hash_Partitioned (
    booking_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL CHECK (total_price > 0),
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CHECK (end_date > start_date)
)
PARTITION BY HASH(CRC32(user_id))
PARTITIONS 8;

-- =====================================================
-- Indexes for Partitioned Tables
-- =====================================================
-- Create indexes on partitioned tables for optimal performance

-- Indexes for yearly partitioned table
ALTER TABLE Booking_Partitioned ADD INDEX idx_part_user_id (user_id);
ALTER TABLE Booking_Partitioned ADD INDEX idx_part_property_id (property_id);
ALTER TABLE Booking_Partitioned ADD INDEX idx_part_status (status);
ALTER TABLE Booking_Partitioned ADD INDEX idx_part_dates (start_date, end_date);
ALTER TABLE Booking_Partitioned ADD INDEX idx_part_created (created_at);

-- =====================================================
-- Performance Testing Queries
-- =====================================================

-- Query 1: Date range query (should use partition pruning)
-- This query should only scan the p2025 partition
SELECT COUNT(*) as total_bookings,
       AVG(total_price) as avg_price,
       SUM(total_price) as total_revenue
FROM Booking_Partitioned
WHERE start_date BETWEEN '2025-06-01' AND '2025-08-31';

-- Query 2: Single month query for monthly partitioned table
SELECT booking_id, user_id, property_id, start_date, total_price
FROM Booking_Monthly_Partitioned
WHERE start_date BETWEEN '2025-07-01' AND '2025-07-31'
ORDER BY start_date DESC;

-- Query 3: User-specific query on hash partitioned table
SELECT COUNT(*) as user_bookings,
       SUM(total_price) as total_spent
FROM Booking_Hash_Partitioned
WHERE user_id = 'specific-user-uuid-here';

-- Query 4: Cross-partition query (multiple years)
SELECT YEAR(start_date) as booking_year,
       COUNT(*) as yearly_bookings,
       SUM(total_price) as yearly_revenue
FROM Booking_Partitioned
WHERE start_date BETWEEN '2024-01-01' AND '2025-12-31'
GROUP BY YEAR(start_date)
ORDER BY booking_year;

-- =====================================================
-- Partition Management Operations
-- =====================================================

-- Add new partition for 2027
ALTER TABLE Booking_Partitioned 
ADD PARTITION (PARTITION p2027 VALUES LESS THAN (2028));

-- Drop old partition (for data retention policies)
-- ALTER TABLE Booking_Partitioned DROP PARTITION p2020;

-- Reorganize partition (split a partition)
-- ALTER TABLE Booking_Partitioned 
-- REORGANIZE PARTITION p_future INTO (
--     PARTITION p2027 VALUES LESS THAN (2028),
--     PARTITION p_future VALUES LESS THAN MAXVALUE
-- );

-- =====================================================
-- Partition Information Queries
-- =====================================================

-- View partition information
SELECT 
    PARTITION_NAME,
    PARTITION_ORDINAL_POSITION,
    PARTITION_METHOD,
    PARTITION_EXPRESSION,
    PARTITION_DESCRIPTION,
    TABLE_ROWS,
    AVG_ROW_LENGTH,
    DATA_LENGTH
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = 'airbnb_db' 
  AND TABLE_NAME = 'Booking_Partitioned';

-- Check which partitions are being used for a query
-- EXPLAIN PARTITIONS
-- SELECT * FROM Booking_Partitioned 
-- WHERE start_date BETWEEN '2025-06-01' AND '2025-08-31';

-- =====================================================
-- Data Migration to Partitioned Tables
-- =====================================================

-- Example: Migrate data from original Booking table to partitioned table
-- INSERT INTO Booking_Partitioned 
-- SELECT booking_id, property_id, user_id, start_date, end_date, 
--        total_price, status, created_at
-- FROM Booking
-- WHERE start_date >= '2020-01-01';

-- =====================================================
-- Performance Monitoring
-- =====================================================

-- Monitor partition access patterns
SELECT 
    OBJECT_SCHEMA,
    OBJECT_NAME,
    PARTITION_NAME,
    COUNT_READ,
    COUNT_WRITE,
    SUM_TIMER_READ,
    SUM_TIMER_WRITE
FROM performance_schema.table_io_waits_summary_by_index_usage
WHERE OBJECT_SCHEMA = 'airbnb_db' 
  AND OBJECT_NAME LIKE '%Booking%Partitioned%';

-- Example benchmark queries
-- SET profiling = 1;

-- Test non-partitioned query
-- SELECT COUNT(*) FROM Booking WHERE start_date BETWEEN '2025-06-01' AND '2025-08-31';

-- Test partitioned query
-- SELECT COUNT(*) FROM Booking_Partitioned WHERE start_date BETWEEN '2025-06-01' AND '2025-08-31';

-- SHOW PROFILES;
