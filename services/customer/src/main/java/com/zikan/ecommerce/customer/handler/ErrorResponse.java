package com.zikan.ecommerce.customer.handler;

import java.util.HashMap;
import java.util.Map;

public record ErrorResponse(
        Map<String, String> errors
) {

}
