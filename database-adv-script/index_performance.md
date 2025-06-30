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
CREATE INDEX idx_bookings_created_at ON bookings (created_at);