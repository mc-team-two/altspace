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
            <li class="menu_item"><a href="<c:url value="/details"/> ">예약 내역</a></li>
        </ul>
    </div>
</div>

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

                    <c:forEach var="a" items="${accomm}">
                        <div class="offers_item rating_??">
                            <div class="row">
                                <div class="col-lg-1 temp_col"></div>
                                <div class="col-lg-3 col-1680-4">
                                    <div class="offers_image_container">
                                        <div class="offers_image_background" style="background-image:url('${pageContext.request.contextPath}/images/')"></div>
                                        <div class="offer_name"><a href="<c:url value="/detail?id=${a.accommodationId}"/>">${a.name}</a></div>
                                    </div>
                                </div>
                                <div class="col-lg-8">
                                    <div class="offers_content">
                                        <div class="offers_price">$${a.priceNight}<span>per night</span></div>
                                        <div class="rating_r rating_r_?? offers_rating" data-rating="??">
                                            <i></i><i></i><i></i><i></i><i></i>
                                        </div>
                                        <p class="offers_text">${a.description}</p>
                                        <div class="offers_icons">
                                            <ul class="offers_icons_list">
                                                <li class="offers_icons_item"><img src="images/post.png" alt=""></li>
                                                <li class="offers_icons_item"><img src="images/compass.png" alt=""></li>
                                                <li class="offers_icons_item"><img src="images/bicycle.png" alt=""></li>
                                                <li class="offers_icons_item"><img src="images/sailboat.png" alt=""></li>
                                            </ul>
                                        </div>
                                        <div class="button book_button"><a href="<c:url value="/detail?id=${a.accommodationId}"/>">상세보기<span></span><span></span><span></span></a></div>
                                        <div class="offer_reviews">
                                            <div class="offer_reviews_content">
                                                <div class="offer_reviews_title">very good</div>
                                                <div class="offer_reviews_subtitle"> reviews</div>
                                            </div>
                                            <div class="offer_reviews_rating text-center"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="js/darkmode.js"></script>