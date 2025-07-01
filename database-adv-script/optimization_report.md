Airbnb Clone Database Advanced Queries
Overview
The database-adv-script/ directory contains advanced SQL queries and optimizations for the Airbnb Clone database, demonstrating joins, subqueries, aggregations, window functions, index-based performance improvements, and query refactoring. These are designed for MySQL and align with the schema in database-script-0x01/schema.sql and sample data in database-script-0x02/seed.sql.
Files

joins_queries.sql: Three SQL queries using different types of joins:
INNER JOIN: Retrieves all bookings and their associated users (6 rows).
LEFT JOIN: Retrieves all properties and their reviews, including properties without reviews (7 rows).
FULL OUTER JOIN (simulated): Retrieves all users and bookings, including users without bookings (11 rows).


subqueries.sql: Two SQL queries demonstrating subqueries:
Non-correlated subquery: Finds properties with an average rating > 4.0 (1 row: Downtown Loft).
Correlated subquery: Finds users with > 3 bookings (0 rows).


aggregations_and_window_functions.sql: Two SQL queries demonstrating aggregations and window functions:
Aggregation: Uses COUNT and GROUP BY to find the total number of bookings for users with bookings (2 rows: Carol, David).
Window Function: Uses RANK to rank properties by total bookings (4 rows: Cozy Beach Cottage, Downtown Loft, Mountain Cabin, Urban Apartment).


database_index.sql: SQL commands to create indexes on high-usage columns (users.email, properties.host_id, bookings.user_id, bookings.property_id, bookings.created_at) and EXPLAIN analysis for two queries.
index_performance.md: Documents high-usage columns and references EXPLAIN analysis in database_index.sql.
perfomance.sql: Initial and refactored queries retrieving bookings with user, property, and payment details, with EXPLAIN analysis.
optimization_report.md: Documents initial query, performance analysis, inefficiencies, and refactored query for optimization.

Purpose
The files demonstrate proficiency in advanced SQL techniques and database optimization:

Joins: Combine data from multiple tables.
Subqueries: Filter data using nested queries.
Aggregations: Summarize data with COUNT and GROUP BY.
Window Functions: Rank data with RANK.
Indexes: Optimize query performance with EXPLAIN analysis.
Query Optimization: Refactor complex queries to reduce execution time.

Usage

Setup Database:
Set up the MySQL database with the schema from database-script-0x01/schema.sql.
Populate with sample data from database-script-0x02/seed.sql:mysql -u <username> -p <database_name> < database-script-0x01/schema.sql
mysql -u <username> -p <database_name> < database-script-0x02/seed.sql




Apply Indexes:
Execute database_index.sql to create indexes:mysql -u <username> -p <database_name> < database-adv-script/database_index.sql




Run Queries:
Execute queries in joins_queries.sql, subqueries.sql, aggregations_and_window_functions.sql, or perfomance.sql:mysql -u <username> -p <database_name> < database-adv-script/joins_queries.sql
mysql -u <username> -p <database_name> < database-adv-script/subqueries.sql
mysql -u <username> -p <database_name> < database-adv-script/aggregations_and_window_functions.sql
mysql -u <username> -p <database_name> < database-adv-script/perfomance.sql


Alternatively, copy and paste queries into a MySQL client (e.g., MySQL Workbench).


Analyze Performance:
Review database_index.sql and perfomance.sql for EXPLAIN analysis.
Run EXPLAIN manually to verify:EXPLAIN SELECT ...;





Query and Index Details

joins_queries.sql:
Query 1 (INNER JOIN): Joins bookings and users on user_id (6 rows).
Query 2 (LEFT JOIN): Joins properties with reviews on property_id (7 rows).
Query 3 (FULL OUTER JOIN): Simulates with LEFT JOIN UNION RIGHT JOIN (11 rows).


subqueries.sql:
Query 1 (Non-correlated): Finds properties with average rating > 4.0 (1 row).
Query 2 (Correlated): Finds users with > 3 bookings (0 rows).


aggregations_and_window_functions.sql:
Query 1 (Aggregation): Uses COUNT and GROUP BY with INNER JOIN (2 rows).
Query 2 (Window Function): Uses RANK to rank properties (4 rows).


database_index.sql:
Indexes: idx_users_email, idx_properties_host_id, idx_bookings_user_id, idx_bookings_property_id, idx_bookings_created_at.
EXPLAIN analysis for two queries, showing ~50-60% cost reduction.


index_performance.md:
Summarizes high-usage columns and references EXPLAIN analysis in database_index.sql.


perfomance.sql:
Initial query: Joins bookings, users, properties, payments (6 rows).
Refactored query: Uses LEFT JOIN for payments, filters confirmed bookings (~3-6 rows, ~30-40% cost reduction).


optimization_report.md:
Documents initial query, inefficiencies, and refactored query with EXPLAIN analysis.



Notes

Database: Uses MySQL with CHAR(36) for IDs, per database-script-0x01/schema.sql.
Sample Data: Assumes database-script-0x02/seed.sql
