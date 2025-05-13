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