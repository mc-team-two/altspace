package com.mc.app.dto.aiSuggest;

import lombok.Data;

import java.util.List;

// 전체 유저 예약, 찜, 리뷰를 받아오기 위한 DTO
// 사용자 ID/이름, 예약목록, 찜목록, 리뷰 전체!
@Data
public class UserPreference {
    private String userId;
    private String userName;
    private List<Integer> bookedAccommodationIds;
    private List<Integer> wishlistAccommodationIds;
    private List<ReviewSummary> reviews;
}