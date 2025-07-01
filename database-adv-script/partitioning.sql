-- partitioning.sql
-- SQL commands to create a partitioned bookings table and test query performance
-- Designed for MySQL, aligned with schema in database-script-0x01/schema.sql

-- Step 1: Create a new partitioned table
CREATE TABLE bookings_partitioned (
    booking_id CHAR(36) NOT NULL,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    PRIMARY KEY (booking_id, start_date),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    CHECK (end_date > start_date),
    CHECK (total_price >= 0),
    CHECK (status IN ('pending', 'confirmed', 'cancelled'))
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Step 2: Create indexes on the partitioned table
CREATE INDEX idx_bookings_partitioned_user_id ON bookings_partitioned (user_id);
CREATE INDEX idx_bookings_partitioned_property_id ON bookings_partitioned (property_id);
CREATE INDEX idx_bookings_partitioned_created_at ON bookings_partitioned (created_at);

-- Step 3: Migrate data from bookings to bookings_partitioned
INSERT INTO bookings_partitioned (
    booking_id, property_id, user_id, start_date, end_date,
    total_price, status, created_at, updated_at
)
SELECT 
    booking_id, property_id, user_id, start_date, end_date,
    total_price, status, created_at, updated_at
FROM bookings;

-- Step 4: Test query to fetch bookings in a date range
EXPLAIN SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name,
    p.name AS property_name
FROM bookings_partitioned b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
WHERE b.start_date BETWEEN '2025-01-01' AND '2025-12-31';

-- Expected EXPLAIN output (partitioned table):
-- - bookings_partitioned: type=range, rows=~6 (sample data), key=PRIMARY, partitions=p2025
-- - users: type=ref, rows=~1, key=idx_bookings_user_id
-- - properties: type=ref, rows=~1, key=idx_bookings_property_id
-- - Rows examined: ~6 (scans only p2025 partition)
-- - Cost: Lower due to partition pruning (only 2025 data scanned)