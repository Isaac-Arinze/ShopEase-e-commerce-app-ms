-- Create sequences
CREATE SEQUENCE IF NOT EXISTS category_seq INCREMENT BY 50;
CREATE SEQUENCE IF NOT EXISTS product_seq INCREMENT BY 50;
CREATE SEQUENCE IF NOT EXISTS customer_order_seq INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS order_line_seq INCREMENT BY 1;

-- Create tables
CREATE TABLE IF NOT EXISTS category (
                                        id INTEGER NOT NULL PRIMARY KEY,
                                        description VARCHAR(255),
                                        name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS product (
                                       id INTEGER NOT NULL PRIMARY KEY,
                                       name VARCHAR(255),
                                       description VARCHAR(255),
                                       available_quantity DOUBLE PRECISION NOT NULL,
                                       price NUMERIC(38,2),
                                       category_id INTEGER,
                                       CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES category (id)
);

CREATE TABLE IF NOT EXISTS customer_order (
                                              id INTEGER PRIMARY KEY DEFAULT nextval('customer_order_seq'),
                                              created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                              customer_id INTEGER NOT NULL,
                                              last_modified_date TIMESTAMP,
                                              payment_method VARCHAR(255),
                                              reference VARCHAR(255),
                                              total_amount DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS order_line (
                                          id INTEGER PRIMARY KEY DEFAULT nextval('order_line_seq'),
                                          order_id INTEGER NOT NULL,
                                          product_id INTEGER NOT NULL,
                                          quantity INTEGER NOT NULL,
                                          FOREIGN KEY (order_id) REFERENCES customer_order(id),
                                          FOREIGN KEY (product_id) REFERENCES product(id)
);

-- Insert data into tables
INSERT INTO category (id, description, name)
VALUES
    (nextval('category_seq'), 'Computer Keyboards', 'Keyboards'),
    (nextval('category_seq'), 'Computer Monitors', 'Monitors'),
    (nextval('category_seq'), 'Display Screens', 'Screens'),
    (nextval('category_seq'), 'Computer Mice', 'Mice'),
    (nextval('category_seq'), 'Computer Accessories', 'Accessories');

INSERT INTO product (id, available_quantity, description, name, price, category_id)
VALUES
    (nextval('product_seq'), 10, 'Mechanical keyboard with RGB lighting', 'Mechanical Keyboard 1', 99.99, (SELECT id FROM category WHERE name = 'Keyboards' LIMIT 1)),
    (nextval('product_seq'), 15, 'Wireless compact keyboard', 'Wireless Compact Keyboard 1', 79.99, (SELECT id FROM category WHERE name = 'Keyboards' LIMIT 1)),
    (nextval('product_seq'), 20, 'Backlit gaming keyboard with customizable keys', 'Gaming Keyboard 1', 129.99, (SELECT id FROM category WHERE name = 'Keyboards' LIMIT 1)),
    (nextval('product_seq'), 25, 'Mechanical keyboard with wrist rest', 'Ergonomic Keyboard 1', 109.99, (SELECT id FROM category WHERE name = 'Keyboards' LIMIT 1)),
    (nextval('product_seq'), 18, 'Wireless keyboard and mouse combo', 'Wireless Combo 1', 69.99, (SELECT id FROM category WHERE name = 'Keyboards' LIMIT 1)),
    (nextval('product_seq'), 30, '27-inch IPS monitor with 4K resolution', '4K Monitor 1', 399.99, (SELECT id FROM category WHERE name = 'Monitors' LIMIT 1)),
    (nextval('product_seq'), 25, 'Ultra-wide gaming monitor with HDR support', 'Ultra-wide Gaming Monitor 1', 499.99, (SELECT id FROM category WHERE name = 'Monitors' LIMIT 1)),
    (nextval('product_seq'), 22, '24-inch LED monitor for office use', 'Office Monitor 1', 179.99, (SELECT id FROM category WHERE name = 'Monitors' LIMIT 1)),
    (nextval('product_seq'), 28, '32-inch curved monitor with AMD FreeSync', 'Curved Monitor 1', 329.99, (SELECT id FROM category WHERE name = 'Monitors' LIMIT 1)),
    (nextval('product_seq'), 35, 'Portable USB-C monitor for laptops', 'Portable Monitor 1', 249.99, (SELECT id FROM category WHERE name = 'Monitors' LIMIT 1));

-- Sample data for customer_order and order_line tables
INSERT INTO customer_order (id, created_at, customer_id, last_modified_date, payment_method, reference, total_amount)
VALUES
    (nextval('customer_order_seq'), CURRENT_TIMESTAMP, 1, NULL, 'Credit Card', 'ORD-2024-001', 299.99),
    (nextval('customer_order_seq'), CURRENT_TIMESTAMP, 2, NULL, 'PayPal', 'ORD-2024-002', 419.99),
    (nextval('customer_order_seq'), CURRENT_TIMESTAMP, 3, NULL, 'Credit Card', 'ORD-2024-003', 229.99);

-- Sample data for order_line table
INSERT INTO order_line (order_id, product_id, quantity)
VALUES
    ((SELECT id FROM customer_order WHERE reference = 'ORD-2024-001' LIMIT 1), (SELECT id FROM product WHERE name = 'Mechanical Keyboard 1' LIMIT 1), 2),
    ((SELECT id FROM customer_order WHERE reference = 'ORD-2024-001' LIMIT 1), (SELECT id FROM product WHERE name = '4K Monitor 1' LIMIT 1), 1),
    ((SELECT id FROM customer_order WHERE reference = 'ORD-2024-002' LIMIT 1), (SELECT id FROM product WHERE name = 'Ultra-wide Gaming Monitor 1' LIMIT 1), 1),
    ((SELECT id FROM customer_order WHERE reference = 'ORD-2024-002' LIMIT 1), (SELECT id FROM product WHERE name = 'Gaming Keyboard 1' LIMIT 1), 3),
    ((SELECT id FROM customer_order WHERE reference = 'ORD-2024-003' LIMIT 1), (SELECT id FROM product WHERE name = 'Portable Monitor 1' LIMIT 1), 2);
