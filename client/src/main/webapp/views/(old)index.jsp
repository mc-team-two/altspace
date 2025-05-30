<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Altspace | 가장 빠른 공간대여 알트스페이스</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="Altspace Project">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
    <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
    <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
    <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
    <link rel="stylesheet" type="text/css" href="styles/main_styles.css">
    <link rel="stylesheet" type="text/css" href="styles/responsive.css">
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
                                <li class="main_nav_item"><a href="#">홈</a></li>
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


    <!-- 홈 메인 배너 -->

    <div class="home">

        <!-- Home Slider -->

        <div class="home_slider_container">

            <div class="owl-carousel owl-theme home_slider">

                <!-- Slider Item -->
                <div class="owl-item home_slider_item">
                    <!-- Image by https://unsplash.com/@anikindimitry -->
                    <div class="home_slider_background" style="background-image:url(images/home_slider_1.jpg)"></div>

                    <div class="home_slider_content text-center">
                        <div class="home_slider_content_inner" data-animation-in="flipInX" data-animation-out="animate-out fadeOut">
                            <h1>호텔/리조트</h1>
                            <div class="button home_slider_button"><div class="button_bcg"></div><a href="#">바로 검색하기<span></span><span></span><span></span></a></div>
                        </div>
                    </div>
                </div>

                <!-- Slider Item -->
                <div class="owl-item home_slider_item">
                    <div class="home_slider_background" style="background-image:url(images/home_slider_2.jpg)"></div>

                    <div class="home_slider_content text-center">
                        <div class="home_slider_content_inner" data-animation-in="flipInX" data-animation-out="animate-out fadeOut">
                            <h1>펜션/게하</h1>
                            <div class="button home_slider_button"><div class="button_bcg"></div><a href="#">바로 검색하기<span></span><span></span><span></span></a></div>
                        </div>
                    </div>
                </div>

                <!-- Slider Item -->
                <div class="owl-item home_slider_item">
                    <div class="home_slider_background" style="background-image:url(images/home_slider_3.jpg)"></div>

                    <div class="home_slider_content text-center">
                        <div class="home_slider_content_inner" data-animation-in="flipInX" data-animation-out="animate-out fadeOut">
                            <h1>파티룸</h1>
                            <div class="button home_slider_button"><div class="button_bcg"></div><a href="#">바로 검색하기<span></span><span></span><span></span></a></div>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Home Slider Nav - Prev -->
            <div class="home_slider_nav home_slider_prev">
                <svg version="1.1" id="Layer_2" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                     width="28px" height="33px" viewBox="0 0 28 33" enable-background="new 0 0 28 33" xml:space="preserve">
					<defs>
                        <linearGradient id='home_grad_prev'>
                            <stop offset='0%' stop-color='#fa9e1b'/>
                            <stop offset='100%' stop-color='#8d4fff'/>
                        </linearGradient>
                    </defs>
                    <path class="nav_path" fill="#F3F6F9" d="M19,0H9C4.029,0,0,4.029,0,9v15c0,4.971,4.029,9,9,9h10c4.97,0,9-4.029,9-9V9C28,4.029,23.97,0,19,0z
					M26,23.091C26,27.459,22.545,31,18.285,31H9.714C5.454,31,2,27.459,2,23.091V9.909C2,5.541,5.454,2,9.714,2h8.571
					C22.545,2,26,5.541,26,9.909V23.091z"/>
                    <polygon class="nav_arrow" fill="#F3F6F9" points="15.044,22.222 16.377,20.888 12.374,16.885 16.377,12.882 15.044,11.55 9.708,16.885 11.04,18.219
					11.042,18.219 "/>
				</svg>
            </div>

            <!-- Home Slider Nav - Next -->
            <div class="home_slider_nav home_slider_next">
                <svg version="1.1" id="Layer_3" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                     width="28px" height="33px" viewBox="0 0 28 33" enable-background="new 0 0 28 33" xml:space="preserve">
					<defs>
                        <linearGradient id='home_grad_next'>
                            <stop offset='0%' stop-color='#fa9e1b'/>
                            <stop offset='100%' stop-color='#8d4fff'/>
                        </linearGradient>
                    </defs>
                    <path class="nav_path" fill="#F3F6F9" d="M19,0H9C4.029,0,0,4.029,0,9v15c0,4.971,4.029,9,9,9h10c4.97,0,9-4.029,9-9V9C28,4.029,23.97,0,19,0z
				M26,23.091C26,27.459,22.545,31,18.285,31H9.714C5.454,31,2,27.459,2,23.091V9.909C2,5.541,5.454,2,9.714,2h8.571
				C22.545,2,26,5.541,26,9.909V23.091z"/>
                    <polygon class="nav_arrow" fill="#F3F6F9" points="13.044,11.551 11.71,12.885 15.714,16.888 11.71,20.891 13.044,22.224 18.379,16.888 17.048,15.554
				17.046,15.554 "/>
				</svg>
            </div>

            <!-- Home Slider Dots -->

            <div class="home_slider_dots">
                <ul id="home_slider_custom_dots" class="home_slider_custom_dots">
                    <li class="home_slider_custom_dot active"><div></div>01.</li>
                    <li class="home_slider_custom_dot"><div></div>02.</li>
                    <li class="home_slider_custom_dot"><div></div>03.</li>
                </ul>
            </div>

        </div>

    </div>

    <!-- 검색 -->

    <div class="search">


        <!-- 검색 바 상세 -->

        <div class="container fill_height">
            <div class="row fill_height">
                <div class="col fill_height">

                    <!-- Search Tabs -->

                    <div class="search_tabs_container">
                        <div class="search_tabs d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
                            <div class="search_tab active d-flex flex-row align-items-center justify-content-lg-center justify-content-start"><img src="images/suitcase.png" alt=""><span>호텔/리조트</span></div>
                            <div class="search_tab d-flex flex-row align-items-center justify-content-lg-center justify-content-start"><img src="images/island.png" alt="">펜션/게하</div>
                            <div class="search_tab d-flex flex-row align-items-center justify-content-lg-center justify-content-start"><img src="images/diving.png" alt="">파티룸</div>
                        </div>
                    </div>

                    <!-- Search Panel 1 -->

                    <div class="search_panel active">
                        <form action="#" id="search_form_1" class="search_panel_content d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
                            <div class="search_item">
                                <div>목적지</div>
                                <input type="text" class="destination search_input" placeholder="여행지나 숙소를 검색해보세요." required="required">
                            </div>
                            <div class="search_item">
                                <div>체크인</div>
                                <input type="text" class="check_in search_input" placeholder="YYYY-MM-DD">
                            </div>
                            <div class="search_item">
                                <div>체크아웃</div>
                                <input type="text" class="check_out search_input" placeholder="YYYY-MM-DD">
                            </div>
                            <div class="search_item">
                                <div>인원</div>
                                <select name="adults" id="adults_1" class="dropdown_item_select search_input">
                                    <option>1명</option>
                                    <option>2명</option>
                                    <option>3~5명</option>
                                    <option>5명 이상</option>
                                </select>
                            </div>
                            <button class="button search_button">검색<span></span><span></span><span></span></button>
                        </form>
                    </div>

                    <!-- Search Panel 2 -->

                    <div class="search_panel">
                        <form action="#" id="search_form_2" class="search_panel_content d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
                            <div class="search_item">
                                <div>목적지</div>
                                <input type="text" class="destination search_input" placeholder="여행지나 숙소를 검색해보세요." required="required">
                            </div>
                            <div class="search_item">
                                <div>체크인</div>
                                <input type="text" class="check_in search_input" placeholder="YYYY-MM-DD">
                            </div>
                            <div class="search_item">
                                <div>체크아웃</div>
                                <input type="text" class="check_out search_input" placeholder="YYYY-MM-DD">
                            </div>
                            <div class="search_item">
                                <div>인원</div>
                                <select name="adults" id="adults_2" class="dropdown_item_select search_input">
                                    <option>1명</option>
                                    <option>2명</option>
                                    <option>3~5명</option>
                                    <option>5명 이상</option>
                                </select>
                            </div>
                            <button class="button search_button">검색<span></span><span></span><span></span></button>
                        </form>
                    </div>

                    <!-- Search Panel 3 -->

                    <div class="search_panel">
                        <form action="#" id="search_form_3" class="search_panel_content d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
                        <div class="search_item">
                            <div>위치</div>
                            <input type="text" class="destination search_input" placeholder="위치나 파티룸을 검색해보세요." required="required">
                        </div>
                        <div class="search_item">
                            <div>체크인</div>
                            <input type="text" class="check_in search_input" placeholder="YYYY-MM-DD">
                        </div>
                        <div class="search_item">
                            <div>체크아웃</div>
                            <input type="text" class="check_out search_input" placeholder="YYYY-MM-DD">
                        </div>
                        <div class="search_item">
                            <div>인원</div>
                            <select name="adults" id="adults_3" class="dropdown_item_select search_input">
                                <option>1명</option>
                                <option>2명</option>
                                <option>3~5명</option>
                                <option>5명 이상</option>
                            </select>
                        </div>
                            <button class="button search_button">검색<span></span><span></span><span></span></button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Altspace 인기 여행지 -->

    <div class="intro">
        <div class="container">
            <div class="row">
                <div class="col">
                    <h2 class="intro_title text-center">Altspace 인기 여행지</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-10 offset-lg-1">
                    <div class="intro_text text-center">
                        <p>황금연휴 한정 최대 30% 할인 혜택 받고 봄캉스 떠나보세요!</p>
                    </div>
                </div>
            </div>
            <div class="row intro_items">

                <!-- 서울 -->

                <div class="col-lg-4 intro_col">
                    <div class="intro_item">
                        <div class="intro_item_overlay"></div>
                        <!-- Image by https://unsplash.com/@dnevozhai -->
                        <div class="intro_item_background" style="background-image:url(images/intro_1.jpg)"></div>
                        <div class="intro_item_content d-flex flex-column align-items-center justify-content-center">
                            <div class="intro_date">~5월 1일까지</div>
                            <div class="button intro_button"><div class="button_bcg"></div><a href="#">더 찾아보기<span></span><span></span><span></span></a></div>
                            <div class="intro_center text-center">
                                <h1>서울</h1>
                                <h3>Seoul</h3>
                                <div class="intro_price">150,000원~</div>
                                <div class="rating rating_4">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 부산 -->

                <div class="col-lg-4 intro_col">
                    <div class="intro_item">
                        <div class="intro_item_overlay"></div>
                        <!-- Image by https://unsplash.com/@hellolightbulb -->
                        <div class="intro_item_background" style="background-image:url(images/intro_2.jpg)"></div>
                        <div class="intro_item_content d-flex flex-column align-items-center justify-content-center">
                            <div class="intro_date">~5월 1일까지</div>
                            <div class="button intro_button"><div class="button_bcg"></div><a href="#">더 찾아보기<span></span><span></span><span></span></a></div>
                            <div class="intro_center text-center">
                                <h1>부산</h1>
                                <h3>Busan</h3>
                                <div class="intro_price">130,000원~</div>
                                <div class="rating rating_4">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 제주 -->

                <div class="col-lg-4 intro_col">
                    <div class="intro_item">
                        <div class="intro_item_overlay"></div>
                        <!-- Image by https://unsplash.com/@willianjusten -->
                        <div class="intro_item_background" style="background-image:url(images/intro_3.jpg)"></div>
                        <div class="intro_item_content d-flex flex-column align-items-center justify-content-center">
                            <div class="intro_date">~5월 1일까지</div>
                            <div class="button intro_button"><div class="button_bcg"></div><a href="#">더 찾아보기<span></span><span></span><span></span></a></div>
                            <div class="intro_center text-center">
                                <h1>제주</h1>
                                <h3>Jeju</h3>
                                <div class="intro_price">170,000원~</div>
                                <div class="rating rating_4">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- 이벤트 모음 -->

    <div class="cta">
        <!-- Image by https://unsplash.com/@thanni -->
        <div class="cta_background" style="background-image:url(images/cta.jpg)"></div>

        <div class="container">
            <div class="row">
                <div class="col">

                    <!-- 이벤트 슬라이더 -->

                    <div class="cta_slider_container">
                        <div class="owl-carousel owl-theme cta_slider">

                            <!-- 이벤트 1 -->
                            <div class="owl-item cta_item text-center">
                                <div class="cta_title">레이트 체크아웃 모음</div>

                                <p class="cta_text">넉넉한 퇴실 시간으로 마음까지 여유롭게! 추가비용 없는 레이트 체크아웃을 확인해보세요.</p>
                                <div class="button cta_button"><div class="button_bcg"></div><a href="#">지금 예약하기<span></span><span></span><span></span></a></div>
                            </div>

                            <!-- 이벤트 2 -->
                            <div class="owl-item cta_item text-center">
                                <div class="cta_title">봄 특집 4월 인기 펜션 기획전</div>

                                <p class="cta_text">설렘 가득한 벚꽃 여행! 할인 혜택 가득한 봄 여행 펜캉스 기획전을 확인해보세요.</p>
                                <div class="button cta_button"><div class="button_bcg"></div><a href="#">지금 검색하기<span></span><span></span><span></span></a></div>
                            </div>

                            <!-- 이벤트 3 -->
                            <div class="owl-item cta_item text-center">
                                <div class="cta_title">믿기지 않는 가성비! 10만원 이하 숙소 모음</div>

                                <p class="cta_text">이 가격에 이 퀄리티가 가능한가요? 10만원 이하로 가성비 있게 여행을 떠나보세요.</p>
                                <div class="button cta_button"><div class="button_bcg"></div><a href="#">지금 검색하기<span></span><span></span><span></span></a></div>
                            </div>

                        </div>

                        <!-- 이벤트 슬라이더 내비게이터 - 이전 -->
                        <div class="cta_slider_nav cta_slider_prev">
                            <svg version="1.1" id="Layer_4" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                 width="28px" height="33px" viewBox="0 0 28 33" enable-background="new 0 0 28 33" xml:space="preserve">
								<defs>
                                    <linearGradient id='cta_grad_prev'>
                                        <stop offset='0%' stop-color='#fa9e1b'/>
                                        <stop offset='100%' stop-color='#8d4fff'/>
                                    </linearGradient>
                                </defs>
                                <path class="nav_path" fill="#F3F6F9" d="M19,0H9C4.029,0,0,4.029,0,9v15c0,4.971,4.029,9,9,9h10c4.97,0,9-4.029,9-9V9C28,4.029,23.97,0,19,0z
								M26,23.091C26,27.459,22.545,31,18.285,31H9.714C5.454,31,2,27.459,2,23.091V9.909C2,5.541,5.454,2,9.714,2h8.571
								C22.545,2,26,5.541,26,9.909V23.091z"/>
                                <polygon class="nav_arrow" fill="#F3F6F9" points="15.044,22.222 16.377,20.888 12.374,16.885 16.377,12.882 15.044,11.55 9.708,16.885 11.04,18.219
								11.042,18.219 "/>
							</svg>
                        </div>

                        <!-- 이벤트 슬라이더 내비게이터 - 다음 -->
                        <div class="cta_slider_nav cta_slider_next">
                            <svg version="1.1" id="Layer_5" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                 width="28px" height="33px" viewBox="0 0 28 33" enable-background="new 0 0 28 33" xml:space="preserve">
								<defs>
                                    <linearGradient id='cta_grad_next'>
                                        <stop offset='0%' stop-color='#fa9e1b'/>
                                        <stop offset='100%' stop-color='#8d4fff'/>
                                    </linearGradient>
                                </defs>
                                <path class="nav_path" fill="#F3F6F9" d="M19,0H9C4.029,0,0,4.029,0,9v15c0,4.971,4.029,9,9,9h10c4.97,0,9-4.029,9-9V9C28,4.029,23.97,0,19,0z
							M26,23.091C26,27.459,22.545,31,18.285,31H9.714C5.454,31,2,27.459,2,23.091V9.909C2,5.541,5.454,2,9.714,2h8.571
							C22.545,2,26,5.541,26,9.909V23.091z"/>
                                <polygon class="nav_arrow" fill="#F3F6F9" points="13.044,11.551 11.71,12.885 15.714,16.888 11.71,20.891 13.044,22.224 18.379,16.888 17.048,15.554
							17.046,15.554 "/>
							</svg>
                        </div>

                    </div>

                </div>
            </div>
        </div>

    </div>

    <!-- Altspace HOT 숙소 모음 -->

    <div class="offers">
        <div class="container">
            <div class="row">
                <div class="col text-center">
                    <h2 class="section_title">Altspace 이용객들이 가장 많이 찾은 HOT 숙소 모음</h2>
                </div>
            </div>
            <div class="row offers_items">

                <!-- Offers Item -->
                <div class="col-lg-6 offers_col">
                    <div class="offers_item">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="offers_image_container">
                                    <!-- Image by https://unsplash.com/@kensuarez -->
                                    <div class="offers_image_background" style="background-image:url(images/offer_1.jpg)"></div>
                                    <div class="offer_name"><a href="#">신라호텔 서울</a></div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="offers_content">
                                    <div class="offers_price">250,000원~</div>
                                    <div class="rating_r rating_r_5 offers_rating">
                                        <i></i>
                                        <i></i>
                                        <i></i>
                                        <i></i>
                                        <i></i>
                                    </div>
                                    <p class="offers_text">공간의 교통편과 간략한 소개글</p>
                                    <div class="offers_icons">
                                        <ul class="offers_icons_list">
                                            <li class="offers_icons_item"><img src="images/post.png" alt=""></li>
                                            <li class="offers_icons_item"><img src="images/compass.png" alt=""></li>
                                            <li class="offers_icons_item"><img src="images/bicycle.png" alt=""></li>
                                            <li class="offers_icons_item"><img src="images/sailboat.png" alt=""></li>
                                        </ul>
                                    </div>
                                    <div class="offers_link"><a href="offers.html">상세 정보</a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Offers Item -->
                <div class="col-lg-6 offers_col">
                    <div class="offers_item">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="offers_image_container">
                                    <!-- Image by Egzon Bytyqi -->
                                    <div class="offers_image_background" style="background-image:url(images/offer_2.jpg)"></div>
                                    <div class="offer_name"><a href="#">노보텔 엠배서더 용산</a></div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="offers_content">
                                    <div class="offers_price">200,000원~</div>
                                    <div class="rating_r rating_r_4 offers_rating">
                                        <i></i>
                                        <i></i>
                                        <i></i>
                                        <i></i>
                                        <i></i>
                                    </div>
                                    <p class="offers_text">공간의 교통편과 간략한 소개글</p>
                                    <div class="offers_icons">
                                        <ul class="offers_icons_list">
                                            <li class="offers_icons_item"><img src="images/post.png" alt=""></li>
                                            <li class="offers_icons_item"><img src="images/compass.png" alt=""></li>
                                            <li class="offers_icons_item"><img src="images/bicycle.png" alt=""></li>
                                            <li class="offers_icons_item"><img src="images/sailboat.png" alt=""></li>
                                        </ul>
                                    </div>
                                    <div class="offers_link"><a href="offers.html">상세 정보</a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Offers Item -->
                <div class="col-lg-6 offers_col">
                    <div class="offers_item">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="offers_image_container">
                                    <!-- Image by https://unsplash.com/@nevenkrcmarek -->
                                    <div class="offers_image_background" style="background-image:url(images/offer_3.jpg)"></div>
                                    <div class="offer_name"><a href="#">체스터톤스 속초</a></div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="offers_content">
                                    <div class="offers_price">75,000원~</div>
                                    <div class="rating_r rating_r_5 offers_rating">
                                        <i></i>
                                        <i></i>
                                        <i></i>
                                        <i></i>
                                        <i></i>
                                    </div>
                                    <p class="offers_text">공간의 교통편과 간략한 소개글</p>
                                    <div class="offers_icons">
                                        <ul class="offers_icons_list">
                                            <li class="offers_icons_item"><img src="images/post.png" alt=""></li>
                                            <li class="offers_icons_item"><img src="images/compass.png" alt=""></li>
                                            <li class="offers_icons_item"><img src="images/bicycle.png" alt=""></li>
                                            <li class="offers_icons_item"><img src="images/sailboat.png" alt=""></li>
                                        </ul>
                                    </div>
                                    <div class="offers_link"><a href="offers.html">상세 정보</a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Offers Item -->
                <div class="col-lg-6 offers_col">
                    <div class="offers_item">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="offers_image_container">
                                    <!-- Image by https://unsplash.com/@mantashesthaven -->
                                    <div class="offers_image_background" style="background-image:url(images/offer_4.jpg)"></div>
                                    <div class="offer_name"><a href="#">해운대 팔레드시즈</a></div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="offers_content">
                                    <div class="offers_price">120,000원~</div>
                                    <div class="rating_r rating_r_4 offers_rating">
                                        <i></i>
                                        <i></i>
                                        <i></i>
                                        <i></i>
                                        <i></i>
                                    </div>
                                    <p class="offers_text">공간의 교통편과 간략한 소개글</p>
                                    <div class="offers_icons">
                                        <ul class="offers_icons_list">
                                            <li class="offers_icons_item"><img src="images/post.png" alt=""></li>
                                            <li class="offers_icons_item"><img src="images/compass.png" alt=""></li>
                                            <li class="offers_icons_item"><img src="images/bicycle.png" alt=""></li>
                                            <li class="offers_icons_item"><img src="images/sailboat.png" alt=""></li>
                                        </ul>
                                    </div>
                                    <div class="offers_link"><a href="offers.html">상세 정보</a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- 이용객 리뷰 -->

    <div class="testimonials">
        <div class="test_border"></div>
        <div class="container">
            <div class="row">
                <div class="col text-center">
                    <h2 class="section_title">이용객 리뷰</h2>
                </div>
            </div>
            <div class="row">
                <div class="col">

                    <!-- 리뷰 슬라이더 -->

                    <div class="test_slider_container">
                        <div class="owl-carousel owl-theme test_slider">

                            <!-- 리뷰 1 -->
                            <div class="owl-item">
                                <div class="test_item">
                                    <div class="test_image"><img src="images/test_1.jpg" width="200" height="520"></div>
                                    <div class="test_icon"><img src="images/backpack.png" alt=""></div>
                                    <div class="test_content_container">
                                        <div class="test_content">
                                            <div class="test_item_info">
                                                <div class="test_name">이황수</div>
                                                <div class="test_date">2025년 2월 15일</div>
                                            </div>
                                            <div class="test_quote_title">"오션뷰에 바베큐까지 환상적이네요"</div>
                                            <div class="rating_r rating_r_5">
                                                <i></i>
                                                <i></i>
                                                <i></i>
                                                <i></i>
                                                <i></i>
                                            </div>
                                            <p class="test_quote_text">리뷰 내용</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- 리뷰 2 -->
                            <div class="owl-item">
                                <div class="test_item">
                                    <div class="test_image"><img src="images/test_2.jpg" width="200" height="520"></div>
                                    <div class="test_icon"><img src="images/island_t.png" alt=""></div>
                                    <div class="test_content_container">
                                        <div class="test_content">
                                            <div class="test_item_info">
                                                <div class="test_name">임유경</div>
                                                <div class="test_date">2024년 12월 24일</div>
                                            </div>
                                            <div class="test_quote_title">"매년 찾게 되는 만족스러운 호텔입니다"</div>
                                            <div class="rating_r rating_r_4">
                                                <i></i>
                                                <i></i>
                                                <i></i>
                                                <i></i>
                                                <i></i>
                                            </div>
                                            <p class="test_quote_text">리뷰 내용</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- 리뷰 3 -->
                            <div class="owl-item">
                                <div class="test_item">
                                    <div class="test_image"><img src="images/test_3.jpg" width="200" height="520"></div>
                                    <div class="test_icon"><img src="images/kayak.png" alt=""></div>
                                    <div class="test_content_container">
                                        <div class="test_content">
                                            <div class="test_item_info">
                                                <div class="test_name">김부건</div>
                                                <div class="test_date">2024년 11월 4일</div>
                                            </div>
                                            <div class="test_quote_title">"외관은 예쁜데 실내가 생각보다 별로였어요"</div>
                                            <div class="rating_r rating_r_3">
                                                <i></i>
                                                <i></i>
                                                <i></i>
                                                <i></i>
                                                <i></i>
                                            </div>
                                            <p class="test_quote_text">리뷰 내용</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- 리뷰 4 -->
                            <div class="owl-item">
                                <div class="test_item">
                                    <div class="test_image"><img src="images/test_4.jpg" width="200" height="520"></div>
                                    <div class="test_icon"><img src="images/island_t.png" alt=""></div>
                                    <div class="test_content_container">
                                        <div class="test_content">
                                            <div class="test_item_info">
                                                <div class="test_name">이예진</div>
                                                <div class="test_date">2024년 10월 15일</div>
                                            </div>
                                            <div class="test_quote_title">"펜션도 여행지도 모두 만족스러웠어요"</div>
                                            <div class="rating_r rating_r_5">
                                                <i></i>
                                                <i></i>
                                                <i></i>
                                                <i></i>
                                                <i></i>
                                            </div>
                                            <p class="test_quote_text">리뷰 내용</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- 리뷰 5 -->
                            <div class="owl-item">
                                <div class="test_item">
                                    <div class="test_image"><img src="images/test_5.jpg" width="200" height="520"></div>
                                    <div class="test_icon"><img src="images/backpack.png" alt=""></div>
                                    <div class="test_content_container">
                                        <div class="test_content">
                                            <div class="test_item_info">
                                                <div class="test_name">박정우</div>
                                                <div class="test_date">2024년 4월 10일</div>
                                            </div>
                                            <div class="test_quote_title">"앞으로 스키 타러 여기만 와야겠어요"</div>
                                            <div class="rating_r rating_r_4">
                                                <i></i>
                                                <i></i>
                                                <i></i>
                                                <i></i>
                                                <i></i>
                                            </div>
                                            <p class="test_quote_text">리뷰 내용</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- 리뷰 6 -->
                            <div class="owl-item">
                                <div class="test_item">
                                    <div class="test_image"><img src="images/test_6.jpg" width="200" height="520"></div>
                                    <div class="test_icon"><img src="images/kayak.png" alt=""></div>
                                    <div class="test_content_container">
                                        <div class="test_content">
                                            <div class="test_item_info">
                                                <div class="test_name">이진만</div>
                                                <div class="test_date">2024년 1월 6일</div>
                                            </div>
                                            <div class="test_quote_title">"친구들과 즐거운 시간을 보내고 왔어요"</div>
                                            <div class="rating_r rating_r_3">
                                                <i></i>
                                                <i></i>
                                                <i></i>
                                                <i></i>
                                                <i></i>
                                            </div>
                                            <p class="test_quote_text">리뷰 내용</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <!-- Testimonials Slider Nav - Prev -->
                        <div class="test_slider_nav test_slider_prev">
                            <svg version="1.1" id="Layer_6" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                 width="28px" height="33px" viewBox="0 0 28 33" enable-background="new 0 0 28 33" xml:space="preserve">
								<defs>
                                    <linearGradient id='test_grad_prev'>
                                        <stop offset='0%' stop-color='#fa9e1b'/>
                                        <stop offset='100%' stop-color='#8d4fff'/>
                                    </linearGradient>
                                </defs>
                                <path class="nav_path" fill="#F3F6F9" d="M19,0H9C4.029,0,0,4.029,0,9v15c0,4.971,4.029,9,9,9h10c4.97,0,9-4.029,9-9V9C28,4.029,23.97,0,19,0z
								M26,23.091C26,27.459,22.545,31,18.285,31H9.714C5.454,31,2,27.459,2,23.091V9.909C2,5.541,5.454,2,9.714,2h8.571
								C22.545,2,26,5.541,26,9.909V23.091z"/>
                                <polygon class="nav_arrow" fill="#F3F6F9" points="15.044,22.222 16.377,20.888 12.374,16.885 16.377,12.882 15.044,11.55 9.708,16.885 11.04,18.219
								11.042,18.219 "/>
							</svg>
                        </div>

                        <!-- Testimonials Slider Nav - Next -->
                        <div class="test_slider_nav test_slider_next">
                            <svg version="1.1" id="Layer_7" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                 width="28px" height="33px" viewBox="0 0 28 33" enable-background="new 0 0 28 33" xml:space="preserve">
								<defs>
                                    <linearGradient id='test_grad_next'>
                                        <stop offset='0%' stop-color='#fa9e1b'/>
                                        <stop offset='100%' stop-color='#8d4fff'/>
                                    </linearGradient>
                                </defs>
                                <path class="nav_path" fill="#F3F6F9" d="M19,0H9C4.029,0,0,4.029,0,9v15c0,4.971,4.029,9,9,9h10c4.97,0,9-4.029,9-9V9C28,4.029,23.97,0,19,0z
							M26,23.091C26,27.459,22.545,31,18.285,31H9.714C5.454,31,2,27.459,2,23.091V9.909C2,5.541,5.454,2,9.714,2h8.571
							C22.545,2,26,5.541,26,9.909V23.091z"/>
                                <polygon class="nav_arrow" fill="#F3F6F9" points="13.044,11.551 11.71,12.885 15.714,16.888 11.71,20.891 13.044,22.224 18.379,16.888 17.048,15.554
							17.046,15.554 "/>
							</svg>
                        </div>

                    </div>

                </div>
            </div>

        </div>
    </div>

    <!-- 이번 주 특가 모음 -->

    <div class="trending">
        <div class="container">
            <div class="row">
                <div class="col text-center">
                    <h2 class="section_title">이번 주 특가 모음</h2>
                </div>
            </div>
            <div class="row trending_container">

                <!-- 특가 1 -->
                <div class="col-lg-3 col-sm-6">
                    <div class="trending_item clearfix">
                        <div class="trending_image"><img src="images/trend_1.png" alt="https://unsplash.com/@fransaraco"></div>
                        <div class="trending_content">
                            <div class="trending_title"><a href="#">신라스테이 역삼</a></div>
                            <div class="trending_price">30%</div><h4>80,000원~</h4>
                            <div class="trending_location">서울 강남구 역삼동</div>
                        </div>
                    </div>
                </div>

                <!-- 특가 2 -->
                <div class="col-lg-3 col-sm-6">
                    <div class="trending_item clearfix">
                        <div class="trending_image"><img src="images/trend_2.png" alt="https://unsplash.com/@grovemade"></div>
                        <div class="trending_content">
                            <div class="trending_title"><a href="#">신라스테이 구로</a></div>
                            <div class="trending_price">30%</div><h4>80,000원~</h4>
                            <div class="trending_location">서울 구로구 구로동</div>
                        </div>
                    </div>
                </div>

                <!-- 특가 3 -->
                <div class="col-lg-3 col-sm-6">
                    <div class="trending_item clearfix">
                        <div class="trending_image"><img src="images/trend_3.png" alt="https://unsplash.com/@jbriscoe"></div>
                        <div class="trending_content">
                            <div class="trending_title"><a href="#">신라스테이 목동</a></div>
                            <div class="trending_price">30%</div><h4>80,000원~</h4>
                            <div class="trending_location">서울 양천구 목동</div>
                        </div>
                    </div>
                </div>

                <!-- 특가 4 -->
                <div class="col-lg-3 col-sm-6">
                    <div class="trending_item clearfix">
                        <div class="trending_image"><img src="images/trend_4.png" alt="https://unsplash.com/@oowgnuj"></div>
                        <div class="trending_content">
                            <div class="trending_title"><a href="#">신라스테이 동탄</a></div>
                            <div class="trending_price">30%</div><h4>80,000원~</h4>
                            <div class="trending_location">경기 화성 청계동</div>
                        </div>
                    </div>
                </div>

                <!-- 특가 5 -->
                <div class="col-lg-3 col-sm-6">
                    <div class="trending_item clearfix">
                        <div class="trending_image"><img src="images/trend_5.png" alt="https://unsplash.com/@mindaugas"></div>
                        <div class="trending_content">
                            <div class="trending_title"><a href="#">신라스테이 대전</a></div>
                            <div class="trending_price">30%</div><h4>80,000원~</h4>
                            <div class="trending_location">대전 서구 갈마동</div>
                        </div>
                    </div>
                </div>

                <!-- 특가 6 -->
                <div class="col-lg-3 col-sm-6">
                    <div class="trending_item clearfix">
                        <div class="trending_image"><img src="images/trend_6.png" alt="https://unsplash.com/@itsnwa"></div>
                        <div class="trending_content">
                            <div class="trending_title"><a href="#">신라스테이 춘천</a></div>
                            <div class="trending_price">30%</div><h4>80,000원~</h4>
                            <div class="trending_location">강원 춘천 소양동</div>
                        </div>
                    </div>
                </div>

                <!-- 특가 7 -->
                <div class="col-lg-3 col-sm-6">
                    <div class="trending_item clearfix">
                        <div class="trending_image"><img src="images/trend_7.png" alt="https://unsplash.com/@rktkn"></div>
                        <div class="trending_content">
                            <div class="trending_title"><a href="#">신라스테이 수성못</a></div>
                            <div class="trending_price">30%</div><h4>80,000원~</h4>
                            <div class="trending_location">대구 수성구 황금동</div>
                        </div>
                    </div>
                </div>

                <!-- 특가 8 -->
                <div class="col-lg-3 col-sm-6">
                    <div class="trending_item clearfix">
                        <div class="trending_image"><img src="images/trend_8.png" alt="https://unsplash.com/@thoughtcatalog"></div>
                        <div class="trending_content">
                            <div class="trending_title"><a href="#">신라스테이 동성로</a></div>
                            <div class="trending_price">30%</div><h4>80,000원~</h4>
                            <div class="trending_location">대구 수성구 성내동</div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- 고객센터 상담 -->

    <div class="contact">
        <div class="contact_background" style="background-image:url(images/contact.png)"></div>

        <div class="container">
            <div class="row">
                <div class="col-lg-5">
                    <div class="contact_image">

                    </div>
                </div>
                <div class="col-lg-7">
                    <div class="contact_form_container">
                        <div class="contact_title">고객센터 상담 요청</div>
                        <form action="#" id="contact_form" class="contact_form">
                            <input type="text" id="contact_form_name" class="contact_form_name input_field" placeholder="이름" required="required" data-error="이름을 입력해주세요.">
                            <input type="text" id="contact_form_email" class="contact_form_email input_field" placeholder="전화번호 또는 이메일" required="required" data-error="전화번호 또는 이메일을 입력해주세요.">
                            <input type="text" id="contact_form_subject" class="contact_form_subject input_field" placeholder="제목" required="required" data-error="제목을 입력해주세요.">
                            <textarea id="contact_form_message" class="text_field contact_form_message" name="message" rows="4" placeholder="내용" required="required" data-error="내용을 입력해주세요."></textarea>
                            <button type="submit" id="form_submit_button" class="form_submit_button button">문의하기<span></span><span></span><span></span></button>
                        </form>
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
<script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="js/custom.js"></script>

</body>

</html>