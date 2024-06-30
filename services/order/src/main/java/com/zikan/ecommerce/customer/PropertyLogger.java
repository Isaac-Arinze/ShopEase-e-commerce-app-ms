package com.zikan.ecommerce.customer;

import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

//import javax.annotation.PostConstruct;

@Component
public class PropertyLogger {

    @Value("${application.config.customer-url}")
    private String customerUrl;

    @PostConstruct
    public void logProperties() {
        System.out.println("Customer URL: " + customerUrl);
    }
}
