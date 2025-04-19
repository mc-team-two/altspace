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

                    <!-- 내역 1 -->

                    <div class="blog_post">
                        <div class="blog_post_image">
                            <img src="images/blog_1.jpg">
                            <div class="blog_post_date d-flex flex-column align-items-center justify-content-center">
                                <div class="blog_post_day">예약</div>
                                <div class="blog_post_month">2025-07-11</div>
                            </div>
                        </div>
                        <div class="blog_post_meta">
                            <ul>
                                <li class="blog_post_meta_item"><a href="/roominfo">숙소 정보</a></li>
                                <li class="blog_post_meta_item"><a href="">결제 정보</a></li>
                            </ul>
                        </div>
                        <div class="blog_post_title"><a href="#">제주 감귤 레지던스</a></div>
                    </div>

                    <!-- 내역 2 -->

                    <div class="blog_post">
                        <div class="blog_post_image">
                            <img src="images/blog_2.jpg">
                            <div class="blog_post_date d-flex flex-column align-items-center justify-content-center">
                                <div class="blog_post_day">완료</div>
                                <div class="blog_post_month">2025-01-11</div>
                            </div>
                        </div>
                        <div class="blog_post_meta">
                            <ul>
                                <li class="blog_post_meta_item"><a href="/roominfo">숙소 정보</a></li>
                                <li class="blog_post_meta_item"><a href="">결제 정보</a></li>
                            </ul>
                        </div>
                        <div class="blog_post_title"><a href="#">제주 감귤 레지던스</a></div>
                    </div>

                    <!-- 내역 3 -->

                    <div class="blog_post">
                        <div class="blog_post_image">
                            <img src="images/blog_3.jpg">
                            <div class="blog_post_date d-flex flex-column align-items-center justify-content-center">
                                <div class="blog_post_day">완료</div>
                                <div class="blog_post_month">2024-12-11</div>
                            </div>
                        </div>
                        <div class="blog_post_meta">
                            <ul>
                                <li class="blog_post_meta_item"><a href="/roominfo">숙소 정보</a></li>
                                <li class="blog_post_meta_item"><a href="">결제 정보</a></li>
                            </ul>
                        </div>
                        <div class="blog_post_title"><a href="#">제주 감귤 레지던스</a></div>
                    </div>

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