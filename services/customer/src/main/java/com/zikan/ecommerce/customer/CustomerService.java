package com.zikan.ecommerce.customer;


import com.ctc.wstx.util.StringUtil;
import com.zikan.ecommerce.customer.exception.CustomerNotFoundException;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

import static java.lang.String.format;

@RequiredArgsConstructor
@Service
public class CustomerService {

    private final CustomerRepository customerRepository;

    private final CustomerMapper customerMapper;


    public String createCustomer(CustomerRequest request) {

        var customer = customerRepository.save(customerMapper.toCustomer(request));
        return customer.getId();
    }

    public void updateCustomer(CustomerRequest request) {

        var customer = customerRepository.findById(request.id()).orElseThrow(()-> new CustomerNotFoundException(
                format("cannot update customer:: No customer foundd with the provided ID:: %s", request.id())
        ));

        mergedCustomer(customer, request); // mergin customer to the request
        customerRepository.save(customer);

    }

    private void mergedCustomer(Customer customer, CustomerRequest request) {
        // if entity exist in db, update

        if (StringUtils.isNotBlank(request.firstname())){
            customer.setFirstname(request.firstname());
        }

        if (StringUtils.isNotBlank(request.lastname())){
            customer.setLastname(request.lastname());
        }

        if (StringUtils.isNotBlank(request.email())){
            customer.setEmail(request.email());
        }

        if (request.address() != null){
            customer.setAddress(request.address());
        }

    }

    public List<CustomerResponse> findAllCustomer() {
        return customerRepository.findAll()
                .stream()
                .map(customerMapper::fromCustomer)
                .collect(Collectors.toList());
    }

    public Boolean existsById(String customerId) {
        return customerRepository.findById(customerId)
                .isPresent(); // returns true if customer is present & false if not
    }

    public CustomerResponse findById(String customerId) {

        return customerRepository.findById(customerId)
                .map(customerMapper::fromCustomer)
                .orElseThrow(()-> new CustomerNotFoundException(format("No customer found with provided ID:: %s", customerId)));
    }

    public void deleteCustomer(String customerId) {
       customerRepository.deleteById(customerId);

    }
}
