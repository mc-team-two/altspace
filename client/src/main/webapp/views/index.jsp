<%--
  Created by IntelliJ IDEA.
  User: ishot
  Date: 25. 4. 7.
  Time: 오후 2:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Altspace | 가장 빠른 공간대여 알트스페이스</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="Altspace Project">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/bootstrap4/bootstrap.min.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="plugins/font-awesome-4.7.0/css/font-awesome.min.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/offers_styles.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/offers_responsive.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/darkmode.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/chatbot.css"/>">
</head>

<body>

<div class="super_container">

    <div class="main_content">
        <!-- Header -->
        <header class="header">
            <!-- 헤더 최상단 바 (전화번호, SNS, 로그인, 회원가입) -->
            <div class="top_bar">
                <div class="container">
                    <div class="row">
                        <div class="col d-flex flex-row">
                            <div class="weather"></div>
                            <c:choose>
                                <c:when test="${sessionScope.user.name == null}">
                                    <div class="user_box ml-auto">
                                        <div class="user_box_login user_box_link">
                                            <a href="<c:url value="/login"/> ">로그인</a>
                                        </div>
                                        <div class="user_box_login user_box_link">
                                            <a href="<c:url value="/login/register"/> ">회원가입</a>
                                        </div>
                                        <div class="user_box_login theme-switch">
                                            <label class="theme-toggle" title="다크 모드 전환">
                                                <input type="checkbox" id="theme-toggle-guest" class="theme-toggle">
                                                <span class="slider">
                                        <i class="fa fa-moon-o moon-icon" aria-hidden="true"></i>
                                        <i class="fa fa-sun-o sun-icon" aria-hidden="true"></i>
                                    </span>
                                            </label>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="user_box ml-auto">
                                        <div class="user_box_login user_box_link">
                                            <a href="<c:url value="/mypage?name=${sessionScope.user.name}"/> ">${sessionScope.user.name}</a>
                                        </div>
                                        <div class="user_box_login user_box_link">
                                            <a href="<c:url value="/auth/logout"/> ">logout</a>
                                        </div>
                                        <div class="user_box_login theme-switch">
                                            <label class="theme-toggle" title="다크 모드 전환">
                                                <input type="checkbox" id="theme-toggle-user" class="theme-toggle">
                                                <span class="slider">
                                        <i class="fa fa-moon-o moon-icon" aria-hidden="true"></i>
                                        <i class="fa fa-sun-o sun-icon" aria-hidden="true"></i>
                                    </span>
                                            </label>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 헤더 메뉴 버튼 (홈, 어바웃, 예약, 고객센터, 마이페이지) -->

            <nav class="main_nav">
                <div class="container">
                    <div class="row">
                        <div class="col main_nav_col d-flex flex-row align-items-center justify-content-start">
                            <div class="logo_container">
                                <div class="logo"><a href="<c:url value="/" />"><img src="images/logo.png" alt=""></a></div>
                            </div>
                            <div class="main_nav_container ml-auto">
                                <ul class="main_nav_list">
                                    <li class="main_nav_item"><a href="<c:url value="/"/> ">홈</a></li>
                                    <li class="main_nav_item"><a href="<c:url value="/about"/> ">Altspace란</a></li>
                                    <li class="main_nav_item"><a href="<c:url value="/contacts"/> ">고객센터</a></li>
                                    <li class="main_nav_item"><a href="<c:url value="/details"/> ">마이페이지</a></li>
                                </ul>
                            </div>
                            <div class="hamburger">
                                <i class="fa fa-bars trans_200"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>
        </header>
    </div>

    <div class="main_content">
        <jsp:include page="${center}.jsp" />
    </div>

    <div class="main_content">

        <!-- 푸터 -->
        <footer class="footer">
            <div class="container">
                <div class="row">

                    <!-- 회사 정보 -->
                    <div class="col-lg-12 footer_column">
                        <div class="footer_col">
                            <div class="footer_content footer_about">
                                <div class="logo_container footer_logo">
                                    <div class="logo"><a href="#"><img src="images/logo.png" alt=""></a></div>
                                </div>
                                <p class="footer_about_text">(주)알트스페이스 | 대표이사: 이예진 | 사업자 등록번호: 123-81-45678 | 통신판매업신고: 2025-서울영등포-0001 |
                                    관광사업자 등록번호: 제2025-00001호 | 주소: 서울 영등포구 여의동로 330 (여의도동, 알트타워) | 호스팅 서비스 제공자: (주)알트스페이스그룹</p>
                            </div>
                        </div>
                    </div>

                    <!-- 연락처 -->
                    <div class="col-lg-12 footer_column">
                        <div class="footer_col">
                            <div class="footer_content footer_contact">
                                <ul class="contact_info_list">
                                    <li class="contact_info_item d-flex flex-row">
                                        <div><div class="contact_info_icon"><img src="images/placeholder.svg" alt=""></div></div>
                                        <div class="contact_info_text">서울 영등포구 여의동로 330 (여의도동, 알트타워)</div>
                                    </li>
                                    <li class="contact_info_item d-flex flex-row">
                                        <div><div class="contact_info_icon"><img src="images/phone-call.svg" alt=""></div></div>
                                        <div class="contact_info_text">02-1234-5678 / 1588-1588</div>
                                    </li>
                                    <li class="contact_info_item d-flex flex-row">
                                        <div><div class="contact_info_icon"><img src="images/message.svg" alt=""></div></div>
                                        <div class="contact_info_text"><a href="mailto:biz.altspace@gmail.com?Subject=Hello" target="_top">biz.altspace@gmail.com</a></div>
                                    </li>
                                    <li class="contact_info_item d-flex flex-row">
                                        <div><div class="contact_info_icon"><img src="images/planet-earth.svg" alt=""></div></div>
                                        <div class="contact_info_text"><a href="https://altspace.com/help">www.altspace.com/help</a></div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </div>

    <!-- Copyright -->

    <div class="copyright">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 order-lg-1 order-2  ">
                    <div class="copyright_content d-flex flex-row align-items-center">
                        <div><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                            Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved </a>
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="<c:url value="js/jquery-3.2.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"/>"></script>
<!-- iamport.payment.js -->
<script src="<c:url value="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"/>"></script>
<!-- moment.js -->
<script src="<c:url value="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"/>"></script>
<!-- daterangepicker.js + CSS -->
<script src="<c:url value="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"/>"></script>
<link rel="stylesheet" href="<c:url value="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css"/>">
<!-- Bootstrap 4.6.2 JS (bundle 포함 = popper.js 포함) -->
<script src="<c:url value="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"/>"></script>
<%-- kakao map library --%>
<script src="<c:url value="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"/>"></script>
<script type="text/javascript" src="<c:url value="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoJSApiKey}&libraries=services"/>"></script>


<script src="<c:url value="styles/bootstrap4/popper.js"/>"></script>
<script src="<c:url value="styles/bootstrap4/bootstrap.min.js"/>"></script>
<script src="<c:url value="plugins/Isotope/isotope.pkgd.min.js"/>"></script>
<script src="<c:url value="plugins/easing/easing.js"/>"></script>
<script src="<c:url value="plugins/parallax-js-master/parallax.min.js"/>"></script>
<script src="<c:url value="js/offers_custom.js"/>"></script>
<script src="<c:url value="js/darkmode.js"/>"></script>
<script src="<c:url value="js/iconpopper.js"/>"></script>
<script src="<c:url value="/webjars/sockjs-client/sockjs.min.js"/> "></script>
<script src="<c:url value="/webjars/stomp-websocket/stomp.min.js"/> "></script>
<script src="<c:url value="js/chatbot.js"/>"></script>

<script type="text/javascript" src="<c:url value="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="js/weather_API.js"/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />">
</body>

</html>