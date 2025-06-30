-- aggregations_and_window_functions.sql
-- SQL queries demonstrating aggregation and window functions for the Airbnb Clone database
-- Designed for MySQL, aligned with schema in database-script-0x01/schema.sql

-- Query 1: Aggregation using COUNT and GROUP BY to find the total number of bookings per user
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS booking_count
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name, u.email
ORDER BY booking_count DESC, u.user_id;

-- Query 2: Window function using RANK to rank properties based on total bookings
WITH BookingCounts AS (
    SELECT 
        p.property_id,
        p.name AS property_name,
        p.location,
        p.pricepernight,
        COUNT(b.booking_id) AS booking_count
    FROM properties p
    LEFT JOIN bookings b ON p.property_id = b.property_id
    GROUP BY p.property_id, p.name, p.location, p.pricepernight
)
SELECT 
    property_id,
    property_name,
    location,
    pricepernight,
    booking_count,
    RANK() OVER (ORDER BY booking_count DESC) AS booking_rank
FROM BookingCounts
ORDER BY booking_rank, property_id;