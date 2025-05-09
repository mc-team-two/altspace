<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<head>
    <link rel="stylesheet" type="text/css" href="styles/darkmode.css">
</head>

<div class="menu trans_500">
    <div class="menu_content d-flex flex-column align-items-center justify-content-center text-center">
        <div class="menu_close_container"><div class="menu_close"></div></div>
        <div class="logo menu_logo"><a href="/"><img src="images/logo.png" alt=""></a></div>
        <ul>
            <li class="menu_item"><a href="<c:url value="/"/> ">홈</a></li>
            <li class="menu_item"><a href="<c:url value="/about"/> ">Altspace란</a></li>
            <li class="menu_item"><a href="<c:url value="/contacts"/> ">고객센터</a></li>
            <li class="menu_item"><a href="<c:url value="/details"/> ">마이페이지</a></li>
        </ul>
    </div>
</div>

    <!-- Home -->

    <div class="home">
        <div class="home_background parallax-window" data-parallax="scroll"
             data-image-src="static/images/single_background.jpg"></div>
        <div class="home_content">
            <div class="home_title">My Page</div>
        </div>
    </div>
    <!-- Offers -->

    <div class="listing">

        <!-- Search -->

        <div class="search">
            <div class="search_inner">

                <!-- Search Contents -->

                <div class="container fill_height no-padding">
                    <div class="row fill_height no-margin">
                        <div class="col fill_height no-padding">

                            <!-- Search Tabs -->

                            <div class="search_tabs_container">
                                <div class="search_tabs d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
                                    <div class="search_tab active d-flex flex-row align-items-center justify-content-lg-center justify-content-start">
                                        <img src="images/suitcase.png" alt=""><span>hotels</span></div>
                                    <div class="search_tab d-flex flex-row align-items-center justify-content-lg-center justify-content-start">
                                        <img src="images/bus.png" alt="">car rentals
                                    </div>
                                    <div class="search_tab d-flex flex-row align-items-center justify-content-lg-center justify-content-start">
                                        <img src="images/departure.png" alt="">flights
                                    </div>
                                    <div class="search_tab d-flex flex-row align-items-center justify-content-lg-center justify-content-start">
                                        <img src="images/island.png" alt="">trips
                                    </div>
                                    <div class="search_tab d-flex flex-row align-items-center justify-content-lg-center justify-content-start">
                                        <img src="images/cruise.png" alt="">cruises
                                    </div>
                                    <div class="search_tab d-flex flex-row align-items-center justify-content-lg-center justify-content-start">
                                        <img src="images/diving.png" alt="">activities
                                    </div>
                                </div>
                            </div>

                            <!-- Search Panel -->

                            <div class="search_panel active">
                                <form action="#" id="search_form_1"
                                      class="search_panel_content d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
                                    <div class="search_item">
                                        <div>destination</div>
                                        <input type="text" class="destination search_input" required="required">
                                    </div>
                                    <div class="search_item">
                                        <div>check in</div>
                                        <input type="text" class="check_in search_input" placeholder="YYYY-MM-DD">
                                    </div>
                                    <div class="search_item">
                                        <div>check out</div>
                                        <input type="text" class="check_out search_input" placeholder="YYYY-MM-DD">
                                    </div>
                                    <div class="search_item">
                                        <div>adults</div>
                                        <select name="adults" id="adults_1" class="dropdown_item_select search_input">
                                            <option>01</option>
                                            <option>02</option>
                                            <option>03</option>
                                        </select>
                                    </div>
                                    <div class="search_item">
                                        <div>children</div>
                                        <select name="children" id="children_1"
                                                class="dropdown_item_select search_input">
                                            <option>0</option>
                                            <option>02</option>
                                            <option>03</option>
                                        </select>
                                    </div>
                                    <div class="extras">
                                        <ul class="search_extras clearfix">
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_1"
                                                           class="search_extras_cb">
                                                    <label for="search_extras_1">Pet Friendly</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_2"
                                                           class="search_extras_cb">
                                                    <label for="search_extras_2">Car Parking</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_3"
                                                           class="search_extras_cb">
                                                    <label for="search_extras_3">Wireless Internet</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_4"
                                                           class="search_extras_cb">
                                                    <label for="search_extras_4">Reservations</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_5"
                                                           class="search_extras_cb">
                                                    <label for="search_extras_5">Private Parking</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_6"
                                                           class="search_extras_cb">
                                                    <label for="search_extras_6">Smoking Area</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_7"
                                                           class="search_extras_cb">
                                                    <label for="search_extras_7">Wheelchair Accessible</label>
                                                </div>
                                            </li>
                                            <li class="search_extras_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="search_extras_8"
                                                           class="search_extras_cb">
                                                    <label for="search_extras_8">Pool</label>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="more_options">
                                        <div class="more_options_trigger">
                                            <a href="#">load more options</a>
                                        </div>
                                        <ul class="more_options_list clearfix">
                                            <li class="more_options_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="more_options_1" class="search_extras_cb">
                                                    <label for="more_options_1">Pet Friendly</label>
                                                </div>
                                            </li>
                                            <li class="more_options_item">
                                                <div class="clearfix">
                                                    <input type="checkbox" id="more_options_2" class="search_extras_cb">
                                                    <label for="more_options_2">Car Parking</label>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                    <button class="button search_button">search<span></span><span></span><span></span>
                                    </button>
                                </form>
                            </div>

                            <!-- Search Panel -->

                            <div class="search_panel">
                                <form action="#" id="search_form_2"
                                      class="search_panel_content d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
                                    <div class="search_item">
                                        <div>destination</div>
                                        <input type="text" class="destination search_input" required="required">
                                    </div>
                                    <div class="search_item">
                                        <div>check in</div>
                                        <input type="text" class="check_in search_input" placeholder="YYYY-MM-DD">
                                    </div>
                                    <div class="search_item">
                                        <div>check out</div>
                                        <input type="text" class="check_out search_input" placeholder="YYYY-MM-DD">
                                    </div>
                                    <div class="search_item">
                                        <div>adults</div>
                                        <select name="adults" id="adults_2" class="dropdown_item_select search_input">
                                            <option>01</option>
                                            <option>02</option>
                                            <option>03</option>
                                        </select>
                                    </div>
                                    <div class="search_item">
                                        <div>children</div>
                                        <select name="children" id="children_2"
                                                class="dropdown_item_select search_input">
                                            <option>0</option>
                                            <option>02</option>
                                            <option>03</option>
                                        </select>
                                    </div>
                                    <button class="button search_button">search<span></span><span></span><span></span>
                                    </button>
                                </form>
                            </div>

                            <!-- Search Panel -->

                            <div class="search_panel">
                                <form action="#" id="search_form_3"
                                      class="search_panel_content d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
                                    <div class="search_item">
                                        <div>destination</div>
                                        <input type="text" class="destination search_input" required="required">
                                    </div>
                                    <div class="search_item">
                                        <div>check in</div>
                                        <input type="text" class="check_in search_input" placeholder="YYYY-MM-DD">
                                    </div>
                                    <div class="search_item">
                                        <div>check out</div>
                                        <input type="text" class="check_out search_input" placeholder="YYYY-MM-DD">
                                    </div>
                                    <div class="search_item">
                                        <div>adults</div>
                                        <select name="adults" id="adults_3" class="dropdown_item_select search_input">
                                            <option>01</option>
                                            <option>02</option>
                                            <option>03</option>
                                        </select>
                                    </div>
                                    <div class="search_item">
                                        <div>children</div>
                                        <select name="children" id="children_3"
                                                class="dropdown_item_select search_input">
                                            <option>0</option>
                                            <option>02</option>
                                            <option>03</option>
                                        </select>
                                    </div>
                                    <button class="button search_button">search<span></span><span></span><span></span>
                                    </button>
                                </form>
                            </div>

                            <!-- Search Panel -->

                            <div class="search_panel">
                                <form action="#" id="search_form_4"
                                      class="search_panel_content d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
                                    <div class="search_item">
                                        <div>destination</div>
                                        <input type="text" class="destination search_input" required="required">
                                    </div>
                                    <div class="search_item">
                                        <div>check in</div>
                                        <input type="text" class="check_in search_input" placeholder="YYYY-MM-DD">
                                    </div>
                                    <div class="search_item">
                                        <div>check out</div>
                                        <input type="text" class="check_out search_input" placeholder="YYYY-MM-DD">
                                    </div>
                                    <div class="search_item">
                                        <div>adults</div>
                                        <select name="adults" id="adults_4" class="dropdown_item_select search_input">
                                            <option>01</option>
                                            <option>02</option>
                                            <option>03</option>
                                        </select>
                                    </div>
                                    <div class="search_item">
                                        <div>children</div>
                                        <select name="children" id="children_4"
                                                class="dropdown_item_select search_input">
                                            <option>0</option>
                                            <option>02</option>
                                            <option>03</option>
                                        </select>
                                    </div>
                                    <button class="button search_button">search<span></span><span></span><span></span>
                                    </button>
                                </form>
                            </div>

                            <!-- Search Panel -->

                            <div class="search_panel">
                                <form action="#" id="search_form_5"
                                      class="search_panel_content d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
                                    <div class="search_item">
                                        <div>destination</div>
                                        <input type="text" class="destination search_input" required="required">
                                    </div>
                                    <div class="search_item">
                                        <div>check in</div>
                                        <input type="text" class="check_in search_input" placeholder="YYYY-MM-DD">
                                    </div>
                                    <div class="search_item">
                                        <div>check out</div>
                                        <input type="text" class="check_out search_input" placeholder="YYYY-MM-DD">
                                    </div>
                                    <div class="search_item">
                                        <div>adults</div>
                                        <select name="adults" id="adults_5" class="dropdown_item_select search_input">
                                            <option>01</option>
                                            <option>02</option>
                                            <option>03</option>
                                        </select>
                                    </div>
                                    <div class="search_item">
                                        <div>children</div>
                                        <select name="children" id="children_5"
                                                class="dropdown_item_select search_input">
                                            <option>0</option>
                                            <option>02</option>
                                            <option>03</option>
                                        </select>
                                    </div>
                                    <button class="button search_button">search<span></span><span></span><span></span>
                                    </button>
                                </form>
                            </div>

                            <!-- Search Panel -->

                            <div class="search_panel">
                                <form action="#" id="search_form_6"
                                      class="search_panel_content d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
                                    <div class="search_item">
                                        <div>destination</div>
                                        <input type="text" class="destination search_input" required="required">
                                    </div>
                                    <div class="search_item">
                                        <div>check in</div>
                                        <input type="text" class="check_in search_input" placeholder="YYYY-MM-DD">
                                    </div>
                                    <div class="search_item">
                                        <div>check out</div>
                                        <input type="text" class="check_out search_input" placeholder="YYYY-MM-DD">
                                    </div>
                                    <div class="search_item">
                                        <div>adults</div>
                                        <select name="adults" id="adults_6" class="dropdown_item_select search_input">
                                            <option>01</option>
                                            <option>02</option>
                                            <option>03</option>
                                        </select>
                                    </div>
                                    <div class="search_item">
                                        <div>children</div>
                                        <select name="children" id="children_6"
                                                class="dropdown_item_select search_input">
                                            <option>0</option>
                                            <option>02</option>
                                            <option>03</option>
                                        </select>
                                    </div>
                                    <button class="button search_button">search<span></span><span></span><span></span>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Single Listing -->

        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="single_listing">

                        <!-- Hotel Info -->

                        <div class="hotel_info">

                            <!-- Title -->
                            <div class="hotel_title_container d-flex flex-lg-row flex-column">
                                <div class="hotel_title_content">
                                    <h1 class="hotel_title">임시 페이지 입니다</h1>
                                    <div class="rating_r rating_r_4 hotel_rating">
                                        <i></i>
                                        <i></i>
                                        <i></i>
                                        <i></i>
                                        <i></i>
                                    </div>
                                    <div class="hotel_location">345 677 Gran Via Street, no 34, Madrid, Spain</div>
                                </div>
                                <div class="hotel_title_button ml-lg-auto text-lg-right">
                                    <div class="button book_button trans_200"><a
                                            href="#">book<span></span><span></span><span></span></a></div>
                                    <div class="hotel_map_link_container">
                                        <div class="hotel_map_link">See Location on Map</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Listing Image -->

                            <div class="hotel_image">
                                <img src="images/listing_hotel.jpg" alt="">
                            </div>
                        </div>
                    </div>

