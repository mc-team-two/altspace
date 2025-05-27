<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<head>
    <link rel="stylesheet" type="text/css" href="<c:url value='styles/blog_styles.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='styles/blog_responsive.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='styles/darkmode.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='plugins/font-awesome-4.7.0/css/font-awesome.min.css'/>">
    <link rel="stylesheet"
          href="<c:url value="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css"/>">
    <link rel="stylesheet"
          href="<c:url value="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>">
</head>

<style>

    .submenu {
        display: none;
        margin-top: 6px; /* 상단 여백 추가 */
        padding-left: 18px; /* 좌측 들여쓰기 */
        padding-top: 6px; /* 내부 위쪽 여백 */
        list-style-type: circle;
        font-size: 14px;
        color: #555;
    }

    .submenu li {
        margin: 6px 0; /* 각 항목 간 간격 */
    }

    .has-submenu > a {
        cursor: pointer;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 5px 0;
    }

    .has-submenu.active > .submenu {
        display: block;
        animation: slideDown 0.3s ease;
    }

    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-5px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .card.h-100 {
        transition: transform 0.2s ease, box-shadow 0.2s ease;
        border: 1px solid #e0e0e0;
        border-radius: 8px;
        background-color: #fff;
    }

    .card.h-100:hover {
        transform: translateY(-4px);
        box-shadow: 0 8px 16px rgba(0,0,0,0.1);
    }

    .card-title {
        font-size: 1.1rem;
        font-weight: 600;
        color: #333;
    }

    .card-body p {
        font-size: 0.9rem;
        line-height: 1.4;
    }

    .card.h-100 {
        border: 1px solid #ddd; /* 카드 테두리 */
        border-radius: 8px;
        background-color: #fafafa; /* 조금 더 옅은 배경으로 */
        transition: transform 0.2s, box-shadow 0.2s;
    }

    [data-theme="dark"] .card.h-100 {
        border-color: #333; /* 다크모드용 테두리 색상 */
        background-color: #1e1e1e; /* 다크모드용 카드 배경 */
    }

    .card.h-100:hover {
        transform: translateY(-4px);
        box-shadow: 0 8px 16px rgba(0,0,0,0.1);
    }

    /* darkmode.css */
    [data-theme="dark"] {
        --bg-color: #121212; /* 다크 배경 */
        --text-color: #f5f5f5; /* 다크 텍스트 */
    }

    [data-theme="dark"] body,
    [data-theme="dark"] .card,
    [data-theme="dark"] .card-body {
        background-color: var(--bg-color);
        color: var(--text-color);
    }
</style>

<div class="menu trans_500">
    <div class="menu_content d-flex flex-column align-items-center justify-content-center text-center">
        <div class="menu_close_container">
            <div class="menu_close"></div>
        </div>
        <div class="logo menu_logo"><a href="/"><img src="images/logo.png" alt=""></a></div>
        <ul>
            <li class="menu_item"><a href="<c:url value='/'/>">홈</a></li>
            <li class="menu_item"><a href="<c:url value='/about'/>">Altspace란</a></li>
            <li class="menu_item"><a href="<c:url value='/faq1'/>">고객센터</a></li>
            <li class="menu_item"><a href="<c:url value='/mypage/aireport'/>">마이페이지</a></li>
        </ul>
    </div>
</div>
<!-- 홈 영역 -->
<div class="home">
    <div class="home_background parallax-window" data-parallax="scroll"
         data-image-src="images/offer_background.jpg"></div>
    <div class="home_content">
        <div class="home_title">마이 페이지</div>
    </div>
