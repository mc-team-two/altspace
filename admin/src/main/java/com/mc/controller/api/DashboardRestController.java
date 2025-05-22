package com.mc.controller.api;

import com.mc.app.dto.AccStats;
import com.mc.app.dto.Reservations;
import com.mc.app.dto.User;
import com.mc.app.service.AccStatsService;
import com.mc.app.service.ReservationService;
import com.mc.common.response.ResponseMessage;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/api/dashboard")
@RestController
@RequiredArgsConstructor
@Slf4j
public class DashboardRestController {

    private final ReservationService reservationService;
    private final AccStatsService accStatsService;

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

        Map<String, Object> response = new LinkedHashMap<>(); // HashMap (순서 유지X) LinkedHashMap (삽입 순서 유지)

        List<Reservations> currentReservations = reservationService.getCurrentReservations(hostId);
        List<Reservations> upcomingCheckIns = reservationService.getUpcomingCheckIns(hostId);
        List<Reservations> upcomingCheckOuts = reservationService.getUpcomingCheckOuts(hostId);
        List<Reservations> hostingNow = reservationService.getHostingNow(hostId);

        response.put("currentReservations", Map.of(
                "count", currentReservations.size(),
                "data", currentReservations
        ));

        response.put("upcomingCheckIns", Map.of(
                "count", upcomingCheckIns.size(),
                "data", upcomingCheckIns
        ));

        response.put("upcomingCheckOuts", Map.of(
                "count", upcomingCheckOuts.size(),
                "data", upcomingCheckOuts
        ));

        response.put("hostingNow", Map.of(
                "count", hostingNow.size(),
                "data", hostingNow
        ));

        return ResponseEntity.ok(response);
    }

    @GetMapping("/accommodations")
    public ResponseEntity<?> getAccommodations(@RequestParam("hostId") String hostId,
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

        List<AccStats> topViews = accStatsService.getTopViews(hostId);
        List<AccStats> topReviews = accStatsService.getTopReviews(hostId);
        List<AccStats> topWishlists = accStatsService.getTopWishlists(hostId);
        List<AccStats> topBookingsThisMonth = accStatsService.getTopBookingsThisMonth(hostId);
        List<AccStats> topSalesAllTime = accStatsService.getTopSalesAllTime(hostId);
        List<AccStats> topSalesThisMonth = accStatsService.getTopSalesThisMonth(hostId);

        response.put("topViews", topViews);
        response.put("topReviews", topReviews);
        response.put("topWishlists", topWishlists);
        response.put("topBookingsThisMonth", topBookingsThisMonth);
        response.put("topSalesAllTime", topSalesAllTime);
        response.put("topSalesThisMonth", topSalesThisMonth);

        return ResponseEntity.ok(response);
    }
}