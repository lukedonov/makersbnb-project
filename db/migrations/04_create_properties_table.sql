
CREATE TABLE properties(id SERIAL PRIMARY KEY, name VARCHAR(80), cpn NUMERIC, description VARCHAR(2000), user_id INTEGER REFERENCES users (id));