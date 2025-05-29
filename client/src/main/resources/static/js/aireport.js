function saveToLocalStorageWithExpiry(key, data, ttlMillis) {
    const now = Date.now();
    const item = {
        data,
        expiry: now + ttlMillis
    };
    localStorage.setItem(key, JSON.stringify(item));
}

function loadFromLocalStorageWithExpiry(key) {
    const itemStr = localStorage.getItem(key);
    if (!itemStr) return null;

    try {
        const item = JSON.parse(itemStr);
        const now = Date.now();
        if (now > item.expiry) {
            console.log("⏰ 로컬스토리지 캐시 만료됨!");
            localStorage.removeItem(key);
            return null;
        }
        return item.data;
    } catch (e) {
        console.error("로컬스토리지 파싱 오류:", e);
        return null;
    }
}

document.addEventListener("DOMContentLoaded", function () {

    console.log("userId in JS (from JSP):", userId);

    if (userId !== "") {
        loadAiReportData(userId);
    } else {
        console.error("사용자 ID를 찾을 수 없습니다. AI 리포트를 로드할 수 없습니다.");
        document.getElementById('analysisSpinner').innerHTML = `
                <div class="alert alert-warning text-center" role="alert">
                    로그인이 필요합니다.
                    <a href="/login" class="alert-link">로그인 페이지로 이동</a>
                </div>`;
        document.getElementById('recommendationSpinner').innerHTML = `
                <div class="alert alert-warning text-center" role="alert">
                    로그인이 필요합니다.
                    <a href="/login" class="alert-link">로그인 페이지로 이동</a>
                </div>`;

        document.getElementById('analysisSpinner').classList.add('d-none');
        document.getElementById('recommendationSpinner').classList.add('d-none');
    }
});

async function loadAiReportData(userId) {
    const consumptionAnalysisContent = document.getElementById('consumptionAnalysisContent');
    const aiRecommendationsContainer = document.getElementById('aiRecommendationsContainer');
    const analysisSpinner = document.getElementById('analysisSpinner');
    const recommendationSpinner = document.getElementById('recommendationSpinner');

    console.log("🟩 loadAiReportData에 전달된 userId:", userId);

    // 초기 상태
    analysisSpinner.classList.remove('d-none');
    recommendationSpinner.classList.remove('d-none');
    consumptionAnalysisContent.innerHTML = '';
    aiRecommendationsContainer.innerHTML = '';

    // 🔑 로컬스토리지 키 & 유효기간 (1시간)
    const localKey = `aiReportData_${userId}`;
    const ttl = 60 * 60 * 1000; // 1시간

    // ✅ 1) 로컬스토리지 확인
    let data = loadFromLocalStorageWithExpiry(localKey);

    if (data && data.success) {
        console.log("✅ 로컬스토리지에서 AI 리포트 데이터를 사용합니다:", data);
        renderAiReportData(data);
    } else {
        try {
            // ⭐ userId 인코딩
            const encodedUserId = encodeURIComponent(userId);
            console.log("🟩 encodedUserId:", encodedUserId);
            const response = await fetch(`/api/gemini/user-ai-data?userId=${encodedUserId}`);

            if (!response.ok) {
                const errorText = await response.text();
                throw new Error(`HTTP error! status: ${response.status}, message: ${errorText}`);
            }

            data = await response.json();
            console.log("✅ API로 받은 AI 리포트 데이터:", data);

            if (data.success) {
                // ⭐ 로컬스토리지에 저장
                saveToLocalStorageWithExpiry(localKey, data, ttl);
                renderAiReportData(data);
            } else {
                console.error("AI 리포트 데이터 처리 실패 (서버 로직 오류):", data.message);
                consumptionAnalysisContent.innerHTML = `<div class="alert alert-danger text-center">데이터 로드 실패: ${data.message || '알 수 없는 오류'}</div>`;
                aiRecommendationsContainer.innerHTML = '';
            }

        } catch (error) {
            console.error("🚨 네트워크/파싱 오류:", error);
            consumptionAnalysisContent.innerHTML = `<div class="alert alert-danger text-center">데이터를 불러올 수 없습니다. (${error.message})</div>`;
            aiRecommendationsContainer.innerHTML = '';
        }
    }

    analysisSpinner.classList.add('d-none');
    recommendationSpinner.classList.add('d-none');
}

/**
 * 📦 AI 리포트 데이터를 화면에 렌더링
 */
function renderAiReportData(data) {
    const consumptionAnalysisContent = document.getElementById('consumptionAnalysisContent');
    const aiRecommendationsContainer = document.getElementById('aiRecommendationsContainer');

    // 소비 유형 분석
    if (data.consumptionAnalysis) {
        const analysis = data.consumptionAnalysis;
        consumptionAnalysisContent.innerHTML = `
            <p><strong>소비 유형:</strong> ${analysis.consumptionType || '정보 없음'}</p>
            <p>${analysis.consumptionTypeDescription || '설명 없음'}</p>
            <p><strong>추론 사유:</strong> ${analysis.favoriteAccommodationType || '정보 없음'}</p>
        `;
    } else {
        consumptionAnalysisContent.innerHTML = '<p class="text-muted">AI 분석 데이터가 준비되지 않았습니다.</p>';
    }

    // 추천 숙소
    aiRecommendationsContainer.innerHTML = '<div class="row" id="recommendationsGrid"></div>';
    const recommendationsGrid = document.getElementById('recommendationsGrid');
    if (data.aiRecommendations && data.aiRecommendations.length > 0) {
        data.aiRecommendations.forEach(rec => {
            recommendationsGrid.innerHTML += `
                <div class="col-md-6 col-lg-4 mb-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title mb-2">${rec.name || '숙소명 없음'}</h5>
                            <p class="mb-1 text-muted">위치: ${rec.location || '위치 정보 없음'}</p>
                            <p class="small">${rec.recommendationReason || '추천 사유 없음'}</p>
                        </div>
                    </div>
                </div>
            `;
        });
    } else {
        recommendationsGrid.innerHTML = '<div class="col-12"><p class="text-muted">AI 추천 데이터가 준비되지 않았습니다.</p></div>';
    }
}