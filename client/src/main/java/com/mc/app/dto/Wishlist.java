package com.mc.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class Wishlist {
    private int wishlistId;
    private String userId;
    private int accommodationId;
    private Timestamp createDay;

    // 숙소 정보
    private String name;
    private int priceNight;
    private String description;
    private String image1Name;
    private boolean breakfast;
    private boolean pool;
    private boolean barbecue;
    private boolean pet;

    // 평점 정보
    private double averageRating;
}
