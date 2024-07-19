package com.zikan.ecommerce.order;

import com.fasterxml.jackson.annotation.JsonUnwrapped;
import com.zikan.ecommerce.customer.Address;
import com.zikan.ecommerce.product.PurchaseRequest;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.math.BigDecimal;
import java.util.List;

public record OrderRequest(
        Integer id,
        String reference,
        @Positive(message = "Order amount should be positive")
        BigDecimal amount,
        @NotNull(message = "Payment method should be specified")
        PaymentMethod paymentMethod,
        @NotBlank(message = "Customer ID should be present")
        String customerId,
        @NotEmpty(message = "At least one product should be purchased")
        List<PurchaseRequest> products,
//        @JsonUnwrapped
        Address address
) {
}
