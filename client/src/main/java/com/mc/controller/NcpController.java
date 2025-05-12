package com.mc.controller;

import com.mc.msg.Msg;
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

    final SimpMessagingTemplate template;

    @Value("${ncp.chatbot.url}")
    String url;
    @Value("${ncp.chatbot.key}")
    String key;

    @MessageMapping("/sendchatbot") // 특정 Id에게 전송
    public void sendchat(Msg msg, SimpMessageHeaderAccessor headerAccessor) throws Exception {
        String id = msg.getSendid();
        String content = msg.getContent1();
        log.info("-------------------------");
        log.info(msg.toString());

        //String result = ChatBotUtil.getMsg(url,key, content);
        //msg.setContent1(result);

        template.convertAndSend("/sendto/"+id,msg);

    }
}
