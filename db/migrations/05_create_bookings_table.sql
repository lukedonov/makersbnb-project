CREATE TABLE bookings
(
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users (id),
  property_id INTEGER REFERENCES properties (id),
  start_date TIMESTAMP,
  end_date TIMESTAMP,
  approval VARCHAR(10)
);