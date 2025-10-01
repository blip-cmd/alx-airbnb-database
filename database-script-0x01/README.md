# Database Schema Documentation

## Overview
This directory contains the SQL Data Definition Language (DDL) scripts for creating the Airbnb database schema. The schema is designed to support a fully functional property rental platform similar to Airbnb.

## Files in this Directory
- `schema.sql` - Complete DDL script for creating the database schema

## Database Schema Structure

### Core Tables

#### 1. User Table
Stores information for all platform users (guests, hosts, and admins).

**Key Features:**
- UUID primary key for enhanced security
- Role-based access control (guest/host/admin)
- Unique email constraint for authentication
- Indexed on email and role for performance

#### 2. Property Table
Contains property listings with detailed information.

**Key Features:**
- References host through foreign key to User table
- Price validation (must be positive)
- Automatic timestamp tracking
- Multiple indexes for location and price searches

#### 3. Booking Table
Manages reservation transactions between guests and properties.

**Key Features:**
- Date validation (end date must be after start date)
- Booking conflict prevention through triggers
- Status tracking (pending/confirmed/canceled)
- Comprehensive indexing for date and property queries

#### 4. Payment Table
Tracks payment information for each booking.

**Key Features:**
- One-to-one relationship with Booking
- Amount validation against booking total
- Support for multiple payment methods
- Payment date tracking

#### 5. Review Table
Stores guest reviews and ratings for properties.

**Key Features:**
- Rating constraint (1-5 scale)
- Unique constraint (one review per user per property)
- Full relationship tracking to both property and user

#### 6. Message Table
Enables communication between platform users.

**Key Features:**
- Prevents self-messaging through check constraint
- Indexed for efficient conversation retrieval
- Full message history preservation

### Performance Optimizations

#### Indexes Created
1. **User Table:**
   - `idx_user_email` - For authentication queries
   - `idx_user_role` - For role-based filtering

2. **Property Table:**
   - `idx_property_host` - Host-specific queries
   - `idx_property_location` - Location-based searches
   - `idx_property_price` - Price filtering
   - `idx_property_location_price` - Combined location/price searches

3. **Booking Table:**
   - `idx_booking_property` - Property-specific bookings
   - `idx_booking_user` - User booking history
   - `idx_booking_dates` - Date range queries
   - `idx_booking_status` - Status filtering
   - `idx_booking_property_dates` - Availability checks

4. **Payment Table:**
   - `idx_payment_booking` - Booking-payment lookups
   - `idx_payment_method` - Payment method analysis
   - `idx_payment_date` - Time-based queries

5. **Review Table:**
   - `idx_review_property` - Property reviews
   - `idx_review_user` - User review history
   - `idx_review_rating` - Rating-based queries
   - `idx_review_date` - Chronological sorting

6. **Message Table:**
   - `idx_message_sender` - Sent messages
   - `idx_message_recipient` - Received messages
   - `idx_message_date` - Message chronology
   - `idx_message_conversation` - Conversation threads

### Data Integrity Features

#### Constraints
- **Foreign Key Constraints:** Maintain referential integrity
- **Check Constraints:** Validate business rules (dates, ratings, prices)
- **Unique Constraints:** Prevent duplicate reviews and ensure unique emails

#### Triggers
1. **Property Host Validation:** Ensures only hosts can create properties
2. **Booking Conflict Check:** Prevents overlapping bookings
3. **Payment Amount Validation:** Ensures payment matches booking total

#### Views
1. **PropertyWithHost:** Combines property and host information
2. **BookingSummary:** Complete booking details with relationships
3. **PropertyRatings:** Aggregated rating statistics per property

### Stored Procedures and Functions

#### Procedures
- `CheckPropertyAvailability()` - Validates date availability for properties

#### Functions
- `CalculateBookingDays()` - Computes duration between dates

## Database Creation Instructions

### Prerequisites
- MySQL 8.0 or higher (recommended)
- Sufficient privileges to create databases, tables, and users

### Step-by-Step Setup

1. **Connect to MySQL Server:**
   ```sql
   mysql -u root -p
   ```

2. **Create Database (Optional):**
   ```sql
   CREATE DATABASE airbnb_db;
   USE airbnb_db;
   ```

3. **Execute Schema Script:**
   ```sql
   SOURCE schema.sql;
   ```

4. **Verify Creation:**
   ```sql
   SHOW TABLES;
   DESCRIBE User;
   ```

### Alternative Execution Methods

#### Using MySQL Workbench
1. Open MySQL Workbench
2. Connect to your MySQL server
3. Open the `schema.sql` file
4. Execute the script

#### Using Command Line
```bash
mysql -u username -p database_name < schema.sql
```

## Performance Considerations

### Index Strategy
- **Selective Indexes:** Created only on frequently queried columns
- **Composite Indexes:** For multi-column WHERE clauses
- **Covering Indexes:** Reduce disk I/O for common queries

### Query Optimization Tips
1. Use indexes for WHERE, ORDER BY, and JOIN clauses
2. Avoid SELECT * in production queries
3. Use EXPLAIN to analyze query execution plans
4. Consider partitioning for very large tables

## Security Features

### User Management
The schema includes commented-out user creation scripts for:
- Application user with CRUD permissions
- Read-only user for reporting

### Data Protection
- UUID primary keys prevent enumeration attacks
- Password hashing required (application-level)
- Role-based access control built into schema

## Maintenance and Monitoring

### Regular Maintenance Tasks
1. **Index Optimization:** Monitor and rebuild indexes as needed
2. **Statistics Updates:** Keep table statistics current
3. **Log Monitoring:** Watch for slow queries and errors

### Backup Strategy
- Regular full backups of the entire database
- Point-in-time recovery capabilities
- Test restore procedures regularly

## Business Rules Enforced

1. **User Management:**
   - Unique email addresses required
   - Role-based permissions (guest/host/admin)

2. **Property Management:**
   - Only hosts can create properties
   - Price must be positive
   - Location information required

3. **Booking System:**
   - No overlapping bookings per property
   - End date must be after start date
   - Status progression rules

4. **Payment Processing:**
   - Payment amount must match booking total
   - One payment per booking

5. **Review System:**
   - Ratings between 1-5 only
   - One review per user per property
   - Reviews tied to actual users and properties

6. **Messaging:**
   - Users cannot message themselves
   - All messages preserved for history

## Future Enhancements

### Potential Schema Extensions
1. **Property Amenities:** Separate table for property features
2. **Availability Calendar:** Detailed date/time availability management
3. **Pricing Rules:** Dynamic pricing based on seasons/demand
4. **Photo Management:** Property and user photo storage
5. **Booking Modifications:** Support for booking changes and cancellations
6. **Multi-currency Support:** International payment handling

### Scalability Considerations
- Table partitioning for large datasets
- Read replicas for improved performance
- Caching strategies for frequently accessed data
- Archive strategies for historical data

## Support and Documentation

For questions about the schema design or implementation:
1. Review the normalization documentation in `../normalization.md`
2. Check the ER diagram requirements in `../ERD/requirements.md`
3. Refer to MySQL documentation for specific syntax questions

## Version History
- **v1.0** (2025-10-01): Initial schema creation with full feature set