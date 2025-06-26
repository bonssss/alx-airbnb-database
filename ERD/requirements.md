# Entity-Relationship Diagram for Airbnb Database

## Entities and Attributes

1. **User**
   - _user_id_: UUID, Primary Key, Indexed
   - first_name: VARCHAR, NOT NULL
   - last_name: VARCHAR, NOT NULL
   - email: VARCHAR, UNIQUE, NOT NULL, Indexed
   - password_hash: VARCHAR, NOT NULL
   - phone_number: VARCHAR, NULL
   - role: ENUM(guest, host, admin), NOT NULL
   - created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

2. **Property**
   - _property_id_: UUID, Primary Key, Indexed
   - host_id: UUID, Foreign Key (User.user_id)
   - name: VARCHAR, NOT NULL
   - description: TEXT, NOT NULL
   - location: VARCHAR, NOT NULL
   - pricepernight: DECIMAL, NOT NULL
   - created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
   - updated_at: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

3. **Booking**
   - _booking_id_: UUID, Primary Key, Indexed
   - property_id: UUID, Foreign Key (Property.property_id), Indexed
   - user_id: UUID, Foreign Key (User.user_id)
   - start_date: DATE, NOT NULL
   - end_date: DATE, NOT NULL
   - total_price: DECIMAL, NOT NULL
   - status: ENUM(pending, confirmed, canceled), NOT NULL
   - created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

4. **Payment**
   - _payment_id_: UUID, Primary Key, Indexed
   - booking_id: UUID, Foreign Key (Booking.booking_id), Indexed
   - amount: DECIMAL, NOT NULL
   - payment_date: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
   - payment_method: ENUM(credit_card, paypal, stripe), NOT NULL

5. **Review**
   - _review_id_: UUID, Primary Key, Indexed
   - property_id: UUID, Foreign Key (Property.property_id)
   - user_id: UUID, Foreign Key (User.user_id)
   - rating: INTEGER, CHECK (rating >= 1 AND rating <= 5), NOT NULL
   - comment: TEXT, NOT NULL
   - created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

6. **Message**
   - _message_id_: UUID, Primary Key, Indexed
   - sender_id: UUID, Foreign Key (User.user_id)
   - recipient_id: UUID, Foreign Key (User.user_id)
   - message_body: TEXT, NOT NULL
   - sent_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

## Relationships
- **User to Property**: One-to-Many (User owns Properties; host_id FK).
- **User to Booking**: One-to-Many (User makes Bookings; user_id FK).
- **Property to Booking**: One-to-Many (Property has Bookings; property_id FK).
- **Booking to Payment**: One-to-One (Booking has 0 or 1 Payment; booking_id FK).
- **User to Review**: One-to-Many (User writes Reviews; user_id FK).
- **Property to Review**: One-to-Many (Property has Reviews; property_id FK).
- **User to Message (Sender)**: One-to-Many (User sends Messages; sender_id FK).
- **User to Message (Recipient)**: One-to-Many (User receives Messages; recipient_id FK).

## Indexes
- Primary Keys: user_id, property_id, booking_id, payment_id, review_id, message_id.
- Additional: User.email, Booking.property_id, Payment.booking_id.

## Draw.io Instructions
- **Entities**: Rectangles with entity name and attributes (underline PKs, mark FKs).
- **Relationships**: Lines with Crow’s Foot notation (1, many, 0..1).
- **Constraints**: Note NOT NULL, UNIQUE, CHECK, and ENUM values.
- **Indexes**: Annotate indexed fields (e.g., “Index: email”).