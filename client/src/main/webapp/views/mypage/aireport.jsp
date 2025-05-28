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
    /* 기존 스타일 유지 */
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
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
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
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
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

    .sidebar-link {
        display: flex;
        align-items: center;
        gap: 10px; /* 아이콘과 텍스트 간격 */
        font-size: 16px;
        color: #333;
        text-decoration: none;
        transition: all 0.2s ease-in-out;
    }

    .sidebar-link:hover {
        color: #007bff;
        transform: translateX(4px);
    }

    .sidebar-link i {
        font-size: 16px;
        width: 20px; /* 아이콘 영역 고정 */
        text-align: center;
    }

    /* 나의 정보 라인도 동일하게 맞추기 */
    .has-submenu > .sidebar-link {
        justify-content: space-between;
        padding-right: 8px; /* 드롭다운 아이콘 여유 공간 */
    }

    /* 드롭다운 아이콘 위치 조정 */
    .has-submenu .fa-chevron-down {
        margin-left: auto;
        font-size: 12px;
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
            <div class="col-lg-8">
                <div class="card mb-4 shadow-sm">
                    <div class="card-body">
                        <h4 class="card-title mb-3">🧩 나의 여행 소비 유형</h4>
                        <%-- 기존 JSTL 조건부 렌더링 제거 --%>
                        <div id="consumptionAnalysisContent">
                            <div id="analysisSpinner" class="text-center py-3">
                                <div class="spinner-border text-success" role="status">
                                    <span class="sr-only">Loading analysis...</span>
                                </div>
                                <p class="mt-2 text-muted">AI가 소비 패턴을 분석하는 중...</p>
                            </div>
                        </div>
                        <button type="button" class="btn btn-link p-0" data-toggle="modal"
                                data-target="#consumptionTypeModal">전체 유형 보기
                        </button>
                    </div>
                </div>

                <div class="modal fade" id="consumptionTypeModal" tabindex="-1" role="dialog"
                     aria-labelledby="consumptionTypeModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="consumptionTypeModalLabel">여행 소비 유형 전체 보기</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <ul class="list-unstyled">
                                    <li><strong>1️⃣ 짧고 자주 가는 여행자</strong> – 짧은 일정으로 여행을 자주 떠나며, 교통 편리성과 빠른 예약을 중시</li>
                                    <li><strong>2️⃣ 호캉스 중심 여행자</strong> – 숙소 내 휴식과 고급스러운 경험을 중시. 뷰, 수영장, 룸서비스 등 부대시설 선호
                                    </li>
                                    <li><strong>3️⃣ 자연 속 힐링파</strong> – 자연 속에서의 조용한 휴식을 선호. 숲속 리조트, 한적한 펜션 선호</li>
                                    <li><strong>4️⃣ 맛집 탐험가</strong> – 여행지의 먹거리와 맛집을 탐험. 맛집과 가까운 위치의 숙소 선호</li>
                                    <li><strong>5️⃣ 가족 중심 여행자</strong> – 가족 단위 여행이 많고, 키즈존·패밀리룸 등 편의시설을 중시</li>
                                    <li><strong>6️⃣ 액티비티 애호가</strong> – 숙소 근처에서 즐길 수 있는 레저/액티비티를 중요시. 서핑, 스키, MTB 등 계절별
                                        스포츠
                                    </li>
                                    <li><strong>7️⃣ 전통/문화 탐방객</strong> – 전통문화, 유적지, 로컬 체험 위주의 여행을 선호. 한옥스테이·문화유산 근처 숙소
                                        선호
                                    </li>
                                    <li><strong>8️⃣ 럭셔리 & 프리미엄</strong> – 고급스러운 인테리어와 서비스 중시. 풀빌라, 럭셔리 호텔, 스위트룸 등 선호
                                    </li>
                                    <li><strong>9️⃣ 장기 투숙형</strong> – 출장·여행으로 장기간 머무는 타입. 주방·세탁시설 완비된 레지던스 숙소 선호</li>
                                    <li><strong>🔟 커플/로맨틱 여행자</strong> – 프라이빗한 공간과 로맨틱한 분위기를 중요시. 야경, 루프탑, 감각적인 인테리어 선호
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm mt-4"> <%-- 마진 탑 추가 --%>
                    <div class="card-body">
                        <h4 class="card-title mb-3">🏠 AI 추천 숙소</h4>
                        <%-- 기존 JSTL 조건부 렌더링 제거 --%>
                        <div id="aiRecommendationsContainer" class="row">
                            <div id="recommendationSpinner" class="col-12 text-center py-3">
                                <div class="spinner-border text-primary" role="status">
                                    <span class="sr-only">Loading recommendations...</span>
                                </div>
                                <p class="mt-2 text-muted">AI 추천 데이터를 불러오는 중...</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 사이드바 (오른쪽) -->
            <div class="col-lg-4">
                <div class="position-sticky sidebar_list4css" style="top: 100px; z-index: 10;">
                    <div class="sidebar_archives" style="margin-left: 100px;">
                        <div class="sidebar_title" style="font-size: 20px; font-weight: bold; margin-bottom: 20px;">MENU</div>
                        <div class="sidebar_list">
                            <ul style="list-style: none; padding-left: 0;">
                                <li style="margin-bottom: 12px;">
                                    <a href="<c:url value='/details'/>" class="sidebar-link">
                                        <i class="fas fa-calendar-check"></i>
                                        <span>나의 예약</span>
                                    </a>
                                </li>
                                <li style="margin-bottom: 12px;">
                                    <a href="<c:url value='/review'/>" class="sidebar-link">
                                        <i class="fas fa-star"></i>
                                        <span>나의 리뷰</span>
                                    </a>
                                </li>
                                <li style="margin-bottom: 12px;">
                                    <a href="<c:url value='/wishlist'/>" class="sidebar-link">
                                        <i class="fas fa-heart"></i>
                                        <span>찜 목록</span>
                                    </a>
                                </li>
                                <li style="margin-bottom: 12px;">
                                    <a href="<c:url value='/mypage/aireport'/>" class="sidebar-link">
                                        <i class="fas fa-robot"></i>
                                        <span>AI 분석</span>
                                    </a>
                                </li>
                                <li class="has-submenu" style="margin-bottom: 12px;">
                                    <a href="javascript:void(0)" class="sidebar-link" style="display: flex; justify-content: space-between; align-items: center;">
                                        <span style="display: flex; align-items: center; gap: 10px;">
                                            <i class="fas fa-user"></i>
                                            나의 정보
                                        </span>
                                        <i class="fa fa-chevron-down"></i>
                                    </a>
                                    <ul class="submenu" style="padding-left: 20px; margin-top: 10px;">
                                        <li><a href="<c:url value='/mypage'/>">📄 내 정보</a></li>
                                        <li><a href="<c:url value='/mypage/modify-info'/>">✏️ 내 정보 수정</a></li>
                                        <li><a href="<c:url value='/mypage/reset-password'/>">🔒 비밀번호 재설정</a></li>
                                        <li><a href="<c:url value='/mypage/delete-account'/>">⛔ 회원 탈퇴</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

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
        <i class="fab fa-google" aria-hidden="true"></i>
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
<script src="<c:url value="js/aireport.js"/>"></script>
<script>
    // ✅ JSP가 userId를 EL로 넘겨줌 (null-safe)
    const userId = "<c:out value='${user.userId}' default=''/>".trim();
    const encodedUserId = encodeURIComponent(userId);
</script>
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