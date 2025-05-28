package com.mc.restfulController;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.AccomodationsWithRating;
import com.mc.app.service.AccomService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/search")
@Slf4j
@RequiredArgsConstructor
public class SearchAccomRestController {

    private final AccomService accomService;

    /**
     * 🔍 위치 기반 숙소 검색
     */
    @GetMapping("/search")
    public Object searchAccommodations(
            @RequestParam(value = "location", required = false) String location,
            @RequestParam(value = "checkInDate", required = false) String checkInDate,
            @RequestParam(value = "checkOutDate", required = false) String checkOutDate,
            @RequestParam(value = "personnel", required = false) String personnel,
            @RequestParam(value = "extras[]", required = false) List<String> extras,
            @RequestParam(value = "withRating", required = false, defaultValue = "false") boolean withRating
    ) throws Exception {
        // ✅ 입력값 검증
        location = sanitize(location);
        if (checkInDate != null && !isValidDate(checkInDate)) {
            throw new IllegalArgumentException("유효하지 않은 체크인 날짜입니다.");
        }
        if (checkOutDate != null && !isValidDate(checkOutDate)) {
            throw new IllegalArgumentException("유효하지 않은 체크아웃 날짜입니다.");
        }
        if (personnel != null && !personnel.matches("\\d{1,2}")) {
            throw new IllegalArgumentException("인원수는 숫자여야 합니다.");
        }

        // ✅ extras 유효성
        if (extras != null) {
            List<String> allowed = List.of("breakfast", "pet", "barbecue", "pool");
            extras = extras.stream().filter(allowed::contains).collect(Collectors.toList());
        }

        // ✅ 서비스 호출
        List<Accommodations> accommodations = accomService.getAccommodationsByLocation(
                location, checkInDate, checkOutDate, personnel, extras
        );
        if (withRating) {
            return accomService.getAccommodationsWithRating(accommodations);
        } else {
            return accommodations;
        }
    }

    /**
     * 🔍 사용자 위치 기반 숙소 검색 (Geo)
     */
    @GetMapping("/geo")
    public List<AccomodationsWithRating> searchAccommodationsByGeoLocation(
            @RequestParam("latitude") double latitude,
            @RequestParam("longitude") double longitude,
            @RequestParam("radius") double radius,
            @RequestParam(value = "extras[]", required = false) List<String> extras,
            @RequestParam(value = "withRating", required = false, defaultValue = "false") boolean withRating
    ) throws Exception {
        return accomService.searchAccommodationsByGeoLocation(latitude, longitude, radius, extras, withRating);
    }

    /**
     * 🔧 입력값 XSS 예방
     */
    private String sanitize(String input) {
        return input == null ? "" : input.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    }

    /**
     * 🔧 yyyy-MM-dd 날짜 형식 검사
     */
    private boolean isValidDate(String date) {
        try {
            LocalDate.parse(date);
            return true;
        } catch (DateTimeParseException e) {
            return false;
        }
    }
}