<%--                    <!-- Hotel Gallery -->--%>

<%--                    <div class="hotel_gallery">--%>
<%--                        <div class="hotel_slider_container">--%>
<%--                            <div class="owl-carousel owl-theme hotel_slider">--%>

<%--                                <!-- Hotel Gallery Slider Item -->--%>
<%--                                <div class="owl-item">--%>
<%--                                    <a class="colorbox cboxElement" href="images/listing_1.jpg">--%>
<%--                                        <img src="images/listing_thumb_1.jpg" alt="https://unsplash.com/@jbriscoe">--%>
<%--                                    </a>--%>
<%--                                </div>--%>

<%--                                <!-- Hotel Gallery Slider Item -->--%>
<%--                                <div class="owl-item">--%>
<%--                                    <a class="colorbox cboxElement" href="images/listing_2.jpg">--%>
<%--                                        <img src="images/listing_thumb_2.jpg" alt="https://unsplash.com/@grovemade">--%>
<%--                                    </a>--%>
<%--                                </div>--%>

<%--                                <!-- Hotel Gallery Slider Item -->--%>
<%--                                <div class="owl-item">--%>
<%--                                    <a class="colorbox cboxElement" href="images/listing_3.jpg">--%>
<%--                                        <img src="images/listing_thumb_3.jpg"--%>
<%--                                             alt="https://unsplash.com/@fransaraco">--%>
<%--                                    </a>--%>
<%--                                </div>--%>

