package com.mc.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class AccStats {
    private Integer accommodationId;
    private String hostId;
    private String name;

    // 조회수, 찜, 리뷰 개수, 매출 등 집계 수치 필드 (필요한 것만 사용)
    private Integer views;          // 누적 조회수
    private Integer wishlistCount;  // 누적 찜
    private Integer reviewCount;    // 누적 리뷰
    private Integer totalSales;     // 누적 매출
    private Integer totalBooking;   // 누적 예약건수
}
