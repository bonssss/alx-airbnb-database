-- database_index.sql
-- SQL commands to create indexes for optimizing query performance in the Airbnb Clone database
-- Designed for MySQL, aligned with schema in database-script-0x01/schema.sql

-- Index on users.email for searches and grouping
CREATE INDEX idx_users_email ON users (email);

-- Index on properties.host_id for host-specific queries
CREATE INDEX idx_properties_host_id ON properties (host_id);

-- Index on bookings.user_id for joins and filters
CREATE INDEX idx_bookings_user_id ON bookings (user_id);

-- Index on bookings.property_id for joins and filters
CREATE INDEX idx_bookings_property_id ON bookings (property_id);

-- Index on bookings.created_at for sorting
CREATE INDEX idx_bookings_created_at ON bookings (created_at);-- database_index.sql
-- SQL commands to create indexes and analyze query performance for the Airbnb Clone database
-- Designed for MySQL, aligned with schema in database-script-0x01/schema.sql

-- Index creation for high-usage columns
CREATE INDEX idx_users_email ON users (email);
CREATE INDEX idx_properties_host_id ON properties (host_id);
CREATE INDEX idx_bookings_user_id ON bookings (user_id);
CREATE INDEX idx_bookings_property_id ON bookings (property_id);
CREATE INDEX idx_bookings_created_at ON bookings (created_at);

-- Performance analysis using EXPLAIN for Query 1 (Aggregation) before indexes
-- Query: Total number of bookings per user
EXPLAIN SELECT 
    u.user_id,
    u.first_name,
    u.email,
    COUNT(b.booking_id) AS booking_count
FROM users u
INNER JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.email
ORDER BY booking_count DESC, u.user_id;

-- Note: Run the above EXPLAIN before creating indexes to capture baseline performance.
-- Expected EXPLAIN output (before indexes):
-- - users: type=ALL, rows=~5, key=NULL (full table scan)
-- - bookings: type=ALL, rows=~6, key=NULL (full table scan)
-- - Rows examined: ~30 (5 users × 6 bookings)
-- - Cost: Higher due to table scans

-- Performance analysis using EXPLAIN for Query 1 (Aggregation) after indexes
-- Run after creating idx_bookings_user_id and idx_users_email
EXPLAIN SELECT 
    u.user_id,
    u.first_name,
    u.email,
    COUNT(b.booking_id) AS booking_count
FROM users u
INNER JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.email
ORDER BY booking_count DESC, u.user_id;

-- Expected EXPLAIN output (after indexes):
-- - users: type=index, rows=~5, key=idx_users_email
-- - bookings: type=ref, rows=~3, key=idx_bookings_user_id
-- - Rows examined: ~10 (fewer due to index-based join)
-- - Cost: Reduced by ~50%

-- Performance analysis using EXPLAIN for Query 2 (Window Function) before indexes
-- Query: Rank properties by total bookings
EXPLAIN SELECT 
    p.property_id,
    p.name AS property_name,
    p.pricepernight,
    COUNT(b.booking_id) AS booking_count,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name, p.pricepernight
ORDER BY booking_rank, p.property_id;

-- Expected EXPLAIN output (before indexes):
-- - properties: type=ALL, rows=~4, key=NULL (full table scan)
-- - bookings: type=ALL, rows=~6, key=NULL (full table scan)
-- - Rows examined: ~24 (4 properties × 6 bookings)
-- - Cost: Higher due to table scans

-- Performance analysis using EXPLAIN for Query 2 (Window Function) after indexes
-- Run after creating idx_bookings_property_id
EXPLAIN SELECT 
    p.property_id,
    p.name AS property_name,
    p.pricepernight,
    COUNT(b.booking_id) AS booking_count,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name, p.pricepernight
ORDER BY booking_rank, p.property_id;

-- Expected EXPLAIN output (after indexes):
-- - properties: type=index, rows=~4, key=PRIMARY
-- - bookings: type=ref, rows=~2, key=idx_bookings_property_id
-- - Rows examined: ~8 (fewer due to index-based join)
-- - Cost: Reduced by ~60%