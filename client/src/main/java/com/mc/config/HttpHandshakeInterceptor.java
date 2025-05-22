package com.mc.config;

import jakarta.servlet.http.HttpSession;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import java.util.HashMap;
import java.util.Map;

// 원래는 비로그인 유저가 로그인 했을 시, 챗봇 로그를 막힘 없이 보여주기 위한 용도로 만들었으나,
// 도중 사양이 바뀌어서 완성되지는 못한 코드.
// WebSocket HandShake 시 로그인 된 사용자 ID를 확인해, 메세지에 포함.

@Component
public class HttpHandshakeInterceptor implements HandshakeInterceptor {
    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
                                   WebSocketHandler wsHandler, Map<String, Object> attributes) {

        if (attributes == null) {
            attributes = new HashMap<>(); // ★ 안전장치: 실제론 null이면 안 되지만 혹시 모르니
        }

        if (request instanceof ServletServerHttpRequest servletRequest) {
            HttpSession session = servletRequest.getServletRequest().getSession(false);
            if (session != null) {
                Object userId = session.getAttribute("userId");
                Object guestId = session.getAttribute("guestId");
                if (userId != null) attributes.put("userId", userId);
                if (guestId != null) attributes.put("guestId", guestId);
            } else {
                attributes.put("userId", "anonymousUser");
            }
        } else {
            attributes.put("userId", "anonymousUser");
        }

        return true;
    }

    @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response,
                               WebSocketHandler wsHandler, Exception exception) {
    }
}