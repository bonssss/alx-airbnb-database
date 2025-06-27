-- seed.sql
-- Sample data for Airbnb-like database
-- Designed for MySQL 8.0.16+ with CHECK constraints
-- Assumes schema.sql from database-script-0x01 has been executed

-- Insert Users (2 hosts, 2 guests, 1 admin)
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
    ('550e8400-e29b-41d4-a716-446655440000', 'Alice', 'Smith', 'alice.smith@example.com', 'hash123', '555-0101', 'host', '2025-01-01 10:00:00'),
    ('550e8400-e29b-41d4-a716-446655440001', 'Bob', 'Johnson', 'bob.johnson@example.com', 'hash456', '555-0102', 'host', '2025-01-02 12:00:00'),
    ('550e8400-e29b-41d4-a716-446655440002', 'Carol', 'Williams', 'carol.williams@example.com', 'hash789', '555-0103', 'guest', '2025-02-01 09:00:00'),
    ('550e8400-e29b-41d4-a716-446655440003', 'David', 'Brown', 'david.brown@example.com', 'hash012', NULL, 'guest', '2025-02-15 11:00:00'),
    ('550e8400-e29b-41d4-a716-446655440004', 'Emma', 'Davis', 'emma.davis@example.com', 'hash345', '555-0104', 'admin', '2025-03-01 08:00:00');

-- Insert Properties (4 properties by 2 hosts)
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
    ('6b86b273-ff34-4359-9d72-54e6f9c1b2a0', '550e8400-e29b-41d4-a716-446655440000', 'Cozy Beach Cottage', 'A charming cottage by the sea', 'Miami, FL', 120.00, '2025-03-10 14:00:00', '2025-03-10 14:00:00'),
    ('6b86b273-ff34-4359-9d72-54e6f9c1b2a1', '550e8400-e29b-41d4-a716-446655440000', 'Downtown Loft', 'Modern loft in the city center', 'New York, NY', 180.00, '2025-03-15 15:00:00', '2025-03-15 15:00:00'),
    ('6b86b273-ff34-4359-9d72-54e6f9c1b2a2', '550e8400-e29b-41d4-a716-446655440001', 'Mountain Cabin', 'Rustic cabin with mountain views', 'Aspen, CO', 150.00, '2025-04-01 10:00:00', '2025-04-01 10:00:00'),
    ('6b86b273-ff34-4359-9d72-54e6f9c1b2a3', '550e8400-e29b-41d4-a716-446655440001', 'Urban Apartment', 'Spacious apartment near downtown', 'Chicago, IL', 100.00, '2025-04-05 12:00:00', '2025-04-05 12:00:00');

-- Insert Bookings (6 bookings by guests)
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
    ('7c8b3a2e-4f1d-46b7-9a8e-2f5d7e9c3f20', '6b86b273-ff34-4359-9d72-54e6f9c1b2a0', '550e8400-e29b-41d4-a716-446655440002', '2025-07-01', '2025-07-05', 480.00, 'confirmed', '2025-06-01 09:00:00'),
    ('7c8b3a2e-4f1d-46b7-9a8e-2f5d7e9c3f21', '6b86b273-ff34-4359-9d72-54e6f9c1b2a1', '550e8400-e29b-41d4-a716-446655440002', '2025-08-10', '2025-08-12', 360.00, 'confirmed', '2025-06-05 10:00:00'),
    ('7c8b3a2e-4f1d-46b7-9a8e-2f5d7e9c3f22', '6b86b273-ff34-4359-9d72-54e6f9c1b2a2', '550e8400-e29b-41d4-a716-446655440003', '2025-09-01', '2025-09-04', 450.00, 'pending', '2025-06-10 11:00:00'),
    ('7c8b3a2e-4f1d-46b7-9a8e-2f5d7e9c3f23', '6b86b273-ff34-4359-9d72-54e6f9c1b2a3', '550e8400-e29b-41d4-a716-446655440003', '2025-06-20', '2025-06-22', 200.00, 'canceled', '2025-06-15 12:00:00'),
    ('7c8b3a2e-4f1d-46b7-9a8e-2f5d7e9c3f24', '6b86b273-ff34-4359-9d72-54e6f9c1b2a0', '550e8400-e29b-41d4-a716-446655440003', '2025-07-10', '2025-07-15', 600.00, 'confirmed', '2025-06-20 13:00:00'),
    ('7c8b3a2e-4f1d-46b7-9a8e-2f5d7e9c3f25', '6b86b273-ff34-4359-9d72-54e6f9c1b2a1', '550e8400-e29b-41d4-a716-446655440002', '2025-08-20', '2025-08-25', 900.00, 'confirmed', '2025-06-25 14:00:00');

-- Insert Payments (4 payments for confirmed bookings)
INSERT INTO payments (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
    ('8d9c4b3f-5g2e-57c8-0b9f-3g6e8f0b4c30', '7c8b3a2e-4f1d-46b7-9a8e-2f5d7e9c3f20', 480.00, '2025-06-02 09:30:00', 'credit_card'),
    ('8d9c4b3f-5g2e-57c8-0b9f-3g6e8f0b4c31', '7c8b3a2e-4f1d-46b7-9a8e-2f5d7e9c3f21', 360.00, '2025-06-06 10:30:00', 'paypal'),
    ('8d9c4b3f-5g2e-57c8-0b9f-3g6e8f0b4c32', '7c8b3a2e-4f1d-46b7-9a8e-2f5d7e9c3f24', 600.00, '2025-06-21 13:30:00', 'stripe'),
    ('8d9c4b3f-5g2e-57c8-0b9f-3g6e8f0b4c33', '7c8b3a2e-4f1d-46b7-9a8e-2f5d7e9c3f25', 900.00, '2025-06-26 14:30:00', 'credit_card');

-- Insert Reviews (3 reviews for properties from guests)
INSERT INTO reviews (review_id, property_id, user_id, rating, comment, created_at)
VALUES
    ('9e0d5c40-6h3f-68d9-1c0g-4h7f9g1c5d40', '6b86b273-ff34-4359-9d72-54e6f9c1b2a0', '550e8400-e29b-41d4-a716-446655440002', 4, 'Great stay, loved the beach view!', '2025-07-06 10:00:00'),
    ('9e0d5c40-6h3f-68d9-1c0g-4h7f9g1c5d41', '6b86b273-ff34-4359-9d72-54e6f9c1b2a1', '550e8400-e29b-41d4-a716-446655440002', 5, 'Amazing loft, very central.', '2025-08-13 11:00:00'),
    ('9e0d5c40-6h3f-68d9-1c0g-4h7f9g1c5d42', '6b86b273-ff34-4359-9d72-54e6f9c1b2a0', '550e8400-e29b-41d4-a716-446655440003', 3, 'Nice place, but parking was tricky.', '2025-07-16 12:00:00');

-- Insert Messages (4 messages between users)
INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
    ('af1e6d51-7i4g-79e0-2d1h-5i8g0h2d6e50', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440000', 'Is the cottage available for July?', '2025-05-30 08:00:00'),
    ('af1e6d51-7i4g-79e0-2d1h-5i8g0h2d6e51', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440002', 'Yes, it’s available! Please book online.', '2025-05-30 09:00:00'),
    ('af1e6d51-7i4g-79e0-2d1h-5i8g0h2d6e52', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440001', 'Can I check in early on July 10?', '2025-06-15 10:00:00'),
    ('af1e6d51-7i4g-79e0-2d1h-5i8g0h2d6e53', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440003', 'Early check-in is possible, please confirm closer to the date.', '2025-06-15 11:00:00');