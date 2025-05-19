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

<!-- 메뉴 -->
<div class="menu trans_500">
    <div class="menu_content d-flex flex-column align-items-center justify-content-center text-center">
        <div class="menu_close_container"><div class="menu_close"></div></div>
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
    <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/offer_background.jpg"></div>
    <div class="home_content">
        <div class="home_title">마이 페이지</div>
    </div>
</div>

<!-- 마이페이지 본문 -->
<div class="blog">
    <div class="container">
        <div class="row">

            <!-- 왼쪽: 마이페이지 내용 -->
            <div class="col-lg-8 items_4css">
                <div class="single_listing" style="margin-top: 0 !important; padding: 30px; background-color: #fff; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.05);">
                    <div class="hotel_info text-center">
                        <div class="hotel_title_container mb-4">
                            <h1 class="hotel_title" style="font-size: 2.5rem; color: #333;">개인 정보</h1>
                        </div>
                        <div class="hotel_image">
                            <img src="/images/avatar.png" alt="User Profile" style="width: 150px; border-radius: 8px;">
                        </div>
                    </div>

                    <div class="hotel_info_text">
                        <c:if test="${errorMessage != null}">
                            <p class="error-message text-danger mb-3">${errorMessage}</p>
                        </c:if>

                        <br>
                        <br>
                        <c:if test="${not empty user}">
                            <div class="user-info-list">
                                <div class="user-info-item d-flex mb-2">
                                    <span class="user-info-label flex-shrink-0 me-2 fw-bold">이메일:</span>
                                    <span class="user-info-value">${user.email}</span>
                                </div>
                                <div class="user-info-item d-flex mb-2">
                                    <span class="user-info-label flex-shrink-0 me-2 fw-bold">이름:</span>
                                    <span class="user-info-value">${user.name}</span>
                                </div>
                                <div class="user-info-item d-flex mb-2">
                                    <span class="user-info-label flex-shrink-0 me-2 fw-bold">전화번호:</span>
                                    <span class="user-info-value">${user.phone}</span>
                                </div>
                                <div class="user-info-item d-flex mb-2">
                                    <span class="user-info-label flex-shrink-0 me-2 fw-bold">가입일:</span>
                                    <span class="user-info-value">${user.createDay}</span>
                                </div>
                                <div class="user-info-item d-flex mb-2">
                                    <span class="user-info-label flex-shrink-0 me-2 fw-bold">정보 수정일:</span>
                                    <span class="user-info-value">
                    <c:choose>
                        <c:when test="${user.updateDay == null}">
                            <span class="text-muted">수정 기록 없음</span>
                        </c:when>
                        <c:otherwise>
                            ${user.updateDay}
                        </c:otherwise>
                    </c:choose>
                </span>
                                </div>
                            </div>
                        </c:if>
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
            </div>

            <!-- 오른쪽 사이드바 -->
            <div class="col-lg-4 sidebar_list4css">
                <div class="sidebar_archives" style="margin-left: 100px;">
                    <div class="sidebar_title">MENU</div>
                    <div class="sidebar_list">
                        <ul>
                            <li><a href="<c:url value='/details'/>">나의 예약</a></li>
                            <li><a href="<c:url value='/review'/>">나의 리뷰</a></li>
                            <li><a href="<c:url value='/wishlist'/>">찜 목록</a></li>
                            <li><a href="<c:url value='/mypage'/>">나의 정보</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 스크립트 -->
<script src="js/darkmode.js"></script>