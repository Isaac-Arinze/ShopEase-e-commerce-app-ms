package com.zikan.ecommerce.kafka;

import com.zikan.ecommerce.order.PaymentMethod;
import com.zikan.ecommerce.customer.CustomerResponse;
import com.zikan.ecommerce.product.PurchaseResponse;

import java.math.BigDecimal;
import java.util.List;

public record OrderConfirmation(
        // what is needed to send to notification brokers

        String orderReference,

        BigDecimal totalAmount,
        PaymentMethod paymentMethod,
        CustomerResponse customer,
        List<PurchaseResponse> products


) {

}
