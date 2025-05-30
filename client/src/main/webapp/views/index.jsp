<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title><spring:message code="title"/></title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="Altspace Project">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/bootstrap4/bootstrap.min.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="plugins/font-awesome-4.7.0/css/font-awesome.min.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/offers_styles.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/offers_responsive.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/darkmode.css"/>">
    <link rel="stylesheet" type="text/css"
          href="<c:url value="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/chatbot.css"/>">
    <link rel="stylesheet"
          href="<c:url value="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css"/>">
    <link rel="stylesheet"
          href="<c:url value="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>">
    <style>
        .footer_col{
            margin-top: 50px;
        }

        .footer_content{
            margin-bottom: 30px;
        }

        .weather {
            display: flex;
            font-size: clamp(0.3rem, 0.6vw, 0.5rem);
        }

        .lang-option {
            cursor: pointer;
            text-decoration: none;
            padding: 2px 4px;
            color: #555;
            font-size: 10px;
        }
        .lang-option:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="super_container">

    <!-- Header -->
    <header class="header">
        <!-- 헤더 최상단 바 (전화번호, SNS, 로그인, 회원가입) -->
        <div class="top_bar">
            <div class="container">
                <div class="row">
                    <div class="col d-flex flex-row">
                        <div class="user_box ml-auto">
                            <div class="weather"></div>

                            <c:choose>
                                <c:when test="${sessionScope.user.name == null}">
                                    <div class="user_box_login user_box_link">
                                        <a href="<c:url value='/login'/>"><spring:message code="login"/></a>
                                    </div>
                                    <div class="user_box_login user_box_link">
                                        <a href="<c:url value='/login/register'/>"><spring:message code="register"/></a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="user_box_login user_box_link">
                                        <a href="<c:url value='/mypage?name=${sessionScope.user.name}'/>">${sessionScope.user.name}</a>
                                    </div>
                                    <div class="user_box_login user_box_link">
                                        <a href="<c:url value='/login/logout'/>"><spring:message code="logout"/></a>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <!-- 공통 다크 모드 토글 -->
                            <div class="user_box_login theme-switch">
                                <label class="theme-toggle" title="다크 모드 전환">
                                    <input type="checkbox"
                                           id="${sessionScope.user.name == null ? 'theme-toggle-guest' : 'theme-toggle-user'}"
                                           class="theme-toggle">
                                    <span class="slider">
                                        <i class="fa fa-moon${sessionScope.user.name == null ? '' : '-o'} moon-icon" aria-hidden="true"></i>
                                        <i class="fa fa-sun${sessionScope.user.name == null ? '' : '-o'} sun-icon" aria-hidden="true"></i>
                                    </span>
                                </label>
                            </div>

                            <!-- 공통 언어 선택 -->
                            <div class="user_box_login lang-switch">
                                <form id="languageForm" method="get" style="display: flex; gap: 8px; align-items: center;">
                                    <c:forEach var="param" items="${param}">
                                        <c:if test="${param.key ne 'lang'}">
                                            <input type="hidden" name="${param.key}" value="${param.value}"/>
                                        </c:if>
                                    </c:forEach>

                                    <input type="hidden" name="lang" id="langInput" value="${param.lang}"/>

                                    <span class="lang-option <c:if test='${param.lang == "ko" || (empty param.lang && sessionScope.currentLocale == "ko")}'>active</c:if>"
                                          onclick="changeLang('ko')">KR</span>
                                    |
                                    <span class="lang-option <c:if test='${param.lang == "en" || (empty param.lang && sessionScope.currentLocale == "en")}'>active</c:if>"
                                          onclick="changeLang('en')">EN</span>
                                    |
                                    <span class="lang-option <c:if test='${param.lang == "ja" || (empty param.lang && sessionScope.currentLocale == "ja")}'>active</c:if>"
                                          onclick="changeLang('ja')">JA</span>
                                </form>
                            </div>
                        </div>
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
                                <li class="main_nav_item"><a href="<c:url value="/"/> "><spring:message
                                        code="home"/></a></li>
                                <li class="main_nav_item"><a href="<c:url value="/about"/> "><spring:message
                                        code="about"/></a></li>
                                <li class="main_nav_item"><a href="<c:url value="/faq1"/> "><spring:message
                                        code="contacts"/></a></li>
                                <li class="main_nav_item"><a href="<c:url value="/mypage/aireport"/> "><spring:message
                                        code="details"/></a></li>
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

    <div class="main_content">
        <jsp:include page="${center}.jsp"/>
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
                                <p class="footer_about_text"><spring:message code="footer-name"/> | <spring:message
                                        code="footer-boss"/> | <spring:message code="footer-lisence"/> | <spring:message
                                        code="footer-onlinemerchundise-registered"/> |
                                    <spring:message code="footer-tourism-registerd"/> | <spring:message
                                            code="footer-address"/> | <spring:message code="footer-hosting"/></p>
                            </div>
                        </div>
                    </div>

                    <!-- 연락처 -->
                    <div class="col-lg-12 footer_column">
                        <div class="footer_col">
                            <div class="footer_content footer_contact">
                                <ul class="contact_info_list">
                                    <li class="contact_info_item d-flex flex-row">
                                        <div>
                                            <div class="contact_info_icon"><img src="images/placeholder.svg" alt="">
                                            </div>
                                        </div>
                                        <div class="contact_info_text"><spring:message code="footer-address2"/></div>
                                    </li>
                                    <li class="contact_info_item d-flex flex-row">
                                        <div>
                                            <div class="contact_info_icon"><img src="images/phone-call.svg" alt="">
                                            </div>
                                        </div>
                                        <div class="contact_info_text">02-1234-5678 / 1588-1588</div>
                                    </li>
                                    <li class="contact_info_item d-flex flex-row">
                                        <div>
                                            <div class="contact_info_icon"><img src="images/message.svg" alt=""></div>
                                        </div>
                                        <div class="contact_info_text"><a
                                                href="mailto:biz.altspace@gmail.com?Subject=Hello" target="_top">biz.altspace@gmail.com</a>
                                        </div>
                                    </li>
                                    <li class="contact_info_item d-flex flex-row">
                                        <div>
                                            <div class="contact_info_icon"><img src="images/planet-earth.svg" alt="">
                                            </div>
                                        </div>
                                        <div class="contact_info_text"><a href="https://altspace.com/help">www.altspace.com/help</a>
                                        </div>
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
                            Copyright &copy;<script>document.write(new Date().getFullYear());</script>
                            All rights reserved </a>
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--언어 선택 변경 스크립트--%>
<script>
    function changeLang(lang) {
        document.getElementById('langInput').value = lang;
        document.getElementById('languageForm').submit();
    }
