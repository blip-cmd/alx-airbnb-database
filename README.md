# ALX Airbnb Database Project

## Project Overview
This project is part of the comprehensive ALX Airbnb Database Module, focusing on database design, normalization, schema creation, and data seeding. The project simulates a production-level database system for an Airbnb-like property rental platform, emphasizing high standards of design, development, and data handling.

## Learning Objectives
By completing this project, you will:
- Apply advanced principles of database design to model complex systems
- Master normalization techniques to optimize database efficiency and minimize redundancy
- Use SQL DDL to define database schema with appropriate constraints, keys, and indexing
- Write and execute SQL DML scripts to seed databases with realistic sample data
- Enhance collaboration skills through proper documentation and version control

## Project Structure
```
alx-airbnb-database/
├── ERD/
│   └── requirements.md          # Entity-Relationship Diagram requirements and specifications
├── database-script-0x01/
│   ├── schema.sql              # Database schema creation (DDL)
│   └── README.md               # Schema documentation
├── database-script-0x02/
│   ├── seed.sql                # Sample data insertion (DML)
│   └── README.md               # Sample data documentation
├── database-adv-script/        # Advanced database scripts (existing)
│   ├── aggregations_and_window_functions.sql
│   ├── database_index.sql
│   ├── joins_queries.sql
│   ├── partitioning.sql
│   ├── performance.sql
│   ├── subqueries.sql
│   └── *.md files             # Various documentation files
├── normalization.md            # Database normalization analysis
└── README.md                   # This file
```

## Tasks Completed

### ✅ Task 0: Define Entities and Relationships in ER Diagram
**Location**: `ERD/requirements.md`

Created comprehensive entity-relationship diagram requirements including:
- **Core Entities**: User, Property, Booking, Payment, Review, Message
- **Relationships**: Detailed one-to-many and one-to-one relationships
- **Attributes**: Complete attribute specifications with data types
- **Constraints**: Business rules and data validation requirements
- **Visual Guidelines**: Instructions for creating the actual ER diagram

### ✅ Task 1: Normalize Your Database Design
**Location**: `normalization.md`

Applied systematic normalization principles:
- **First Normal Form (1NF)**: Atomic values and unique records
- **Second Normal Form (2NF)**: Elimination of partial dependencies
- **Third Normal Form (3NF)**: Removal of transitive dependencies
- **Analysis**: Detailed table-by-table normalization verification
- **Benefits**: Documentation of improved data integrity and efficiency

### ✅ Task 2: Design Database Schema (DDL)
**Location**: `database-script-0x01/`

Created comprehensive SQL schema including:
- **Table Definitions**: All core tables with proper data types
- **Constraints**: Primary keys, foreign keys, check constraints, unique constraints
- **Indexes**: Performance-optimized indexes for common queries
- **Views**: Business-friendly views for complex queries
- **Triggers**: Data validation and business rule enforcement
- **Stored Procedures**: Reusable database functions
- **Security**: User management and permission structure

### ✅ Task 3: Seed the Database with Sample Data
**Location**: `database-script-0x02/`

Populated database with realistic sample data:
- **13 Users**: 5 hosts, 7 guests, 1 admin with diverse profiles
- **10 Properties**: Various types across multiple locations and price ranges
- **12 Bookings**: Different statuses (confirmed, pending, canceled)
- **8 Payments**: Multiple payment methods and realistic amounts
- **10 Reviews**: Detailed feedback with ratings from 1-5
- **12 Messages**: Realistic conversations between users
- **Verification Queries**: Business intelligence and data validation

## Database Design Features

### Core Entities
1. **User**: Platform users (guests, hosts, admins)
2. **Property**: Rental property listings
3. **Booking**: Reservation transactions
4. **Payment**: Payment processing records
5. **Review**: Property reviews and ratings
6. **Message**: User communication system

### Key Design Principles
- **UUID Primary Keys**: Enhanced security and scalability
- **Referential Integrity**: Proper foreign key relationships
- **Data Validation**: Check constraints for business rules
- **Performance Optimization**: Strategic indexing
- **Audit Trail**: Timestamp tracking for critical operations
- **Flexible Design**: Extensible for future requirements

### Performance Features
- **Composite Indexes**: Optimized for common query patterns
- **Covering Indexes**: Reduced I/O for frequent operations
- **Query Optimization**: Views for complex business queries
- **Partitioning Ready**: Designed for future scaling needs

## Quick Start Guide

### Prerequisites
- MySQL 8.0 or higher
- Database administration privileges
- MySQL client (CLI, Workbench, or similar)

### Step 1: Create Database Schema
```sql
-- Connect to MySQL server
mysql -u root -p

-- Create database (optional)
CREATE DATABASE airbnb_db;
USE airbnb_db;

-- Execute schema creation
SOURCE database-script-0x01/schema.sql;
```

### Step 2: Load Sample Data
```sql
-- Execute data seeding
SOURCE database-script-0x02/seed.sql;
```

