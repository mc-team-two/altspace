package com.mc.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class Payments {
    private int reservationsId;
    private String guestId;
    private int accommodationId;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkIn;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkOut;
    private BigDecimal payAmount;
    private String payStatus;            // '완료', '취소', '환불'
    private String payMeans;             // '카드', '계좌이체'
    private String impUid;
    private String name;                 // 숙소 이름(조인해서 가져오는 데이터)
    private String location;             // 숙소 주소(조인해서 가져오는 데이터)
    private Timestamp createDay;
    private String image1Name;          // 숙소 대표 이미지(조인해서 가져오는 데이터)
}