</script>

<!-- jQuery (필수: Bootstrap은 jQuery에 의존함) -->
<script src="<c:url value='js/jquery-3.2.1.min.js'/>"></script>
<!-- moment.js -->
<script type="text/javascript" src="<c:url value='https://cdn.jsdelivr.net/momentjs/latest/moment.min.js'/>"></script>
<!-- daterangepicker.js + CSS -->
<script src="<c:url value='https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js'/>"></script>
<link rel="stylesheet" href="<c:url value='https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css'/>">
<!-- iamport.payment.js -->
<script src="<c:url value='https://cdn.iamport.kr/js/iamport.payment-1.2.0.js'/>"></script>
<!-- Bootstrap 4.6.2 JS (bundle 포함 = popper.js 포함) -->
<script src="<c:url value='https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js'/>"></script>
<%-- kakao map library --%>
<script src="<c:url value='//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js'/>"></script>
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoJSApiKey}&libraries=services"></script>


<script src="<c:url value='styles/bootstrap4/popper.js'/>"></script>
<script src="<c:url value='styles/bootstrap4/bootstrap.min.js'/>"></script>
<script src="<c:url value='plugins/Isotope/isotope.pkgd.min.js'/>"></script>
<script src="<c:url value='plugins/easing/easing.js'/>"></script>
<script src="<c:url value='plugins/parallax-js-master/parallax.min.js'/>"></script>
<script src="<c:url value='js/offers_custom.js'/>"></script>
<script src="<c:url value='js/custom.js'/>"></script>
<script defer src="<c:url value='js/darkmode.js'/>"></script>
<script src="<c:url value='js/iconpopper.js'/>"></script>

<script src="<c:url value='/webjars/sockjs-client/sockjs.min.js'/> "></script>
<script src="<c:url value='/webjars/stomp-websocket/stomp.min.js'/> "></script>
<script defer src="<c:url value='js/chatbot.js'/>"></script>
<script src="<c:url value='js/GeminiChatbot.js'/>"></script>

<script type="text/javascript"
        src="<c:url value='https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js'/>"></script>

<script type="text/javascript" src="<c:url value='js/weather_API.js'/>"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</body>

</html>