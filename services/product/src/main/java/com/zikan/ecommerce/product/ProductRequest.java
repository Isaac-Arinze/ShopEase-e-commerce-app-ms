package com.zikan.ecommerce.product;

import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;

public record ProductRequest(
        Integer id,

        @NotNull (message = "Product name is required")
        String name,
        @NotNull (message = "Product Description is required")
        String description,
        @NotNull (message = "Product quantity should not be be greater than zero")
        double availableQuantity,
        @NotNull (message = "Price should be positive")
        BigDecimal price,

        @NotNull (message = "Price category is required")
        Integer categoryId
) {



}
