package com.zikan.ecommerce.orderline;

import com.zikan.ecommerce.OrderLine;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderLineRepository extends JpaRepository<OrderLine, Integer> {
}
