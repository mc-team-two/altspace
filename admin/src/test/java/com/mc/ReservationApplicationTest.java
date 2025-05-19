package com.mc;

import com.mc.app.dto.Reservations;
import com.mc.app.service.ReservationService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
@Slf4j
public class ReservationApplicationTest {

    @Autowired
    private ReservationService reservationService;

    @Test
    void getCurrentReservationsLoads() {
        String hostId = "cb55f65d";
        List<Reservations> list = reservationService.getCurrentReservations(hostId);
        log.info("가져온 row 수: " + list.size());
    }

    @Test
    void getUpcomingCheckInLoads() {
        String hostId = "cb55f65d";
        List<Reservations> list = reservationService.getUpcomingCheckIns(hostId);
        log.info("가져온 row 수: " + list.size());
    }

    @Test
    void getUpcomingCheckOutsLoads() {
        String hostId = "cb55f65d";
        List<Reservations> list = reservationService.getUpcomingCheckOuts(hostId);
        log.info("가져온 row 수: " + list.size());
    }

    @Test
    void getHostingNowLoads() {
        String hostId = "cb55f65d";
        List<Reservations> list = reservationService.getHostingNow(hostId);
        log.info("가져온 row 수: " + list.size());
    }
}
