package com.mc.app.dto.aiSuggest;

import lombok.Data;

@Data
public class UserConsumptionAnalysis {
    private String consumptionType;          // 사용자 소비 유형
    private String consumptionTypeDescription; // 사용자 소비 유형 설명
    private String favoriteAccommodationType; // 선호 숙소 유형 (쉼표로 구분된 문자열)
}