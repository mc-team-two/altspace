package com.mc.util;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

public class AuthUtil {
    // 랜덤 8자리 uuid 생성
    public static String generateUUID() {
        return UUID.randomUUID().toString().replace("-", "").substring(0, 8);
    }

    private static final String LETTERS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String DIGITS = "0123456789";
    private static final String SPECIALS = "@$!%*?&";
    private static final String ALL_ALLOWED = LETTERS + DIGITS + SPECIALS;

    private static final SecureRandom random = new SecureRandom();

    // 임시 비밀번호 생성기
    public static String generatePwd() {
        int length = 8;

        // 필수 조건을 만족하는 문자 각각 하나씩
        char letter = LETTERS.charAt(random.nextInt(LETTERS.length()));
        char digit = DIGITS.charAt(random.nextInt(DIGITS.length()));
        char special = SPECIALS.charAt(random.nextInt(SPECIALS.length()));

        List<Character> chars = new ArrayList<>();
        chars.add(letter);
        chars.add(digit);
        chars.add(special);

        // 나머지 자리 랜덤 채우기
        for (int i = 3; i < length; i++) {
            chars.add(ALL_ALLOWED.charAt(random.nextInt(ALL_ALLOWED.length())));
        }

        // 섞기
        Collections.shuffle(chars);

        // 문자열로 변환
        StringBuilder password = new StringBuilder();
        for (char c : chars) {
            password.append(c);
        }

        return password.toString();
    }
}
