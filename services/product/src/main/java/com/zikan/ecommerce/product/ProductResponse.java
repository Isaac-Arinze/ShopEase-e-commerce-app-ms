package com.zikan.ecommerce.product;

import java.math.BigDecimal;

public record ProductResponse(
        Integer id,
        String name,
        String description,
        double availableQuanntity,
        BigDecimal price,
        Integer categoryId,
        String categoryname,
        String categoryDescription
) {
}

