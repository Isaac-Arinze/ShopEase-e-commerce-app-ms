package com.zikan.ecommerce;

import org.flywaydb.core.Flyway;

public class FlywayRepair {
    public static void main(String[] args) {
        Flyway flyway = Flyway.configure()
                .dataSource("jdbc:postgresql://localhost:5432/product", "postgres", "Anawana@19")
                .load();
        flyway.repair();
    }
}
