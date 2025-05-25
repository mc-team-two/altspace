package com.mc.msg;

import lombok.Data;

// 사용자 수 집계를 위한 ViewingMsg DTO

@Data
public class ViewingMsg {
    private String userId;    // 사용자 ID (또는 닉네임)
    private String accommId;  // 숙소 ID
    private String content1;  // "입장", "퇴장" 또는 현재 접속자 수 등의 메시지
}