<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<head>
    <link rel="stylesheet" type="text/css" href="styles/blog_styles.css">
    <link rel="stylesheet" type="text/css" href="styles/blog_responsive.css">
    <link rel="stylesheet" type="text/css" href="styles/darkmode.css">
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
            <li class="menu_item"><a href="<c:url value="/details"/> ">예약 내역</a></li>
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
        <div class="row">

            <!-- 예약 내역 -->
            <div class="col-lg-8">
                <div class="blog_post_container">
                    <c:forEach var="py" items="${paymentList}">
                        <div class="blog_post">
                            <div class="blog_post_image">
                                <img src="images/blog_1.jpg"> <!-- 실제 이미지 경로가 있다면 p.imagePath 등으로 수정 -->
                                <div class="blog_post_date d-flex flex-column align-items-center justify-content-center">
                                    <div class="blog_post_day">${py.payStatus}</div>
                                </div>
                            </div>
                            <div class="blog_post_meta">
                                <ul>
                                    <li class="blog_post_meta_item">
                                        <a>${py.checkIn} ~ ${py.checkOut}</a>
                                    </li>
                                    <li class="blog_post_meta_item">
                                        <a href="<c:url value="/detail?id=${py.accommodationId}&pyStatus=${py.payStatus}&paymentId=${py.paymentId}"/>">결제 정보</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="blog_post_title">
                                <a href="#">${py.name}</a> <!-- p.accommodationName 은 테이블 join or 따로 세팅 필요 -->
                                <p></p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="blog_navigation">
                    <ul>
                        <li class="blog_dot active"><div></div>01</li>
                        <li class="blog_dot"><div></div>02</li>
                    </ul>
                </div>
            </div>

            <!-- 사이드바 -->
            <div class="col-lg-4 sidebar_col">

                <!-- 사이드바 메뉴 -->
                <div class="sidebar_archives">
                    <div class="sidebar_title">MENU</div>
                    <div class="sidebar_list">
                        <ul>
                            <li><a href="<c:url value="/details"/> ">나의 예약</a></li>
                            <li><a href="<c:url value="/review"/> ">나의 리뷰</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="js/offers_custom.js"></script>

<script src="js/darkmode.js"></script>