package com.mc.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.support.RequestContextUtils;

import java.util.Locale;

@Component
public class LocaleInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 모든 요청에 대해 현재 로케일을 세션에 저장
        Locale currentLocale = RequestContextUtils.getLocale(request);
        request.getSession().setAttribute("currentLocale", currentLocale.getLanguage());
        return true;
    }
}