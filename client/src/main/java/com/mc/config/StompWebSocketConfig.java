package com.mc.config;

import com.mc.msg.Msg;
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

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/chat")
                .addInterceptors(httpHandshakeInterceptor)
                .setAllowedOriginPatterns("*")
                .withSockJS();

        registry.addEndpoint("/chatbot")
                .addInterceptors(httpHandshakeInterceptor)
                .setAllowedOriginPatterns("*")
                .withSockJS();
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        registry.enableSimpleBroker("/sub", "/sendto");
        registry.setApplicationDestinationPrefixes("/pub", "/app");
    }

    public void convertAndSend(String s, Msg msg) {
    }
}