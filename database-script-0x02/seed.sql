-- =====================================================
-- Airbnb Database Sample Data (DML Script)
-- =====================================================
-- This script populates the Airbnb database with realistic sample data
-- for testing and development purposes.
-- 
-- Author: ALX Student
-- Date: 2025-10-01
-- Version: 1.0
-- =====================================================

-- Disable foreign key checks temporarily for easier insertion
SET FOREIGN_KEY_CHECKS = 0;

-- Clear existing data (use with caution in production)
-- TRUNCATE TABLE Message;
-- TRUNCATE TABLE Review;
-- TRUNCATE TABLE Payment;
-- TRUNCATE TABLE Booking;
-- TRUNCATE TABLE Property;
-- TRUNCATE TABLE User;

-- =====================================================
-- Insert Sample Users
-- =====================================================

INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
-- Hosts
('550e8400-e29b-41d4-a716-446655440001', 'Alice', 'Johnson', 'alice.johnson@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeVMuS4KCvOkL1k2y', '+1-555-0101', 'host', '2024-01-15 08:30:00'),
('550e8400-e29b-41d4-a716-446655440002', 'Michael', 'Chen', 'michael.chen@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeVMuS4KCvOkL1k2y', '+1-555-0102', 'host', '2024-01-20 10:15:00'),
('550e8400-e29b-41d4-a716-446655440003', 'Sarah', 'Williams', 'sarah.williams@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeVMuS4KCvOkL1k2y', '+1-555-0103', 'host', '2024-02-01 14:20:00'),
('550e8400-e29b-41d4-a716-446655440004', 'David', 'Brown', 'david.brown@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeVMuS4KCvOkL1k2y', '+1-555-0104', 'host', '2024-02-10 09:45:00'),
('550e8400-e29b-41d4-a716-446655440005', 'Emma', 'Davis', 'emma.davis@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeVMuS4KCvOkL1k2y', '+1-555-0105', 'host', '2024-02-15 16:30:00'),

-- Guests
('550e8400-e29b-41d4-a716-446655440006', 'John', 'Smith', 'john.smith@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeVMuS4KCvOkL1k2y', '+1-555-0106', 'guest', '2024-03-01 11:00:00'),
('550e8400-e29b-41d4-a716-446655440007', 'Emily', 'Taylor', 'emily.taylor@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeVMuS4KCvOkL1k2y', '+1-555-0107', 'guest', '2024-03-05 13:15:00'),
('550e8400-e29b-41d4-a716-446655440008', 'Robert', 'Anderson', 'robert.anderson@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeVMuS4KCvOkL1k2y', '+1-555-0108', 'guest', '2024-03-10 15:45:00'),
('550e8400-e29b-41d4-a716-446655440009', 'Lisa', 'Wilson', 'lisa.wilson@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeVMuS4KCvOkL1k2y', '+1-555-0109', 'guest', '2024-03-15 12:30:00'),
('550e8400-e29b-41d4-a716-446655440010', 'James', 'Moore', 'james.moore@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeVMuS4KCvOkL1k2y', '+1-555-0110', 'guest', '2024-03-20 14:00:00'),
('550e8400-e29b-41d4-a716-446655440011', 'Jessica', 'Garcia', 'jessica.garcia@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeVMuS4KCvOkL1k2y', '+1-555-0111', 'guest', '2024-03-25 16:20:00'),
('550e8400-e29b-41d4-a716-446655440012', 'Mark', 'Martinez', 'mark.martinez@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeVMuS4KCvOkL1k2y', '+1-555-0112', 'guest', '2024-04-01 10:10:00'),

-- Admin
('550e8400-e29b-41d4-a716-446655440013', 'Admin', 'User', 'admin@airbnb.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LeVMuS4KCvOkL1k2y', '+1-555-0113', 'admin', '2024-01-01 00:00:00');

-- =====================================================
-- Insert Sample Properties
-- =====================================================

