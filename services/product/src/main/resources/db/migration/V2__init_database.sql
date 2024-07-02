-- CREATE TABLE IF NOT EXISTS category (
--                                         id INTEGER NOT NULL PRIMARY KEY,
--                                         description VARCHAR(255),
--                                         name VARCHAR(255)
-- );
--
-- CREATE TABLE IF NOT EXISTS product (
--                                        id INTEGER NOT NULL PRIMARY KEY,
--                                        name VARCHAR(255),
--                                        description VARCHAR(255),
--                                        available_quantity DOUBLE PRECISION NOT NULL,
--                                        price NUMERIC(38,2),
--                                        category_id INTEGER,
--                                        CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES category (id)
-- );
--
-- CREATE SEQUENCE IF NOT EXISTS category_seq INCREMENT BY 50;
-- CREATE SEQUENCE IF NOT EXISTS product_seq INCREMENT BY 50;


CREATE TABLE IF NOT EXISTS category (
                                        id INTEGER NOT NULL PRIMARY KEY,
                                        description VARCHAR(255),
                                        name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS category (
                                        id INTEGER NOT NULL PRIMARY KEY,
                                        description VARCHAR(255),
                                        name VARCHAR(255)
);
CREATE SEQUENCE IF NOT EXISTS category_seq INCREMENT BY 50;
CREATE SEQUENCE IF NOT EXISTS product_seq INCREMENT BY 50;

INSERT INTO category (id, description, name) VALUES (nextval('category_seq'), 'Computer Keyboards', 'Keyboards');
INSERT INTO category (id, description, name) VALUES (nextval('category_seq'), 'Computer Monitors', 'Monitors');
INSERT INTO category (id, description, name) VALUES (nextval('category_seq'), 'Display Screens', 'Screens');
INSERT INTO category (id, description, name) VALUES (nextval('category_seq'), 'Computer Mice', 'Mice');
INSERT INTO category (id, description, name) VALUES (nextval('category_seq'), 'Computer Accessories', 'Accessories');

INSERT INTO public.product (id, available_quantity, description, name, price, category_id)
VALUES
    (nextval('product_seq'), 10, 'Mechanical keyboard with RGB lighting', 'Mechanical Keyboard 1', 99.99, (SELECT id FROM category WHERE name = 'Keyboards')),
    (nextval('product_seq'), 15, 'Wireless compact keyboard', 'Wireless Compact Keyboard 1', 79.99, (SELECT id FROM category WHERE name = 'Keyboards')),
    (nextval('product_seq'), 20, 'Backlit gaming keyboard with customizable keys', 'Gaming Keyboard 1', 129.99, (SELECT id FROM category WHERE name = 'Keyboards')),
    (nextval('product_seq'), 25, 'Mechanical keyboard with wrist rest', 'Ergonomic Keyboard 1', 109.99, (SELECT id FROM category WHERE name = 'Keyboards')),
    (nextval('product_seq'), 18, 'Wireless keyboard and mouse combo', 'Wireless Combo 1', 69.99, (SELECT id FROM category WHERE name = 'Keyboards'));

INSERT INTO public.product (id, available_quantity, description, name, price, category_id)
VALUES
    (nextval('product_seq'), 30, '27-inch IPS monitor with 4K resolution', '4K Monitor 1', 399.99, (SELECT id FROM category WHERE name = 'Monitors')),
    (nextval('product_seq'), 25, 'Ultra-wide gaming monitor with HDR support', 'Ultra-wide Gaming Monitor 1', 499.99, (SELECT id FROM category WHERE name = 'Monitors')),
    (nextval('product_seq'), 22, '24-inch LED monitor for office use', 'Office Monitor 1', 179.99, (SELECT id FROM category WHERE name = 'Monitors')),
    (nextval('product_seq'), 28, '32-inch curved monitor with AMD FreeSync', 'Curved Monitor 1', 329.99, (SELECT id FROM category WHERE name = 'Monitors')),
    (nextval('product_seq'), 35, 'Portable USB-C monitor for laptops', 'Portable Monitor 1', 249.99, (SELECT id FROM category WHERE name = 'Monitors'));

INSERT INTO public.product (id, available_quantity, description, name, price, category_id)
VALUES
    (nextval('product_seq'), 15, 'Curved OLED gaming screen with 240Hz refresh rate', 'Curved OLED Gaming Screen 1', 799.99, (SELECT id FROM category WHERE name = 'Screens')),
    (nextval('product_seq'), 18, 'Flat QLED monitor with 1440p resolution', 'QLED Monitor 1', 599.99, (SELECT id FROM category WHERE name = 'Screens')),
    (nextval('product_seq'), 22, '27-inch touch screen display for creative work', 'Touch Screen Display 1', 699.99, (SELECT id FROM category WHERE name = 'Screens')),
    (nextval('product_seq'), 20, 'Ultra-slim 4K HDR display for multimedia', 'Ultra-slim 4K HDR Display 1', 449.99, (SELECT id FROM category WHERE name = 'Screens')),
    (nextval('product_seq'), 25, 'Gaming projector with low input lag', 'Gaming Projector 1', 899.99, (SELECT id FROM category WHERE name = 'Screens'));

INSERT INTO public.product (id, available_quantity, description, name, price, category_id)
VALUES
    (nextval('product_seq'), 25, 'Adjustable laptop stand with cooling fan', 'Adjustable Laptop Stand 1', 34.99, (SELECT id FROM category WHERE name = 'Accessories')),
    (nextval('product_seq'), 20, 'Wireless charging pad for smartphones', 'Wireless Charging Pad 1', 24.99, (SELECT id FROM category WHERE name = 'Accessories')),
    (nextval('product_seq'), 28, 'Gaming headset stand with RGB lighting', 'RGB Headset Stand 1', 49.99, (SELECT id FROM category WHERE name = 'Accessories')),
    (nextval('product_seq'), 22, 'Bluetooth mechanical keypad for tablets', 'Bluetooth Keypad 1', 39.99, (SELECT id FROM category WHERE name = 'Accessories')),
    (nextval('product_seq'), 30, 'External hard drive enclosure with USB-C', 'External Hard Drive Enclosure 1', 29.99, (SELECT id FROM category WHERE name = 'Accessories'));
