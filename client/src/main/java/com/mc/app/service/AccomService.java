package com.mc.app.service;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.mc.app.dto.AccomSuggestion;
import com.mc.app.dto.Accommodations;
import com.mc.app.dto.AccomodationsWithRating;
import com.mc.app.dto.TravelInsight;
import com.mc.app.frame.MCService;
import com.mc.app.repository.AccomRepository;
import com.mc.util.GeminiUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class AccomService implements MCService<Accommodations, Integer> {

    private final AccomRepository accomRepository;
    private final ReviewService reviewService;
    private final GeminiUtil geminiUtil;

    @Override
    public void add(Accommodations accommodations) throws Exception {
        accomRepository.insert(accommodations);
    }

    @Override
    public void mod(Accommodations accommodations) throws Exception {
        accomRepository.update(accommodations);
    }

    @Override
    public void del(Integer integer) throws Exception {
        accomRepository.delete(integer);
    }

    @Override
    public Accommodations get(Integer integer) throws Exception {
        return accomRepository.selectOne(integer);
    }

    @Override
    public List<Accommodations> get() throws Exception {
        return accomRepository.select();
    }

    // 페이징된 숙소 목록과 함께 평균 평점을 반환하는 메서드
    public List<AccomodationsWithRating> getAccommodationsWithRating(List<Accommodations> accommodations) throws Exception {
        List<AccomodationsWithRating> accommodationsWithRatingList = new ArrayList<>();
        for (Accommodations acc : accommodations) {
            double avgRating = reviewService.getAverageRating((long) acc.getAccommodationId());
            AccomodationsWithRating dto = AccomodationsWithRating.builder()
                    .accommodation(acc)
                    .averageRating(avgRating)
                    .roundedRating((int) Math.round(avgRating))
                    .build();
            accommodationsWithRatingList.add(dto);
        }
        return accommodationsWithRatingList;
    }

    // 지역으로 숙소를 검색하는 메서드 (location 컬럼에 검색어 포함)
    public List<Accommodations> getAccommodationsByLocation(String location, String checkInDate, String checkOutDate, String personnel, List<String> extras) {
        Map<String, Object> params = new HashMap<>();
        params.put("location", location);
        params.put("checkInDate", checkInDate);
        params.put("checkOutDate", checkOutDate);
        params.put("personnel", personnel); // 추가된 personnel 파라미터
        params.put("extras", extras);
        return accomRepository.searchAccommodationsByLocation(params);
    }
    public List<AccomodationsWithRating> searchAccommodationsByGeoLocation(double latitude, double longitude, double radius, List<String> extras, boolean withRating) throws Exception {
        Map<String, Object> params = new HashMap<>();
        params.put("userLatitude", latitude);
        params.put("userLongitude", longitude);
        params.put("radius", radius);
        params.put("extras", extras);
        List<Accommodations> accommodations = accomRepository.searchAccommodationsByGeoLocation(params);

        if (withRating) {
            return getAccommodationsWithRating(accommodations);
        } else {
            List<AccomodationsWithRating> accommodationsWithRatingList = new ArrayList<>();
            for (Accommodations acc : accommodations) {
                AccomodationsWithRating dto = AccomodationsWithRating.builder()
                        .accommodation(acc)
                        .averageRating(0) // Or null, depending on your DTO
                        .roundedRating(0)   // Or null
                        .build();
                accommodationsWithRatingList.add(dto);
            }
            return accommodationsWithRatingList;
        }
    }

    public void updateAccommodationViews(int accId) {
        accomRepository.updateAccommodationViews(accId);
    }

    // 제미나이로부터 응답을 받아오는 메서드
    public TravelInsight getSuggestions(AccomSuggestion request) {

        String jsonString = geminiUtil.askGeminiSuggestion(request).trim();

// 👉 1. Markdown 래핑 제거 (` ```json\n` 혹은 ```만 제거)
        if (jsonString.startsWith("```json") || jsonString.startsWith("```")) {
            jsonString = jsonString.replaceAll("```json\\s*", "")
                    .replaceAll("```", "")
                    .trim();
        }

        log.info("🔍 최종 파싱 대상 JSON 문자열:\n{}", jsonString);

// 👉 2. JSON 객체 파싱 시도
        try {
            return new Gson().fromJson(jsonString, TravelInsight.class);
        } catch (JsonSyntaxException e) {
            log.error("❌ Gemini 응답 JSON 파싱 실패: {}", jsonString, e);
            throw new RuntimeException("Gemini JSON 파싱 실패", e);
        }
    }
}