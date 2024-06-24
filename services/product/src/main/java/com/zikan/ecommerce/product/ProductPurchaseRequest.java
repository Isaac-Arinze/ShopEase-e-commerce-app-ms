package com.zikan.ecommerce.product;

import jakarta.validation.constraints.NotNull;

public record ProductPurchaseRequest(
        @NotNull(message = "Product Id manadatory")
        Integer productId,
        @NotNull(message = "Quantity Is mandatory ")
        double quantity
) {
}
