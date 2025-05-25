package com.mc.app.dto.aiSuggest;

import lombok.Data;

@Data
public class UserConsumptionType {
    private String userId;
    private String consumptionType; // ex) "짧고 자주 가는 여행자", "호캉스 중심"
    private String favoriteAccommodationType; // ex) "풀빌라, 모던호텔"
}
