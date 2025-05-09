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
public class SimpReview {
    private int reviewId;
    private String guestId;         // 리뷰 작성한 게스트
    private int accommodationId;    // 리뷰 대상 숙박시설
    private int grade;              // 평점
    private String comment;         // 내용
    private Timestamp createDay;
    private Timestamp updateDay;
}