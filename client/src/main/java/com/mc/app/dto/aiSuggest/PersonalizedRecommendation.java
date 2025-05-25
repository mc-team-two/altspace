package com.mc.app.dto.aiSuggest;

import lombok.Data;


// 개인화 추천을 위한 DTO
@Data
public class PersonalizedRecommendation {
    private String accommodationId;
    private String name;
    private String location;
    private String recommendationReason; // AI가 알려주는 추천 이유
}