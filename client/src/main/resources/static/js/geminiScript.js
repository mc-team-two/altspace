<!-- 실제 JS에서 사용할 변수 정의 -->
const statsElement = document.getElementById("statsJson");
let stats = [];

if (statsElement && statsElement.textContent.trim()) {
    try {
        stats = JSON.parse(statsElement.textContent);
    } catch (e) {
        console.error("📛 JSON 파싱 오류:", e);
    }
} else {
    console.warn("⚠ statsJson 요소가 없거나 내용이 비었습니다.");
}

console.log("📊 히트맵 데이터:", stats);


    let parsed;
    let geminiText;
    document.addEventListener("DOMContentLoaded", function () {
    const mapContainer = document.getElementById("map");

    if (!mapContainer) {
    console.warn("지도 컨테이너(#map)가 없습니다.");
    return;
}

    console.log("➡️ DOMContentLoaded 발생, stats 값 확인:", stats); // <-- 여기에서 stats 값 확인!
    if (stats && stats.length > 0) {
    console.log("✅ stats 데이터가 있어서 Gemini 분석 요청 시작.");
    sendStatsToGemini(); // 지도 로딩과 별개로 Gemini 분석 요청
} else {
    // stats 데이터가 없는 경우 처리
    console.warn("❌ stats 데이터가 비어 있어 Gemini 분석 요청을 건너뜁니다.");
}

    // kakao 객체가 없는 경우 (429나 로딩 실패 등)
    if (typeof kakao === "undefined" || !kakao.maps || !kakao.maps.load) {
    console.error("⚠ Kakao 지도 API 로딩 실패 또는 차단되었습니다. (429 또는 네트워크 문제 등)");
    mapContainer.innerHTML = `
                <div style="padding: 2rem; text-align: center; color: red; font-weight: bold;">
                    🔌 Kakao 지도 로딩에 실패했습니다.<br>
                    네트워크 상태를 확인하거나, 새로고침 후 다시 시도해주세요.<br>
                    (429 Too Many Requests 또는 차단 가능성)
                </div>
            `;
    return;
}

    // 정상 로딩된 경우
    // 기본값: 서울
    kakao.maps.load(function () {
    if (!stats || stats.length === 0) {
    console.warn("히트맵 데이터가 비어 있습니다.");
    return;
}

    const map = new kakao.maps.Map(mapContainer, {
    center: new kakao.maps.LatLng(36.5, 127.5), // 대한민국 중심부 (충청도 부근)
    level: 18
});

    const geocoder = new kakao.maps.services.Geocoder();

    let completed = 0;
    const total = stats.length;

    stats.forEach((item) => {
    if (!item.location) {
    completed++;
    return;
}

    geocoder.addressSearch(item.location, function (result, status) {
    completed++;

    if (status === kakao.maps.services.Status.OK) {
    const coords = new kakao.maps.LatLng(result[0].y, result[0].x);

    const circle = new kakao.maps.Circle({
    center: coords,
    radius: Math.max(300, item.totalViews * 10),
    strokeWeight: 1,
    strokeColor: '#0040ff',
    strokeOpacity: 0.8,
    fillColor: '#0040ff',
    fillOpacity: 0.4
});
    circle.setMap(map);

    const marker = new kakao.maps.Marker({
    position: coords,
    map: map
});

    const infowindow = new kakao.maps.InfoWindow({
    content: `
                    <div style="padding:10px;font-size:13px;">
                        <b>${item.location}</b><br/>
                        조회수: ${item.totalViews}<br/>
                        예약 수: ${item.bookingCount}<br/>
                        평점: ${item.avgRating != null ? item.avgRating.toFixed(1) : 'N/A'}
                    </div>`
});

    kakao.maps.event.addListener(marker, 'click', function () {
    infowindow.open(map, marker);
});
} else {
    console.warn("지오코딩 실패:", item.location);
}
});
});
});


    async function sendStatsToGemini() {
    if (!stats || stats.length === 0) {
    document.getElementById('gemini-insight').innerHTML = `
                    <div class="alert alert-info" role="alert">
                        분석할 데이터가 없습니다.
                    </div>`;
    return; // 데이터가 없으면 함수 종료
}

    try {
    const res = await fetch('/analyze-heatmap', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(stats)
});

    geminiText = await res.text();
    let text = geminiText.replace(/```json|```/g, '').trim();

    try {
    parsed = JSON.parse(text);
    console.log("✅ parsed:", parsed);

    if (!Array.isArray(parsed) || parsed.length === 0) {
    document.getElementById('gemini-insight').innerHTML = `
                    <div class="alert alert-info" role="alert">
                        분석 결과 데이터가 없습니다.
                    </div>`;
    return;
}
} catch (e) {
    console.error("❌ JSON 파싱 실패:", e);
    document.getElementById('gemini-insight').innerHTML = `
                <div class="alert alert-danger">
                    Gemini 응답 파싱 실패<br>
                    <pre style="white-space: pre-wrap;">${text}</pre>
                </div>`;
    return;
}

    // 모든 carousel-item에서 active 클래스를 먼저 제거
    // HTML에 미리 active 클래스가 지정되어 있을 수 있으므로 초기화 시점에 모든 active를 제거하고
    // 첫 번째에만 다시 추가하는 것이 안전합니다.
    document.querySelectorAll('#top5Carousel .carousel-item').forEach(item => {
    item.classList.remove('active');
});


    // 데이터 삽입 대상: carousel1 ~ carousel5
    for (let i = 0; i < 5; i++) {
    const item = parsed[i];
    const el = document.getElementById(`carousel${i + 1}`);

    if (!el) {
    console.warn(`Carousel element with ID carousel${i + 1} not found.`);
    continue;
}

    // 첫 번째 아이템에만 active 클래스 추가
    if (i === 0) {
    el.classList.add('active');
}

    if (!item) {
    el.innerHTML = `
                            <div class="d-flex justify-content-center align-items-center" style="height: 300px;">
                                <span class="text-muted">데이터 없음</span>
                            </div>`;
    continue;
}

    el.innerHTML = `
                        <div class="d-flex justify-content-center">
                            <div class="card" style="width: 20rem;">
                                <div class="card-body">
                                    <h6 class="card-title">🏷️ ${item.호텔명 || ''}</h6>
                                    <p class="mb-1"><strong>조회수:</strong> ${item.조회수 || 0}</p>
                                    <p class="mb-1"><strong>예약수:</strong> ${item.예약수 || 0}</p>
                                    <p class="mb-1"><strong>평점:</strong> ${item.평점 != null ? item.평점.toFixed(1) : 'N/A'}</p>
                                    <p class="card-text mt-2 text-muted">${item.인사이트 || ''}</p>
                                </div>
                            </div>
                        </div>`;
}

    // 캐러셀 보이게 만들기
    document.getElementById("top5Carousel").classList.remove("d-none");

    // Bootstrap 4 캐러셀 초기화
    // 캐러셀이 HTML에 data-ride="carousel"이 이미 있다면, 여기서 다시 초기화할 필요가 없을 수 있습니다.
    // 중복 초기화가 문제의 원인일 수 있으므로 이 부분을 제거하거나,
    // HTML의 data-ride="carousel"을 제거하고 여기서만 초기화하는 것을 권장합니다.
    if (typeof $ !== 'undefined' && $('#top5Carousel').length > 0) {
    // Bootstrap 4 캐러셀 초기화
    // 만약 이미 초기화되었다면, 이 코드는 아무 일도 하지 않거나 에러를 낼 수 있습니다.
    // 강제로 재초기화하거나, data-ride를 제거하는 것이 좋습니다.
    $('#top5Carousel').carousel('cycle'); // 캐러셀을 수동으로 시작 (선택 사항)
    console.log("✅ Bootstrap 4 캐러셀이 초기화되었습니다. ID: top5Carousel");
} else {
    console.warn("Bootstrap 4 캐러셀 초기화: jQuery 또는 '#top5Carousel' 요소를 찾을 수 없습니다.");
}

} catch (error) { // 'e' 대신 'error'로 변경하여 일관성 유지
    console.error("❌ Gemini 분석 요청 실패:", error);
    document.getElementById('gemini-insight').innerHTML = `
            <div class="alert alert-danger">
                Gemini와의 연결에 실패했습니다.<br>오류: ${error.message || '알 수 없는 오류'}
            </div>`
}
}
})