package com.mc.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Slf4j
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Value("${app.dir.imgdir}")
    String imgdir;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/imgs/**").addResourceLocations(imgdir);
        registry.addResourceHandler("/mypage/**").addResourceLocations("classpath:/static/");

    }

    // 컨트롤러를 일일이 검사할 것이 아니라, 경로에 mypage가 있다면 인터셉터에서 컨트롤러 호출 전에 로그인이 되어있는지 확인.
    // 컨트롤러가 많아지니 더 효율적으로 검사하도록 지정. HTTP 요청 전에 확인. 전역 설정.
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns("/mypage/**"); // 마이페이지 하위 모든 URL
    }

}