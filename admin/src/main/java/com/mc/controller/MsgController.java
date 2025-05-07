package com.mc.controller;

import com.mc.app.msg.Msg;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

@Slf4j
@Controller
public class MsgController {
    @Autowired
    SimpMessagingTemplate template;

    @MessageMapping("/receiveall") // 모두에게 전송
    public void receiveall(Msg msg, SimpMessageHeaderAccessor headerAccessor) {
        log.info(msg.toString());
        template.convertAndSend("/sub",msg);
    }

    @MessageMapping("/receiveme") // 나에게만 전송 ex)Ch
    public void receiveme(Msg msg, SimpMessageHeaderAccessor headerAccessor) {
        log.info(msg.toString());

        String id = msg.getSendid();
        template.convertAndSend("/sub/"+id,msg);
    }
    @MessageMapping("/receiveto") // 특정 Id에게 전송
    public void receiveto(Msg msg, SimpMessageHeaderAccessor headerAccessor) {
        String target = msg.getReceiveid();
        log.info("-------------------------");
        log.info(target);

        template.convertAndSend("/sub/to/"+target,msg);
    }
}