INSERT INTO Property (property_id, host_id, name, description, location, price_per_night, created_at, updated_at) VALUES
-- Alice's Properties
('650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 'Cozy Downtown Apartment', 'A beautiful 2-bedroom apartment in the heart of downtown with modern amenities and stunning city views. Perfect for business travelers and couples.', 'New York, NY, USA', 125.00, '2024-01-16 09:00:00', '2024-01-16 09:00:00'),
('650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 'Luxury Penthouse Suite', 'Exclusive penthouse with panoramic city views, private terrace, and premium furnishings. Ideal for special occasions and luxury stays.', 'New York, NY, USA', 350.00, '2024-01-18 11:30:00', '2024-01-18 11:30:00'),

-- Michael's Properties
('650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440002', 'Beachfront Villa', 'Stunning 4-bedroom villa directly on the beach with private access, pool, and breathtaking ocean views. Perfect for families and groups.', 'Malibu, CA, USA', 450.00, '2024-01-22 14:15:00', '2024-01-22 14:15:00'),
('650e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440002', 'Modern City Loft', 'Industrial-style loft in trendy neighborhood with exposed brick walls, high ceilings, and designer furniture. Great for creative professionals.', 'San Francisco, CA, USA', 200.00, '2024-01-25 16:45:00', '2024-01-25 16:45:00'),

-- Sarah's Properties
('650e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440003', 'Mountain Cabin Retreat', 'Rustic log cabin nestled in the mountains with fireplace, hot tub, and hiking trails nearby. Perfect for nature lovers and romantic getaways.', 'Aspen, CO, USA', 275.00, '2024-02-03 10:20:00', '2024-02-03 10:20:00'),
('650e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440003', 'Historic Brownstone', 'Charming 3-bedroom brownstone in historic district with original features, modern updates, and private garden. Rich in character and history.', 'Boston, MA, USA', 180.00, '2024-02-05 12:00:00', '2024-02-05 12:00:00'),

-- David's Properties
('650e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440004', 'Lakeside Cottage', 'Peaceful 2-bedroom cottage on pristine lake with dock, kayaks, and fishing equipment. Ideal for relaxation and water activities.', 'Lake Tahoe, CA, USA', 220.00, '2024-02-12 13:30:00', '2024-02-12 13:30:00'),
('650e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440004', 'Urban Studio Apartment', 'Compact but well-designed studio in vibrant neighborhood with easy access to restaurants, shopping, and public transportation.', 'Chicago, IL, USA', 95.00, '2024-02-14 15:00:00', '2024-02-14 15:00:00'),

-- Emma's Properties
('650e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440005', 'Wine Country Estate', 'Elegant 5-bedroom estate in renowned wine region with vineyard views, wine cellar, and gourmet kitchen. Perfect for wine enthusiasts.', 'Napa Valley, CA, USA', 500.00, '2024-02-17 11:15:00', '2024-02-17 11:15:00'),
('650e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440005', 'Tropical Beach House', 'Stunning beachfront house with multiple bedrooms, private beach access, and tropical gardens. Paradise for beach lovers and groups.', 'Key West, FL, USA', 380.00, '2024-02-20 14:45:00', '2024-02-20 14:45:00');

-- =====================================================
-- Insert Sample Bookings
-- =====================================================

INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
-- Past Bookings (Confirmed)
('750e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', '2024-04-01', '2024-04-05', 500.00, 'confirmed', '2024-03-25 10:30:00'),
('750e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440007', '2024-04-10', '2024-04-15', 2250.00, 'confirmed', '2024-03-30 14:20:00'),
('750e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440008', '2024-04-20', '2024-04-23', 825.00, 'confirmed', '2024-04-10 16:45:00'),
('750e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440009', '2024-05-01', '2024-05-04', 660.00, 'confirmed', '2024-04-20 12:15:00'),
('750e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440010', '2024-05-15', '2024-05-17', 700.00, 'confirmed', '2024-05-05 09:30:00'),

-- Current/Future Bookings (Confirmed)
('750e8400-e29b-41d4-a716-446655440006', '650e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440011', '2024-11-01', '2024-11-05', 2000.00, 'confirmed', '2024-09-15 11:00:00'),
('750e8400-e29b-41d4-a716-446655440007', '650e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440012', '2024-11-10', '2024-11-13', 600.00, 'confirmed', '2024-09-20 13:45:00'),
('750e8400-e29b-41d4-a716-446655440008', '650e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440006', '2024-12-01', '2024-12-05', 720.00, 'confirmed', '2024-10-01 15:20:00'),

-- Pending Bookings
('750e8400-e29b-41d4-a716-446655440009', '650e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440007', '2024-11-20', '2024-11-22', 190.00, 'pending', '2024-10-01 08:00:00'),
('750e8400-e29b-41d4-a716-446655440010', '650e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440008', '2024-12-15', '2024-12-20', 1900.00, 'pending', '2024-10-01 14:30:00'),

-- Canceled Bookings
('750e8400-e29b-41d4-a716-446655440011', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440009', '2024-06-01', '2024-06-03', 250.00, 'canceled', '2024-05-20 10:00:00'),
('750e8400-e29b-41d4-a716-446655440012', '650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440010', '2024-07-15', '2024-07-20', 2250.00, 'canceled', '2024-06-30 16:15:00');

-- =====================================================
-- Insert Sample Payments
-- =====================================================

INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
-- Payments for confirmed bookings only
('850e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440001', 500.00, '2024-03-25 10:35:00', 'credit_card'),
('850e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440002', 2250.00, '2024-03-30 14:25:00', 'stripe'),
('850e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440003', 825.00, '2024-04-10 16:50:00', 'paypal'),
('850e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440004', 660.00, '2024-04-20 12:20:00', 'credit_card'),
('850e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440005', 700.00, '2024-05-05 09:35:00', 'stripe'),
('850e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440006', 2000.00, '2024-09-15 11:05:00', 'credit_card'),
('850e8400-e29b-41d4-a716-446655440007', '750e8400-e29b-41d4-a716-446655440007', 600.00, '2024-09-20 13:50:00', 'paypal'),
('850e8400-e29b-41d4-a716-446655440008', '750e8400-e29b-41d4-a716-446655440008', 720.00, '2024-10-01 15:25:00', 'stripe');

-- =====================================================
-- Insert Sample Reviews
-- =====================================================

INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
-- Reviews for completed bookings
('950e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', 5, 'Absolutely wonderful apartment! The location was perfect, right in the heart of downtown with easy access to everything. Alice was a fantastic host, very responsive and helpful. The apartment was exactly as described and spotlessly clean. Would definitely stay again!', '2024-04-06 10:30:00'),

('950e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440007', 5, 'This beachfront villa exceeded all expectations! The views were breathtaking, and having private beach access was incredible. The house was spacious, beautifully decorated, and had everything we needed for our family vacation. Michael was an excellent host. Highly recommended!', '2024-04-16 14:20:00'),

('950e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440008', 4, 'Beautiful mountain retreat! The cabin was cozy and had all the amenities we needed. The hot tub was a nice touch after hiking all day. The location is perfect for nature lovers. Only minor issue was WiFi connectivity, but we came to disconnect anyway. Sarah was very accommodating.', '2024-04-24 16:45:00'),

('950e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440009', 5, 'Perfect lakeside getaway! The cottage was charming and the lake access was amazing. We spent our days kayaking and fishing. The property was well-maintained and David provided excellent recommendations for local activities. Will definitely return!', '2024-05-05 12:15:00'),

('950e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440010', 4, 'Luxury penthouse with stunning views! The apartment was beautifully furnished and the terrace was perfect for evening drinks. Location was excellent for exploring the city. Only downside was some noise from the street at night, but the amazing views made up for it.', '2024-05-18 09:30:00'),

-- Additional reviews from other users
('950e8400-e29b-41d4-a716-446655440006', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440007', 4, 'Great downtown location with modern amenities. The apartment was clean and comfortable. Alice was responsive and provided helpful local tips. Would recommend for business travelers.', '2024-06-15 11:00:00'),

('950e8400-e29b-41d4-a716-446655440007', '650e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440008', 5, 'Amazing loft in a vibrant neighborhood! The space was stylish and perfect for our creative team retreat. Great restaurants and cafes within walking distance. Michael was a wonderful host.', '2024-07-20 13:45:00'),

('950e8400-e29b-41d4-a716-446655440008', '650e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440009', 3, 'Nice historic property with character. The brownstone was well-located and had interesting architectural features. However, some areas could use updating and the heating was inconsistent. Sarah was helpful with local recommendations.', '2024-08-10 15:20:00'),

('950e8400-e29b-41d4-a716-446655440009', '650e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440010', 4, 'Convenient urban studio in a great location. Perfect for a solo business trip. The space was efficiently designed and had everything needed for a short stay. Easy access to public transportation.', '2024-09-05 08:00:00'),

('950e8400-e29b-41d4-a716-446655440010', '650e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440006', 5, 'Incredible wine country experience! The estate was absolutely gorgeous with stunning vineyard views. The wine cellar tour was a highlight. Emma was an exceptional host who arranged special wine tastings. Perfect for a romantic getaway!', '2024-09-25 14:30:00');

-- =====================================================
-- Insert Sample Messages
-- =====================================================

INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
-- Conversation between guest and host before booking
('a50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', 'Hi Alice! I am interested in booking your downtown apartment for April 1-5. Is it still available? Also, could you tell me more about parking options in the area?', '2024-03-24 14:30:00'),

('a50e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', 'Hello John! Yes, the apartment is available for those dates. There is street parking available, and I can also provide information about nearby parking garages. The apartment is perfectly located for exploring downtown on foot. Would you like to proceed with the booking?', '2024-03-24 15:45:00'),

('a50e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', 'That sounds perfect! Yes, I would like to book it. Is there anything specific I should know about check-in procedures?', '2024-03-24 16:15:00'),

('a50e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', 'Wonderful! I will send you detailed check-in instructions 24 hours before your arrival. The building has a doorman who will assist you. Looking forward to hosting you!', '2024-03-24 16:30:00'),

-- Conversation about special requests
('a50e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440002', 'Hi Michael! We are very excited about our stay at your beachfront villa. We are celebrating our anniversary - do you have any recommendations for romantic restaurants nearby?', '2024-04-08 10:20:00'),

('a50e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440007', 'Congratulations on your anniversary! I have several excellent recommendations. There is a fantastic seafood restaurant right on the pier with sunset views, and a cozy Italian place in town. I will email you a detailed list with reservations contacts. Have a wonderful celebration!', '2024-04-08 12:15:00'),

-- Follow-up conversation after stay
('a50e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', 'Hi Sarah! Thank you for a wonderful stay at your mountain cabin. We had an amazing time hiking and relaxing. The hot tub was perfect after long days on the trails. We left a small gift on the kitchen counter as a thank you.', '2024-04-24 11:00:00'),

('a50e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440008', 'Thank you so much, Robert! It was a pleasure hosting you. I am so glad you enjoyed the hiking trails and found the cabin relaxing. The gift was very thoughtful! You are welcome back anytime. I hope you will consider staying again in the future.', '2024-04-24 14:30:00'),

-- Inquiry about future booking
('a50e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440005', 'Hello Emma! I am planning a wine tasting trip for next November and your estate looks perfect. Would November 1-5 work? Also, do you offer any wine tasting experiences on the property?', '2024-09-10 09:15:00'),

('a50e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440011', 'Hi Jessica! Those dates are available and would be perfect for wine season. Yes, I can arrange private wine tastings with local vintners, and we have a beautiful wine cellar on the property. I can also recommend the best wineries to visit in the area. Shall I hold those dates for you?', '2024-09-10 11:45:00'),

-- Property inquiry with questions
('a50e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440004', 'Hi David! I am interested in your lakeside cottage for a fishing trip. Does the property include fishing equipment and boat access? Also, are there good fishing spots directly from the dock?', '2024-10-01 13:20:00'),

('a50e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440012', 'Hello Mark! Yes, the cottage includes fishing rods, tackle box, and basic equipment. The dock is perfect for fishing, and there are excellent spots for trout and bass. I can also recommend a local guide if you are interested in deep water fishing. When were you thinking of visiting?', '2024-10-01 15:10:00');

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================
-- Data Verification Queries
-- =====================================================

-- Count records in each table
SELECT 'Users' as Table_Name, COUNT(*) as Record_Count FROM User
UNION ALL
SELECT 'Properties', COUNT(*) FROM Property
UNION ALL
SELECT 'Bookings', COUNT(*) FROM Booking
UNION ALL
SELECT 'Payments', COUNT(*) FROM Payment
UNION ALL
SELECT 'Reviews', COUNT(*) FROM Review
UNION ALL
SELECT 'Messages', COUNT(*) FROM Message;

-- Show sample data from each table
SELECT '=== SAMPLE USERS ===' as Info;
SELECT user_id, first_name, last_name, email, role, created_at FROM User LIMIT 5;

SELECT '=== SAMPLE PROPERTIES ===' as Info;
SELECT property_id, name, location, price_per_night, host_id FROM Property LIMIT 5;

SELECT '=== SAMPLE BOOKINGS ===' as Info;
SELECT booking_id, property_id, user_id, start_date, end_date, total_price, status FROM Booking LIMIT 5;

SELECT '=== SAMPLE PAYMENTS ===' as Info;
SELECT payment_id, booking_id, amount, payment_method, payment_date FROM Payment LIMIT 5;

SELECT '=== SAMPLE REVIEWS ===' as Info;
SELECT review_id, property_id, rating, SUBSTRING(comment, 1, 50) as comment_preview FROM Review LIMIT 5;

SELECT '=== SAMPLE MESSAGES ===' as Info;
SELECT message_id, sender_id, recipient_id, SUBSTRING(message_body, 1, 50) as message_preview FROM Message LIMIT 5;

-- =====================================================
-- Business Intelligence Queries
-- =====================================================

-- Average property ratings
SELECT '=== PROPERTY RATINGS SUMMARY ===' as Info;
SELECT 
    p.name,
    p.location,
    ROUND(AVG(r.rating), 2) as avg_rating,
    COUNT(r.review_id) as total_reviews
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name, p.location
ORDER BY avg_rating DESC;

-- Booking statistics by status
SELECT '=== BOOKING STATISTICS ===' as Info;
SELECT 
    status,
    COUNT(*) as booking_count,
    ROUND(SUM(total_price), 2) as total_revenue
FROM Booking
GROUP BY status;

-- Host revenue summary
SELECT '=== HOST REVENUE SUMMARY ===' as Info;
SELECT 
    CONCAT(u.first_name, ' ', u.last_name) as host_name,
    COUNT(DISTINCT p.property_id) as properties_count,
    COUNT(b.booking_id) as total_bookings,
    ROUND(SUM(CASE WHEN b.status = 'confirmed' THEN b.total_price ELSE 0 END), 2) as confirmed_revenue
FROM User u
JOIN Property p ON u.user_id = p.host_id
LEFT JOIN Booking b ON p.property_id = b.property_id
WHERE u.role = 'host'
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY confirmed_revenue DESC;

-- Popular destinations
SELECT '=== POPULAR DESTINATIONS ===' as Info;
SELECT 
    location,
    COUNT(b.booking_id) as total_bookings,
    ROUND(AVG(p.price_per_night), 2) as avg_price_per_night
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
GROUP BY location
ORDER BY total_bookings DESC;

SELECT 'Sample data insertion completed successfully!' as Status;