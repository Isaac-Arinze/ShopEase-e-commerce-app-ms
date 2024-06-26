package com.zikan.ecommerce;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/orders")
public class OrderController {

    private final OrderService orderService;
    public ResponseEntity<Integer> createOrder(@RequestBody @Valid OrderRequest orderRequest){

        return ResponseEntity.ok(orderService.createOrder(orderRequest));

    }

}
