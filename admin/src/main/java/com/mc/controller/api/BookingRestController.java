package com.mc.controller.api;

import com.mc.app.dto.Reservations;
import com.mc.app.dto.User;
import com.mc.app.service.ReservationService;
import com.mc.common.response.ResponseMessage;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
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
    public ResponseEntity<?> getReservations(@RequestParam("hostId") String hostId,
                                             HttpSession httpSession) {
        // 권한 제어
        User curUser = (User) httpSession.getAttribute("user");
        if (curUser == null) {
            return ResponseEntity
                    .status(ResponseMessage.UNAUTHORIZED.getStatus())
                    .body(ResponseMessage.UNAUTHORIZED.getMessage());
        }
        if (!curUser.getUserId().equals(hostId)) {
            return ResponseEntity
                    .status(ResponseMessage.FORBIDDEN.getStatus())
                    .body(ResponseMessage.FORBIDDEN.getMessage());
        }

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

        return ResponseEntity.ok(response);
    }

}
