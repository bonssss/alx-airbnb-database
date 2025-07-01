-- partitioning.sql
-- SQL commands to implement range partitioning on the bookings table by start_date
-- Designed for MySQL, aligned with schema in database-script-0x01/schema.sql

-- Step 1: Ensure existing indexes are present (from database_index.sql)
CREATE INDEX idx_bookings_user_id ON bookings (user_id);
CREATE INDEX idx_bookings_property_id ON bookings (property_id);
CREATE INDEX idx_bookings_created_at ON bookings (created_at);

-- Step 2: Alter the bookings table to use range partitioning by start_date
-- Note: This requires copying data; ensure backups before running in production
ALTER TABLE bookings
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Step 3: Test query to fetch bookings in a date range
EXPLAIN SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name,
    p.name AS property_name
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
WHERE b.start_date BETWEEN '2025-01-01' AND '2025-12-31';

-- Expected EXPLAIN output (partitioned table):
-- - bookings: type=range, rows=~6 (sample data), key=PRIMARY, partitions=p2025
-- - users: type=ref, rows=~1, key=idx_bookings_user_id
-- - properties: type=ref, rows=~1, key=idx_bookings_property_id
-- - Rows examined: ~6 (scans only p2025 partition)
-- - Cost: Lower due to partition pruning (only 2025 data scanned)