# Database Sample Data Documentation

## Overview
This directory contains SQL Data Manipulation Language (DML) scripts for populating the Airbnb database with realistic sample data. The data simulates real-world usage patterns and provides a comprehensive foundation for testing and development.

## Files in this Directory
- `seed.sql` - Complete DML script for inserting sample data

## Sample Data Structure

### Data Volume Summary
- **Users**: 13 total (5 hosts, 7 guests, 1 admin)
- **Properties**: 10 diverse properties across various locations
- **Bookings**: 12 bookings with different statuses (confirmed, pending, canceled)
- **Payments**: 8 payments for confirmed bookings
- **Reviews**: 10 detailed reviews from actual guests
- **Messages**: 12 realistic conversations between users

### User Profiles

#### Hosts (5 users)
1. **Alice Johnson** - NYC host with downtown properties
2. **Michael Chen** - West Coast host with beach and city properties
3. **Sarah Williams** - Mountain and historic property specialist
4. **David Brown** - Lakeside and urban property owner
5. **Emma Davis** - Luxury estate and tropical property host

#### Guests (7 users)
- **John Smith** - Business traveler
- **Emily Taylor** - Vacation enthusiast
- **Robert Anderson** - Nature lover
- **Lisa Wilson** - City explorer
- **James Moore** - Luxury seeker
- **Jessica Garcia** - Wine enthusiast
- **Mark Martinez** - Outdoor adventurer

#### Admin (1 user)
- **Admin User** - Platform administrator

### Property Portfolio

#### Property Types and Locations
1. **Cozy Downtown Apartment** - New York, NY ($125/night)
2. **Luxury Penthouse Suite** - New York, NY ($350/night)
3. **Beachfront Villa** - Malibu, CA ($450/night)
4. **Modern City Loft** - San Francisco, CA ($200/night)
5. **Mountain Cabin Retreat** - Aspen, CO ($275/night)
6. **Historic Brownstone** - Boston, MA ($180/night)
7. **Lakeside Cottage** - Lake Tahoe, CA ($220/night)
8. **Urban Studio Apartment** - Chicago, IL ($95/night)
9. **Wine Country Estate** - Napa Valley, CA ($500/night)
10. **Tropical Beach House** - Key West, FL ($380/night)

#### Price Range Distribution
- **Budget** ($95-$125): 2 properties
- **Mid-range** ($180-$275): 5 properties
- **Luxury** ($350-$500): 3 properties

### Booking Patterns

#### Booking Status Distribution
- **Confirmed**: 8 bookings (67%)
- **Pending**: 2 bookings (17%)
- **Canceled**: 2 bookings (17%)

#### Temporal Distribution
- **Past Bookings**: April-May 2024 (completed stays)
- **Current/Future**: November-December 2024 (upcoming stays)
- **Canceled**: June-July 2024 (various reasons)

#### Revenue Analysis
- **Total Confirmed Revenue**: $8,155.00
- **Average Booking Value**: $679.58
- **Pending Revenue**: $2,090.00

### Payment Methods
- **Credit Card**: 4 payments (50%)
- **Stripe**: 3 payments (37.5%)
- **PayPal**: 2 payments (25%)

### Review Quality and Distribution

#### Rating Distribution
- **5-star reviews**: 6 reviews (60%)
- **4-star reviews**: 3 reviews (30%)
- **3-star reviews**: 1 review (10%)
- **Average rating**: 4.5/5.0

#### Review Content Themes
- Location and accessibility
- Host communication and responsiveness
- Property condition and amenities
- Unique features and experiences
- Constructive feedback for improvements

### Communication Patterns

#### Message Categories
1. **Pre-booking inquiries** (40%)
   - Availability questions
   - Amenity information
   - Special requests

2. **Booking coordination** (25%)
   - Check-in procedures
   - Local recommendations
   - Special arrangements

3. **Post-stay communication** (25%)
   - Thank you messages
   - Experience feedback
   - Return visit planning

4. **Future booking inquiries** (10%)
   - Availability for future dates
   - Special event planning

## Data Relationships and Integrity

### Referential Integrity
- All foreign key relationships are properly maintained
- No orphaned records exist in the sample data
- Cascade deletes are properly configured

### Business Rule Compliance
- **Booking Validation**: All bookings have valid date ranges
- **Payment Validation**: All payments match corresponding booking totals
- **Review Constraints**: All reviews are within 1-5 rating range
- **User Role Validation**: Only hosts own properties
- **Message Validation**: No self-messaging attempts

### Data Consistency Checks
- **Email Uniqueness**: All user emails are unique
- **UUID Format**: All primary keys use proper UUID format
- **Date Logic**: All end dates are after start dates
- **Price Validation**: All prices are positive values

## Usage Instructions

### Loading the Sample Data

#### Prerequisites
- Database schema must be created first (run `../database-script-0x01/schema.sql`)
- MySQL 8.0 or higher recommended
- Sufficient database privileges for INSERT operations

#### Step-by-Step Loading

1. **Ensure Clean Database:**
   ```sql
   -- Optional: Clear existing data
   SET FOREIGN_KEY_CHECKS = 0;
   TRUNCATE TABLE Message;
   TRUNCATE TABLE Review;
   TRUNCATE TABLE Payment;
   TRUNCATE TABLE Booking;
   TRUNCATE TABLE Property;
   TRUNCATE TABLE User;
   SET FOREIGN_KEY_CHECKS = 1;
   ```

