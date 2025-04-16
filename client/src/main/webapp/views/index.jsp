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
    <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
    <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="styles/offers_styles.css">
    <link rel="stylesheet" type="text/css" href="styles/offers_responsive.css">
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
            <div class="home_title">빠르고 간편하게, Altspace</div>
        </div>
    </div>

    <!-- 예약 -->

    <div class="offers">

        <!-- 예약 > 검색 -->

        <div class="search">
            <div class="search_inner">

                <!-- Search Contents -->

                <div class="container fill_height no-padding">
                    <div class="row fill_height no-margin">
                        <div class="col fill_height no-padding">

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

                                    <!-- Search Panel 1 추가 옵션 -->

                                    <div class="extras">
                                        <ul class="search_extras clearfix">
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_1" class="search_extras_cb">
                                                    <label for="search_extras_1">반려동물 동반 가능</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_2" class="search_extras_cb">
                                                    <label for="search_extras_2">주차 가능</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_3" class="search_extras_cb">
                                                    <label for="search_extras_3">Wi-Fi/인터넷</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_4" class="search_extras_cb">
                                                    <label for="search_extras_4">비흡연 객실</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_5" class="search_extras_cb">
                                                    <label for="search_extras_5">욕조/풀장</label>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                    <button class="button search_button">검색하기<span></span><span></span><span></span></button>
                                </form>
                            </div>

                            <!-- Search Panel 2 -->

                            <div class="search_panel active_2">
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

                                    <!-- Search Panel 2 추가 옵션 -->

                                    <div class="extras">
                                        <ul class="search_extras clearfix">
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_6" class="search_extras_cb">
                                                    <label for="search_extras_6">반려동물 동반 가능</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_7" class="search_extras_cb">
                                                    <label for="search_extras_7">주차 가능</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_8" class="search_extras_cb">
                                                    <label for="search_extras_8">Wi-Fi/인터넷</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_9" class="search_extras_cb">
                                                    <label for="search_extras_9">비흡연 객실</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_10" class="search_extras_cb">
                                                    <label for="search_extras_10">욕조/풀장</label>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>

                                    <button class="button search_button">검색하기<span></span><span></span><span></span></button>
                                </form>
                            </div>

                            <!-- Search Panel 3 -->

                            <div class="search_panel active_3">
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

                                    <!-- Search Panel 3 추가 옵션 -->

                                    <div class="extras">
                                        <ul class="search_extras clearfix">
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_11" class="search_extras_cb">
                                                    <label for="search_extras_11">반려동물 동반 가능</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_12" class="search_extras_cb">
                                                    <label for="search_extras_12">주차 가능</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_13" class="search_extras_cb">
                                                    <label for="search_extras_13">Wi-Fi/인터넷</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_14" class="search_extras_cb">
                                                    <label for="search_extras_14">비흡연 객실</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_15" class="search_extras_cb">
                                                    <label for="search_extras_15">욕조/풀장</label>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                    <button class="button search_button">검색하기<span></span><span></span><span></span></button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 예약 > 목록 -->

        <div class="container">
            <div class="row">
                <div class="col-lg-1 temp_col"></div>
                <div class="col-lg-11">

                    <!-- Offers Sorting -->
                    <div class="offers_sorting_container">
                        <ul class="offers_sorting">
                            <li>
                                <span class="sorting_text">가격</span>
                                <i class="fa fa-chevron-down"></i>
                                <ul>
                                    <li class="sort_btn" data-isotope-option='{ "sortBy": "original-order" }' data-parent=".price_sorting"><span>전체</span></li>
                                    <li class="sort_btn" data-isotope-option='{ "sortBy": "price" }' data-parent=".price_sorting"><span>낮은 가격순</span></li>
                                </ul>
                            </li>
                            <li>
                                <span class="sorting_text">숙소명</span>
                                <i class="fa fa-chevron-down"></i>
                                <ul>
                                    <li class="sort_btn" data-isotope-option='{ "sortBy": "original-order" }'><span>전체</span></li>
                                    <li class="sort_btn" data-isotope-option='{ "sortBy": "name" }'><span>가나다순</span></li>
                                </ul>
                            </li>
                            <li>
                                <span class="sorting_text">별점</span>
                                <i class="fa fa-chevron-down"></i>
                                <ul>
                                    <li class="filter_btn" data-filter="*"><span>전체</span></li>
                                    <li class="sort_btn" data-isotope-option='{ "sortBy": "stars" }'><span>낮은 별점순</span></li>
                                    <li class="filter_btn" data-filter=".rating_3"><span>3</span></li>
                                    <li class="filter_btn" data-filter=".rating_4"><span>4</span></li>
                                    <li class="filter_btn" data-filter=".rating_5"><span>5</span></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="col-lg-12">
                    <!-- Offers Grid -->

                    <div class="offers_grid">

                        <!-- 호텔 1 -->

                        <div class="offers_item rating_4">
                            <div class="row">
                                <div class="col-lg-1 temp_col"></div>
                                <div class="col-lg-3 col-1680-4">
                                    <div class="offers_image_container">
                                        <div class="offers_image_background" style="background-image:url(images/offer_1.jpg)"></div>
                                        <div class="offer_name"><a href="/roominfo">제주 감귤 레지던스</a></div>
                                    </div>
                                </div>
                                <div class="col-lg-8">
                                    <div class="offers_content">
                                        <div class="offers_price">110,000원<span>~1박</span></div>
                                        <div class="rating_r rating_r_4 offers_rating" data-rating="4">
                                            <i></i>
                                            <i></i>
                                            <i></i>
                                            <i></i>
                                            <i></i>
                                        </div>
                                        <p class="offers_text">제주 감귤 레지던스에 대한 간략한 소개글</p>
                                        <div class="offers_icons">
                                            <ul class="offers_icons_list">
                                                <li class="offers_icons_item"><img src="images/post.png" alt=""></li>
                                                <li class="offers_icons_item"><img src="images/compass.png" alt=""></li>
                                                <li class="offers_icons_item"><img src="images/bicycle.png" alt=""></li>
                                                <li class="offers_icons_item"><img src="images/sailboat.png" alt=""></li>
                                            </ul>
                                        </div>
                                        <div class="button book_button"><a href="/roominfo">숙소 보기<span></span><span></span><span></span></a></div>
                                        <div class="offer_reviews">
                                            <div class="offer_reviews_content">
                                                <div class="offer_reviews_title">매우 만족</div>
                                                <div class="offer_reviews_subtitle">100개의 리뷰</div>
                                            </div>
                                            <div class="offer_reviews_rating text-center">4.5</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Offers Item -->

                        <div class="offers_item rating_5">
                            <div class="row">
                                <div class="col-lg-1 temp_col"></div>
                                <div class="col-lg-3 col-1680-4">
                                    <div class="offers_image_container">
                                        <!-- Image by https://unsplash.com/@mindaugas -->
                                        <div class="offers_image_background" style="background-image:url(images/offer_6.jpg)"></div>
                                        <div class="offer_name"><a href="/roominfo">여의도 알트스페이스</a></div>
                                    </div>
                                </div>
                                <div class="col-lg-8">
                                    <div class="offers_content">
                                        <div class="offers_price">150,000원<span>~1박</span></div>
                                        <div class="rating_r rating_r_5 offers_rating"  data-rating="5">
                                            <i></i>
                                            <i></i>
                                            <i></i>
                                            <i></i>
                                            <i></i>
                                        </div>
                                        <p class="offers_text">여의도 알트스페이스에 대한 간략한 소개글</p>
                                        <div class="offers_icons">
                                            <ul class="offers_icons_list">
                                                <li class="offers_icons_item"><img src="images/post.png" alt=""></li>
                                                <li class="offers_icons_item"><img src="images/compass.png" alt=""></li>
                                                <li class="offers_icons_item"><img src="images/bicycle.png" alt=""></li>
                                                <li class="offers_icons_item"><img src="images/sailboat.png" alt=""></li>
                                            </ul>
                                        </div>
                                        <div class="button book_button"><a href="#">숙소 보기<span></span><span></span><span></span></a></div>
                                        <div class="offer_reviews">
                                            <div class="offer_reviews_content">
                                                <div class="offer_reviews_title">매우 만족</div>
                                                <div class="offer_reviews_subtitle">100개의 리뷰</div>
                                            </div>
                                            <div class="offer_reviews_rating text-center">5.0</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Offers Item -->

                        <div class="offers_item rating_3">
                            <div class="row">
                                <div class="col-lg-1 temp_col"></div>
                                <div class="col-lg-3 col-1680-4">
                                    <div class="offers_image_container">
                                        <!-- Image by https://unsplash.com/@itsnwa -->
                                        <div class="offers_image_background" style="background-image:url(images/offer_8.jpg)"></div>
                                        <div class="offer_name"><a href="/roominfo">광안리 해담채</a></div>
                                    </div>
                                </div>
                                <div class="col-lg-8">
                                    <div class="offers_content">
                                        <div class="offers_price">80,000원<span>~1박</span></div>
                                        <div class="rating_r rating_r_3 offers_rating" data-rating="3">
                                            <i></i>
                                            <i></i>
                                            <i></i>
                                            <i></i>
                                            <i></i>
                                        </div>
                                        <p class="offers_text">광안리 해담채에 대한 간략한 소개글</p>
                                        <div class="offers_icons">
                                            <ul class="offers_icons_list">
                                                <li class="offers_icons_item"><img src="images/post.png" alt=""></li>
                                                <li class="offers_icons_item"><img src="images/compass.png" alt=""></li>
                                                <li class="offers_icons_item"><img src="images/bicycle.png" alt=""></li>
                                                <li class="offers_icons_item"><img src="images/sailboat.png" alt=""></li>
                                            </ul>
                                        </div>
                                        <div class="button book_button"><a href="#">숙소 보기<span></span><span></span><span></span></a></div>
                                        <div class="offer_reviews">
                                            <div class="offer_reviews_content">
                                                <div class="offer_reviews_title">전반적으로 만족</div>
                                                <div class="offer_reviews_subtitle">100개의 리뷰</div>
                                            </div>
                                            <div class="offer_reviews_rating text-center">3.5</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
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
<script src="plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="js/offers_custom.js"></script>

</body>

</html>