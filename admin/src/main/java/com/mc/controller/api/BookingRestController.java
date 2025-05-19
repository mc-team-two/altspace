package com.mc.controller.api;

import com.mc.app.dto.Reservations;
import com.mc.app.service.ReservationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/api/booking")
@RestController
@RequiredArgsConstructor
@Slf4j
public class BookingRestController {

    private final ReservationService reservationService;

    @GetMapping("/reservations")
    public Map<String, Object> getReservations(@RequestParam("hostId") String hostId) {
        Map<String, Object> response = new LinkedHashMap<>();

        List<Reservations> upcoming = reservationService.getCurrentReservations(hostId);
        List<Reservations> finished = reservationService.getFinishedReservations(hostId);
        List<Reservations> hostingNow = reservationService.getHostingNow(hostId);
        List<Reservations> canceled = reservationService.getCanceledReservations(hostId);

        // 호스팅 예정된 예약
        response.put("upcoming", Map.of(
                "count", upcoming.size(),
                "data", upcoming
        ));
        // 호스팅 종료된 예약
        response.put("finished", Map.of(
                "count", finished.size(),
                "data", finished
        ));
        // 호스팅 진행중 예약
        response.put("hostingNow", Map.of(
                "count", hostingNow.size(),
                "data", hostingNow
        ));
        // 취소/환불된 예약
        response.put("canceled", Map.of(
                "count", canceled.size(),
                "data", canceled
        ));

        return response;
    }

}
