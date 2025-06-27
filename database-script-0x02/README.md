Airbnb Database Seed Data
Overview
This directory (database-script-0x02) contains the SQL script to populate the Airbnb-like database with sample data for testing and development. The data simulates real-world usage, covering users, properties, bookings, payments, reviews, and messages, designed for MySQL 8.0.16+.
File

seed.sql: Contains INSERT statements to add sample data to the database tables defined in database-script-0x01/schema.sql.

Sample Data Details
The seed data includes:

Users: 5 users (2 hosts, 2 guests, 1 admin) with realistic names, emails, and roles.
Properties: 4 properties owned by the 2 hosts, with varied locations (e.g., Miami, New York) and prices ($100-$180/night).
Bookings: 6 bookings by guests, with statuses (4 confirmed, 1 pending, 1 canceled) and realistic dates in 2025.
Payments: 4
