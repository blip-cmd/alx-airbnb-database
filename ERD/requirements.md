# Airbnb Database - Entity-Relationship Diagram Requirements

## Project Overview
This document outlines the entities, attributes, and relationships for the Airbnb-like database system.

## Entities and Attributes

### 1. User
**Purpose**: Represents both guests and hosts in the system
- `user_id` (Primary Key, UUID)
- `first_name` (VARCHAR, NOT NULL)
- `last_name` (VARCHAR, NOT NULL)
- `email` (VARCHAR, UNIQUE, NOT NULL)
- `password_hash` (VARCHAR, NOT NULL)
- `phone_number` (VARCHAR)
- `role` (ENUM: guest, host, admin)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### 2. Property
**Purpose**: Represents rental properties listed on the platform
- `property_id` (Primary Key, UUID)
- `host_id` (Foreign Key -> User.user_id)
- `name` (VARCHAR, NOT NULL)
- `description` (TEXT)
- `location` (VARCHAR, NOT NULL)
- `price_per_night` (DECIMAL(10,2), NOT NULL)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- `updated_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP ON UPDATE)

### 3. Booking
**Purpose**: Represents reservation transactions between guests and properties
- `booking_id` (Primary Key, UUID)
- `property_id` (Foreign Key -> Property.property_id)
- `user_id` (Foreign Key -> User.user_id)
- `start_date` (DATE, NOT NULL)
- `end_date` (DATE, NOT NULL)
- `total_price` (DECIMAL(10,2), NOT NULL)
- `status` (ENUM: pending, confirmed, canceled)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### 4. Payment
**Purpose**: Tracks payment transactions for bookings
- `payment_id` (Primary Key, UUID)
- `booking_id` (Foreign Key -> Booking.booking_id)
- `amount` (DECIMAL(10,2), NOT NULL)
- `payment_date` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- `payment_method` (ENUM: credit_card, paypal, stripe)

### 5. Review
**Purpose**: Stores guest reviews and ratings for properties
- `review_id` (Primary Key, UUID)
- `property_id` (Foreign Key -> Property.property_id)
- `user_id` (Foreign Key -> User.user_id)
- `rating` (INTEGER, CHECK rating >= 1 AND rating <= 5)
- `comment` (TEXT)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### 6. Message
**Purpose**: Enables communication between guests and hosts
- `message_id` (Primary Key, UUID)
- `sender_id` (Foreign Key -> User.user_id)
- `recipient_id` (Foreign Key -> User.user_id)
- `message_body` (TEXT, NOT NULL)
- `sent_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

## Relationships

### 1. User-Property Relationship
- **Type**: One-to-Many (1:M)
- **Description**: One host (user) can own multiple properties
- **Implementation**: Property.host_id references User.user_id

### 2. User-Booking Relationship
- **Type**: One-to-Many (1:M)
- **Description**: One user can make multiple bookings
- **Implementation**: Booking.user_id references User.user_id

### 3. Property-Booking Relationship
- **Type**: One-to-Many (1:M)
- **Description**: One property can have multiple bookings
- **Implementation**: Booking.property_id references Property.property_id

### 4. Booking-Payment Relationship
- **Type**: One-to-One (1:1)
- **Description**: Each booking has exactly one payment
- **Implementation**: Payment.booking_id references Booking.booking_id (UNIQUE)

### 5. Property-Review Relationship
- **Type**: One-to-Many (1:M)
- **Description**: One property can have multiple reviews
- **Implementation**: Review.property_id references Property.property_id

### 6. User-Review Relationship
- **Type**: One-to-Many (1:M)
- **Description**: One user can write multiple reviews
- **Implementation**: Review.user_id references User.user_id

### 7. User-Message Relationship (Sender)
- **Type**: One-to-Many (1:M)
- **Description**: One user can send multiple messages
- **Implementation**: Message.sender_id references User.user_id

### 8. User-Message Relationship (Recipient)
- **Type**: One-to-Many (1:M)
- **Description**: One user can receive multiple messages
- **Implementation**: Message.recipient_id references User.user_id

## ER Diagram Instructions

### Tools Recommended
- Draw.io (diagrams.net)
- Lucidchart
- ERDPlus
- MySQL Workbench

### Visual Elements to Include
1. **Entities**: Represented as rectangles
2. **Attributes**: Listed within or connected to entities
3. **Primary Keys**: Underlined or marked with (PK)
4. **Foreign Keys**: Marked with (FK)
5. **Relationships**: Connected with lines showing cardinality
6. **Relationship Labels**: Clearly describe the nature of each relationship

### Cardinality Notation
- Use crow's foot notation or similar to show:
  - One-to-Many relationships (1:M)
  - One-to-One relationships (1:1)
  - Many-to-Many relationships (M:N) - if any

## Constraints and Business Rules

1. **User Constraints**:
   - Email must be unique across all users
   - Phone number should follow international format
   - Role determines access permissions

2. **Property Constraints**:
   - Price per night must be positive
   - Host must be a user with 'host' role
   - Location should include city, state/region, country

3. **Booking Constraints**:
   - End date must be after start date
   - No overlapping bookings for the same property
   - Total price should match (end_date - start_date) × price_per_night

4. **Payment Constraints**:
   - Amount must match booking total_price
   - Payment date should be within reasonable time of booking

5. **Review Constraints**:
   - Rating must be between 1 and 5
   - User can only review properties they have booked
   - One review per user per property

6. **Message Constraints**:
   - Sender and recipient must be different users
   - Message body cannot be empty

## Data Integrity Rules

1. **Referential Integrity**: All foreign keys must reference existing records
2. **Entity Integrity**: All primary keys must be unique and not null
3. **Domain Integrity**: All attributes must comply with defined data types and constraints
4. **User-Defined Integrity**: Business rules must be enforced (e.g., booking date validation)

## Next Steps

1. Create the visual ER diagram using one of the recommended tools
2. Export the diagram as PNG/JPG and include in this directory
3. Validate the design against normalization principles
4. Proceed to schema creation (DDL) based on this design