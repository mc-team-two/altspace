<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <link rel="stylesheet" type="text/css" href="<c:url value='styles/blog_styles.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='styles/blog_responsive.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='styles/darkmode.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="plugins/font-awesome-4.7.0/css/font-awesome.min.css"/>">
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

    @media (min-width: 992px) {
        .pl-lg-5 {
            padding-left: 5rem !important; /* 간격 확보 */
        }
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
<body>
<div class="menu trans_500">
    <div class="menu_content d-flex flex-column align-items-center justify-content-center text-center">
        <div class="menu_close_container"><div class="menu_close"></div></div>
        <div class="logo menu_logo"><a href="/"><img src="images/logo.png" alt=""></a></div>
        <ul>
            <li class="menu_item"><a href="<c:url value="/"/> ">홈</a></li>
            <li class="menu_item"><a href="<c:url value="/about"/> ">Altspace란</a></li>
            <li class="menu_item"><a href="<c:url value="/faq1"/> ">고객센터</a></li>
            <li class="menu_item"><a href="<c:url value="/mypage/aireport"/> ">마이페이지</a></li>
        </ul>
    </div>
</div>
<!-- 홈 -->
<div class="home">
    <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/offer_background.jpg"></div>
    <div class="home_content">
        <div class="home_title">찜 목록</div>
    </div>
</div>

<!-- 센터 -->
<div class="blog">
    <div class="container">
        <div class="row">
            <!-- 센터 영역 (찜 목록) -->
            <div class="col-lg-8 items_4css">
                <c:choose>
                    <c:when test="${empty wishlists}">
                        <div class="card mb-4 p-4 shadow-sm text-center item_none">
                            <img src="images/avatar.png" alt="찜한 숙소가 없어요!" class="img-fluid mb-3"
                                 style="max-width: 120px;">
                            <h5 class="mb-1 font-weight-bold text-dark">아직 찜한 숙소가 없어요!</h5>
                            <p class="text-muted mb-0">마음에 드는 숙소를 찜하고 편하게 다시 확인해보세요.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="offers_grid" style="margin-top: 0 !important;">
                            <c:forEach var="w" items="${wishlists}">
                                <div class="offers_item">
                                    <div class="row">
                                        <div class="col-lg-4">
                                            <div class="offers_image_container">
                                                <div class="offers_image_background"
                                                     style="background-image:url('/imgs/${w.image1Name}')">
                                                </div>
                                                <div class="offer_name">
                                                    <a href="<c:url value='/detail?id=${w.accommodationId}'/>">${w.name}</a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-8">
                                            <div class="offers_content">
                                                <div class="offers_price">
                                                    ₩<fmt:formatNumber value="${w.priceNight}" type="number"/>
                                                    <span> / 1박</span>
                                                </div>
                                                <p class="offers_text mt-4">${w.description}</p>
                                                <div class="offers_icons">
                                                    <ul class="offers_icons_list d-flex flex-row p-0" style="list-style: none; gap: 1px;">
                                                        <c:if test="${w.barbecue}">
                                                            <li class="offers_icons_item" data-popper-content="바베큐 시설 안내">
                                                                <i class="fa fa-fire  text-warning" aria-hidden="true"></i>
                                                            </li>
                                                        </c:if>
                                                        <c:if test="${w.breakfast}">
                                                            <li class="offers_icons_item" data-popper-content="맛있는 조식 제공">
                                                                <i class="fa fa-coffee text-danger" aria-hidden="true"></i>
                                                            </li>
                                                        </c:if>
                                                        <c:if test="${w.pet}">
                                                            <li class="offers_icons_item" data-popper-content="반려동물 동반">
                                                                <i class="fa fa-paw text-info" aria-hidden="true"></i>
                                                            </li>
                                                        </c:if>
                                                        <c:if test="${w.pool}">
                                                            <li class="offers_icons_item" data-popper-content="시원한 수영장">
                                                                <i class="fa fa-swimmer text-primary" aria-hidden="true"></i>
                                                            </li>
                                                        </c:if>
                                                    </ul>
                                                </div>
                                                <div class="button book_button">
                                                    <a href="<c:url value="/detail?id=${w.accommodationId}"/>">상세보기<span></span><span></span><span></span></a>
                                                </div>
                                                <!-- 리뷰 평점 영역 -->
                                                <div class="offer_reviews d-flex align-items-center mb-2" style="gap: 10px;">
                                                    <div class="offer_reviews_content"> <!-- 더 붙이기 위해 mr-2 적용 -->
                                                        <div class="offer_reviews_title">
                                                            <c:choose>
                                                                <c:when test="${w.averageRating >= 4}">최고예요!</c:when>
                                                                <c:when test="${w.averageRating >= 3}">좋아요!</c:when>
                                                                <c:when test="${w.averageRating >= 2}">괜찮아요!</c:when>
                                                                <c:when test="${w.averageRating >= 1}">그저 그래요!</c:when>
                                                                <c:otherwise>평가가 없어요</c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                    <div class="offer_reviews_rating text-center">
                                                            ${w.averageRating}
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
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

<script src="js/darkmode.js"></script>
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