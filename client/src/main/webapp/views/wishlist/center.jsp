<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<head>
    <link rel="stylesheet" type="text/css" href="styles/blog_styles.css">
    <link rel="stylesheet" type="text/css" href="styles/blog_responsive.css">
    <link rel="stylesheet" type="text/css" href="styles/darkmode.css">
</head>

<body>
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
        <div class="home_title">찜 목록</div>
    </div>
</div>

<!-- 센터 -->
<div class="blog">
    <div class="container">
        <div class="row">
            <!-- 센터 영역 (찜 목록) -->
            <div class="col-lg-8">
                <div class="offers_grid" style="margin-top: 0 !important;">
                    <c:forEach var="w" items="${wishlists}">
                        <div class="offers_item">
                            <div class="row">
                                <div class="col-lg-4">
                                    <div class="offers_image_container">
                                        <div class="offers_image_background"
                                             style="background-image:url('${pageContext.request.contextPath}/images/${w.image1Name}')">
                                        </div>
                                        <div class="offer_name">
                                            <a href="<c:url value='/detail?id=${w.accommodationId}'/>">${w.name}</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-8">
                                    <div class="offers_content">
                                        <div class="offers_price">₩${w.priceNight}<span> / 1박</span></div>
                                        <p class="offers_text">${w.description}</p><!-- 아이콘 영역 -->
                                        <div class="offers_icons">
                                            <ul class="offers_icons_list d-flex flex-row p-0" style="list-style: none; gap: 1px;">
                                                <c:if test="${w.barbecue}">
                                                    <li class="offers_icons_item" data-popper-content="바베큐 시설 안내">
                                                        <i class="fa fa-fire" aria-hidden="true"></i>
                                                    </li>
                                                </c:if>
                                                <c:if test="${w.breakfast}">
                                                    <li class="offers_icons_item" data-popper-content="맛있는 조식 제공">
                                                        <i class="fa fa-coffee" aria-hidden="true"></i>
                                                    </li>
                                                </c:if>
                                                <c:if test="${w.pet}">
                                                    <li class="offers_icons_item" data-popper-content="반려동물 동반">
                                                        <i class="fa fa-paw" aria-hidden="true"></i>
                                                    </li>
                                                </c:if>
                                                <c:if test="${w.pool}">
                                                    <li class="offers_icons_item" data-popper-content="시원한 수영장">
                                                        <i class="fa fa-tint" aria-hidden="true"></i>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </div>
                                        <div class="button book_button">
                                            <a href="<c:url value="/detail?id=${w.accommodationId}"/>">상세보기<span></span><span></span><span></span></a>
                                        </div>
                                        <!-- 리뷰 평점 영역 -->
                                        <div class="offer_reviews d-flex align-items-center mt-2" style="gap: 10px;">
                                            <div class="offer_reviews_content"> <!-- 더 붙이기 위해 mr-2 적용 -->
                                                <div class="offer_reviews_title">
                                                    <c:choose>
                                                        <c:when test="${w.averageRating >= 4}">최고예요!</c:when>
                                                        <c:when test="${w.averageRating >= 3}">좋아요!</c:when>
                                                        <c:when test="${w.averageRating >= 2}">괜찮아요!</c:when>
                                                        <c:when test="${w.averageRating >= 1}">그저 그래요!</c:when>
                                                        <c:otherwise>평가가 없어요</c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <div class="offer_reviews_rating text-center">
                                                    ${w.averageRating}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- 사이드바 (오른쪽) -->
            <div class="col-lg-4">
                <div class="sidebar_archives" style="margin-left: 100px;">
                    <div class="sidebar_title">MENU</div>
                    <div class="sidebar_list">
                        <ul>
                            <li><a href="<c:url value='/details'/>">나의 예약</a></li>
                            <li><a href="<c:url value='/review'/>">나의 리뷰</a></li>
                            <li><a href="<c:url value="/wishlist"/> ">찜 목록</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="js/darkmode.js"></script>