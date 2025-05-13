<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>


<div class="menu trans_500">
    <div class="menu_content d-flex flex-column align-items-center justify-content-center text-center">
        <div class="menu_close_container">
            <div class="menu_close"></div>
        </div>
        <div class="logo menu_logo"><a href="/"><img src="images/logo.png" alt=""></a></div>
        <ul>
            <li class="menu_item"><a href="<c:url value="/"/> ">홈</a></li>
            <li class="menu_item"><a href="<c:url value="/about"/> ">Altspace란</a></li>
            <li class="menu_item"><a href="<c:url value="/contacts"/> ">고객센터</a></li>
            <li class="menu_item"><a href="<c:url value="/details"/> ">마이페이지</a></li>
        </ul>
    </div>
</div>

<!-- 홈 -->

<div class="home">
    <div class="home_background parallax-window" data-parallax="scroll"
         data-image-src="images/offer_background.jpg"></div>
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
                            <form id="searchForm"
                                  class="search_panel_content d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-between justify-content-start">
                                <div class="search_item">
                                    <div>목적지</div>
                                    <input type="text" id="searchInput" class="destination search_input"
                                           placeholder="여행지나 숙소를 검색해보세요." required="required">
                                </div>
                                <div class="search_item">
                                    <div>체크인</div>
                                    <input type="text" class="check_in search_input" id="checkInInput"
                                           placeholder="YYYY-MM-DD">
                                </div>
                                <div class="search_item">
                                    <div>체크아웃</div>
                                    <input type="text" class="check_out search_input" id="checkOutInput"
                                           placeholder="YYYY-MM-DD">
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
                                                <label for="search_extras_1">맛있는 조식 제공</label>
                                            </div>
                                        </li>
                                        <li class="search_extras_item">
                                            <div class="clearfix">
                                                <input type="checkbox" id="search_extras_2" class="search_extras_cb">
                                                <label for="search_extras_2">반려동물 동반</label>
                                            </div>
                                        </li>
                                        <li class="search_extras_item">
                                            <div class="clearfix">
                                                <input type="checkbox" id="search_extras_3" class="search_extras_cb">
                                                <label for="search_extras_3">바베큐 시설 안내</label>
                                            </div>
                                        </li>
                                        <li class="search_extras_item">
                                            <div class="clearfix">
                                                <input type="checkbox" id="search_extras_4" class="search_extras_cb">
                                                <label for="search_extras_4">시원한 수영장</label>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <button type="button" class="button search_button" id="searchAccommodationBtn">
                                    검색하기<span></span><span></span><span></span></button>
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
                                <li class="sort_btn" data-isotope-option='{ "sortBy": "original-order" }'
                                    data-parent=".price_sorting"><span>전체</span></li>
                                <li class="sort_btn" data-isotope-option='{ "sortBy": "price", "sortAscending": true }'
                                    data-parent=".price_sorting"><span>낮은 가격순</span></li>
                                <li class="sort_btn" data-isotope-option='{ "sortBy": "price", "sortAscending": false }'
                                    data-parent=".price_sorting"><span>높은 가격순</span></li>
                            </ul>
                        </li>
                        <li>
                            <span class="sorting_text">숙소명</span>
                            <i class="fa fa-chevron-down"></i>
                            <ul>
                                <li class="sort_btn" data-isotope-option='{ "sortBy": "original-order" }'>
                                    <span>전체</span></li>
                                <li class="sort_btn" data-isotope-option='{ "sortBy": "name", "sortAscending": true }'>
                                    <span>가나다순</span></li>
                                <li class="sort_btn" data-isotope-option='{ "sortBy": "name", "sortAscending": false }'>
                                    <span>역순</span></li>
                            </ul>
                        </li>
                        <li>
                            <span class="sorting_text">별점</span>
                            <i class="fa fa-chevron-down"></i>
                            <ul>
                                <li class="sort_btn" data-isotope-option='{ "sortBy": "original-order" }'>
                                    <span>전체</span></li>
                                <li class="sort_btn" data-isotope-option='{ "sortBy": "stars", "sortAscending": true }'>
                                    <span>낮은 별점순</span></li>
                                <li class="sort_btn"
                                    data-isotope-option='{ "sortBy": "stars", "sortAscending": false }'>
                                    <span>높은 별점순</span></li>
                                <%--                                기능 보류. isotope에서 처리하는 녀석과 아닌 녀석이 한 카테고리에 있어서 전체 소트가 안먹힘..--%>
                                <%--                                <li class="filter_btn" data-filter=".rating_3"><span>3</span></li>--%>
                                <%--                                <li class="filter_btn" data-filter=".rating_4"><span>4</span></li>--%>
                                <%--                                <li class="filter_btn" data-filter=".rating_5"><span>5</span></li>--%>
                            </ul>
                        </li>
                    </ul>
                    <button id="geolocationBtn" data-popper-content="현재 위치를 기준으로 검색">
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
                                    <div class="offers_image_container">
                                        <div class="offers_image_background"
                                             style="background-image:url('${pageContext.request.contextPath}/images/${a.image1Name}')"></div>
                                        <div class="offer_name"><a
                                                href="<c:url value="/detail?id=${a.accommodationId}"/>">${a.name}</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-8">
                                    <div class="offers_content">
                                        <div class="offers_price">₩${a.priceNight}<span>per night</span></div>
                                        <div class="rating_r rating_r_${currentRating} offers_rating"
                                             data-rating="${currentRating}">
                                            <i></i><i></i><i></i><i></i><i></i>
                                        </div>
                                        <p class="offers_text">${a.description}</p>
                                        <div class="offers_icons">
                                            <ul class="offers_icons_list">
                                                <c:if test="${a.barbecue}">
                                                    <li class="offers_icons_item" data-popper-content="바베큐 시설 안내">
                                                        <i class="fa fa-fire" aria-hidden="true" title="바베큐"></i>
                                                    </li>
                                                    <div class="popper-arrow"></div>
                                                </c:if>
                                                <c:if test="${a.breakfast}">
                                                    <li class="offers_icons_item" data-popper-content="맛있는 조식 제공">
                                                        <i class="fa fa-coffee" aria-hidden="true" title="조식"></i>
                                                    </li>
                                                    <div class="popper-arrow"></div>
                                                </c:if>
                                                <c:if test="${a.pet}">
                                                    <li class="offers_icons_item" data-popper-content="반려동물 동반">
                                                        <i class="fa fa-paw" aria-hidden="true" title="반려동물"></i>
                                                    </li>
                                                    <div class="popper-arrow"></div>
                                                </c:if>
                                                <c:if test="${a.pool}">
                                                    <li class="offers_icons_item" data-popper-content="시원한 수영장">
                                                        <i class="fa fa-tint" aria-hidden="true" title="수영장"></i>
                                                    </li>
                                                    <div class="popper-arrow"></div>
                                                </c:if>
                                            </ul>
                                        </div>
                                        <div class="button book_button"><a
                                                href="<c:url value="/detail?id=${a.accommodationId}"/>">상세보기<span></span><span></span><span></span></a>
                                        </div>
                                        <div class="offer_reviews">
                                            <div class="offer_reviews_content">
                                                <div class="offer_reviews_title">
                                                    <c:choose>
                                                        <c:when test="${currentRating >= 4}">최고예요!</c:when>
                                                        <c:when test="${currentRating == 3}">좋아요!</c:when>
                                                        <c:when test="${currentRating == 2}">괜찮아요!</c:when>
                                                        <c:when test="${currentRating == 1}">그저 그래요!</c:when>
                                                        <c:otherwise>평가가 없어요</c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="offer_reviews_subtitle"> 리뷰 평점:</div>
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
                                        <a href="?pageNum=${i}" class="blog_dot ${i == pageInfo.pageNum ? 'active' : ''}">
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
                        <i class="fa fa-comment" aria-hidden="true"></i>
                    </div>
                    <div id="chat-window" class="chat-window">
                        <div class="chat-header">
                            <span>챗봇과 대화하기</span>
                            <button id="chat-close-btn" class="chat-close-btn">&times;</button>
                        </div>
                        <div class="chat-messages" id="chat-messages">

                        </div>
                        <div class="chat-input">
                            <input type="text" id="chat-input" placeholder="메세지를 입력해주세요">
                            <button id="chat-send-btn">보내기</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>