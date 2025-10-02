-- =====================================================
-- Database Indexes for Optimization
-- =====================================================
-- This file contains CREATE INDEX commands for optimizing query performance
-- Based on high-usage columns in User, Booking, and Property tables
-- Author: ALX Student
-- Date: 2025-10-01
-- =====================================================

-- =====================================================
-- User Table Indexes
-- =====================================================

-- Email index for authentication and lookup queries
-- Already exists in schema but recreating for demonstration
-- CREATE INDEX idx_user_email ON User(email);

-- Role index for role-based queries
-- CREATE INDEX idx_user_role ON User(role);

-- Composite index for name searches
CREATE INDEX idx_user_full_name ON User(first_name, last_name);

-- Phone number index for contact lookup
CREATE INDEX idx_user_phone ON User(phone_number);

-- Created date index for user registration analysis
CREATE INDEX idx_user_created_at ON User(created_at);

-- =====================================================
-- Property Table Indexes
-- =====================================================

-- Host ID index for host-related queries
-- Already exists in schema
-- CREATE INDEX idx_property_host ON Property(host_id);

-- Location index for location-based searches
-- Already exists in schema
-- CREATE INDEX idx_property_location ON Property(location);

-- Price index for price-based filtering
-- Already exists in schema
-- CREATE INDEX idx_property_price ON Property(price_per_night);

-- Composite index for location and price searches
-- Already exists in schema
-- CREATE INDEX idx_property_location_price ON Property(location, price_per_night);

-- Property name index for text searches
CREATE INDEX idx_property_name ON Property(name);

-- Updated date index for recent listings
CREATE INDEX idx_property_updated_at ON Property(updated_at);

-- =====================================================
-- Booking Table Indexes
-- =====================================================

-- Property ID index for property-related queries
-- Already exists in schema
-- CREATE INDEX idx_booking_property ON Booking(property_id);

-- User ID index for user booking history
-- Already exists in schema
-- CREATE INDEX idx_booking_user ON Booking(user_id);

-- Date range index for availability checks
-- Already exists in schema
-- CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);

-- Status index for booking status queries
-- Already exists in schema
-- CREATE INDEX idx_booking_status ON Booking(status);

-- Total price index for revenue analysis
CREATE INDEX idx_booking_total_price ON Booking(total_price);

-- Created date index for booking trends
CREATE INDEX idx_booking_created_at ON Booking(created_at);

-- Composite index for user and date-based queries
CREATE INDEX idx_booking_user_dates ON Booking(user_id, start_date, end_date);

-- =====================================================
-- Payment Table Indexes
-- =====================================================

-- Booking ID index for payment lookup
-- Already exists in schema
-- CREATE INDEX idx_payment_booking ON Payment(booking_id);

-- Payment method index for payment analysis
-- Already exists in schema
-- CREATE INDEX idx_payment_method ON Payment(payment_method);

-- Payment date index for financial reporting
-- Already exists in schema
-- CREATE INDEX idx_payment_date ON Payment(payment_date);

-- Amount index for payment value analysis
CREATE INDEX idx_payment_amount ON Payment(amount);

-- Composite index for payment method and date
CREATE INDEX idx_payment_method_date ON Payment(payment_method, payment_date);

-- =====================================================
-- Review Table Indexes
-- =====================================================

-- Property ID index for property reviews
-- Already exists in schema
-- CREATE INDEX idx_review_property ON Review(property_id);

-- User ID index for user review history
-- Already exists in schema
-- CREATE INDEX idx_review_user ON Review(user_id);

-- Rating index for rating-based queries
-- Already exists in schema
-- CREATE INDEX idx_review_rating ON Review(rating);

-- Created date index for recent reviews
-- Already exists in schema
-- CREATE INDEX idx_review_date ON Review(created_at);

-- Composite index for property and rating analysis
CREATE INDEX idx_review_property_rating ON Review(property_id, rating);

-- =====================================================
-- Message Table Indexes
-- =====================================================

-- Sender ID index for sent messages
-- Already exists in schema
-- CREATE INDEX idx_message_sender ON Message(sender_id);

-- Recipient ID index for received messages
-- Already exists in schema
-- CREATE INDEX idx_message_recipient ON Message(recipient_id);

-- Sent date index for message chronology
-- Already exists in schema
-- CREATE INDEX idx_message_date ON Message(sent_at);

-- Conversation index for message threads
-- Already exists in schema
-- CREATE INDEX idx_message_conversation ON Message(sender_id, recipient_id, sent_at);

-- =====================================================
-- Performance Testing Queries
-- =====================================================

-- Example queries to test index performance
-- Use EXPLAIN or EXPLAIN ANALYZE to measure performance

-- Test User email lookup
-- EXPLAIN ANALYZE SELECT * FROM User WHERE email = 'user@example.com';

-- Test Property location search
-- EXPLAIN ANALYZE SELECT * FROM Property WHERE location = 'New York' AND price_per_night BETWEEN 100 AND 200;

-- Test Booking date range query
-- EXPLAIN ANALYZE SELECT * FROM Booking WHERE start_date >= '2025-01-01' AND end_date <= '2025-01-31';

-- Test complex join query performance
-- EXPLAIN ANALYZE 
-- SELECT p.name, u.first_name, u.last_name, b.start_date, b.total_price
-- FROM Booking b
-- JOIN User u ON b.user_id = u.user_id
-- JOIN Property p ON b.property_id = p.property_id
-- WHERE b.start_date >= '2025-01-01' AND p.location = 'New York';

-- =====================================================
-- Index Maintenance Commands
-- =====================================================

-- Show index usage statistics (MySQL)
-- SELECT * FROM performance_schema.table_io_waits_summary_by_index_usage;

-- Analyze table to update index statistics
-- ANALYZE TABLE User, Property, Booking, Payment, Review, Message;
