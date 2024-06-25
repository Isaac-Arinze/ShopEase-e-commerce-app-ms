-- Insert data into the category table
INSERT INTO category (id, description, name) VALUES
                                                 (nextval('category_seq'), 'Electronics devices and gadgets', 'Electronics'),
                                                 (nextval('category_seq'), 'Books of various genres and subjects', 'Books'),
                                                 (nextval('category_seq'), 'Home and kitchen appliances', 'Home & Kitchen');

-- Insert data into the product table
INSERT INTO product (id, name, description, available_quantity, price, category_id) VALUES
                                                                                        (nextval('product_seq'), 'Smartphone', 'Latest model smartphone with advanced features', 50, 699.99, (SELECT id FROM category WHERE name = 'Electronics' LIMIT 1)),
                                                                                        (nextval('product_seq'), 'Laptop', 'High-performance laptop for gaming and work', 30, 1199.99, (SELECT id FROM category WHERE name = 'Electronics' LIMIT 1)),
                                                                                        (nextval('product_seq'), 'Fiction Book', 'Bestselling fiction novel', 100, 14.99, (SELECT id FROM category WHERE name = 'Books' LIMIT 1)),
                                                                                        (nextval('product_seq'), 'Non-fiction Book', 'Inspirational non-fiction book', 70, 19.99, (SELECT id FROM category WHERE name = 'Books' LIMIT 1)),
                                                                                        (nextval('product_seq'), 'Blender', 'Powerful kitchen blender for smoothies and soups', 40, 49.99, (SELECT id FROM category WHERE name = 'Home & Kitchen' LIMIT 1)),
                                                                                        (nextval('product_seq'), 'Microwave', 'Compact microwave oven with multiple settings', 25, 89.99, (SELECT id FROM category WHERE name = 'Home & Kitchen' LIMIT 1));
