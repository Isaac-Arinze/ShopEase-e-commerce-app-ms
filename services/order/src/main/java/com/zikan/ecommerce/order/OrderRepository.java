package com.zikan.ecommerce.order;

import com.zikan.ecommerce.Order;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<Order, Integer> {
}
