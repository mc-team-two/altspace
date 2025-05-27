package com.mc.app.dto;

import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.sql.Timestamp;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class Accommodations {
    private int accommodationId;

    @NotBlank(message = "호스트 ID는 필수입니다.")
    private String hostId;

    @NotBlank
    @Size(max = 100)
    private String name;

    @NotBlank
    @Size(max = 200)
    private String location;

    @Min(0)
    private int priceNight;

    @Min(1)
    private int personMax;

    @NotBlank
    private String description;

    private String notice;

    @Pattern(regexp = "활성|비활성")
    private String status;

    private String category;
    private String roomType;

    private boolean breakfast;
    private boolean pool;
    private boolean barbecue;
    private boolean pet;

    private BigDecimal latitude;
    private BigDecimal longitude;

    private String image1Name;
    private String image2Name;
    private String image3Name;
    private String image4Name;
    private String image5Name;

    private Timestamp createDay;
    private Timestamp updateDay;
    private Timestamp hostCreateDay;

    private int views;

    private String hostGrade; // 예: 신입호스트, 일반호스트, 슈퍼호스트
}
