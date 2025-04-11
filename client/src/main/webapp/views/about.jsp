<%--
  Created by IntelliJ IDEA.
  User: ishot
  Date: 25. 4. 7.
  Time: 오후 2:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Altspace | Altspace란</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="Travelix Project">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
    <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
    <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
    <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
    <link rel="stylesheet" type="text/css" href="styles/about_styles.css">
    <link rel="stylesheet" type="text/css" href="styles/about_responsive.css">
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
                            <div class="user_box_login user_box_link"><a href="#">로그인</a></div>
                            <div class="user_box_register user_box_link"><a href="#">회원가입</a></div>
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
                            <div class="logo"><a href="#"><img src="images/logo.png" alt=""></a></div>
                        </div>
                        <div class="main_nav_container ml-auto">
                            <ul class="main_nav_list">
                                <li class="main_nav_item"><a href="/">홈</a></li>
                                <li class="main_nav_item"><a href="/about">Altspace란</a></li>
                                <li class="main_nav_item"><a href="/offers">예약</a></li>
                                <li class="main_nav_item"><a href="/contact">고객센터</a></li>
                                <li class="main_nav_item"><a href="/mypage">마이페이지</a></li>
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

    <!-- Home -->

    <div class="home">
        <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/about_background.jpg"></div>
        <div class="home_content">
            <div class="home_title">알트스페이스란</div>
        </div>
    </div>

    <!-- Altspace 소개 -->

    <div class="intro">
        <div class="container">
            <div class="row">
                <div class="col-lg-7">
                    <div class="intro_image"><img src="images/intro.png" alt=""></div>
                </div>
                <div class="col-lg-5">
                    <div class="intro_content">
                        <div class="intro_title">Altspace에 오신 것을 환영합니다!</div>
                        <p class="intro_text">
                            Altspace™는 메뉴를 빠르게 여는 Alt + Space 단축키에 간결하게 정리된 레이아웃을 가진 웹사이트를 통해 빠르고 편리한 공간 예약 서비스를 제공하고 있습니다.
                            <p></p>
                            Altspace에서 다양한 호텔 및 리조트는 물론 게스트하우스, 모텔, 파티룸 등 프라이빗한 공간을 안심하고 예약하실 수 있으며 이용 요금, 편의 시설과 서비스,
                            예약 가능 객실, 반려동물 동반 여부 등 등 모든 정보를 한 눈에 확인하실 수 있습니다.
                            <p></p>
                            본 웹사이트는 멀티캠퍼스 2조 운영진이 (이예진, 이황수, 임유경, 박정우, 김부건) 공동 운영합니다. 자세한 문의사항 또는 분쟁의 경우 아래 연락처로 연락 바랍니다.
                            <p></p>
                            02-1234-5678 / 1588-1588 / help.alt@altspace.com
                            <p></p>
                            (주)알트스페이스 | 대표이사: 이예진 | 사업자 등록번호: 123-81-45678 | 통신판매업신고: 2025-서울영등포-0001 |
                            관광사업자 등록번호: 제2025-00001호 | 주소: 서울 영등포구 여의동로 330 (여의도동, 알트타워) | 호스팅 서비스 제공자: (주)알트스페이스그룹
                        </p>
                        <div class="button intro_button"><div class="button_bcg"></div><a href="/offers">예약하러 가기<span></span><span></span><span></span></a></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Stats -->

    <div class="stats">
        <div class="container">
            <div class="row">
                <div class="col text-center">
                    <div class="section_title">years statistics</div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-10 offset-lg-1 text-center">
                    <p class="stats_text">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus quis vulputate eros, iaculis consequat nisl. Nunc et suscipit urna. Integer elementum orci eu vehicula pretium. Donec bibendum tristique condimentum. Aenean in lacus ligula. </p>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <div class="stats_years">
                        <div class="stats_years_last">2016</div>
                        <div class="stats_years_new float-right">2017</div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <div class="stats_contents">

                        <!-- Stats Item -->
                        <div class="stats_item d-flex flex-md-row flex-column clearfix">
                            <div class="stats_last order-md-1 order-3">
                                <div class="stats_last_icon d-flex flex-column align-items-center justify-content-end">
                                    <img src="images/stats_1.png" alt="">
                                </div>
                                <div class="stats_last_content">
                                    <div class="stats_number">1642</div>
                                    <div class="stats_type">Clients</div>
                                </div>
                            </div>
                            <div class="stats_bar order-md-2 order-2" data-x="1642" data-y="3527" data-color="#31124b">
                                <div class="stats_bar_perc">
                                    <div>
                                        <div class="stats_bar_value"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="stats_new order-md-3 order-1 text-right">
                                <div class="stats_new_icon d-flex flex-column align-items-center justify-content-end">
                                    <img src="images/stats_1.png" alt="">
                                </div>
                                <div class="stats_new_content">
                                    <div class="stats_number">3527</div>
                                    <div class="stats_type">Clients</div>
                                </div>
                            </div>
                        </div>

                        <!-- Stats Item -->
                        <div class="stats_item d-flex flex-md-row flex-column clearfix">
                            <div class="stats_last order-md-1 order-3">
                                <div class="stats_last_icon d-flex flex-column align-items-center justify-content-end">
                                    <img src="images/stats_2.png" alt="">
                                </div>
                                <div class="stats_last_content">
                                    <div class="stats_number">768</div>
                                    <div class="stats_type">Returning Clients</div>
                                </div>
                            </div>
                            <div class="stats_bar order-md-2 order-2" data-x="768" data-y="145" data-color="#a95ce4">
                                <div class="stats_bar_perc">
                                    <div>
                                        <div class="stats_bar_value"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="stats_new order-md-3 order-1 text-right">
                                <div class="stats_new_icon d-flex flex-column align-items-center justify-content-end">
                                    <img src="images/stats_2.png" alt="">
                                </div>
                                <div class="stats_new_content">
                                    <div class="stats_number">145</div>
                                    <div class="stats_type">Returning Clients</div>
                                </div>
                            </div>
                        </div>

                        <!-- Stats Item -->
                        <div class="stats_item d-flex flex-md-row flex-column clearfix">
                            <div class="stats_last order-md-1 order-3">
                                <div class="stats_last_icon d-flex flex-column align-items-center justify-content-end">
                                    <img src="images/stats_3.png" alt="">
                                </div>
                                <div class="stats_last_content">
                                    <div class="stats_number">11546</div>
                                    <div class="stats_type">Reach</div>
                                </div>
                            </div>
                            <div class="stats_bar order-md-2 order-2" data-x="11546" data-y="9321" data-color="#fa6f1b">
                                <div class="stats_bar_perc">
                                    <div>
                                        <div class="stats_bar_value"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="stats_new order-md-3 order-1 text-right">
                                <div class="stats_new_icon d-flex flex-column align-items-center justify-content-end">
                                    <img src="images/stats_3.png" alt="">
                                </div>
                                <div class="stats_new_content">
                                    <div class="stats_number">9321</div>
                                    <div class="stats_type">Reach</div>
                                </div>
                            </div>
                        </div>

                        <!-- Stats Item -->
                        <div class="stats_item d-flex flex-md-row flex-column clearfix">
                            <div class="stats_last order-md-1 order-3">
                                <div class="stats_last_icon d-flex flex-column align-items-center justify-content-end">
                                    <img src="images/stats_4.png" alt="">
                                </div>
                                <div class="stats_last_content">
                                    <div class="stats_number">3729</div>
                                    <div class="stats_type">Items</div>
                                </div>
                            </div>
                            <div class="stats_bar order-md-2 order-2" data-x="3729" data-y="17429" data-color="#fa9e1b">
                                <div class="stats_bar_perc">
                                    <div>
                                        <div class="stats_bar_value"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="stats_new order-md-3 order-1 text-right">
                                <div class="stats_new_icon d-flex flex-column align-items-center justify-content-end">
                                    <img src="images/stats_4.png" alt="">
                                </div>
                                <div class="stats_new_content">
                                    <div class="stats_number">17429</div>
                                    <div class="stats_type">More Items</div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add -->

    <div class="add">
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="add_container">
                        <div class="add_background" style="background-image:url(images/add.jpg)"></div>
                        <div class="add_content">
                            <h1 class="add_title">thailand</h1>
                            <div class="add_subtitle">From <span>$999</span></div>
                            <div class="button add_button"><div class="button_bcg"></div><a href="#">explore now<span></span><span></span><span></span></a></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Milestones -->

    <div class="milestones">
        <div class="container">
            <div class="row">

                <!-- Milestone -->
                <div class="col-lg-3 milestone_col">
                    <div class="milestone text-center">
                        <div class="milestone_icon"><img src="images/milestone_1.png" alt=""></div>
                        <div class="milestone_counter" data-end-value="255">0</div>
                        <div class="milestone_text">Clients</div>
                    </div>
                </div>

                <!-- Milestone -->
                <div class="col-lg-3 milestone_col">
                    <div class="milestone text-center">
                        <div class="milestone_icon"><img src="images/milestone_2.png" alt=""></div>
                        <div class="milestone_counter" data-end-value="1176">0</div>
                        <div class="milestone_text">Projects</div>
                    </div>
                </div>

                <!-- Milestone -->
                <div class="col-lg-3 milestone_col">
                    <div class="milestone text-center">
                        <div class="milestone_icon"><img src="images/milestone_3.png" alt=""></div>
                        <div class="milestone_counter" data-end-value="39">0</div>
                        <div class="milestone_text">Countries</div>
                    </div>
                </div>

                <!-- Milestone -->
                <div class="col-lg-3 milestone_col">
                    <div class="milestone text-center">
                        <div class="milestone_icon"><img src="images/milestone_4.png" alt=""></div>
                        <div class="milestone_counter" data-end-value="127">0</div>
                        <div class="milestone_text">Coffees</div>
                    </div>
                </div>

            </div>
        </div>
    </div>

</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/greensock/TweenMax.min.js"></script>
<script src="plugins/greensock/TimelineMax.min.js"></script>
<script src="plugins/scrollmagic/ScrollMagic.min.js"></script>
<script src="plugins/greensock/animation.gsap.min.js"></script>
<script src="plugins/greensock/ScrollToPlugin.min.js"></script>
<script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="js/about_custom.js"></script>

</body>

</html>