<%--                                <!-- Hotel Gallery Slider Item -->--%>
<%--                                <div class="owl-item">--%>
<%--                                    <a class="colorbox cboxElement" href="images/listing_4.jpg">--%>
<%--                                        <img src="images/listing_thumb_4.jpg" alt="https://unsplash.com/@workweek">--%>
<%--                                    </a>--%>
<%--                                </div>--%>

<%--                                <!-- Hotel Gallery Slider Item -->--%>
<%--                                <div class="owl-item">--%>
<%--                                    <a class="colorbox cboxElement" href="images/listing_5.jpg">--%>
<%--                                        <img src="images/listing_thumb_5.jpg" alt="https://unsplash.com/@workweek">--%>
<%--                                    </a>--%>
<%--                                </div>--%>

<%--                                <!-- Hotel Gallery Slider Item -->--%>
<%--                                <div class="owl-item">--%>
<%--                                    <a class="colorbox cboxElement" href="images/listing_6.jpg">--%>
<%--                                        <img src="images/listing_thumb_6.jpg" alt="https://unsplash.com/@avidenov">--%>
<%--                                    </a>--%>
<%--                                </div>--%>

<%--                                <!-- Hotel Gallery Slider Item -->--%>
<%--                                <div class="owl-item">--%>
<%--                                    <a class="colorbox cboxElement" href="images/listing_7.jpg">--%>
<%--                                        <img src="images/listing_thumb_7.jpg"--%>
<%--                                             alt="https://unsplash.com/@pietruszka">--%>
<%--                                    </a>--%>
<%--                                </div>--%>

