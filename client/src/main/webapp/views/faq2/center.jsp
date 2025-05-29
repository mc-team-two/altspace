<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<head>
  <link rel="stylesheet" type="text/css" href="styles/blog_styles.css">
  <link rel="stylesheet" type="text/css" href="styles/blog_responsive.css">
  <link rel="stylesheet" type="text/css" href="styles/darkmode.css">
  <link rel="stylesheet" type="text/css" href="<c:url value="styles/chatbot.css"/>">
  <link rel="stylesheet" type="text/css" href="<c:url value="plugins/font-awesome-4.7.0/css/font-awesome.min.css"/>">
  <link rel="stylesheet"
        href="<c:url value="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css"/>">
  <link rel="stylesheet"
        href="<c:url value="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>">

  <style>
    /* 이미지 반응형 및 가운데 정렬 스타일 */
    .faq_book_image img{
      max-width: 100%;
      height: auto;
      display: block;
      margin: 0 auto;
    }

    /* 이미지 컨테이너 간격 */
    .faq_book_image{
      margin-top: 100px;
      margin-bottom: 50px;
    }

    /* 각 FAQ 항목 사이의 간격 */
    .faq_book{
      margin-bottom: 50px;
    }
  </style>
</head>

<body>

<div class="menu trans_500">
  <div class="menu_content d-flex flex-column align-items-center justify-content-center text-center">
    <div class="menu_close_container"><div class="menu_close"></div></div>
    <div class="logo menu_logo"><a href="/"><img src="images/logo.png" alt=""></a></div>
    <ul>
      <li class="menu_item"><a href="<c:url value="/"/> ">홈</a></li>
      <li class="menu_item"><a href="<c:url value="/about"/> ">Altspace란</a></li>
      <li class="menu_item"><a href="<c:url value="/faq1"/> ">고객센터</a></li>
      <li class="menu_item"><a href="<c:url value="/mypage/aireport"/> ">마이페이지</a></li>
    </ul>
  </div>
</div>

<!-- 배너 -->
<div class="home">
  <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/offer_background.jpg"></div>
  <div class="home_content">
    <div class="home_title">예약 FAQ</div>
  </div>
</div>

<!-- 예약 -->
<div class="faq">
  <div class="container">
    <div class="row">

      <!-- 예약 FAQ -->
      <div class="col-lg-8">
        <div class="faq_contents_area">

          <!-- 질문 1 -->
          <div class="faq_book">
            <div class="faq_book_image">
              <img src="images/faq_book_1.JPG">
            </div>
            <div class="faq_book_title"><h3>할인 혜택이 궁금해요.</h3></div>
            <div class="faq_book_text">
              <p>결제 창에서 현재 진행 중인 할인 혜택을 확인할 수 있습니다.</p>
            </div>
          </div>

          <!-- 질문 2 -->
          <div class="faq_book">
            <div class="faq_book_image">
              <img src="images/faq_book_2.JPG">
            </div>
            <div class="faq_book_title"><h3>결제 수단은 어떻게 되는지 궁금해요.</h3></div>
            <div class="faq_book_text">
              <p>간편 결제, 계좌 이체, 신용카드 등 다양한 결제 수단을 지원합니다.</p>
            </div>
          </div>

          <!-- 질문 3 -->
          <div class="faq_book">
            <div class="faq_book_image">
              <img src="images/faq_book_3.JPG">
            </div>
            <div class="faq_book_title"><h3>결제 내역을 확인하고 싶어요.</h3></div>
            <div class="faq_book_text">
              <p>마이페이지에서 확인할 수 있으며, 결제 시 입력한 이메일로 결제 내역이 전송됩니다.</p>
            </div>
          </div>

          <!-- 질문 4 -->
          <div class="faq_book">
            <div class="faq_book_image">
              <img src="images/faq_book_4.JPG">
            </div>
            <div class="faq_book_title"><h3>예약을 취소하거나 변경하고 싶어요.</h3></div>
            <div class="faq_book_text">
              <p>마이페이지의 결제 내역에서 취소 후 다시 예약을 진행하면 됩니다. 단, 숙소 상황에 따라 불가능할 수 있으니 해당 내용은 숙소에 직접 문의하시기 바랍니다.</p>
            </div>
          </div>
        </div>
      </div>

      <!-- 챗봇 -->
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

      <div id="gemini-chatbot" class="chatbot chatbot-gemini">
        <div id="gemini-chat-icon" class="chat-icon gemini-icon">
          <i class="fab fa-google" aria-hidden="true"></i>
        </div>
        <div id="gemini-chat-window" class="chat-window gemini-window">
          <div class="chat-header gemini-header">
            <span>Gemini 챗봇</span>
            <button id="gemini-chat-close-btn" class="chat-close-btn">&times;</button>
          </div>
          <div class="chat-messages" id="gemini-chat-messages"></div>
          <div class="chat-input">
            <input type="text" id="gemini-chat-input" placeholder="Gemini에게 물어보세요">
            <button id="gemini-chat-send-btn">보내기</button>
          </div>
        </div>
      </div>

      <!-- 사이드바 -->
      <div class="col-lg-4 sidebar_col">
        <div class="position-sticky" style="top: 100px; z-index: 10;">
          <div class="sidebar_archives" style="margin-left: 100px;">
            <div class="sidebar_title">MENU</div>
            <div class="sidebar_list">
              <ul style="list-style: none; padding-left: 0;">
                <li class="mb-3">
                  <a href="<c:url value='/faq1'/>" class="d-flex align-items-center text-dark">
                    <i class="fas fa-home mr-2 text-primary"></i> 홈 FAQ
                  </a>
                </li>
                <li class="mb-3">
                  <a href="<c:url value='/faq2'/>" class="d-flex align-items-center text-dark">
                    <i class="fas fa-calendar-check mr-2 text-success"></i> 예약 FAQ
                  </a>
                </li>
                <li class="mb-3">
                  <a href="<c:url value='/faq3'/>" class="d-flex align-items-center text-dark">
                    <i class="fas fa-question-circle mr-2 text-info"></i> 기타 FAQ
                  </a>
                </li>
                <li class="mb-3">
                  <a href="<c:url value='/contacts'/>" class="d-flex align-items-center text-dark">
                    <i class="fas fa-headset mr-2 text-danger"></i> 고객센터 문의
                  </a>
                </li>
              </ul>
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
<script src="<c:url value="/webjars/sockjs-client/sockjs.min.js"/> "></script>
<script src="<c:url value="/webjars/stomp-websocket/stomp.min.js"/> "></script>
