<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Altspace | 나의 리뷰 | 가장 빠른 공간대여 알트스페이스</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="Travelix Project">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
    <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="plugins/colorbox/colorbox.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="styles/blog_styles.css">
    <link rel="stylesheet" type="text/css" href="styles/blog_responsive.css">
</head>

<body>

<div class="super_container">

    <!-- 헤더 -->

    <header class="header">

        <!-- 헤더 최상단 바 (전화번호, SNS, 로그인, 회원가입) -->

        <div class="top_bar">
            <div class="container">
                <div class="row">
                    <div class="col d-flex flex-row">
                        <div class="phone">02-1234-5678</div>
                        <div class="social">
                            <ul class="social_list">
                                <li class="social_list_item"><a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a></li>
                                <li class="social_list_item"><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                                <li class="social_list_item"><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                <li class="social_list_item"><a href="#"><i class="fa fa-dribbble" aria-hidden="true"></i></a></li>
                                <li class="social_list_item"><a href="#"><i class="fa fa-behance" aria-hidden="true"></i></a></li>
                                <li class="social_list_item"><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                            </ul>
                        </div>
                        <div class="user_box ml-auto">
                            <div class="user_box_login user_box_link"><a href="/login">로그인</a></div>
                            <div class="user_box_register user_box_link"><a href="/login/register">회원가입</a></div>
                        </div>
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
                        <div class="main_nav_container ml-auto">
                            <ul class="main_nav_list">
                                <li class="main_nav_item"><a href="/">홈</a></li>
                                <li class="main_nav_item"><a href="/about">Altspace란</a></li>
                                <li class="main_nav_item"><a href="/contact">고객센터</a></li>
                                <li class="main_nav_item"><a href="/details">예약내역</a></li>
                            </ul>
                        </div>
                        <div class="content_search ml-lg-0 ml-auto">
                            <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                 width="17px" height="17px" viewBox="0 0 512 512" enable-background="new 0 0 512 512" xml:space="preserve">
								<g>
                                    <g>
                                        <g>
                                            <path class="mag_glass" fill="#FFFFFF" d="M78.438,216.78c0,57.906,22.55,112.343,63.493,153.287c40.945,40.944,95.383,63.494,153.287,63.494
											s112.344-22.55,153.287-63.494C489.451,329.123,512,274.686,512,216.78c0-57.904-22.549-112.342-63.494-153.286
											C407.563,22.549,353.124,0,295.219,0c-57.904,0-112.342,22.549-153.287,63.494C100.988,104.438,78.439,158.876,78.438,216.78z
											M119.804,216.78c0-96.725,78.69-175.416,175.415-175.416s175.418,78.691,175.418,175.416
											c0,96.725-78.691,175.416-175.416,175.416C198.495,392.195,119.804,313.505,119.804,216.78z"/>
                                        </g>
                                    </g>
                                    <g>
                                        <g>
                                            <path class="mag_glass" fill="#FFFFFF" d="M6.057,505.942c4.038,4.039,9.332,6.058,14.625,6.058s10.587-2.019,14.625-6.058L171.268,369.98
											c8.076-8.076,8.076-21.172,0-29.248c-8.076-8.078-21.172-8.078-29.249,0L6.057,476.693
											C-2.019,484.77-2.019,497.865,6.057,505.942z"/>
                                        </g>
                                    </g>
                                </g>
							</svg>
                        </div>

                        <form id="search_form" class="search_form bez_1">
                            <input type="search" class="search_content_input bez_1">
                        </form>

                        <div class="hamburger">
                            <i class="fa fa-bars trans_200"></i>
                        </div>
                    </div>
                </div>
            </div>
        </nav>

    </header>

    <!-- 홈 -->

    <div class="home">
        <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/offer_background.jpg"></div>
        <div class="home_content">
            <div class="home_title">나의 리뷰</div>
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
                                <li><a href="/details">나의 예약</a></li>
                                <li><a href="/review">나의 리뷰</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 푸터 -->

    <footer class="footer">
        <div class="container">
            <div class="row">

                <!-- 회사 정보 -->
                <div class="col-lg-3 footer_column">
                    <div class="footer_col">
                        <div class="footer_content footer_about">
                            <div class="logo_container footer_logo">
                                <div class="logo"><a href="#"><img src="images/logo.png" alt=""></a></div>
                            </div>
                            <p class="footer_about_text">(주)알트스페이스 | 대표이사: 이예진 | 사업자 등록번호: 123-81-45678 | 통신판매업신고: 2025-서울영등포-0001 |
                                관광사업자 등록번호: 제2025-00001호 | 주소: 서울 영등포구 여의동로 330 (여의도동, 알트타워) | 호스팅 서비스 제공자: (주)알트스페이스그룹</p>
                            <ul class="footer_social_list">
                                <li class="footer_social_item"><a href="#"><i class="fa fa-pinterest"></i></a></li>
                                <li class="footer_social_item"><a href="#"><i class="fa fa-facebook-f"></i></a></li>
                                <li class="footer_social_item"><a href="#"><i class="fa fa-twitter"></i></a></li>
                                <li class="footer_social_item"><a href="#"><i class="fa fa-dribbble"></i></a></li>
                                <li class="footer_social_item"><a href="#"><i class="fa fa-behance"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- 기존 템플릿 내용 삭제 후 정렬을 위한 빈 칸으로 활용 -->
                <div class="col-lg-3 footer_column">
                    <div class="footer_col">
                        <%--<div class="footer_title">blog posts</div>
                        <div class="footer_content footer_blog">

                            <!-- Footer blog item -->
                            <div class="footer_blog_item clearfix">
                                <div class="footer_blog_image"><img src="images/footer_blog_1.jpg" alt="https://unsplash.com/@avidenov"></div>
                                <div class="footer_blog_content">
                                    <div class="footer_blog_title"><a href="blog.html">Travel with us this year</a></div>
                                    <div class="footer_blog_date">Nov 29, 2017</div>
                                </div>
                            </div>

                            <!-- Footer blog item -->
                            <div class="footer_blog_item clearfix">
                                <div class="footer_blog_image"><img src="images/footer_blog_2.jpg" alt="https://unsplash.com/@deannaritchie"></div>
                                <div class="footer_blog_content">
                                    <div class="footer_blog_title"><a href="blog.html">New destinations for you</a></div>
                                    <div class="footer_blog_date">Nov 29, 2017</div>
                                </div>
                            </div>

                            <!-- Footer blog item -->
                            <div class="footer_blog_item clearfix">
                                <div class="footer_blog_image"><img src="images/footer_blog_3.jpg" alt="https://unsplash.com/@bergeryap87"></div>
                                <div class="footer_blog_content">
                                    <div class="footer_blog_title"><a href="blog.html">Travel with us this year</a></div>
                                    <div class="footer_blog_date">Nov 29, 2017</div>
                                </div>
                            </div>

                        </div>--%>
                    </div>
                </div>


                <!-- 태그 -->
                <div class="col-lg-3 footer_column">
                    <div class="footer_col">
                        <div class="footer_title">태그</div>
                        <div class="footer_content footer_tags">
                            <ul class="tags_list clearfix">
                                <li class="tag_item"><a href="#">바캉스</a></li>
                                <li class="tag_item"><a href="#">호캉스</a></li>
                                <li class="tag_item"><a href="#">페스티벌</a></li>
                                <li class="tag_item"><a href="#">파티</a></li>
                                <li class="tag_item"><a href="#">프라이빗</a></li>
                                <li class="tag_item"><a href="#">마운틴뷰</a></li>
                                <li class="tag_item"><a href="#">시티뷰</a></li>
                                <li class="tag_item"><a href="#">오션뷰</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- 연락처 -->
                <div class="col-lg-3 footer_column">
                    <div class="footer_col">
                        <div class="footer_title">연락처</div>
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
                                    <div class="contact_info_text"><a href="mailto:help.alt@altspace.com?Subject=Hello" target="_top">help.alt@altspace.com</a></div>
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

<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/colorbox/jquery.colorbox-min.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="js/blog_custom.js"></script>

</body>

</html>