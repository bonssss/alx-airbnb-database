-- Create indexes for performance optimization
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_properties_pricepernight ON properties(pricepernight);

-- Analyze performance of a query using EXPLAIN ANALYZE
EXPLAIN ANALYZE
SELECT user_id, COUNT(*) 
FROM bookings 
GROUP BY user_id;

EXPLAIN ANALYZE
SELECT * FROM users 
WHERE email = 'test@example.com';

EXPLAIN ANALYZE
SELECT * FROM properties 
WHERE pricepernight < 100;
