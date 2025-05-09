package com.mc.restfulController;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@Slf4j
@RestController
public class WeatherController {

    // 날씨정보를 위한 OpenWeatherMap API 호출
    @Value("${app.key.weatherApiKey}")
    private String weatherApiKey;

    // 역지오코딩을 위한 카카오 API 호출
    @Value("${app.key.kakaoApiKey}")
    private String kakaoApiKey;

    private final RestTemplate restTemplate = new RestTemplate();

    // 권한이 있을 경우 이 api를 호출합니다.
    @GetMapping("/api/weather")
    public Map<String, Object> getCurrentWeather(@RequestParam double latitude, @RequestParam double longitude) {
        // OpenWeatherMap API를 호출하여 날씨 데이터를 가져옵니다.
        Map<String, Object> weatherData = getWeatherDataFromOpenWeather(latitude, longitude);
        // 날씨 데이터가 성공적으로 가져왔다면
        if (weatherData != null) {
            // 카카오 API를 호출하여 위도와 경도에 해당하는 도시 정보를 가져옵니다.
            String cityInfo = getCityInfoFromKakao(latitude, longitude);
            // 가져온 도시 정보를 weatherData 맵에 "cityName" 키로 추가합니다.
            weatherData.put("cityName", cityInfo);
        }
        // 최종적으로 날씨 데이터 (도시 정보 포함)를 반환합니다.
        return weatherData;
    }

    // 권한이 없거나, 위치 정보 판별에 실패한다면 이 api를 호출합니다.
    @GetMapping("/api/default-weather")
    public Map<String, Object> getDefaultWeather(@RequestParam String city) {
        // OpenWeatherMap API를 호출하여 특정 도시의 날씨 데이터를 가져옵니다.
        Map<String, Object> weatherData = getWeatherDataFromOpenWeather(city);
        // 기본 날씨 정보에서는 OpenWeatherMap에서 제공하는 도시 이름을 그대로 사용합니다.
        return weatherData;
    }

    // OpenWeatherMap API 호출
    private Map<String, Object> getWeatherDataFromOpenWeather(double latitude, double longitude) {
        // OpenWeatherMap API의 현재 날씨 endpoint URL을 위도, 경도, API 키, 단위 (metric), 언어 (kr)를 이용하여 생성합니다.
        String apiUrl = String.format("https://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&appid=%s&units=metric&lang=kr",
                latitude, longitude, weatherApiKey);
        try {
            // RestTemplate을 사용하여 GET 요청을 보내고, 응답을 Map<String, Object> 형태로 받습니다.
            return restTemplate.getForObject(apiUrl, Map.class);
        } catch (Exception e) {
            // API 호출 중 오류가 발생하면 콘솔에 오류 메시지를 출력하고 null을 반환합니다.
            System.err.println("OpenWeatherMap API 호출 오류: " + e.getMessage());
            return null;
        }
    }

    // 카카오 API 호출 (특정 도시 이름으로 날씨 정보 조회)
    private Map<String, Object> getWeatherDataFromOpenWeather(String city) {
        // OpenWeatherMap API의 특정 도시 날씨 endpoint URL을 도시 이름, API 키, 단위 (metric), 언어 (kr)를 이용하여 생성합니다.
        String apiUrl = String.format("https://api.openweathermap.org/data/2.5/weather?q=%s&appid=%s&units=metric&lang=kr",
                city, weatherApiKey);
        try {
            // RestTemplate을 사용하여 GET 요청을 보내고, 응답을 Map<String, Object> 형태로 받습니다.
            return restTemplate.getForObject(apiUrl, Map.class);
        } catch (Exception e) {
            // API 호출 중 오류가 발생하면 콘솔에 오류 메시지를 출력하고 null을 반환합니다.
            System.err.println("OpenWeatherMap 기본 날씨 API 호출 오류: " + e.getMessage());
            return null;
        }
    }

    // 카카오 API 호출 (위도, 경도를 이용하여 도시 정보 조회)
    private String getCityInfoFromKakao(double latitude, double longitude) {
        // 카카오 역지오코딩 API의 endpoint URL을 경도, 위도, 좌표 체계 (WGS84)를 이용하여 생성합니다.
        String kakaoApiUrl = String.format("https://dapi.kakao.com/v2/local/geo/coord2address.json?x=%f&y=%f&input_coord=WGS84", longitude, latitude);
        // HTTP 요청 헤더를 생성합니다.
        HttpHeaders headers = new HttpHeaders();
        // 카카오 API 인증을 위한 Authorization 헤더에 API 키를 설정합니다.
        headers.set("Authorization", "KakaoAK " + kakaoApiKey);
        // HTTP 요청 엔티티를 생성합니다 (본문 없이 헤더만 포함).
        HttpEntity<String> entity = new HttpEntity<>(headers);

        try {
            // RestTemplate을 사용하여 GET 요청을 보내고, 응답을 ResponseEntity<Map> 형태로 받습니다.
            ResponseEntity<Map> kakaoResponse = restTemplate.exchange(kakaoApiUrl, HttpMethod.GET, entity, Map.class);
            // 응답 본문을 Map 형태로 가져옵니다.
            Map<String, Object> kakaoBody = kakaoResponse.getBody();
            // 응답 본문이 있고, "documents" 키를 포함하고 있다면 (카카오 API 응답 구조)
            if (kakaoBody != null && kakaoBody.containsKey("documents")) {
                // "documents"는 주소 정보 리스트이므로 첫 번째 요소를 가져옵니다.
                java.util.List<Map> documents = (java.util.List<Map>) kakaoBody.get("documents");
                if (!documents.isEmpty()) {
                    // 첫 번째 문서에서 "address" 정보를 가져옵니다.
                    Map address = (Map) documents.get(0).get("address");
                    // "address" 정보가 있다면
                    if (address != null) {
                        // 광역시/도 정보와 시/군/구 정보가 있다면 공백으로 연결하여 반환합니다.
                        if (address.containsKey("region_1depth_name") && address.containsKey("region_2depth_name")) {
                            return address.get("region_1depth_name") + " " + address.get("region_2depth_name");
                        }
                        // 광역시/도 정보만 있다면 반환합니다.
                        else if (address.containsKey("region_1depth_name")) {
                            return (String) address.get("region_1depth_name");
                        }
                        // 시/군/구 정보만 있다면 반환합니다.
                        else if (address.containsKey("region_2depth_name")) {
                            return (String) address.get("region_2depth_name");
                        }
                    }
                }
            }
        } catch (Exception e) {
            // 카카오 API 호출 중 오류가 발생하면 콘솔에 오류 메시지를 출력합니다.
            log.error("카카오 API 호출 오류: " + e.getMessage());
        }
        // 카카오 API 호출 실패 또는 원하는 주소 정보가 없을 경우 기본값 "위치 정보 없음"을 반환합니다.
        return "위치 정보 없음";
    }
}