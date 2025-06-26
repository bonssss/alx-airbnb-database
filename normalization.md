# Database Normalization for Airbnb Database

## Objective
Normalize the Airbnb database schema to the Third Normal Form (3NF) to eliminate redundancies and ensure data integrity.

## Normalization Principles
- **1NF**: Atomic attributes, no repeating groups, primary key for each table.
- **2NF**: 1NF + no partial dependencies on composite keys.
- **3NF**: 2NF + no transitive dependencies (non-key attributes depend only on the primary key).

## Schema Review
The schema includes six tables: User, Property, Booking, Payment, Review, and Message. Below is the normalization analysis for each.

### 1. User
- **Attributes**: user_id (PK), first_name, last_name, email (UNIQUE), password_hash, phone_number, role, created_at.
- **1NF**: All attributes are atomic. user_id is the primary key. No repeating groups.
- **2NF**: Single primary key (user_id), so no partial dependencies.
- **3NF**: No transitive dependencies (e.g., first_name does not depend on email).
- **Status**: Satisfies 3NF.
- **Notes**: The email UNIQUE constraint ensures data integrity.

### 2. Property
- **Attributes**: property_id (PK), host_id (FK), name, description, location, pricepernight, created_at, updated_at.
- **1NF**: All attributes are atomic. property_id is the primary key.
- **2NF**: Single primary key, so no partial dependencies.
- **3NF**: No transitive dependencies. Location is assumed atomic (VARCHAR) per the specification.
- **Status**: Satisfies 3NF.
- **Notes**: host_id links to User, maintaining referential integrity.

### 3. Booking
- **Attributes**: booking_id (PK), property_id (FK), user_id (FK), start_date, end_date, total_price, status, created_at.
- **1NF**: All attributes are atomic. booking_id is the primary key.
- **2NF**: Single primary key, so no partial dependencies.
- **3NF**: total_price could be derived from pricepernight (Property) and duration (end_date - start_date), suggesting a transitive dependency. However, storing total_price is justified for:
  - Historical accuracy (pricepernight may change).
  - Performance (avoids repeated calculations).
  - Audit purposes.
- **Status**: Satisfies 3NF with intentional denormalization.
- **Notes**: Indexes on property_id and booking_id optimize joins.

### 4. Payment
- **Attributes**: payment_id (PK), booking_id (FK), amount, payment_date, payment_method.
- **1NF**: All attributes are atomic. payment_id is the primary key.
- **2NF**: Single primary key, so no partial dependencies.
- **3NF**: amount may duplicate Booking.total_price, but it’s retained for:
  - Audit trails (payment records).
  - Potential variations (e.g., fees, partial payments).
- **Status**: Satisfies 3NF with intentional denormalization.
- **Notes**: Foreign key constraint on booking_id ensures integrity.

### 5. Review
- **Attributes**: review_id (PK), property_id (FK), user_id (FK), rating, comment, created_at.
- **1NF**: All attributes are atomic. review_id is the primary key.
- **2NF**: Single primary key, so no partial dependencies.
- **3NF**: No transitive dependencies. Rating (1-5) and comment depend on review_id.
- **Status**: Satisfies 3NF.
- **Notes**: CHECK constraint on rating ensures data validity.

### 6. Message
- **Attributes**: message_id (PK), sender_id (FK), recipient_id (FK), message_body, sent_at.
- **1NF**: All attributes are atomic. message_id is the primary key.
- **2NF**: Single primary key, so no partial dependencies.
- **3NF**: No transitive dependencies. Message_body and sent_at depend on message_id.
- **Status**: Satisfies 3NF.
- **Notes**: Dual foreign keys (sender_id, recipient_id) link to User.

## Adjustments
No structural changes are needed. The schema is in 3NF, with two minor denormalizations:
- **Booking.total_price**: Stored for historical accuracy and performance.
- **Payment.amount**: Stored for audit purposes and potential variations.
These are standard practices in transactional databases like Airbnb’s.

## Conclusion
The schema satisfies 3NF, with all tables properly structured, atomic attributes, and no transitive or partial dependencies. The intentional denormalizations (total_price, amount) are justified for practical reasons, ensuring efficiency and data integrity.