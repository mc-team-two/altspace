<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>


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
                                    <a href="<c:url value="/cart?name=${sessionScope.user.name}"/> ">Cart</a>
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

    <!-- 헤더 메뉴 버튼 (홈, 어바웃, 예약, 고객센터) -->

    <nav class="main_nav">
        <div class="container">
            <div class="row">
                <div class="col main_nav_col d-flex flex-row align-items-center justify-content-start" id="top">
                    <div class="logo_container">
                        <div class="logo"><a href="/"><img src="images/logo.png" alt=""></a></div>
                    </div>
                    <div class="hamburger">
                        <i class="fa fa-bars trans_200"></i>
                    </div>
                </div>
            </div>
        </div>
    </nav>
</header>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="plugins/colorbox/jquery.colorbox-min.js"></script>
<script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyCIwF204lFZg1y4kPSIhKaHEXMLYxxuMhA"></script>
<script src="js/single_listing_custom.js"></script>