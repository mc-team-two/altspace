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
            <li class="menu_item"><a href="<c:url value='/contacts'/>">고객센터</a></li>
            <li class="menu_item"><a href="<c:url value='/details'/>">예약 내역</a></li>
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
            <!-- 왼쪽 본문 영역 -->
            <div class="col-lg-8 items_4css">
                <div class="single_listing"
                     style="margin-top: 0 !important; padding: 30px; background-color: #fff; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.05);">
                    <h3 class="mb-4">비밀번호 재설정</h3>

                    <%-- 소셜로그인시 패스워드 유무로 판별 --%>
                    <c:choose>
                        <c:when test="${empty user.password}">
                            <div class="alert alert-warning">
                                소셜 로그인 사용자입니다. 비밀번호를 재설정할 수 없습니다.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <form id="resetPasswordForm">
                                <div class="form-group mb-3">
                                    <label for="currentPassword">현재 비밀번호</label>
                                    <input type="password" class="form-control" name="currentPassword"
                                           id="currentPassword" placeholder="현재 비밀번호" required>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="newPassword">새 비밀번호</label>
                                    <input type="password" class="form-control" name="newPassword"
                                           id="newPassword" placeholder="새 비밀번호" required>
                                </div>
                                <button type="submit" class="btn btn-primary">변경하기</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- 오른쪽 사이드바 -->
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

    <script src="<c:url value='js/jquery-3.2.1.min.js'/>"></script>
    <script src="<c:url value='https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js'/>"></script>
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