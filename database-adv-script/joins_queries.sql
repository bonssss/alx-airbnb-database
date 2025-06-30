-- joins_queries.sql
-- Complex SQL queries using different types of joins for the Airbnb Clone database
-- Designed for MySQL, aligned with schema in database-script-0x01/schema.sql

-- Query 1: INNER JOIN to retrieve all bookings and their associated users
SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
ORDER BY b.created_at DESC;

-- Query 2: LEFT JOIN to retrieve all properties and their reviews, including properties without reviews
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_created_at
FROM properties p
LEFT JOIN reviews r ON p.property_id = r.property_id
ORDER BY p.property_id, r.created_at DESC;

-- Query 3: FULL OUTER JOIN (simulated) to retrieve all users and bookings, including users without bookings and bookings without users
-- MySQL does not support FULL OUTER JOIN, so we use LEFT JOIN UNION RIGHT JOIN
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
UNION
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM users u
RIGHT JOIN bookings b ON u.user_id = b.user_id
WHERE u.user_id IS NULL
ORDER BY user_id, booking_id;