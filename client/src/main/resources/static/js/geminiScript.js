// ✅ 개선된 히트맵 매핑 및 시각화 코드

// ✅ stats 데이터 정의
const statsElement = document.getElementById("statsJson");
let stats = [];

if (statsElement && statsElement.textContent.trim()) {
    try {
        stats = JSON.parse(statsElement.textContent);
        console.log("📊 원본 히트맵 데이터:", stats);
    } catch (e) {
        console.error("📛 JSON 파싱 오류:", e);
    }
} else {
    console.warn("⚠ statsJson 요소가 없거나 내용이 비었습니다.");
}

// ✅ 개선된 지역 매핑 테이블 (우선순위 기반)
const provinceKeywords = {
    '서울특별시': ['서울특별시', '서울시', '서울'],
    '부산광역시': ['부산광역시', '부산시', '부산'],
    '대구광역시': ['대구광역시', '대구시', '대구'],
    '인천광역시': ['인천광역시', '인천시', '인천'],
    '광주광역시': ['광주광역시', '광주시', '광주'],
    '대전광역시': ['대전광역시', '대전시', '대전'],
    '울산광역시': ['울산광역시', '울산시', '울산'],
    '세종특별자치시': ['세종특별자치시', '세종시', '세종'],
    '제주특별자치도': ['제주특별자치도', '제주시', '제주도', '제주'],
    '경기도': ['경기도', '경기', '수원', '성남', '안양', '부천', '광명', '평택', '동두천', '안산', '고양', '과천', '구리', '남양주', '오산', '시흥', '군포', '의왕', '하남', '용인', '파주', '이천', '안성', '김포', '화성', '광주시', '양주', '포천', '여주', '연천', '가평', '양평'],
    '강원도': ['강원도', '강원', '춘천', '원주', '강릉', '동해', '태백', '속초', '삼척', '홍천', '횡성', '영월', '평창', '정선', '철원', '화천', '양구', '인제', '고성', '양양'],
    '충청북도': ['충청북도', '충북', '청주', '충주', '제천', '보은', '옥천', '영동', '증평', '진천', '괴산', '음성', '단양'],
    '충청남도': ['충청남도', '충남', '천안', '공주', '보령', '아산', '서산', '논산', '계룡', '당진', '금산', '부여', '서천', '청양', '홍성', '예산', '태안'],
    '전라북도': ['전라북도', '전북', '전주', '군산', '익산', '정읍', '남원', '김제', '완주', '진안', '무주', '장수', '임실', '순창', '고창', '부안'],
    '전라남도': ['전라남도', '전남', '목포', '여수', '순천', '나주', '광양', '담양', '곡성', '구례', '고흥', '보성', '화순', '장흥', '강진', '해남', '영암', '무안', '함평', '영광', '장성', '완도', '진도', '신안'],
    '경상북도': ['경상북도', '경북', '포항', '경주', '김천', '안동', '구미', '영주', '영천', '상주', '문경', '경산', '군위', '의성', '청송', '영양', '영덕', '청도', '고령', '성주', '칠곡', '예천', '봉화', '울진', '울릉'],
    '경상남도': ['경상남도', '경남', '창원', '진주', '통영', '사천', '김해', '밀양', '거제', '양산', '의령', '함안', '창녕', '고성', '남해', '하동', '산청', '함양', '거창', '합천']
};

const provinceToEnglish = {
    '서울특별시': 'Seoul',
    '부산광역시': 'Busan',
    '대구광역시': 'Daegu',
    '인천광역시': 'Incheon',
    '광주광역시': 'Gwangju',
    '대전광역시': 'Daejeon',
    '울산광역시': 'Ulsan',
    '세종특별자치시': 'Sejong',
    '경기도': 'Gyeonggi',
    '강원도': 'Gangwon',
    '충청북도': 'Chungbuk',
    '충청남도': 'Chungnam',
    '전라북도': 'Jeonbuk',
    '전라남도': 'Jeonnam',
    '경상북도': 'Gyeongbuk',
    '경상남도': 'Gyeongnam',
    '제주특별자치도': 'Jeju'
};

