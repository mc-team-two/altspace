package com.mc.controller.api;

import com.mc.app.dto.AccStats;
import com.mc.app.dto.Reservations;
import com.mc.app.service.AccStatsService;
import com.mc.app.service.ReservationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/api")
@RestController
@RequiredArgsConstructor
@Slf4j
public class DashboardController {

    private final ReservationService reservationService;
    private final AccStatsService accStatsService;

    @GetMapping("/reservations")
    public Map<String, Object> getReservations(@RequestParam("hostId") String hostId) {
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

        return response;
    }

    @GetMapping("/accommodations")
    public Map<String, Object> getAccommodations(@RequestParam("hostId") String hostId) {
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

        return response;
    }
}