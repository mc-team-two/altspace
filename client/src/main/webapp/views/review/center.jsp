<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<head>
  <title>Altspace | 나의 리뷰 | 가장 빠른 공간대여 알트스페이스</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="Travelix Project">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
  <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <link href="plugins/colorbox/colorbox.css" rel="stylesheet" type="text/css">
  <link rel="stylesheet" type="text/css" href="styles/blog_styles.css">
  <link rel="stylesheet" type="text/css" href="styles/blog_responsive.css">
</head>

<!-- 홈 -->

<div class="home">
  <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/offer_background.jpg"></div>
  <div class="home_content">
    <div class="home_title">나의 리뷰</div>
  </div>
</div>

<!-- 센터 -->

<div class="blog">
  <div class="container">
    <div class="row">

        <!-- 내가 작성한 리뷰 리스트 출력 -->
        <c:forEach var="rv" items="${ReviewList}">
            <div class="col-lg-8">
                <div class="card mb-4 p-3 shadow-sm">
                    <!-- 숙소 이름 + 수정/삭제 드롭다운 -->
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="mb-1 font-weight-bold">${rv.name}</h5>
                            <p class="mb-2 text-muted">${rv.location}</p>
                        </div>
                        <div class="dropdown">
                            <button class="btn btn-light dropdown-toggle" type="button" id="dropdownMenu${rv.reviewId}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-ellipsis-v" aria-hidden="true"></i>
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenu${rv.reviewId}">
                                <a class="dropdown-item" href="/review/update?id=${rv.reviewId}">수정하기</a>
                                <a class="dropdown-item" href="/review/delete?id=${rv.reviewId}" onclick="return confirm('삭제하시겠습니까?');">삭제하기</a>
                            </div>
                        </div>
                    </div>

                    <!-- 유저 이름과 별점 (별점 왼쪽 정렬) -->
                    <div class="d-flex align-items-center mb-2">
                        <span class="text-warning mr-3">★ ${rv.grade}</span>
                        <span class="text-primary font-weight-semibold">${rv.guestId}</span>
                    </div>

                    <!-- 리뷰 내용 -->
                    <p class="mb-2">${rv.comment}</p>

                    <!-- 작성일 -->
                    <small class="text-muted">${rv.createDay}</small>
                </div>
            </div>
        </c:forEach>

      <!-- 사이드바 -->
      <div class="col-lg-4 sidebar_col">

        <!-- 사이드바 메뉴 -->
        <div class="sidebar_archives">
          <div class="sidebar_title">MENU</div>
          <div class="sidebar_list">
            <ul>
              <li><a href="/details">나의 예약</a></li>
              <li><a href="/review">나의 리뷰</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
