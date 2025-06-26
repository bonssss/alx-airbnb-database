Airbnb Database Schema
Overview
This directory (database-script-0x01) contains the SQL schema definition for an Airbnb-like database, designed to manage users, properties, bookings, payments, reviews, and messages. The schema is normalized to the Third Normal Form (3NF) to ensure data integrity and eliminate redundancies.
File

schema.sql: Contains CREATE TABLE statements to define the database schema, including tables, constraints, and indexes.

Schema Details
The database includes six tables:

users: Stores user information (e.g., name, email, role).
properties: Stores property details (e.g., name, location, price per night).
bookings: Manages booking records (e.g., start/end dates, total price).
payments: Tracks payment details for bookings.
reviews: Stores user reviews for properties (e.g., rating, comment).
messages: Handles communication between users.

Key Features

Primary Keys: UUIDs for unique identification (user_id, property_id, etc.).
Foreign Keys: Enforce referential integrity (e.g., host_id in properties references users.user_id).
Constraints:
Unique constraint on users.email.
Check constraint on reviews.rating (1-5).
Non-null constraints on required fields.
Default timestamps for creation/update fields.


Indexes:
Automatic indexes on primary keys.
Additional indexes on users.email, bookings.property_id, and payments.booking_id for query performance.


Data Types:
UUID for IDs.
VARCHAR and TEXT for text fields.
DECIMAL(10,2) for monetary values.
ENUM for restricted values (e.g., role, status).
DATE and TIMESTAMP for dates.



Usage
To set up the database:

Ensure you have a PostgreSQL database server installed.
Enable the UUID extension:CREATE EXTENSION IF NOT EXISTS uuid-ossp;


Run the schema.sql script:psql -U <username> -d <database_name> -f schema.sql


The script creates all tables, constraints, and indexes in the correct order.

Dependencies

PostgreSQL: The script uses PostgreSQL syntax for UUID and ENUM.
UUID Extension: Required for generating UUIDs (uuid-ossp).
For MySQL compatibility, modify UUID to CHAR(36) and replace ENUM with VARCHAR plus CHECK constraints (MySQL 8.0.16+) or separate lookup tables.

Notes

The schema is in 3NF, with minor denormalizations (bookings.total_price, payments.amount) for performance and audit purposes.
Foreign keys use ON DELETE RESTRICT to prevent deletion of referenced records.
Adjust VARCHAR lengths (e.g., VARCHAR(50) for names) based on specific requirements.
For MySQL users, consult comments in schema.sql for alternative syntax.

Normalization
The schema adheres to 3NF:

1NF: Atomic attributes, no repeating groups, primary keys defined.
2NF: No partial dependencies (all tables use single-column primary keys).
3NF: No transitive dependencies, except intentional denormalizations for total_price and amount.

For further details, see the normalization analysis in ERD/normalization.md.