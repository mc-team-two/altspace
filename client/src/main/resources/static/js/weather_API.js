$(document).ready(function() {
    // 페이지 로드 시 바로 실행
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(fetchWeatherOnLoad, handleLocationErrorOnLoad);
    } else {
        fetchDefaultWeatherOnLoad('Seoul');
    }

    function fetchWeatherOnLoad(position) {
        const latitude = position.coords.latitude;
        const longitude = position.coords.longitude;
        fetchWeatherData(latitude, longitude);
    }

    function handleLocationErrorOnLoad(error) {
        console.error('위치 정보를 가져오는 데 실패했습니다 (페이지 로드 시):', error);
        fetchDefaultWeatherOnLoad('Seoul');
    }

    function fetchWeatherData(latitude, longitude) {
        const apiUrl = `/api/weather?latitude=${latitude}&longitude=${longitude}`;
        $.ajax({
            url: apiUrl,
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                displayWeather(data, data.cityName); // 서버에서 보내주는 cityName 사용
            },
            error: function(error) {
                console.error('현재 위치 기반 날씨 정보 로딩 실패:', error);
                fetchDefaultWeatherOnLoad('Seoul');
            }
        });
    }

    function fetchDefaultWeatherOnLoad(city) {
        const apiUrl = `/api/default-weather?city=${city}`;
        $.ajax({
            url: apiUrl,
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                displayWeather(data, data.cityName); // 서버에서 보내주는 cityName 사용
            },
            error: function(error) {
                console.error('기본 날씨 정보 로딩 실패 (페이지 로드 시):', error);
                $('.weather').text('날씨 정보 로딩 실패');
            }
        });
    }

    function displayWeather(data, cityInfo) {
        // 온도를 정수로 변환.
        const temperature = Math.round(data.main.temp);
        const description = data.weather[0].description;
        const iconCode = data.weather[0].icon;
        const iconUrl = `https://openweathermap.org/img/wn/${iconCode}.png`;
        const weatherHtml = `
      <div class="weather-info">
        <img src="${iconUrl}" alt="${description}">
        <span>${temperature}°C</span>
        <span>${description} (${cityInfo})</span>
      </div>
    `;
        $('.weather').empty().append(weatherHtml);
    }
});