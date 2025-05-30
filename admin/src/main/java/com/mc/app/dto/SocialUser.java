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
    private String userId;
    private String provider;
    private String providerUserId;
    private LocalDateTime connectedAt;
}
