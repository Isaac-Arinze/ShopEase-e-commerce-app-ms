DO $$
    BEGIN
        IF NOT EXISTS (
                SELECT 1 FROM information_schema.columns
                WHERE table_name = 'product' AND column_name = 'available_quantity'
            ) THEN
            ALTER TABLE product
                ADD COLUMN available_quantity DOUBLE PRECISION NOT NULL;
        END IF;
    END $$;
