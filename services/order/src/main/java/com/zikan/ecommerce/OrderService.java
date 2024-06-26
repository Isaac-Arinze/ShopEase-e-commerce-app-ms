package com.zikan.ecommerce;


import com.zikan.ecommerce.customer.CustomerClient;
import com.zikan.ecommerce.exception.BusinessException;
import com.zikan.ecommerce.order.OrderMapper;
import com.zikan.ecommerce.order.OrderRepository;
import com.zikan.ecommerce.orderline.OrderLineRequest;
import com.zikan.ecommerce.orderline.OrderLineService;
import com.zikan.ecommerce.product.ProductClient;
import com.zikan.ecommerce.product.PurchaseRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderMapper orderMapper;
    private final OrderRepository orderRepository;
    private final CustomerClient customerClient;
    private final ProductClient productClient;
    private final OrderLineService orderLineService;


    public Integer createOrder(OrderRequest orderRequest) {
        //check the customer use open feign
        var customer = this.customerClient.findCustomerById(orderRequest.customerId())
                .orElseThrow(()-> new BusinessException("Cannot create order:: No customer exists with the provided ID"));

        // purchase d product -->  product m/s (using rest Template)
        // purchase products from m/s
        this.productClient.purchaseProducts(orderRequest.products());

        //persist order object and orderlines

        var order = this.orderRepository.save(orderMapper.toOrder(orderRequest));

        //todo start payment process

        for (PurchaseRequest purchaseRequest: orderRequest.products()){

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
        return null;
    }
}
