package com.mc.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ReviewImage {
    private int imageId;
    private int reviewId;
    private String imageUrl;  // DB에 저장된 이미지 정보를 담는 용도
    private Timestamp createDay;
}
