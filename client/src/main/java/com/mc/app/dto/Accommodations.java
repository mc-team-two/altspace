package com.mc.app.dto;

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
    private int accommodationId;         // PK
    private String hostId;               // FK (users.user_id)
    private String name;                 // 숙소 이름
    private String location;             // 숙소 주소
    private int priceNight;              // 1박 가격
    private int personMax;               // 최대 수용 인원
    private String description;          // 상세 설명
    private String status;               // ENUM('활성','비활성')
    private String category;             // ENUM('아파트','단독주택','오피스텔','빌라')
    private String roomType;             // 객실 유형
    private boolean breakfast;           // BIT(1)
    private boolean pool;                // BIT(1)
    private boolean barbecue;            // BIT(1)
    private boolean pet;                 // BIT(1)
    private BigDecimal latitude;         // 위도
    private BigDecimal longitude;        // 경도
    private String image1Name;
    private String image2Name;
    private String image3Name;
    private String image4Name;
    private String image5Name;
    private Timestamp createDay;         // 등록일
    private Timestamp updateDay;         // 수정일
}
