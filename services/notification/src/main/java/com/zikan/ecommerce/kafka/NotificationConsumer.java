package com.zikan.ecommerce.kafka;

import com.zikan.ecommerce.email.EmailService;
import com.zikan.ecommerce.kafka.order.OrderConfirmation;
import com.zikan.ecommerce.kafka.payment.PaymentConfirmation;
import com.zikan.ecommerce.notification.Notification;
import com.zikan.ecommerce.notification.NotificationRepository;
import jakarta.mail.MessagingException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

import static com.zikan.ecommerce.notification.NotificationType.ORDER_CONFIRMATION;
import static com.zikan.ecommerce.notification.NotificationType.PAYMENT_CONFIRMATION;
import static java.lang.String.format;


@RequiredArgsConstructor
@Service
@Slf4j
public class NotificationConsumer {

    private final NotificationRepository notificationRepository;
    private final EmailService emailService;

    @KafkaListener(topics = "payment-topic")

    public void consumePaymentSuccessNotification(PaymentConfirmation paymentConfirmation) throws MessagingException {
        log.info(format("Consuming the message from payment-topic Topic:: %s", paymentConfirmation));

        notificationRepository.save(
                Notification.builder()
                        .type(PAYMENT_CONFIRMATION)
                        .notificationDate(LocalDateTime.now())
                        .paymentConfirmation(paymentConfirmation)
                        .build()
        );

        // todo send email here
        var customerName = paymentConfirmation.customerFirstname() + " " + paymentConfirmation.customerLastname();
        emailService.sendPaymentSuccessEmail(
                paymentConfirmation.customerEmail(),
                customerName,
                paymentConfirmation.amount(),
                paymentConfirmation.orderReference()
        );

    }

    @KafkaListener(topics = "order-topic")

    public void consumeOrderConfirmationNotification(OrderConfirmation orderConfirmation) throws MessagingException{
        log.info(format("Consuming the message from order-topic Topic:: %s", orderConfirmation));

        notificationRepository.save(
                Notification.builder()
                        .type(ORDER_CONFIRMATION)
                        .notificationDate(LocalDateTime.now())
                        .orderConfirmation(orderConfirmation)
                        .build()
        );

        // todo send email here

        var customerName = orderConfirmation.customer().firstname()  + " " + orderConfirmation.customer().lastname();
        emailService.sendOrderConfirmationEmail(
                orderConfirmation.customer().email(),
                customerName,
                orderConfirmation.totalAmount(),
                orderConfirmation.orderReference(),
                orderConfirmation.products()
        );

    }
}
