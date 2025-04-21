<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<head>
    <title>Altspace | 가장 빠른 공간대여 알트스페이스</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="Travelix Project">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
    <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="styles/offers_styles.css">
    <link rel="stylesheet" type="text/css" href="styles/offers_responsive.css">
</head>

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

            <!-- 검색 -->

            <div class="container fill_height no-padding">
                <div class="row fill_height no-margin">
                    <div class="col fill_height no-padding">

                        <!-- 검색 패널 -->

                        <div class="search_panel active">
                            <form action="/" id="search_form_1" class="search_panel_content d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
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

                                <!-- 검색 패널 추가 옵션 -->

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

                <!-- 필터링 -->
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

                <!-- 목록 -->

                <div class="offers_grid">

                    <!-- 목록 1 -->

                    <div class="offers_item rating_4">
                        <div class="row">
                            <div class="col-lg-1 temp_col"></div>
                            <div class="col-lg-3 col-1680-4">
                                <div class="offers_image_container">
                                    <div class="offers_image_background" style="background-image:url(images/offer_1.jpg)"></div>
                                    <div class="offer_name"><a href="<c:url value="/roominfo"/> ">제주 감귤 레지던스</a></div>
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

                    <!-- 목록 2 -->

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

                    <!-- 목록 3 -->

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