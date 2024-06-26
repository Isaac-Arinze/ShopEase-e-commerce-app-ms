package com.zikan.ecommerce.order;

import com.zikan.ecommerce.Order;
import com.zikan.ecommerce.OrderRequest;
import org.springframework.stereotype.Service;

@Service
public class OrderMapper {
    public Order toOrder(OrderRequest orderRequest) {

        return Order.builder()
                .id(orderRequest.id())
                .customerId(orderRequest.customerId())
                .reference(orderRequest.reference())
                .paymentMethod(orderRequest.paymentMethod())
                .totalAmount(orderRequest.amount())
                .build();
    }
}
