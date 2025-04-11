package com.mc.app.util;

import java.util.UUID;

public class AuthUtil {
    // 랜덤 8자리 uuid 생성
    public static String generateUUID() {
        return UUID.randomUUID().toString().replace("-", "").substring(0, 8);
    }
}