### Step 3: Verify Installation
```sql
-- Check all tables were created
SHOW TABLES;

-- Verify data was loaded
SELECT 'Users' as Table_Name, COUNT(*) as Record_Count FROM User
UNION ALL
SELECT 'Properties', COUNT(*) FROM Property
UNION ALL
SELECT 'Bookings', COUNT(*) FROM Booking;
```

## Database Schema Highlights

### User Management
- Role-based access control (guest/host/admin)
- Secure authentication with hashed passwords
- Unique email constraint for user identification

### Property System
- Flexible property descriptions and amenities
- Location-based search capabilities
- Price validation and tracking

### Booking Engine
- Date conflict prevention
- Status workflow management
- Automatic price calculation validation

### Payment Processing
- Multiple payment method support
- Amount verification against bookings
- Transaction history tracking

### Review System
- Rating constraints (1-5 scale)
- One review per user per property
- Comprehensive feedback collection

### Communication Platform
- User-to-user messaging
- Conversation thread management
- Message history preservation

## Business Intelligence Capabilities

### Analytics Queries Included
- Property performance ratings
- Host revenue summaries
- Popular destination analysis
- Booking conversion metrics
- Payment method distribution

### Sample Business Queries
```sql
-- Top-rated properties
SELECT p.name, AVG(r.rating) as avg_rating, COUNT(r.review_id) as review_count
FROM Property p
JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id
ORDER BY avg_rating DESC;

-- Host performance dashboard
SELECT CONCAT(u.first_name, ' ', u.last_name) as host_name,
       COUNT(DISTINCT p.property_id) as properties,
       SUM(CASE WHEN b.status = 'confirmed' THEN b.total_price ELSE 0 END) as revenue
FROM User u
JOIN Property p ON u.user_id = p.host_id
LEFT JOIN Booking b ON p.property_id = b.property_id
WHERE u.role = 'host'
GROUP BY u.user_id;
```

## Testing and Development

### Sample Data Scenarios
- **User Authentication**: Multiple user types with valid credentials
- **Property Search**: Diverse properties across locations and price ranges
- **Booking Workflow**: Complete booking lifecycle from inquiry to completion
- **Payment Processing**: Various payment methods and amounts
- **Review System**: Realistic review content and ratings
- **Messaging**: Multi-party conversations and inquiries

### Development Guidelines
- Use prepared statements for security
- Implement proper error handling
- Follow database naming conventions
- Maintain referential integrity
- Optimize queries with appropriate indexes

## Security Considerations

### Data Protection
- Password hashing using bcrypt
- UUID primary keys prevent enumeration attacks
- Role-based access control
- Input validation through constraints

### Best Practices
- Regular security audits
- Principle of least privilege
- Secure connection requirements
- Data backup and recovery procedures

## Performance Optimization

### Indexing Strategy
- Primary key indexes on all tables
- Foreign key indexes for joins
- Composite indexes for common query patterns
- Full-text indexes for search functionality

### Query Optimization
- Use EXPLAIN for query analysis
- Optimize JOIN operations
- Implement proper WHERE clause ordering
- Consider query caching for frequent operations

## Maintenance and Monitoring

### Regular Tasks
- Index maintenance and optimization
- Database statistics updates
- Log file monitoring and rotation
- Performance metric tracking

### Backup Strategy
- Daily full backups
- Point-in-time recovery capability
- Offsite backup storage
- Regular restore testing

## Future Enhancements

### Potential Extensions
- **Property Amenities**: Detailed feature tracking
- **Availability Calendar**: Dynamic date management
- **Multi-currency Support**: International payments
- **Photo Management**: Property and user images
- **Advanced Search**: Filters and recommendations
- **Booking Modifications**: Change and cancellation workflows

### Scalability Improvements
- Database sharding strategies
- Read replica implementation
- Caching layer integration
- API rate limiting
- Load balancing considerations

## Documentation References

### Project Files
- **ER Requirements**: `ERD/requirements.md`
- **Normalization Analysis**: `normalization.md`
- **Schema Documentation**: `database-script-0x01/README.md`
- **Sample Data Guide**: `database-script-0x02/README.md`

### External Resources
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Database Design Best Practices](https://dev.mysql.com/doc/refman/8.0/en/optimization.html)
- [SQL Performance Tuning](https://dev.mysql.com/doc/refman/8.0/en/optimization-indexes.html)

## Contributing

### Code Standards
- Follow SQL naming conventions
- Include comprehensive comments
- Maintain consistent formatting
- Test all changes thoroughly

### Documentation
- Update README files for any changes
- Include examples for new features
- Maintain version history
- Document breaking changes

## Project Status

### Completed Tasks
- [x] **Task 0**: ER Diagram Requirements
- [x] **Task 1**: Database Normalization
- [x] **Task 2**: Schema Design (DDL)
- [x] **Task 3**: Sample Data Seeding (DML)

### Manual Review Ready
This project is ready for manual review with all required deliverables:
- Complete ER diagram specifications
- Normalized database design
- Production-ready SQL schema
- Comprehensive sample data
- Full documentation

## License
This project is part of the ALX Software Engineering Program.

## Author
ALX Student - DataScape: Mastering Database Design Module

---
*For questions or support, please refer to the individual README files in each directory or contact your ALX mentor.*