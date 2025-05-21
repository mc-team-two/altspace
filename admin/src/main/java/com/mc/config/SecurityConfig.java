package com.mc.config;

import lombok.AllArgsConstructor;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(securedEnabled = true) //.wgradle clean build 걸어보니 deprecated 되었다고 린트에서 에러나서 수정.
@AllArgsConstructor
public class SecurityConfig  {

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public StandardPBEStringEncryptor  textEncoder(@Value("${jasypt.encryptor.algorithm}") String algo, @Value("${jasypt.encryptor.password}") String skey) {
        StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
        encryptor.setAlgorithm(algo);
        encryptor.setPassword(skey);
        return encryptor;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        //CSRF, CORS
        http.csrf(AbstractHttpConfigurer::disable);
        //http.cors(Customizer.withDefaults());

        CorsConfiguration configuration = new CorsConfiguration();
        configuration.addAllowedOrigin(CorsConfiguration.ALL);
        configuration.addAllowedMethod(CorsConfiguration.ALL);
        configuration.addAllowedHeader(CorsConfiguration.ALL);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        http.cors(cors -> cors.configurationSource(source));


        // 권한 규칙 작성
        http.authorizeHttpRequests(authorize -> authorize
                        .anyRequest().permitAll()
                        //@PreAuthrization을 사용할 것이기 때문에 모든 경로에 대한 인증처리는 Pass
                        //.anyRequest().authenticated()
        );
        return http.build();
    }

}