2. **Load Sample Data:**
   ```sql
   SOURCE seed.sql;
   ```

3. **Verify Data Loading:**
   The script includes automatic verification queries that display:
   - Record counts for each table
   - Sample data from each table
   - Business intelligence summaries

#### Alternative Loading Methods

**Using MySQL Command Line:**
```bash
mysql -u username -p database_name < seed.sql
```

**Using MySQL Workbench:**
1. Open MySQL Workbench
2. Connect to your database
3. Open the `seed.sql` file
4. Execute the script

### Data Verification Queries

The script includes several built-in verification queries:

#### Record Count Verification
```sql
SELECT 'Users' as Table_Name, COUNT(*) as Record_Count FROM User
UNION ALL
SELECT 'Properties', COUNT(*) FROM Property
-- ... (continues for all tables)
```

#### Business Intelligence Queries
- Property ratings summary
- Booking statistics by status
- Host revenue analysis
- Popular destination metrics

## Testing Scenarios

### Functional Testing Data

#### User Authentication Testing
- Valid user credentials for login testing
- Different user roles (guest, host, admin)
- Email uniqueness validation

#### Property Search Testing
- Properties across various price ranges
- Multiple locations for geographic filtering
- Different property types and amenities

#### Booking System Testing
- Available properties for booking
- Conflict detection (overlapping dates)
- Status transitions (pending → confirmed → completed)

#### Payment Processing Testing
- Multiple payment methods
- Amount validation against bookings
- Payment history tracking

#### Review System Testing
- Various rating levels (1-5 stars)
- Different review lengths and content
- Review authenticity (linked to actual bookings)

#### Messaging System Testing
- Host-guest communications
- Multi-message conversations
- Different message types and purposes

### Performance Testing Data

#### Query Performance
- Sufficient data volume for index testing
- Complex join scenarios across multiple tables
- Date range queries with realistic patterns

#### Load Testing Scenarios
- Multiple concurrent user sessions
- Peak booking period simulations
- Search and filtering operations

## Business Intelligence and Analytics

### Key Performance Indicators (KPIs)

#### Host Performance Metrics
- Average property rating per host
- Booking conversion rates
- Revenue per property
- Response time to guest messages

#### Guest Behavior Analysis
- Booking frequency patterns
- Preferred property types and locations
- Average stay duration
- Review submission rates

#### Platform Metrics
- Overall occupancy rates
- Revenue trends by location
- Payment method preferences
- Cancellation patterns

### Sample Analytics Queries

#### Revenue by Location
```sql
SELECT 
    location,
    COUNT(b.booking_id) as total_bookings,
    SUM(CASE WHEN b.status = 'confirmed' THEN b.total_price ELSE 0 END) as revenue
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
GROUP BY location
ORDER BY revenue DESC;
```

#### Host Ranking by Performance
```sql
SELECT 
    CONCAT(u.first_name, ' ', u.last_name) as host_name,
    AVG(r.rating) as avg_rating,
    COUNT(b.booking_id) as total_bookings
FROM User u
JOIN Property p ON u.user_id = p.host_id
LEFT JOIN Booking b ON p.property_id = b.property_id
LEFT JOIN Review r ON p.property_id = r.property_id
WHERE u.role = 'host'
GROUP BY u.user_id
ORDER BY avg_rating DESC, total_bookings DESC;
```

## Data Maintenance and Updates

### Regular Maintenance Tasks

#### Data Freshness
- Update booking dates to reflect current time periods
- Add new properties and users periodically
- Refresh payment dates and review timestamps

#### Data Quality Checks
- Validate referential integrity constraints
- Check for data anomalies or inconsistencies
- Monitor for realistic data patterns

### Extending the Sample Data

#### Adding New Data
- Follow the UUID pattern for new IDs
- Maintain realistic relationships between entities
- Ensure business rule compliance

#### Customization Options
- Modify user profiles for specific testing needs
- Adjust property locations and types
- Change booking patterns and payment methods

## Security and Privacy Considerations

### Data Protection
- All passwords are properly hashed (bcrypt format)
- Personal information is realistic but fictional
- No actual personal data is used

### Test Data Guidelines
- Use only for development and testing purposes
- Do not use in production environments
- Follow data protection regulations for test data

## Troubleshooting

### Common Issues

#### Foreign Key Constraint Errors
- Ensure schema is created before loading data
- Check that UUID references match exactly
- Verify parent records exist before inserting children

#### Duplicate Key Errors
- Clear existing data before reloading
- Check for unique constraint violations
- Ensure UUIDs are properly generated

#### Data Type Mismatches
- Verify date formats (YYYY-MM-DD)
- Check decimal precision for prices
- Ensure ENUM values match schema definitions

### Error Resolution
1. Check error messages for specific constraint violations
2. Verify data formats match schema requirements
3. Ensure proper order of data insertion (parents before children)
4. Use transaction rollback for partial failures

## Version History
- **v1.0** (2025-10-01): Initial sample data creation with comprehensive coverage