<%--                                <!-- Hotel Gallery Slider Item -->--%>
<%--                                <div class="owl-item">--%>
<%--                                    <a class="colorbox cboxElement" href="images/listing_8.jpg">--%>
<%--                                        <img src="images/listing_thumb_8.jpg" alt="https://unsplash.com/@rktkn">--%>
<%--                                    </a>--%>
<%--                                </div>--%>

<%--                                <!-- Hotel Gallery Slider Item -->--%>
<%--                                <div class="owl-item">--%>
<%--                                    <a class="colorbox cboxElement" href="images/listing_9.jpg">--%>
<%--                                        <img src="images/listing_thumb_9.jpg" alt="https://unsplash.com/@mindaugas">--%>
<%--                                    </a>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>

                    <!-- Hotel Info Text -->
                    <div class="hotel_info_text">
                        <c:if test="${errorMessage != null}">
                            <p style="color: red;">${errorMessage}</p>
                        </c:if>

                        <c:if test="${not empty user}">  <%-- user 객체 존재 여부로 분기 --%>
                            <p>이메일: ${user.email}</p>
                            <p>이름: ${user.name}</p>
                            <p>전화번호: ${user.phone}</p>
                            <p>가입일: ${user.createDay}</p>
                            <p>정보 수정일:
                                <c:choose>
                                    <c:when test="${user.updateDay == null}">
                                        수정 기록 없음
                                    </c:when>
                                    <c:otherwise>
                                        ${user.updateDay}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </c:if>
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