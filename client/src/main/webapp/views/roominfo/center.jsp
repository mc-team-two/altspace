<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

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
    <div class="home_background parallax-window" data-parallax="scroll"
         data-image-src="images/offer_background.jpg"></div>
    <div class="home_content">
        <div class="home_title">숙소 정보</div>
    </div>
</div>

<!-- 센터 -->

<div class="listing">

    <!-- 검색 -->

    <div class="search">
        <div class="search_inner">

            <!-- Search Contents -->

            <div class="container fill_height no-padding">
                <div class="row fill_height no-margin">
                    <div class="col fill_height no-padding">

                        <!-- Search Panel 1 -->

                        <div class="search_panel active">
                            <form action="#" id="search_form_1"
                                  class="search_panel_content d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
                                <div class="search_item">
                                    <div>목적지</div>
                                    <input type="text" class="destination search_input" placeholder="여행지나 숙소를 검색해보세요."
                                           required="required">
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
                                <button class="button search_button">검색하기<span></span><span></span><span></span>
                                </button>
                            </form>
                        </div>

                        <!-- Search Panel 2 -->

                        <div class="search_panel active_2">
                            <form action="#" id="search_form_2"
                                  class="search_panel_content d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
                                <div class="search_item">
                                    <div>목적지</div>
                                    <input type="text" class="destination search_input" placeholder="여행지나 숙소를 검색해보세요."
                                           required="required">
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

                                <button class="button search_button">검색하기<span></span><span></span><span></span>
                                </button>
                            </form>
                        </div>

                        <!-- Search Panel 3 -->

                        <div class="search_panel active_3">
                            <form action="#" id="search_form_3"
                                  class="search_panel_content d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
                                <div class="search_item">
                                    <div>위치</div>
                                    <input type="text" class="destination search_input" placeholder="위치나 파티룸을 검색해보세요."
                                           required="required">
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
                                <button class="button search_button">검색하기<span></span><span></span><span></span>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 숙소 -->

    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="single_listing">

                    <!-- 숙소 정보 -->

                    <div class="hotel_info">

                        <!-- 숙소 타이틀 -->
                        <div class="hotel_title_container d-flex flex-lg-row flex-column">
                            <div class="hotel_title_content">
                                <h1 class="hotel_title">제주 감귤 레지던스</h1>
                                <h2 class="hotel_price">110,000원~</h2>
                                <h3 class="hotel_category">아파트</h3>
                                <div class="hotel_location">제주 서귀포시 성산읍 성산리 1</div>
                            </div>
                            <div class="hotel_title_button ml-lg-auto text-lg-right">
                                <div class="button book_button trans_200"><a href="#">숙소
                                    문의<span></span><span></span><span></span></a></div>
                            </div>
                        </div>

                        <!-- 숙소 평점 -->

                        <div class="hotel_image">
                            <img src="images/listing_hotel.jpg" alt="">
                            <div class="hotel_review_container d-flex flex-column align-items-center justify-content-center">
                                <div class="hotel_review">
                                    <div class="hotel_review_content">
                                        <div class="hotel_review_title">매우 만족</div>
                                        <div class="hotel_review_subtitle">100 개의 리뷰</div>
                                    </div>
                                    <div class="hotel_review_rating text-center">4.5</div>
                                </div>
                            </div>
                        </div>

                        <!-- 숙소 사진 (사진 따로 구해야 함) -->

                        <div class="hotel_gallery">
                            <div class="hotel_slider_container">
                                <div class="owl-carousel owl-theme hotel_slider">

                                    <!-- Hotel Gallery Slider Item -->
                                    <div class="owl-item">
                                        <a class="colorbox cboxElement" href="images/listing_1.jpg">
                                            <img src="images/listing_thumb_1.jpg" alt="https://unsplash.com/@jbriscoe">
                                        </a>
                                    </div>

                                    <!-- Hotel Gallery Slider Item -->
                                    <div class="owl-item">
                                        <a class="colorbox cboxElement" href="images/listing_2.jpg">
                                            <img src="images/listing_thumb_2.jpg" alt="https://unsplash.com/@grovemade">
                                        </a>
                                    </div>

                                    <!-- Hotel Gallery Slider Item -->
                                    <div class="owl-item">
                                        <a class="colorbox cboxElement" href="images/listing_3.jpg">
                                            <img src="images/listing_thumb_3.jpg"
                                                 alt="https://unsplash.com/@fransaraco">
                                        </a>
                                    </div>

                                    <!-- Hotel Gallery Slider Item -->
                                    <div class="owl-item">
                                        <a class="colorbox cboxElement" href="images/listing_4.jpg">
                                            <img src="images/listing_thumb_4.jpg" alt="https://unsplash.com/@workweek">
                                        </a>
                                    </div>

                                    <!-- Hotel Gallery Slider Item -->
                                    <div class="owl-item">
                                        <a class="colorbox cboxElement" href="images/listing_5.jpg">
                                            <img src="images/listing_thumb_5.jpg" alt="https://unsplash.com/@workweek">
                                        </a>
                                    </div>

                                    <!-- Hotel Gallery Slider Item -->
                                    <div class="owl-item">
                                        <a class="colorbox cboxElement" href="images/listing_6.jpg">
                                            <img src="images/listing_thumb_6.jpg" alt="https://unsplash.com/@avidenov">
                                        </a>
                                    </div>

                                    <!-- Hotel Gallery Slider Item -->
                                    <div class="owl-item">
                                        <a class="colorbox cboxElement" href="images/listing_7.jpg">
                                            <img src="images/listing_thumb_7.jpg"
                                                 alt="https://unsplash.com/@pietruszka">
                                        </a>
                                    </div>

                                    <!-- Hotel Gallery Slider Item -->
                                    <div class="owl-item">
                                        <a class="colorbox cboxElement" href="images/listing_8.jpg">
                                            <img src="images/listing_thumb_8.jpg" alt="https://unsplash.com/@rktkn">
                                        </a>
                                    </div>

                                    <!-- Hotel Gallery Slider Item -->
                                    <div class="owl-item">
                                        <a class="colorbox cboxElement" href="images/listing_9.jpg">
                                            <img src="images/listing_thumb_9.jpg" alt="https://unsplash.com/@mindaugas">
                                        </a>
                                    </div>
                                </div>

                                <!-- Hotel Slider Nav - Prev -->
                                <div class="hotel_slider_nav hotel_slider_prev">
                                    <svg version="1.1" id="Layer_6" xmlns="http://www.w3.org/2000/svg"
                                         x="0px" y="0px"
                                         width="28px" height="33px" viewBox="0 0 28 33"
                                         enable-background="new 0 0 28 33" xml:space="preserve">
											<defs>
                                                <linearGradient id='hotel_grad_prev'>
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

                                <!-- Hotel Slider Nav - Next -->
                                <div class="hotel_slider_nav hotel_slider_next">
                                    <svg version="1.1" id="Layer_7" xmlns="http://www.w3.org/2000/svg"
                                         x="0px" y="0px"
                                         width="28px" height="33px" viewBox="0 0 28 33"
                                         enable-background="new 0 0 28 33" xml:space="preserve">
											<defs>
                                                <linearGradient id='hotel_grad_next'>
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

                        <!-- 숙소 정보 아이콘 -->

                        <div class="hotel_info_tags">
                            <ul class="hotel_icons_list">
                                <li class="hotel_icons_item"><img src="images/compass.png"><h4 class="pet">반려동물 입장
                                    가능</h4></li>
                                <li class="hotel_icons_item"><img src="images/bicycle.png"><h4 class="pool">수영장 이용
                                    가능</h4></li>
                                <li class="hotel_icons_item"><img src="images/sailboat.png"><h4 class="barbecue">바베큐 이용
                                    가능</h4></li>
                            </ul>
                        </div>

                    </div>

                    <!-- 객실 -->

                    <div class="rooms">

                        <!-- 객실 -->
                        <div class="room">

                            <!-- 객실 1 -->
                            <div class="row">
                                <div class="col-lg-2">
                                    <div class="room_image"><img src="images/room_1.jpg"></div>
                                </div>
                                <div class="col-lg-7">
                                    <div class="room_content">
                                        <div class="room_roomType">예약 가능</div>
                                        <div class="room_price">마운틴뷰 더블</div>
                                        <div class="room_text">110,000원</div>
                                        <div class="room_personMax">최대 3인까지</div>
                                        <div class="room_breakfast">조식 미제공</div>
                                    </div>
                                </div>
                                <div class="col-lg-3 text-lg-right">
                                    <div class="room_button">
                                        <div class="button book_button trans_200"><a
                                                href="#">예약하기<span></span><span></span><span></span></a></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Room -->
                        <div class="room">

                            <!-- Room -->
                            <div class="row">
                                <div class="col-lg-2">
                                    <div class="room_image"><img src="images/room_2.jpg"
                                                                 alt="https://unsplash.com/@oowgnuj"></div>
                                </div>
                                <div class="col-lg-7">
                                    <div class="room_content">
                                        <div class="room_roomType">예약 가능</div>
                                        <div class="room_price">오션뷰 더블</div>
                                        <div class="room_text">150,000원</div>
                                        <div class="room_personMax">최대 4인까지</div>
                                        <div class="room_breakfast">조식 제공</div>
                                    </div>
                                </div>
                                <div class="col-lg-3 text-lg-right">
                                    <div class="room_button">
                                        <div class="button book_button trans_200"><a
                                                href="#">예약하기<span></span><span></span><span></span></a></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <!-- Reviews -->

                    <div class="reviews">
                        <div class="reviews_title">리뷰</div>
                        <div class="reviews_container">

                            <!-- Review -->
                            <div class="review">
                                <div class="row">
                                    <div class="col-lg-1">
                                        <div class="review_image">
                                            <img src="images/review_1.jpg">
                                        </div>
                                    </div>
                                    <div class="col-lg-11">
                                        <div class="review_content">
                                            <div class="review_title_container">
                                                <div class="review_title">제주도에서 제일 맘에 드는 레지던스</div>
                                                <div class="review_rating">4.0</div>
                                            </div>
                                            <div class="review_text">
                                                <p>제주 감귤 레지던스에 대한 간략한 리뷰</p>
                                            </div>
                                            <div class="review_name">배수지</div>
                                            <div class="review_date">2024-12-25</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- 보기 전용 리뷰 -->
                            <div class="review">
                                <div class="row">
                                    <div class="col-lg-1">
                                        <div class="review_image">
                                            <img src="images/review_2.jpg">
                                        </div>
                                    </div>
                                    <div class="col-lg-11">
                                        <div class="review_content">
                                            <div class="review_title_container">
                                                <div class="review_title">제주도에서 제일 맘에 드는 레지던스</div>
                                                <div class="review_rating">5.0</div>
                                            </div>
                                            <div class="review_text">
                                                <p>제주 감귤 레지던스에 대한 간략한 리뷰</p>
                                            </div>
                                            <div class="review_name">이진만</div>
                                            <div class="review_date">2025-02-10</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <!-- 숙소 위치 -->

                    <div class="location_on_map">
                        <div class="location_on_map_title">숙소 위치</div>

                        <!-- Google Map -->

                        <div class="travelix_map">
                            <div id="google_map" class="google_map">
                                <div class="map_container">
                                    <div id="map"></div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="plugins/colorbox/jquery.colorbox-min.js"></script>
<script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyCIwF204lFZg1y4kPSIhKaHEXMLYxxuMhA"></script>
<script src="js/single_listing_custom.js"></script>