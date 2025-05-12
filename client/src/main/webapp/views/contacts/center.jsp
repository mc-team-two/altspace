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
    <div class="home_title">홈 FAQ</div>
  </div>
</div>

<!-- 센터 -->
<div class="blog">
  <div class="container">
    <div class="row">

      <!-- 홈 -->

      <div class="blog">
        <div class="container">
          <div class="row">

            <!-- 홈 FAQ -->

            <div class="col-lg-8">

              <div class="blog_post_container">

                <!-- 질문 1 -->

                <div class="blog_post">
                  <div class="blog_post_image">
                    <img src="images/faq_home_1.JPG">
                  </div>
                  <div class="blog_post_meta">
                  </div>
                  <div class="blog_post_title"><h3>홈 이용 방법이 궁금해요.</h3></div>
                  <div class="blog_post_text">
                    <p>가운데 또는 좌측 검색바에 목적지나 체크인, 체크아웃 날짜 및 인원수를 입력하여 검색해보세요. 페이지 하단에서 해당 숙소를 확인할 수 있으며, 가격, 숙소, 별점 순으로 나열할 수 있습니다.</p>
                  </div>
                </div>

                <!-- 질문 2 -->

                <div class="blog_post">
                  <div class="blog_post_image">
                    <img src="images/faq_home_2.JPG">
                  </div>
                  <div class="blog_post_meta">
                  </div>
                  <div class="blog_post_title"><h3>다크모드로 이용하고 싶어요.</h3></div>
                  <div class="blog_post_text">
                    <p>페이지 오른쪽 상단에 위치한 토글 버튼으로 다크모드를 활성화/비활성화 할 수 있습니다.</p>
                  </div>
                </div>
              </div>
            </div>

            <!-- 사이드바 -->
            <div class="col-lg-4 sidebar_col">

              <!-- 사이드바 메뉴 -->
              <div class="sidebar_archives">
                <div class="sidebar_title">MENU</div>
                <div class="sidebar_list">
                  <ul>
                    <li><a href="<c:url value="/contacts"/> ">홈</a></li>
                    <li><a href="<c:url value="/contacts2"/> ">예약</a></li>
                    <li><a href="<c:url value="/contacts3"/> ">기타</a></li>
                  </ul>
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
<script src="plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="js/offers_custom.js"></script>

<script src="js/darkmode.js"></script>