// ✅ 개선된 지역 매핑 함수 (우선순위 기반)
function getProvince(location) {
    if (!location) return null;

    const normalizedLocation = location.trim().toLowerCase();

    // 각 도별로 키워드 매칭 (긴 키워드부터 우선 매칭)
    for (const [province, keywords] of Object.entries(provinceKeywords)) {
        // 키워드를 길이 순으로 정렬 (긴 것부터)
        const sortedKeywords = keywords.sort((a, b) => b.length - a.length);

        for (const keyword of sortedKeywords) {
            if (normalizedLocation.includes(keyword.toLowerCase())) {
                return province;
            }
        }
    }

    return null;
}

// ✅ 데이터 집계 및 디버깅
const allProvinces = Object.keys(provinceToEnglish);
const aggregatedViews = {};
const unmappedLocations = [];
const mappingDetails = [];

// 초기화
allProvinces.forEach(p => aggregatedViews[p] = 0);

// 데이터 집계
stats.forEach(item => {
    const province = getProvince(item.location);
    const views = Number(item.totalViews) || 0;

    if (province) {
        aggregatedViews[province] += views;
        mappingDetails.push({
            original: item.location,
            mapped: province,
            views: views
        });
    } else {
        unmappedLocations.push({
            location: item.location,
            views: views
        });
    }
});

// ✅ 디버깅 정보 출력
console.log("🗺️ 지역별 집계 결과:", aggregatedViews);
console.log("✅ 매핑 성공:", mappingDetails);
if (unmappedLocations.length > 0) {
    console.warn("❓ 매핑 실패한 지역들:", unmappedLocations);
}

// ✅ 데이터 분포 분석 및 색상 구간 최적화
const viewValues = Object.values(aggregatedViews).filter(v => v > 0);
const maxViews = Math.max(...viewValues);
const minViews = Math.min(...viewValues.filter(v => v > 0));
const avgViews = viewValues.reduce((a, b) => a + b, 0) / viewValues.length;

console.log("📈 데이터 분포:", { min: minViews, max: maxViews, avg: avgViews });

// ✅ 개선된 Google GeoChart
google.charts.load('current', {packages: ['geochart']});
google.charts.setOnLoadCallback(() => {
    const dataArray = [['Province', '조회수']];

    // 데이터가 있는 지역만 추가
    for (const prov of allProvinces) {
        const views = aggregatedViews[prov];
        if (views > 0) {  // 조회수가 0보다 큰 경우만 표시
            dataArray.push([provinceToEnglish[prov], views]);
        }
    }

    console.log("🎨 GeoChart 데이터:", dataArray);

    const data = google.visualization.arrayToDataTable(dataArray);

    // 동적 색상 구간 설정
    const colorStops = [];
    if (maxViews > 0) {
        colorStops.push('#e3f2fd');  // 연한 파랑
        if (maxViews > minViews) {
            colorStops.push('#2196f3');  // 파랑
            colorStops.push('#1976d2');  // 진한 파랑
            colorStops.push('#0d47a1');  // 매우 진한 파랑
        }
    }

    const options = {
        region: 'KR',
        resolution: 'provinces',
        displayMode: 'regions',
        colorAxis: {
            colors: colorStops,
            minValue: minViews > 0 ? minViews : 0,
            maxValue: maxViews
        },
        backgroundColor: '#ffffff',
        datalessRegionColor: '#f5f5f5',
        defaultColor: '#f5f5f5',
        tooltip: {
            textStyle: {
                fontSize: 12,
                fontName: 'Arial'
            }
        }
    };

    const chart = new google.visualization.GeoChart(document.getElementById('regions_div'));
    chart.draw(data, options);

    // 차트 렌더링 후 통계 표시
    displayStats();
});

