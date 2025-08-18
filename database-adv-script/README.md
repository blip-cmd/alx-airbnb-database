
# Complex SQL Joins and Subqueries

This directory contains advanced SQL queries demonstrating the use of different types of joins and subqueries in the context of an Airbnb-like database.

## Files

- `joins_queries.sql`: Contains SQL queries using INNER JOIN, LEFT JOIN, and FULL OUTER JOIN.
- `subqueries.sql`: Contains SQL queries using subqueries and correlated subqueries.

## Queries

### Joins
1. **INNER JOIN**: Retrieves all bookings and the respective users who made those bookings.
2. **LEFT JOIN**: Retrieves all properties and their reviews, including properties that have no reviews.
3. **FULL OUTER JOIN**: Retrieves all users and all bookings, even if the user has no booking or a booking is not linked to a user.

See `joins_queries.sql` for the actual queries.

### Subqueries
1. **Non-correlated subquery**: Finds all properties where the average rating is greater than 4.0.
2. **Correlated subquery**: Finds users who have made more than 3 bookings.

See `subqueries.sql` for the actual queries.
