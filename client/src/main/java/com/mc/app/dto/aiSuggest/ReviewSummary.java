package com.mc.app.dto.aiSuggest;

import lombok.Data;


// 나의 리뷰 요약을 위한 DTO
// 리뷰 한 줄 요약 (숙소ID, 평점, 코멘트)
@Data
public class ReviewSummary {
    private String accommodationId;
    private Integer grade;  // Null 허용 (리뷰 없을 때)
    private String comment;
}