// ✅ 통계 정보 표시 함수
function displayStats() {
    const statsContainer = document.getElementById('mapping-stats');
    if (!statsContainer) return;

    const totalMapped = mappingDetails.length;
    const totalUnmapped = unmappedLocations.length;
    const mappingRate = ((totalMapped / (totalMapped + totalUnmapped)) * 100).toFixed(1);

    const topProvinces = Object.entries(aggregatedViews)
        .filter(([_, views]) => views > 0)
        .sort(([_, a], [__, b]) => b - a)
        .slice(0, 5);

    let statsHtml = `
        <div class="alert alert-info">
            <h6>📊 매핑 통계</h6>
            <p><strong>매핑 성공률:</strong> ${mappingRate}% (${totalMapped}/${totalMapped + totalUnmapped})</p>
            <p><strong>상위 5개 지역:</strong></p>
            <ul>
    `;

    topProvinces.forEach(([province, views]) => {
        statsHtml += `<li>${province}: ${views.toLocaleString()}회</li>`;
    });

    statsHtml += `</ul></div>`;

    if (unmappedLocations.length > 0) {
        statsHtml += `
            <div class="alert alert-warning">
                <h6>❓ 매핑되지 않은 지역 (${unmappedLocations.length}개)</h6>
                <small>`;
        unmappedLocations.slice(0, 10).forEach(item => {
            statsHtml += `${item.location} (${item.views}회), `;
        });
        if (unmappedLocations.length > 10) {
            statsHtml += `외 ${unmappedLocations.length - 10}개...`;
        }
        statsHtml += `</small></div>`;
    }

    statsContainer.innerHTML = statsHtml;
}

// ✅ 기존 Gemini 분석 코드는 그대로 유지
async function sendStatsToGemini() {
    try {
        const res = await fetch('/analyze-heatmap', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(stats)
        });
        const text = (await res.text()).replace(/```json|```/g, '').trim();
        const parsed = JSON.parse(text);
        if (!Array.isArray(parsed)) throw new Error('분석 결과 형식 오류');

        document.querySelectorAll('#top5Carousel .carousel-item').forEach(item => item.classList.remove('active'));

        for (let i = 0; i < 5; i++) {
            const item = parsed[i];
            const el = document.getElementById(`carousel${i + 1}`);
            if (!el) continue;
            if (i === 0) el.classList.add('active');
            if (!item) {
                el.innerHTML = `<div class="d-flex justify-content-center align-items-center" style="height: 300px;">
                    <span class="text-muted">데이터 없음</span></div>`;
                continue;
            }
            el.innerHTML = `<div class="d-flex justify-content-center">
                <div class="card" style="width: 20rem;"><div class="card-body">
                <h6 class="card-title">🏷️ ${item.호텔명 || ''}</h6>
                <p class="mb-1"><strong>조회수:</strong> ${item.조회수 || 0}</p>
                <p class="mb-1"><strong>예약수:</strong> ${item.예약수 || 0}</p>
                <p class="mb-1"><strong>평점:</strong> ${item.평점 != null ? item.평점.toFixed(1) : 'N/A'}</p>
                <p class="card-text mt-2 text-muted">${item.인사이트 || ''}</p></div></div></div>`;
        }

        document.getElementById("top5Carousel").classList.remove("d-none");
        if (typeof $ !== 'undefined' && $('#top5Carousel').length > 0) {
            $('#top5Carousel').carousel('cycle');
        }
    } catch (error) {
        console.error("Gemini 분석 오류:", error);
        document.getElementById('gemini-insight').innerHTML = `<div class="alert alert-danger">
            Gemini 분석 중 오류 발생<br>${error.message}</div>`;
    }
}

document.addEventListener("DOMContentLoaded", () => {
    if (stats.length > 0) {
        sendStatsToGemini();
    }
});