package com.mc.controller;

import com.mc.config.StompWebSocketConfig;
import com.mc.msg.Msg;
import com.mc.util.ChatBotUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

@Controller
@Slf4j
@RequiredArgsConstructor
public class NcpController {

    private final SimpMessagingTemplate template;

    @Value("${ncp.chatbot.url}")
    String url;
    @Value("${ncp.chatbot.key}")
    String key;

    @MessageMapping("/sendchatbot")
    public void sendchat(Msg msg, SimpMessageHeaderAccessor headerAccessor) throws Exception {
        String guestId = (String) headerAccessor.getSessionAttributes().get("guestId");
        String userId = (String) headerAccessor.getSessionAttributes().get("userId");

        // 클라이언트 구독 ID와 정확히 일치하도록!
        String id = guestId != null ? guestId : (userId != null ? userId : msg.getSendid());

        log.info("사용자 구독 채널 ID: {}", id);

        String content = msg.getContent1();
        log.info("받은 메시지: {}", msg);

        String result;
        try {
            result = ChatBotUtil.getMsg(url, key, content);
        } catch (Exception e) {
            log.error("ChatBot API 호출 실패", e);
            result = "챗봇 응답을 가져오지 못했습니다. 잠시 후 다시 시도해주세요.";
        }

        msg.setContent1(result);
        template.convertAndSend("/sendto/" + id, msg);
    }
}
