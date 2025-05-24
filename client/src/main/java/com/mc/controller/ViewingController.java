package com.mc.controller;
import com.mc.msg.ViewingMsg;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

@Controller
@Slf4j
@RequiredArgsConstructor
public class ViewingController {

    private final SimpMessagingTemplate template;
    // 숙소 ID별로 접속자 수를 집계
    private final ConcurrentHashMap<String, AtomicInteger> viewingCountMap = new ConcurrentHashMap<>();

    @MessageMapping("/enteraccom")
    public void enterAccommodation(ViewingMsg msg) {
        log.info("✅ 입장: {}", msg);
        viewingCountMap
                .computeIfAbsent(msg.getAccommId(), k -> new AtomicInteger(0))
                .incrementAndGet();

        // 접속자 수 브로드캐스트
        sendViewingCount(msg.getAccommId());
    }

    @MessageMapping("/leaveaccom")
    public void leaveAccommodation(ViewingMsg msg) {
        log.info("🚪 퇴장: {}", msg);
        viewingCountMap.computeIfPresent(msg.getAccommId(), (k, v) -> {
            v.decrementAndGet();
            return v;
        });

        // 접속자 수 브로드캐스트
        sendViewingCount(msg.getAccommId());
    }

    private void sendViewingCount(String accommId) {
        int count = viewingCountMap.getOrDefault(accommId, new AtomicInteger(0)).get();

        // 예: "/sub/viewing"으로 접속자 수 전송
        ViewingMsg countMsg = new ViewingMsg();
        countMsg.setAccommId(accommId);
        countMsg.setContent1("현재 " + count + "명이 이 숙소를 보고 있어요!");
        countMsg.setUserId("system");

        template.convertAndSend("/sub/viewing", countMsg);
    }
}