<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<head>
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/darkmode.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/chatbot.css"/>">
    <link rel="stylesheet"
          href="<c:url value="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css"/>">
    <link rel="stylesheet"
          href="<c:url value="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>">
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoJSApiKey}&autoload=false&libraries=services"></script>

</head>

<div class="menu trans_500">
    <div class="menu_content d-flex flex-column align-items-center justify-content-center text-center">
        <div class="menu_close_container">
            <div class="menu_close"></div>
        </div>
        <div class="logo menu_logo"><a href="/"><img src="images/logo.png" alt=""></a></div>
        <ul>
            <li class="menu_item"><a href="<c:url value="/"/> "><spring:message code="home"/></a></li>
            <li class="menu_item"><a href="<c:url value="/about"/> "><spring:message code="about"/> </a></li>
            <li class="menu_item"><a href="<c:url value="/contacts"/> "><spring:message code="contacts"/></a></li>
            <li class="menu_item"><a href="<c:url value="/details"/> "><spring:message code="details"/></a></li>
        </ul>
    </div>
</div>

<!-- 홈 -->

<div class="home">
    <div class="home_background parallax-window" data-parallax="scroll"
         data-image-src="images/image20250516174110.gif"></div>
    <div class="home_content">
        <div class="home_title">
            <spring:message code="hometitle"/>
        </div>
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
                            <form id="searchForm"
                                  class="search_panel_content d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
                                <div class="search_item">
                                    <div><spring:message code="destination"/></div>
                                    <input type="text" id="searchInput" class="destination search_input"
                                           placeholder="<spring:message code="destination_placeholder"/>"
                                           required="required">
                                </div>
                                <div class="search_item">
                                    <div><spring:message code="checkIn"/></div>
                                    <input type="text" class="check_in search_input" id="checkInInput"
                                           placeholder="YYYY-MM-DD">
                                </div>
                                <div class="search_item">
                                    <div><spring:message code="checkout"/></div>
                                    <input type="text" class="check_out search_input" id="checkOutInput"
                                           placeholder="YYYY-MM-DD">
                                </div>
                                <div class="search_item">
                                    <div><spring:message code="persons"/></div>
                                    <select name="adults" id="adults_1" class="dropdown_item_select search_input">
                                        <option><spring:message code="person_option1"/></option>
                                        <option><spring:message code="person_option2"/></option>
                                        <option><spring:message code="person_option3"/></option>
                                        <option><spring:message code="person_option4"/></option>
                                    </select>
                                </div>

                                <!-- Search Panel 1 추가 옵션 -->

                                <div class="extras">
                                    <ul class="search_extras clearfix">
                                        <li class="search_extras_item">
                                            <div class="clearfix">
                                                <input type="checkbox" id="search_extras_1" class="search_extras_cb">
                                                <label for="search_extras_1"><spring:message code="breakfast"/></label>
                                            </div>
                                        </li>
                                        <li class="search_extras_item">
                                            <div class="clearfix">
                                                <input type="checkbox" id="search_extras_2" class="search_extras_cb">
                                                <label for="search_extras_2"><spring:message code="petfrendly"/></label>
                                            </div>
                                        </li>
                                        <li class="search_extras_item">
                                            <div class="clearfix">
                                                <input type="checkbox" id="search_extras_3" class="search_extras_cb">
                                                <label for="search_extras_3"><spring:message code="barbecue"/></label>
                                            </div>
                                        </li>
                                        <li class="search_extras_item">
                                            <div class="clearfix">
                                                <input type="checkbox" id="search_extras_4" class="search_extras_cb">
                                                <label for="search_extras_4"><spring:message
                                                        code="swimmingpool"/></label>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <button type="button" class="button search_button" id="searchAccommodationBtn">
                                    <spring:message code="searchBtn"/><span></span><span></span><span></span></button>
                            </form>
                        </div>

                        <!-- Search Panel 2 -->

                        <div class="search_panel active_2">
                            <form action="#" id="search_form_2"
                                  class="search_panel_content d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
                                <div class="search_item">
                                    <div><spring:message code="destination"/></div>
                                    <input type="text" class="destination search_input"
                                           placeholder="<spring:message code="destination_placeholder"/>"
                                           required="required">
                                </div>
                                <div class="search_item">
                                    <div><spring:message code="checkIn"/></div>
                                    <input type="text" class="check_in search_input" placeholder="YYYY-MM-DD">
                                </div>
                                <div class="search_item">
                                    <div><spring:message code="checkout"/></div>
                                    <input type="text" class="check_out search_input" placeholder="YYYY-MM-DD">
                                </div>
                                <div class="search_item">
                                    <div><spring:message code="persons"/></div>
                                    <select name="adults" id="adults_2" class="dropdown_item_select search_input">
                                        <option><spring:message code="person_option1"/></option>
                                        <option><spring:message code="person_option2"/></option>
                                        <option><spring:message code="person_option3"/></option>
                                        <option><spring:message code="person_option4"/></option>
                                    </select>
                                </div>

                                <!-- Search Panel 2 추가 옵션 -->

                                <div class="extras">
                                    <ul class="search_extras clearfix">
                                        <li class="search_extras_item">
                                            <div class="clearfix">
                                                <input type="checkbox" id="search_extras_6" class="search_extras_cb">
                                                <label for="search_extras_6"><spring:message code="breakfast"/></label>
                                            </div>
                                        </li>
                                        <li class="search_extras_item">
                                            <div class="clearfix">
                                                <input type="checkbox" id="search_extras_7" class="search_extras_cb">
                                                <label for="search_extras_7"><spring:message code="petfrendly"/></label>
                                            </div>
                                        </li>
                                        <li class="search_extras_item">
                                            <div class="clearfix">
                                                <input type="checkbox" id="search_extras_8" class="search_extras_cb">
                                                <label for="search_extras_8"><spring:message code="barbecue"/></label>
                                            </div>
                                        </li>
                                        <li class="search_extras_item">
                                            <div class="clearfix">
                                                <input type="checkbox" id="search_extras_9" class="search_extras_cb">
                                                <label for="search_extras_9"><spring:message
                                                        code="swimmingpool"/></label>
                                            </div>
                                        </li>
                                        <li class="search_extras_item">
                                            <div class="clearfix">
                                                <input type="checkbox" id="search_extras_10" class="search_extras_cb">
                                                <label for="search_extras_10"><spring:message
                                                        code="swimmingpool"/></label>
                                            </div>
                                        </li>
                                    </ul>
                                </div>

                                <button class="button search_button"><spring:message
                                        code="searchBtn"/><span></span><span></span><span></span>
                                </button>
                            </form>
                        </div>

                        <!-- Search Panel 3 -->

                        <div class="search_panel active_3">
                            <form action="#" id="search_form_3"
                                  class="search_panel_content d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
                                <div class="search_item">
                                    <div><spring:message code="destination"/></div>
                                    <input type="text" class="destination search_input"
                                           placeholder="<spring:message code="destination_placeholder"/>"
                                           required="required">
                                </div>
                                <div class="search_item">
                                    <div><spring:message code="checkIn"/></div>
                                    <input type="text" class="check_in search_input" placeholder="YYYY-MM-DD">
                                </div>
                                <div class="search_item">
                                    <div><spring:message code="checkout"/></div>
                                    <input type="text" class="check_out search_input" placeholder="YYYY-MM-DD">
                                </div>
                                <div class="search_item">
                                    <div><spring:message code="persons"/></div>
                                    <select name="adults" id="adults_3" class="dropdown_item_select search_input">
                                        <option><spring:message code="person_option1"/></option>
                                        <option><spring:message code="person_option2"/></option>
                                        <option><spring:message code="person_option3"/></option>
                                        <option><spring:message code="person_option4"/></option>
                                    </select>
                                </div>

                                <!-- Search Panel 3 추가 옵션 -->

                                <div class="extras">
                                    <ul class="search_extras clearfix">
                                        <li class="search_extras_item">
                                            <div class="clearfix">
                                                <input type="checkbox" id="search_extras_11" class="search_extras_cb">
                                                <label for="search_extras_11"><spring:message code="breakfast"/></label>
                                            </div>
                                        </li>
                                        <li class="search_extras_item">
                                            <div class="clearfix">
                                                <input type="checkbox" id="search_extras_12" class="search_extras_cb">
                                                <label for="search_extras_12"><spring:message
                                                        code="petfrendly"/></label>
                                            </div>
                                        </li>
                                        <li class="search_extras_item">
                                            <div class="clearfix">
                                                <input type="checkbox" id="search_extras_13" class="search_extras_cb">
                                                <label for="search_extras_13"><spring:message code="barbecue"/></label>
                                            </div>
                                        </li>
                                        <li class="search_extras_item">
                                            <div class="clearfix">
                                                <input type="checkbox" id="search_extras_14" class="search_extras_cb">
                                                <label for="search_extras_14"><spring:message
                                                        code="swimmingpool"/></label>
                                            </div>
                                        </li>
                                        <li class="search_extras_item">
                                            <div class="clearfix">
                                                <input type="checkbox" id="search_extras_15" class="search_extras_cb">
                                                <label for="search_extras_15"><spring:message
                                                        code="swimmingpool"/></label>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <button class="button search_button"><spring:message
                                        code="searchBtn"/><span></span><span></span><span></span>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="container">
        <div id="travel-rankings-container" class="row mt-5">
            <div class="col-md-6">
                <div class="row text-center" id="travel-insight-widgets">
                    <div class="col-12 mb-3"> <div class="card h-100"> <div class="card-body p-0"> <div id="map" style="width: 100%; height: 300px; z-index:1000;">
                    </div>
                    </div>
                    </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6"><h5>📌 Gemini 분석 결과</h5>
                <div id="gemini-insight">
                    <div id="top5Carousel" class="carousel slide d-none" data-ride="carousel">
                        <div class="carousel-inner">
                            <div id="carousel1" class="carousel-item active"></div>
                            <div id="carousel2" class="carousel-item"></div>
                            <div id="carousel3" class="carousel-item"></div>
                            <div id="carousel4" class="carousel-item"></div>
                            <div id="carousel5" class="carousel-item"></div>
                        </div>
                        <a class="carousel-control-prev" href="#top5Carousel" role="button" data-slide="prev" stype="">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#top5Carousel" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
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
                            <span class="sorting_text"><spring:message code="filter1title"/></span>
                            <i class="fa fa-chevron-down"></i>
                            <ul>
                                <li class="sort_btn" data-isotope-option='{ "sortBy": "original-order" }'
                                    data-parent=".price_sorting"><span><spring:message code="filter1all"/></span></li>
                                <li class="sort_btn" data-isotope-option='{ "sortBy": "price", "sortAscending": true }'
                                    data-parent=".price_sorting"><span><spring:message code="filter1asc"/></span></li>
                                <li class="sort_btn" data-isotope-option='{ "sortBy": "price", "sortAscending": false }'
                                    data-parent=".price_sorting"><span><spring:message code="filter1desc"/></span></li>
                            </ul>
                        </li>
                        <li>
                            <span class="sorting_text"><spring:message code="filter2title"/></span>
                            <i class="fa fa-chevron-down"></i>
                            <ul>
                                <li class="sort_btn" data-isotope-option='{ "sortBy": "original-order" }'>
                                    <span><spring:message code="filter2all"/></span></li>
                                <li class="sort_btn" data-isotope-option='{ "sortBy": "name", "sortAscending": true }'>
                                    <span><spring:message code="filter2asc"/></span></li>
                                <li class="sort_btn" data-isotope-option='{ "sortBy": "name", "sortAscending": false }'>
                                    <span><spring:message code="filter2desc"/></span></li>
                            </ul>
                        </li>
                        <li>
                            <span class="sorting_text"><spring:message code="filter3title"/></span>
                            <i class="fa fa-chevron-down"></i>
                            <ul>
                                <li class="sort_btn" data-isotope-option='{ "sortBy": "original-order" }'>
                                    <span><spring:message code="filter3all"/></span></li>
                                <li class="sort_btn" data-isotope-option='{ "sortBy": "stars", "sortAscending": true }'>
                                    <span><spring:message code="filter3asc"/></span></li>
                                <li class="sort_btn"
                                    data-isotope-option='{ "sortBy": "stars", "sortAscending": false }'>
                                    <span><spring:message code="filter3desc"/></span></li>
                                <%--                                기능 보류. isotope에서 처리하는 녀석과 아닌 녀석이 한 카테고리에 있어서 전체 소트가 안먹힘..--%>
                                <%--                                <li class="filter_btn" data-filter=".rating_3"><span>3</span></li>--%>
                                <%--                                <li class="filter_btn" data-filter=".rating_4"><span>4</span></li>--%>
                                <%--                                <li class="filter_btn" data-filter=".rating_5"><span>5</span></li>--%>
                            </ul>
                        </li>
                    </ul>
                    <button id="geolocationBtn" data-popper-content=<spring:message code="geolocationBtn"/>>
                        <i class="fa fa-crosshairs" aria-hidden="true"></i></button>
                    <div class="popper-arrow"></div>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="offers_grid">
                    <c:forEach var="a" items="${accomm}">
                        <c:set var="currentRating" value="0"/>
                        <c:forEach var="awr" items="${accommodationsWithRatingList}">
                            <c:if test="${awr.accommodation.accommodationId == a.accommodationId}">
                                <c:set var="currentRating" value="${awr.roundedRating}"/>
                            </c:if>
                        </c:forEach>

                        <div class="offers_item rating_${currentRating}">
                            <div class="row">
                                <div class="col-lg-1 temp_col"></div>
                                <div class="col-lg-3 col-1680-4">
                                    <div class="offers_image_container" style="cursor:pointer;"
                                         onclick="updateViewsAndGo(${a.accommodationId})">
                                        <div class="offers_image_background"
                                             style="background-image:url('${pageContext.request.contextPath}/images/${a.image1Name}')"></div>
                                        <div class="offer_name"><a
                                                href="<c:url value="/detail?id=${a.accommodationId}"/>">${a.name}</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-8">
                                    <div class="offers_content">
                                        <div class="offers_price">₩${a.priceNight}<span><spring:message
                                                code="pernight"/></span></div>
                                        <div class="rating_r rating_r_${currentRating} offers_rating"
                                             data-rating="${currentRating}">
                                            <i></i><i></i><i></i><i></i><i></i>
                                        </div>
                                        <p class="offers_text">${a.description}</p>
                                        <div class="offers_icons">
                                            <ul class="offers_icons_list">
                                                <c:if test="${a.barbecue}">
                                                    <li class="offers_icons_item"
                                                        data-popper-content="<spring:message code="barbecue"/>">
                                                        <i class="fa fa-fire-alt text-warning" aria-hidden="true"></i>
                                                    </li>
                                                    <div class="popper-arrow"></div>
                                                </c:if>
                                                <c:if test="${a.breakfast}">
                                                    <li class="offers_icons_item"
                                                        data-popper-content="<spring:message code="breakfast"/>">
                                                        <i class="fa fa-coffee text-danger" aria-hidden="true"></i>
                                                    </li>
                                                    <div class="popper-arrow"></div>
                                                </c:if>
                                                <c:if test="${a.pet}">
                                                    <li class="offers_icons_item"
                                                        data-popper-content="<spring:message code="petfrendly"/>">
                                                        <i class="fa fa-paw text-info" aria-hidden="true"></i>
                                                    </li>
                                                    <div class="popper-arrow"></div>
                                                </c:if>
                                                <c:if test="${a.pool}">
                                                    <li class="offers_icons_item"
                                                        data-popper-content="<spring:message code="swimmingpool"/>">
                                                        <i class="fas fa-swimmer text-primary" aria-hidden="true"></i>
                                                    </li>
                                                    <div class="popper-arrow"></div>
                                                </c:if>
                                            </ul>
                                        </div>
                                        <div class="button book_button"><a href="javascript:void(0);"
                                                                           onclick="updateViewsAndGo(${a.accommodationId})"><spring:message
                                                code="book_button"/><span></span><span></span><span></span></a>
                                        </div>
                                        <div class="offer_reviews">
                                            <div class="offer_reviews_content">
                                                <div class="offer_reviews_title">
                                                    <c:choose>
                                                        <c:when test="${currentRating >= 4}"><spring:message
                                                                code="score4"/></c:when>
                                                        <c:when test="${currentRating == 3}"><spring:message
                                                                code="score3"/></c:when>
                                                        <c:when test="${currentRating == 2}"><spring:message
                                                                code="score2"/></c:when>
                                                        <c:when test="${currentRating == 1}"><spring:message
                                                                code="score1"/></c:when>
                                                        <c:otherwise><spring:message code="score0"/></c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="offer_reviews_subtitle"><spring:message
                                                        code="offer_reviews_subtitle"/></div>
                                            </div>
                                            <div class="offer_reviews_rating text-center">
                                                    ${currentRating}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="blog_navigation">
                            <ul class="d-flex flex-row align-items-center justify-content-center">
                                <c:forEach var="i" begin="${pageInfo.navigateFirstPage}"
                                           end="${pageInfo.navigateLastPage}">
                                    <li class="blog_page_item">
                                        <a href="?pageNum=${i}"
                                           class="blog_dot ${i == pageInfo.pageNum ? 'active' : ''}">
                                            <fmt:formatNumber value="${i}" pattern="0"/>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                <div id="chatbot" class="chatbot">
                    <div id="chat-icon" class="chat-icon">
                        <i class="fas fa-comments" aria-hidden="true"></i>
                    </div>
                    <div id="chat-window" class="chat-window">
                        <div class="chat-header">
                            <span><spring:message code="chat-header"/></span>
                            <button id="chat-close-btn" class="chat-close-btn">&times;</button>
                        </div>
                        <div class="chat-messages" id="chat-messages">

                        </div>
                        <div class="chat-input">
                            <input type="text" id="chat-input" placeholder="<spring:message code="chat-input"/>">
                            <button id="chat-send-btn"><spring:message code="chat-send-btn"/></button>
                        </div>
                    </div>
                </div>
                <div id="gemini-chatbot" class="chatbot chatbot-gemini">
                    <div id="gemini-chat-icon" class="chat-icon gemini-icon">
                        <i class="fab fa-android" aria-hidden="true"></i>
                    </div>
                    <div id="gemini-chat-window" class="chat-window gemini-window">
                        <div class="chat-header gemini-header">
                            <span><spring:message code="gemini-header"/></span>
                            <button id="gemini-chat-close-btn" class="chat-close-btn">&times;</button>
                        </div>
                        <div class="chat-messages" id="gemini-chat-messages"></div>
                        <div class="chat-input">
                            <input type="text" id="gemini-chat-input"
                                   placeholder="<spring:message code="gemini-chat-input"/>">
                            <button id="gemini-chat-send-btn"><spring:message code="gemini-chat-send-btn"/></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- JSON 데이터를 담고 있는 스크립트 블록 -->
<script id="statsJson" type="application/json">
    <c:out value="${statsJson}" escapeXml="false"/>


</script>

<script src="<c:url value="/js/geminiScript.js"/>"></script>
<script>
    function updateViewsAndGo(accId) {
        // 조회수 올리는 API 호출 (비동기, 실패해도 이동은 함)
        fetch('${pageContext.request.contextPath}/api/update-views?accId=' + accId, {
            method: 'GET'
        }).catch(err => {
            console.error('조회수 업데이트 실패', err);
        }).finally(() => {
            // API 호출 후 상세 페이지로 이동
            location.href = '${pageContext.request.contextPath}/detail?id=' + accId;
        });
    }
</script>