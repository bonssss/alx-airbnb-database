Airbnb Clone Database Advanced Queries
Overview
The database-adv-script/ directory contains advanced SQL queries for the Airbnb Clone database, demonstrating the use of different types of joins (INNER JOIN, LEFT JOIN, FULL OUTER JOIN). These queries are designed for MySQL and align with the schema in database-script-0x01/schema.sql and sample data in database-script-0x02/seed.sql.
Files

joins_queries.sql: Contains three SQL queries using joins to retrieve data from the database:
INNER JOIN: Retrieves all bookings and their associated users.
LEFT JOIN: Retrieves all properties and their reviews, including properties without reviews.
FULL OUTER JOIN (simulated): Retrieves all users and bookings, including users without bookings and bookings without users.



Purpose
The queries demonstrate proficiency in SQL joins, enabling:

Retrieval of related data (e.g., bookings with user details).
Inclusion of entities without matches (e.g., properties without reviews).
Comprehensive data views (e.g., all users and bookings).

Usage

Setup Database:
Ensure the MySQL database is set up with the schema from database-script-0x01/schema.sql.
Populate the database with sample data from database-script-0x02/seed.sql:mysql -u <username> -p <database_name> < database-script-0x01/schema.sql
mysql -u <username> -p <database_name> < database-script-0x02/seed.sql




Run Queries:
Execute the queries in joins_queries.sql using a MySQL client:mysql -u <username> -p <database_name> < joins_queries.sql


Alternatively, copy and paste individual queries into a MySQL client (e.g., MySQL Workbench).


Review Results:
Query 1: Returns bookings with user details (e.g., first_name, email).
Query 2: Returns all properties, with NULL for review fields if no reviews exist.
Query 3: Returns all users and bookings, with NULLs for unmatched records.



Query Details

Query 1 (INNER JOIN):
Joins bookings and users on user_id.
Returns only bookings with matching users (all bookings in sample data have users due to schema constraints).
Fields: booking_id, property_id, start_date, end_date, total_price, status, user_id, first_name, last_name, email.


Query 2 (LEFT JOIN):
Joins properties with reviews on property_id.
Includes all properties, with NULLs for review fields if no reviews exist.
Fields: property_id, name, location, pricepernight, review_id, rating, comment, review_created_at.


Query 3 (FULL OUTER JOIN):
Simulates FULL OUTER JOIN using LEFT JOIN UNION RIGHT JOIN (MySQL workaround).
Includes all users and bookings, with NULLs for unmatched records (no unmatched bookings in sample data due to foreign key constraints).
Fields: user_id, first_name, last_name, email, booking_id, property_id, start_date, end_date, total_price, status.



Notes

Database: Uses MySQL with CHAR(36) for IDs and VARCHAR with CHECK constraints, as defined in database-script-0x01/schema.sql.
FULL OUTER JOIN: MySQL does not support FULL OUTER JOIN natively, so Query 3 uses a UNION of LEFT and RIGHT JOINs to achieve the same result.
Sample Data: The queries assume the sample data from database-script-0x02/seed.sql, which includes 5 users, 4 properties, 6 bookings, and 3 reviews.
Performance: Queries are optimized with indexes on user_id, property_id (from schema). For large datasets, consider additional indexing or caching.
Repository: Commit and push joins_queries.sql and README.md to the database-adv-script/ directory in the alx-airbnb-database repository:git add database-adv-script/
git commit -m "Add complex join queries and documentation for Airbnb Clone database"
git push origin main



For schema details, see database-script-0x01/README.md. For sample data, see database-script-0x02/README.md. For feature details, see alx-airbnb-project-documentation/features-and-functionalities/features.md.