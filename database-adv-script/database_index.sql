-- Add index on user_id used in WHERE or JOIN
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- Add index on property_id used in JOINs and filtering
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- Add index on email for fast lookup
CREATE INDEX idx_users_email ON users(email);

-- Add index on pricepernight for range queries or ordering
CREATE INDEX idx_properties_pricepernight ON properties(pricepernight);
