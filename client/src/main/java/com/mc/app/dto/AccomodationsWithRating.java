package com.mc.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AccomodationsWithRating {
    private Accommodations accommodation; // 숙소 정보 DTO
    private double averageRating;         // 평균 평점
    private int roundedRating;            // 반올림된 평점
}