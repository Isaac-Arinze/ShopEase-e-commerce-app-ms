package com.zikan.ecommerce.orderline;

import com.zikan.ecommerce.Order;
import com.zikan.ecommerce.OrderLine;
import org.springframework.stereotype.Service;

@Service
public class OrderLineMapper {


    public OrderLine toOrderLine(OrderLineRequest orderLineRequest) {

        return OrderLine.builder()
                .id(orderLineRequest.id())
                .quantity(orderLineRequest.quantity())
                .order(
                        Order.builder()
                                .id(orderLineRequest.orderId())
                                .build()
                )
                .productId(orderLineRequest.productId())
                .build();
    }
}
