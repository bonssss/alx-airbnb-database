# Index Performance Report

## Objective
To measure query performance before and after creating indexes on high-usage columns in the Airbnb clone database.

---

## Queries Tested

1. Count bookings per user:
```sql
SELECT user_id, COUNT(*) FROM bookings GROUP BY user_id;
