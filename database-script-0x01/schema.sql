-- =====================================================
-- Airbnb Database Schema (DDL Script)
-- =====================================================
-- This script creates the complete database schema for an Airbnb-like application
-- including all tables, constraints, indexes, and relationships.
-- 
-- Author: ALX Student
-- Date: 2025-10-01
-- Version: 1.0
-- =====================================================

-- Create database (uncomment if needed)
-- CREATE DATABASE IF NOT EXISTS airbnb_db;
-- USE airbnb_db;

-- =====================================================
-- Table: User
-- Purpose: Stores user information for guests and hosts
-- =====================================================

CREATE TABLE User (
    user_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role ENUM('guest', 'host', 'admin') NOT NULL DEFAULT 'guest',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index for email lookup (frequently used for authentication)
CREATE INDEX idx_user_email ON User(email);

-- Index for role-based queries
CREATE INDEX idx_user_role ON User(role);

-- =====================================================
-- Table: Property
-- Purpose: Stores property listings information
-- =====================================================

CREATE TABLE Property (
    property_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    host_id CHAR(36) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    location VARCHAR(255) NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL CHECK (price_per_night > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign key constraint
    FOREIGN KEY (host_id) REFERENCES User(user_id) ON DELETE CASCADE
);

-- Index for host-based queries
CREATE INDEX idx_property_host ON Property(host_id);

-- Index for location-based searches
CREATE INDEX idx_property_location ON Property(location);

-- Index for price-based searches
CREATE INDEX idx_property_price ON Property(price_per_night);

-- Compound index for location and price searches
CREATE INDEX idx_property_location_price ON Property(location, price_per_night);

-- =====================================================
-- Table: Booking
-- Purpose: Stores booking/reservation information
-- =====================================================

CREATE TABLE Booking (
    booking_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL CHECK (total_price > 0),
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Check constraint to ensure end_date is after start_date
    CHECK (end_date > start_date),
    
    -- Foreign key constraints
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

-- Index for property-based queries
CREATE INDEX idx_booking_property ON Booking(property_id);

-- Index for user-based queries
CREATE INDEX idx_booking_user ON Booking(user_id);

-- Index for date-based queries
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);

-- Index for status-based queries
CREATE INDEX idx_booking_status ON Booking(status);

-- Compound index for property availability checks
CREATE INDEX idx_booking_property_dates ON Booking(property_id, start_date, end_date);

-- =====================================================
-- Table: Payment
-- Purpose: Stores payment information for bookings
-- =====================================================

CREATE TABLE Payment (
    payment_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    booking_id CHAR(36) UNIQUE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL CHECK (amount > 0),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    
    -- Foreign key constraint
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE
);

-- Index for booking-based queries
CREATE INDEX idx_payment_booking ON Payment(booking_id);

-- Index for payment method analysis
CREATE INDEX idx_payment_method ON Payment(payment_method);

-- Index for payment date queries
CREATE INDEX idx_payment_date ON Payment(payment_date);

-- =====================================================
-- Table: Review
-- Purpose: Stores property reviews and ratings
-- =====================================================

CREATE TABLE Review (
    review_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    
    -- Unique constraint to prevent multiple reviews from same user for same property
    UNIQUE KEY unique_user_property_review (user_id, property_id)
);

-- Index for property-based queries
CREATE INDEX idx_review_property ON Review(property_id);

-- Index for user-based queries
CREATE INDEX idx_review_user ON Review(user_id);

-- Index for rating-based queries
CREATE INDEX idx_review_rating ON Review(rating);

-- Index for date-based queries
CREATE INDEX idx_review_date ON Review(created_at);

-- =====================================================
-- Table: Message
-- Purpose: Stores messages between users
-- =====================================================

CREATE TABLE Message (
    message_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    sender_id CHAR(36) NOT NULL,
    recipient_id CHAR(36) NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Check constraint to ensure sender and recipient are different
    CHECK (sender_id != recipient_id),
    
    -- Foreign key constraints
    FOREIGN KEY (sender_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES User(user_id) ON DELETE CASCADE
);

-- Index for sender-based queries
CREATE INDEX idx_message_sender ON Message(sender_id);

-- Index for recipient-based queries
CREATE INDEX idx_message_recipient ON Message(recipient_id);

-- Index for date-based queries
CREATE INDEX idx_message_date ON Message(sent_at);

-- Compound index for conversation queries
CREATE INDEX idx_message_conversation ON Message(sender_id, recipient_id, sent_at);

-- =====================================================
-- Additional Performance Indexes
-- =====================================================

-- Full-text search index for property descriptions (MySQL specific)
-- ALTER TABLE Property ADD FULLTEXT(name, description);

-- Composite index for complex booking queries
CREATE INDEX idx_booking_complex ON Booking(property_id, status, start_date);

-- Index for property ratings calculation
CREATE INDEX idx_review_property_rating ON Review(property_id, rating);

-- =====================================================
-- Views for Common Queries
-- =====================================================

-- View: Property with Host Information
CREATE VIEW PropertyWithHost AS
SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.price_per_night,
    u.first_name AS host_first_name,
    u.last_name AS host_last_name,
    u.email AS host_email,
    p.created_at
FROM Property p
JOIN User u ON p.host_id = u.user_id
WHERE u.role = 'host';

-- View: Booking Summary
CREATE VIEW BookingSummary AS
SELECT 
    b.booking_id,
    p.name AS property_name,
    p.location,
    CONCAT(u.first_name, ' ', u.last_name) AS guest_name,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    pay.payment_method
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
JOIN User u ON b.user_id = u.user_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id;

-- View: Property Rating Summary
CREATE VIEW PropertyRatings AS
SELECT 
    p.property_id,
    p.name,
    COUNT(r.review_id) AS total_reviews,
    AVG(r.rating) AS average_rating,
    MIN(r.rating) AS min_rating,
    MAX(r.rating) AS max_rating
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name;

-- =====================================================
-- Triggers for Data Integrity
-- =====================================================

-- Trigger to validate that host_id in Property table has 'host' role
DELIMITER //
CREATE TRIGGER tr_property_host_validation
    BEFORE INSERT ON Property
    FOR EACH ROW
BEGIN
    DECLARE user_role ENUM('guest', 'host', 'admin');
    
    SELECT role INTO user_role 
    FROM User 
    WHERE user_id = NEW.host_id;
    
    IF user_role != 'host' AND user_role != 'admin' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Property host must have host or admin role';
    END IF;
END//
DELIMITER ;

-- Trigger to prevent booking conflicts (overlapping dates for same property)
DELIMITER //
CREATE TRIGGER tr_booking_conflict_check
    BEFORE INSERT ON Booking
    FOR EACH ROW
BEGIN
    DECLARE conflict_count INT DEFAULT 0;
    
    SELECT COUNT(*) INTO conflict_count
    FROM Booking
    WHERE property_id = NEW.property_id
      AND status IN ('pending', 'confirmed')
      AND (
          (NEW.start_date BETWEEN start_date AND end_date)
          OR (NEW.end_date BETWEEN start_date AND end_date)
          OR (start_date BETWEEN NEW.start_date AND NEW.end_date)
      );
    
    IF conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Booking dates conflict with existing booking';
    END IF;
END//
DELIMITER ;

-- Trigger to validate payment amount matches booking total
DELIMITER //
CREATE TRIGGER tr_payment_amount_validation
    BEFORE INSERT ON Payment
    FOR EACH ROW
BEGIN
    DECLARE booking_total DECIMAL(10,2);
    
    SELECT total_price INTO booking_total
    FROM Booking
    WHERE booking_id = NEW.booking_id;
    
    IF NEW.amount != booking_total THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Payment amount must match booking total price';
    END IF;
END//
DELIMITER ;

-- =====================================================
-- Stored Procedures for Common Operations
-- =====================================================

-- Procedure to calculate property availability
DELIMITER //
CREATE PROCEDURE CheckPropertyAvailability(
    IN prop_id CHAR(36),
    IN check_start_date DATE,
    IN check_end_date DATE,
    OUT is_available BOOLEAN
)
BEGIN
    DECLARE conflict_count INT DEFAULT 0;
    
    SELECT COUNT(*) INTO conflict_count
    FROM Booking
    WHERE property_id = prop_id
      AND status IN ('pending', 'confirmed')
      AND (
          (check_start_date BETWEEN start_date AND end_date)
          OR (check_end_date BETWEEN start_date AND end_date)
          OR (start_date BETWEEN check_start_date AND check_end_date)
      );
    
    SET is_available = (conflict_count = 0);
END//
DELIMITER ;

-- =====================================================
-- Functions for Business Logic
-- =====================================================

-- Function to calculate booking duration in days
DELIMITER //
CREATE FUNCTION CalculateBookingDays(start_date DATE, end_date DATE)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    RETURN DATEDIFF(end_date, start_date);
END//
DELIMITER ;

-- =====================================================
-- Security and Permissions
-- =====================================================

-- Create database users (uncomment and modify as needed)
-- CREATE USER 'airbnb_app'@'localhost' IDENTIFIED BY 'secure_password';
-- GRANT SELECT, INSERT, UPDATE, DELETE ON airbnb_db.* TO 'airbnb_app'@'localhost';

-- CREATE USER 'airbnb_readonly'@'localhost' IDENTIFIED BY 'readonly_password';
-- GRANT SELECT ON airbnb_db.* TO 'airbnb_readonly'@'localhost';

-- FLUSH PRIVILEGES;

-- =====================================================
-- Schema Creation Complete
-- =====================================================

-- Display success message
SELECT 'Airbnb Database Schema Created Successfully!' AS Status;