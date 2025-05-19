package com.mc.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 조인된 테이블로 만든 커스텀 DTO
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class Reservations {
    private String paymentId;
    private String guestId;
    private String guestName;          // users.name
    private LocalDateTime checkIn;
    private LocalDateTime checkOut;
    private String accommodationId;
    private String hostId;             // accommodations.host_id
    private String accommodationName;  // accommodations.name
    private String location;           // accommodations.location
}
