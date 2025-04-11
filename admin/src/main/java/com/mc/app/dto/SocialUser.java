package com.mc.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class SocialUser {
    private Long id;
    private String user_id;
    private String provider;
    private String providerUserId;
    private LocalDateTime createdAt;
}
