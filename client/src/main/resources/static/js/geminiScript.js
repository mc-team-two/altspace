// ✅ Google Charts 로드
google.charts.load('current', {packages: ['geochart']});

/**
 * 데이터를 로컬스토리지에 저장 (유효기간 포함)
 */
function saveToLocalStorageWithExpiry(key, data, ttlMillis) {
    const now = Date.now();
    const item = {
        data,
        expiry: now + ttlMillis
    };
    localStorage.setItem(key, JSON.stringify(item));
}

/**
 * 로컬스토리지에서 데이터 읽기 (유효기간 검사)
 */
function loadFromLocalStorageWithExpiry(key) {
    const itemStr = localStorage.getItem(key);
    if (!itemStr) return null;

    try {
        const item = JSON.parse(itemStr);
        const now = Date.now();
        if (now > item.expiry) {
            console.log("⏰ 로컬스토리지 캐시 만료됨!");
            localStorage.removeItem(key); // 만료되었으면 삭제
            return null;
        }
        return item.data;
    } catch (e) {
        console.error("로컬스토리지 파싱 오류:", e);
        return null;
    }
}

/**
 * ✅ 캐러셀 데이터를 로드하는 함수
 */
function loadCarouselData() {
    document.getElementById('carouselSpinner').classList.remove('d-none');
    document.getElementById('top5Carousel').classList.add('d-none');

    fetch('/api/gemini/get-popular-stats')
        .then(response => response.json())
        .then(data => {
            console.log(data);
            document.getElementById('carouselSpinner').classList.add('d-none');
            document.getElementById('top5Carousel').classList.remove('d-none');
        })
        .catch(error => {
            console.error(error);
            document.getElementById('carouselSpinner').classList.add('d-none');
        });
}

// ✅ 지역별 매핑 키워드 및 영어 이름
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
    '서울특별시': 'Seoul', '부산광역시': 'Busan', '대구광역시': 'Daegu', '인천광역시': 'Incheon',
    '광주광역시': 'Gwangju', '대전광역시': 'Daejeon', '울산광역시': 'Ulsan', '세종특별자치시': 'Sejong',
    '경기도': 'Gyeonggi', '강원도': 'Gangwon', '충청북도': 'Chungbuk', '충청남도': 'Chungnam',
    '전라북도': 'Jeonbuk', '전라남도': 'Jeonnam', '경상북도': 'Gyeongbuk', '경상남도': 'Gyeongnam', '제주특별자치도': 'Jeju'
};

function getProvince(location) {
    if (!location) return null;
    const normalized = location.trim().toLowerCase();
    for (const [province, keywords] of Object.entries(provinceKeywords)) {
        const sorted = keywords.sort((a, b) => b.length - a.length);
        for (const keyword of sorted) {
            if (normalized.includes(keyword.toLowerCase())) {
                return province;
            }
        }
    }
    return null;
}

function processStatsData(stats) {
    const aggregatedViews = {};
    const allProvinces = Object.keys(provinceToEnglish);
    allProvinces.forEach(p => aggregatedViews[p] = 0);

    stats.forEach(item => {
        const province = getProvince(item.location);
        const views = Number(item.totalViews) || 0;
        if (province) aggregatedViews[province] += views;
    });

    const dataArray = [['Province', '조회수']];
    for (const prov of allProvinces) {
        const views = aggregatedViews[prov];
        if (views > 0) {
            dataArray.push([provinceToEnglish[prov], views]);
        }
    }

    const maxViews = Math.max(...Object.values(aggregatedViews));
    const minViews = Math.min(...Object.values(aggregatedViews).filter(v => v > 0));

    const options = {
        region: 'KR',
        resolution: 'provinces',
        displayMode: 'regions',
        colorAxis: {
            colors: ['#e3f2fd', '#2196f3', '#1976d2', '#0d47a1'],
            minValue: minViews > 0 ? minViews : 0,
            maxValue: maxViews
        },
        backgroundColor: '#ffffff',
        datalessRegionColor: '#f5f5f5'
    };

    const data = google.visualization.arrayToDataTable(dataArray);
    const chart = new google.visualization.GeoChart(document.getElementById('regions_div'));
    chart.draw(data, options);
}

async function sendStatsToGemini(stats) {
    const carouselSpinner = document.getElementById("carouselSpinner");
    const carousel = document.getElementById("top5Carousel");

    carouselSpinner.classList.remove("d-none");
    carousel.classList.add("d-none");

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
            el.innerHTML = item ? `
        <div class="d-flex justify-content-center">
          <div class="card" style="width: 20rem;"><div class="card-body">
          <h6 class="card-title">🏷️ ${item.호텔명 || ''}</h6>
          <p class="mb-1"><strong>조회수:</strong> ${item.조회수 || 0}</p>
          <p class="mb-1"><strong>예약수:</strong> ${item.예약수 || 0}</p>
          <p class="mb-1"><strong>평점:</strong> ${item.평점 != null ? item.평점.toFixed(1) : 'N/A'}</p>
          <p class="card-text mt-2 text-muted">${item.인사이트 || ''}</p></div></div></div>` :
                `<div class="d-flex justify-content-center align-items-center" style="height: 300px;">
          <span class="text-muted">데이터 없음</span></div>`;
        }

        carouselSpinner.classList.add("d-none");
        carousel.classList.remove("d-none");
        if (typeof $ !== 'undefined' && $('#top5Carousel').length > 0) {
            $('#top5Carousel').carousel('cycle');
        }
    } catch (error) {
        console.error("Gemini 분석 오류:", error);
        carouselSpinner.innerHTML = `<div class="alert alert-danger">분석 오류 발생<br>${error.message}</div>`;
    }
}

document.addEventListener("DOMContentLoaded", async () => {
    const heatmapSpinner = document.getElementById("heatmapSpinner");
    const regionsDiv = document.getElementById("regions_div");

    const localKey = "popularStatsData";
    const ttl = 60 * 60 * 1000; // 1시간

    let stats = loadFromLocalStorageWithExpiry(localKey);

    if (stats && Array.isArray(stats)) {
        console.log("✅ 로컬스토리지에서 불러온 유효한 데이터:", stats);
        processStatsData(stats);
        sendStatsToGemini(stats);
        heatmapSpinner.style.display = "none";
        regionsDiv.style.display = "block";
    } else {
        try {
            const response = await fetch("/api/gemini/get-popular-stats");
            if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
            stats = await response.json();
            console.log("🔥 API로 불러온 데이터:", stats);

            saveToLocalStorageWithExpiry(localKey, stats, ttl);

            processStatsData(stats);
            sendStatsToGemini(stats);
            heatmapSpinner.style.display = "none";
            regionsDiv.style.display = "block";
        } catch (err) {
            console.error("🚨 인기 지역 통계 조회 실패!", err);
            heatmapSpinner.innerHTML = `<div class="alert alert-danger">데이터를 불러올 수 없습니다.</div>`;
        }
    }
});