</div>
<div class="blog">
    <div class="container">
        <div class="row">
            <!-- 왼쪽 본문 -->
            <div class="col-lg-8">
                <!-- 🔎 사용자 소비유형 분석 카드 -->
                <div class="card mb-4 shadow-sm">
                    <div class="card-body">
                        <h4 class="card-title mb-3">🧩 나의 여행 소비 유형</h4>
                        <c:choose>
                            <c:when test="${not empty consumptionAnalysis}">
                                <p><strong>소비 유형:</strong> ${consumptionAnalysis.consumptionType}</p>
                                <p>${consumptionAnalysis.consumptionTypeDescription}</p>
                                <p><strong>추론 사유:</strong> ${consumptionAnalysis.favoriteAccommodationType}</p>
                                <button type="button" class="btn btn-link p-0" data-toggle="modal" data-target="#consumptionTypeModal">전체 유형 보기</button>
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted">AI 분석 데이터가 준비되지 않았습니다.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="modal fade" id="consumptionTypeModal" tabindex="-1" role="dialog" aria-labelledby="consumptionTypeModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="consumptionTypeModalLabel">여행 소비 유형 전체 보기</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <!-- 여기서 아까 말한 1~10 유형과 설명을 정리 -->
                                <ul class="list-unstyled">
                                    <li><strong>1️⃣ 짧고 자주 가는 여행자</strong> – 짧은 일정으로 여행을 자주 떠나며, 교통 편리성과 빠른 예약을 중시</li>
                                    <li><strong>2️⃣ 호캉스 중심 여행자</strong> – 숙소 내 휴식과 고급스러운 경험을 중시. 뷰, 수영장, 룸서비스 등 부대시설 선호</li>
                                    <li><strong>3️⃣ 자연 속 힐링파</strong> – 자연 속에서의 조용한 휴식을 선호. 숲속 리조트, 한적한 펜션 선호</li>
                                    <li><strong>4️⃣ 맛집 탐험가</strong> – 여행지의 먹거리와 맛집을 탐험. 맛집과 가까운 위치의 숙소 선호</li>
                                    <li><strong>5️⃣ 가족 중심 여행자</strong> – 가족 단위 여행이 많고, 키즈존·패밀리룸 등 편의시설을 중시</li>
                                    <li><strong>6️⃣ 액티비티 애호가</strong> – 숙소 근처에서 즐길 수 있는 레저/액티비티를 중요시. 서핑, 스키, MTB 등 계절별 스포츠</li>
                                    <li><strong>7️⃣ 전통/문화 탐방객</strong> – 전통문화, 유적지, 로컬 체험 위주의 여행을 선호. 한옥스테이·문화유산 근처 숙소 선호</li>
                                    <li><strong>8️⃣ 럭셔리 & 프리미엄</strong> – 고급스러운 인테리어와 서비스 중시. 풀빌라, 럭셔리 호텔, 스위트룸 등 선호</li>
                                    <li><strong>9️⃣ 장기 투숙형</strong> – 출장·여행으로 장기간 머무는 타입. 주방·세탁시설 완비된 레지던스 숙소 선호</li>
                                    <li><strong>🔟 커플/로맨틱 여행자</strong> – 프라이빗한 공간과 로맨틱한 분위기를 중요시. 야경, 루프탑, 감각적인 인테리어 선호</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 🏠 AI가 추천하는 숙소 카드 -->
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h4 class="card-title mb-3">🏠 AI 추천 숙소</h4>
                        <c:choose>
                            <c:when test="${not empty aiRecommendations}">
                                <div class="row">
                                    <c:forEach var="rec" items="${aiRecommendations}">
                                        <div class="col-md-6 col-lg-4 mb-3">
                                            <div class="card h-100 border-0 shadow-sm">
                                                <div class="card-body">
                                                    <h5 class="card-title mb-2">${rec.name}</h5>
                                                    <p class="mb-1 text-muted">위치: ${rec.location}</p>
                                                    <p class="small">${rec.recommendationReason}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted">AI 추천 데이터가 준비되지 않았습니다.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- 오른쪽 사이드바 -->
            <div class="col-lg-4 sidebar_list4css">
                <div class="sidebar_archives">
                    <div class="sidebar_title">MENU</div>
                    <div class="sidebar_list">
                        <ul>
                            <li><a href="<c:url value='/mypage/aireport'/>">AI 분석</a></li>
                            <li><a href="<c:url value='/details'/>">나의 예약</a></li>
                            <li><a href="<c:url value='/review'/>">나의 리뷰</a></li>
                            <li><a href="<c:url value='/wishlist'/>">찜 목록</a></li>
                            <li class="has-submenu">
                                <a href="javascript:void(0)">나의 정보 <i class="fa fa-chevron-down ms-1"></i></a>
                                <ul class="submenu">
                                    <li><a href="<c:url value='/mypage'/>">내 정보</a></li>
                                    <li><a href="<c:url value='/mypage/modify-info'/>">내 정보 수정</a></li>
                                    <li><a href="<c:url value='/mypage/reset-password'/>">비밀번호 재설정</a></li>
                                    <li><a href="<c:url value='/mypage/delete-account'/>">회원 탈퇴</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- /오른쪽 사이드바 -->
        </div>
    </div>
</div>

<!-- 챗봇 영역 -->

<div id="chatbot" class="chatbot">
    <div id="chat-icon" class="chat-icon">
        <i class="fas fa-comments" aria-hidden="true"></i>
    </div>
    <div id="chat-window" class="chat-window">
        <div class="chat-header">
            <span><spring:message code="chat-header"/></span>
            <button id="chat-close-btn" class="chat-close-btn">&times;</button>
        </div>
        <div class="chat-messages" id="chat-messages">

        </div>
        <div class="chat-input">
            <input type="text" id="chat-input" placeholder="<spring:message code="chat-input"/>">
            <button id="chat-send-btn"><spring:message code="chat-send-btn"/></button>
        </div>
    </div>
</div>
<div id="gemini-chatbot" class="chatbot chatbot-gemini">
    <div id="gemini-chat-icon" class="chat-icon gemini-icon">
        <i class="fab fa-android" aria-hidden="true"></i>
    </div>
    <div id="gemini-chat-window" class="chat-window gemini-window">
        <div class="chat-header gemini-header">
            <span><spring:message code="gemini-header"/></span>
            <button id="gemini-chat-close-btn" class="chat-close-btn">&times;</button>
        </div>
        <div class="chat-messages" id="gemini-chat-messages"></div>
        <div class="chat-input">
            <input type="text" id="gemini-chat-input" placeholder="<spring:message code="gemini-chat-input"/>">
            <button id="gemini-chat-send-btn"><spring:message code="gemini-chat-send-btn"/></button>
        </div>
    </div>
</div>


<script src="<c:url value='/js/jquery-3.2.1.min.js'/>"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="<c:url value='styles/bootstrap4/popper.js'/>"></script>
<script src="<c:url value='styles/bootstrap4/bootstrap.min.js'/>"></script>
<script src="<c:url value='plugins/Isotope/isotope.pkgd.min.js'/>"></script>
<script src="<c:url value='plugins/easing/easing.js'/>"></script>
<script src="<c:url value='plugins/parallax-js-master/parallax.min.js'/>"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const submenuToggles = document.querySelectorAll(".has-submenu > a");
        submenuToggles.forEach(function (toggle) {
            toggle.addEventListener("click", function () {
                this.parentElement.classList.toggle("active");
            });
        });
    });
</script>

