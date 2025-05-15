package com.mc;

import com.mc.app.dto.Payments;
import com.mc.app.service.PaymentService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

@SpringBootTest
@Slf4j
class ClientApplicationTests {

    @Autowired
    PaymentService paymentService;

    @Test
    void contextLoads() throws Exception {
        Payments pay = Payments.builder()
                .guestId("cf8e3269")
                .accommodationId(1)
                .checkIn(LocalDate.parse("2025-05-22"))
                .checkOut(LocalDate.parse("2025-06-01"))
                .payAmount(BigDecimal.valueOf(999))
                .payStatus("취소")
                .payMeans("카드")
                .impUid("imp_629828209570")
                .build();

        log.info(pay.toString());
        paymentService.add(pay);
    }

}
