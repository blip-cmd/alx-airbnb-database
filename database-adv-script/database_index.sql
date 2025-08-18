-- Create indexes for optimization
-- Users table: id (PK), email (often searched), name (sometimes filtered)
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_name ON users(name);

-- Bookings table: user_id (JOIN), property_id (JOIN), created_at (ORDER BY)
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_created_at ON bookings(created_at);

CREATE INDEX idx_properties_owner_id ON properties(owner_id);
CREATE INDEX idx_properties_city ON properties(city);


-- Example: Measure query performance before and after adding indexes
-- Before adding indexes:
-- EXPLAIN ANALYZE SELECT * FROM bookings WHERE user_id = 123;

-- After adding indexes:
-- EXPLAIN ANALYZE SELECT * FROM bookings WHERE user_id = 123;
