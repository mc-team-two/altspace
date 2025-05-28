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

    try {
        // ⭐ userId 인코딩
        const encodedUserId = encodeURIComponent(userId);
        console.log("🟩 encodedUserId:", encodedUserId);
        const response = await fetch(`/api/gemini/user-ai-data?userId=${encodedUserId}`);

        if (!response.ok) {
            const errorText = await response.text();
            throw new Error(`HTTP error! status: ${response.status}, message: ${errorText}`);
        }

        const data = await response.json();
        console.log("✅ AI 리포트 데이터 수신:", data);

        if (data.success) {
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

        } else {
            console.error("AI 리포트 데이터 처리 실패 (서버 로직 오류):", data.message);
            consumptionAnalysisContent.innerHTML = `<div class="alert alert-danger text-center">데이터 로드 실패: ${data.message || '알 수 없는 오류'}</div>`;
            aiRecommendationsContainer.innerHTML = '';
        }

    } catch (error) {
        console.error("🚨 네트워크/파싱 오류:", error);
        consumptionAnalysisContent.innerHTML = `<div class="alert alert-danger text-center">데이터를 불러올 수 없습니다. (${error.message})</div>`;
        aiRecommendationsContainer.innerHTML = '';
    } finally {
        analysisSpinner.classList.add('d-none');
        recommendationSpinner.classList.add('d-none');
    }
}