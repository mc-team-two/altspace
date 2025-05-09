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
    <div class="home_title">예약 FAQ</div>
  </div>
</div>

<!-- 센터 -->
<div class="blog">
  <div class="container">
    <div class="row">

      <!-- 예약 -->

      <div class="blog">
        <div class="container">
          <div class="row">

            <!-- 예약 FAQ -->

            <div class="col-lg-8">

              <div class="blog_post_container">

                <!-- 질문 1 -->

                <div class="blog_post">
                  <div class="blog_post_image">
                    <img src="images/faq_book_1.JPG">
                  </div>
                  <div class="blog_post_meta">
                  </div>
                  <div class="blog_post_title"><h3>할인 혜택이 궁금해요.</h3></div>
                  <div class="blog_post_text">
                    <p>결제 창에서 현재 진행 중인 할인 혜택을 확인할 수 있습니다.</p>
                  </div>
                </div>

                <!-- 질문 2 -->

                <div class="blog_post">
                  <div class="blog_post_image">
                    <img src="images/faq_book_2.JPG">
                  </div>
                  <div class="blog_post_meta">
                  </div>
                  <div class="blog_post_title"><h3>결제 수단은 어떻게 되는지 궁금해요.</h3></div>
                  <div class="blog_post_text">
                    <p>간편 결제, 계좌 이체, 신용카드 등 다양한 결제 수단을 지원합니다.</p>
                  </div>
                </div>

                <!-- 질문 3 -->

                <div class="blog_post">
                  <div class="blog_post_image">
                    <img src="images/faq_book_3.JPG">
                  </div>
                  <div class="blog_post_meta">
                  </div>
                  <div class="blog_post_title"><h3>결제 내역을 확인하고 싶어요.</h3></div>
                  <div class="blog_post_text">
                    <p>마이페이지에서 확인할 수 있으며, 결제 시 입력한 이메일로 결제 내역이 전송됩니다.</p>
                  </div>
                </div>

                <!-- 질문 4 -->

                <div class="blog_post">
                  <div class="blog_post_image">
                    <img src="images/faq_book_4.JPG">
                  </div>
                  <div class="blog_post_meta">
                  </div>
                  <div class="blog_post_title"><h3>예약을 취소하거나 변경하고 싶어요.</h3></div>
                  <div class="blog_post_text">
                    <p>마이페이지의 결제 내역에서 취소 후 다시 예약을 진행하면 됩니다. 단, 숙소 상황에 따라 불가능할 수 있으니 해당 내용은 숙소에 직접 문의하시기 바랍니다.</p>
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
                    <li><a href="<c:url value="/contacts2"/> ">결제</a></li>
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