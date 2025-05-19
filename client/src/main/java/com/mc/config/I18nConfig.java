//package com.mc.config;
//import org.springframework.context.MessageSource;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.context.support.ReloadableResourceBundleMessageSource;
//
//@Configuration
//public class I18nConfig {
//
//    @Bean
//    public MessageSource messageSource() {
//        ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
//        messageSource.setBasename("classpath:messages/message"); // 메시지 파일 경로
//        messageSource.setDefaultEncoding("UTF-8");
//        return messageSource;
//    }
//}