-- subqueries.sql
-- SQL queries demonstrating non-correlated and correlated subqueries for the Airbnb Clone database
-- Designed for MySQL, aligned with schema in database-script-0x01/schema.sql

-- Query 1: Non-correlated subquery to find properties with an average rating > 4.0
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight
FROM properties p
WHERE p.property_id IN (
    SELECT r.property_id
    FROM reviews r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
)
ORDER BY p.property_id;

-- Query 2: Correlated subquery to find users with more than 3 bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.user_id
) > 3
ORDER BY u.user_id;