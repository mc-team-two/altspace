package com.mc.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class StompWebSocketConfig implements WebSocketMessageBrokerConfigurer {

    private final HttpHandshakeInterceptor httpHandshakeInterceptor;

    @Autowired
    public StompWebSocketConfig(HttpHandshakeInterceptor httpHandshakeInterceptor) {
        this.httpHandshakeInterceptor = httpHandshakeInterceptor;
    }

    // NCP 챗봇을 위한 엔드포인트
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/chat")
                .addInterceptors(httpHandshakeInterceptor)
                .setAllowedOriginPatterns("*")
                .withSockJS();

        // Gemini 챗봇을 위한 엔드포인트
        registry.addEndpoint("/chatbot")
                .addInterceptors(httpHandshakeInterceptor)
                .setAllowedOriginPatterns("*")
                .withSockJS();

        // 숙소 페이지를 입장 및 퇴장을 감지하기 위한 엔드포인트.
        registry.addEndpoint("/viewing")
                .addInterceptors(httpHandshakeInterceptor)
                .setAllowedOriginPatterns("*")
                .withSockJS();

    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        registry.enableSimpleBroker("/sub", "/sendto");
        registry.setApplicationDestinationPrefixes("/pub", "/app");
    }
}