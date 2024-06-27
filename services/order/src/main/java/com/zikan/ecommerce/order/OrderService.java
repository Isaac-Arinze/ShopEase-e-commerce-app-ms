package com.zikan.ecommerce.order;


import com.zikan.ecommerce.customer.CustomerClient;
import com.zikan.ecommerce.exception.BusinessException;
import com.zikan.ecommerce.kafka.OrderConfirmation;
import com.zikan.ecommerce.kafka.OrderProducer;
import com.zikan.ecommerce.order.OrderMapper;
import com.zikan.ecommerce.order.OrderRepository;
import com.zikan.ecommerce.order.OrderRequest;
import com.zikan.ecommerce.order.OrderResponse;
import com.zikan.ecommerce.orderline.OrderLineRequest;
import com.zikan.ecommerce.orderline.OrderLineService;
import com.zikan.ecommerce.product.ProductClient;
import com.zikan.ecommerce.product.PurchaseRequest;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderMapper orderMapper;
    private final OrderRepository orderRepository;
    private final CustomerClient customerClient;
    private final ProductClient productClient;
    private final OrderLineService orderLineService;

    private final OrderProducer orderProducer;


    public Integer createOrder(OrderRequest orderRequest) {
        //check the customer use open feign
        var customer = this.customerClient.findCustomerById(orderRequest.customerId())
                .orElseThrow(() -> new BusinessException("Cannot create order:: No customer exists with the provided ID"));

        // purchase d product -->  product m/s (using rest Template)
        // purchase products from m/s
        var purchasedProducts = this.productClient.purchaseProducts(orderRequest.products());

        //persist order object and orderlines

        var order = this.orderRepository.save(orderMapper.toOrder(orderRequest));

        //todo start payment process

        for (PurchaseRequest purchaseRequest : orderRequest.products()) {

            orderLineService.saveOrderLine(
                    new OrderLineRequest(
                            null,
                            order.getId(),
                            purchaseRequest.productId(),
                            purchaseRequest.quantity()
                    )
            );


        }

        //send d order confirmation --> notification ms (kafka) send a message
        // to oour kafka broker sending notification to notification service

        //serialize and also deserialize to and from an oject

        orderProducer.sendOrderConfirmation(
                new OrderConfirmation(
                        orderRequest.reference(),
                        orderRequest.amount(),
                        orderRequest.paymentMethod(),
                        customer,
                        purchasedProducts
                )
        );


        return order.getId();
    }

    public List<OrderResponse> findALL() {
        return orderRepository.findAll()
                .stream()
                .map(orderMapper::fromOrder)
                .collect(Collectors.toList());
    }

    public OrderResponse findById(Integer orderId) {

        return orderRepository.findById(orderId)
                .map(orderMapper::fromOrder)
                .orElseThrow(()->
                        new EntityNotFoundException(String.format("No order found with the provided ID: %d", orderId)))


    ;}
}
