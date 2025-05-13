<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<head>
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/blog_styles.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/blog_responsive.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/darkmode.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/chatbot.css"/>">
</head>

    <style>
        /* blog_styles.css 혹은 내부 style 태그에 추가 */
        @media (min-width: 992px) {
            .pl-lg-5 {
                padding-left: 5rem !important;  /* 간격 확보 */
            }
        }
    </style>
</head>

<body>

<div class="menu trans_500">
    <div class="menu_content d-flex flex-column align-items-center justify-content-center text-center">
        <div class="menu_close_container"><div class="menu_close"></div></div>
        <div class="logo menu_logo"><a href="/"><img src="images/logo.png" alt=""></a></div>
        <ul>
            <li class="menu_item"><a href="<c:url value="/"/> ">홈</a></li>
            <li class="menu_item"><a href="<c:url value="/about"/> ">Altspace란</a></li>
            <li class="menu_item"><a href="<c:url value="/contacts"/> ">고객센터</a></li>
            <li class="menu_item"><a href="<c:url value="/details"/> ">마이페이지</a></li>
        </ul>
    </div>
</div>
<!-- 홈 -->
<div class="home">
    <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/offer_background.jpg"></div>
    <div class="home_content">
        <div class="home_title">나의 예약</div>
    </div>
</div>

<!-- 센터 -->
<div class="blog">
    <div class="container">
        <div class="row align-items-start" style="min-height: 100vh;">
            <!-- 예약 내역 -->
            <div class="col-lg-8">
                <div class="row">
                    <c:forEach var="py" items="${paymentList}">
                        <div class="col-md-6 mb-4">
                            <div class="card shadow-sm h-100">
                                <!-- 숙박 이름 -->
                                <div class="card-header bg-primary text-white">
                                    <h5 class="mb-0">${py.name}</h5>
                                </div>

                                <!-- 이미지 + 체크인 정보 -->
                                <img src="${pageContext.request.contextPath}/images/${py.image1Name}"
                                     class="card-img-top"
                                     alt="숙소 이미지"
                                     style="height: 200px; object-fit: cover;">

                                <div class="card-body">
                                    <div class="d-flex justify-content-between mb-2" style="margin-top: -5px;">
                                        <span class="badge bg-info text-dark" style="font-size: 0.85rem;">
                                            결제 상태: ${py.payStatus}
                                        </span>
                                        <span style="font-size: 0.85rem; color: black;">
                                            체크인: ${py.checkIn}
                                        </span>
                                    </div>


                                    <!-- 링크들 -->
                                    <div class="d-flex flex-column gap-1">
                                        <a class="btn btn-outline-secondary btn-sm" href="<c:url value='/detail?id=${py.accommodationId}'/>">숙소 정보</a>
                                        <a class="btn btn-outline-primary btn-sm" href="<c:url value='/detail?id=${py.accommodationId}&pyStatus=${py.payStatus}&paymentId=${py.paymentId}'/>">결제 정보</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <div id="chatbot" class="chatbot">
                        <div id="chat-icon" class="chat-icon">
                            <i class="fa fa-comment" aria-hidden="true"></i>
                        </div>
                        <div id="chat-window" class="chat-window">
                            <div class="chat-header">
                                <span>챗봇과 대화하기</span>
                                <button id="chat-close-btn" class="chat-close-btn">&times;</button>
                            </div>
                            <div class="chat-messages" id="chat-messages">

                            </div>
                            <div class="chat-input">
                                <input type="text" id="chat-input" placeholder="메세지를 입력해주세요">
                                <button id="chat-send-btn">보내기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 사이드바 -->
            <div class="col-lg-4">
                <div class="position-sticky" style="top: 100px; z-index: 10;">
                    <!-- 사이드바 메뉴 -->
                    <div class="sidebar_archives" style="margin-left: 100px;">
                        <div class="sidebar_title">MENU</div>
                        <div class="sidebar_list">
                            <ul>
                                <li><a href="<c:url value="/details"/> ">나의 예약</a></li>
                                <li><a href="<c:url value="/review"/> ">나의 리뷰</a></li>
                                <li><a href="<c:url value="/wishlist"/> ">찜 목록</a></li>
                                <li><a href="<c:url value="mypage"/>">나의 정보</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="<c:url value="js/jquery-3.2.1.min.js"/>"></script>
<script src="<c:url value="styles/bootstrap4/popper.js"/>"></script>
<script src="<c:url value="styles/bootstrap4/bootstrap.min.js"/>"></script>
<script src="<c:url value="plugins/Isotope/isotope.pkgd.min.js"/>"></script>
<script src="<c:url value="plugins/easing/easing.js"/>"></script>
<script src="<c:url value="plugins/parallax-js-master/parallax.min.js"/>"></script>
<script src="<c:url value="js/offers_custom.js"/>"></script>
<script src="<c:url value="/webjars/sockjs-client/sockjs.min.js"/> "></script>
<script src="<c:url value="/webjars/stomp-websocket/stomp.min.js"/> "></script>
<script src="<c:url value="js/chatbot.js"/>"></script>
<script src="<c:url value="js/darkmode.js"/>"></script>