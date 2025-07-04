-- SQL queries demonstrating aggregation and window functions for the Airbnb Clone database
-- Designed for MySQL, aligned with schema in database-script-0x01/schema.sql

-- Query 1: Aggregation using COUNT and GROUP BY to find the total number of bookings per user
SELECT 
    u.user_id,
    u.first_name,
    u.email,
    COUNT(b.booking_id) AS booking_count
FROM users u
INNER JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.email
ORDER BY booking_count DESC, u.user_id;

-- Query 2a: Window function using RANK to rank properties based on total bookings
SELECT 
    p.property_id,
    p.name AS property_name,
    p.pricepernight,
    COUNT(b.booking_id) AS booking_count,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name, p.pricepernight
ORDER BY booking_rank, p.property_id;

-- Query 2b: Window function using ROW_NUMBER to assign unique rank to properties
SELECT 
    p.property_id,
    p.name AS property_name,
    p.pricepernight,
    COUNT(b.booking_id) AS booking_count,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_row_number
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name, p.pricepernight
ORDER BY booking_row_number, p.property_id;
