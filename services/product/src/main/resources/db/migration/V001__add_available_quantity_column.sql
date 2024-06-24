DO $$
    BEGIN
        IF NOT EXISTS (
                SELECT 1 FROM information_schema.columns
                WHERE table_name = 'product' AND column_name = 'id'
            ) THEN
            ALTER TABLE product
                ADD COLUMN id SERIAL PRIMARY KEY,
                ADD COLUMN name VARCHAR(255),
                ADD COLUMN description VARCHAR(255),
                ADD COLUMN available_quantity DOUBLE PRECISION NOT NULL,
                ADD COLUMN category_id INTEGER,
                ADD CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES category (id);
        END IF;
    END $$;