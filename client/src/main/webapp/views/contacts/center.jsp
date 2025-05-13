<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<head>
  <link rel="stylesheet" type="text/css" href="<c:url value="styles/contact_styles.css"/>">
  <link rel="stylesheet" type="text/css" href="<c:url value="styles/contact_responsive.css"/>">
  <link rel="stylesheet" type="text/css" href="<c:url value="styles/darkmode.css"/>">
  <link rel="stylesheet" type="text/css" href="<c:url value="styles/chatbot.css"/>">
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

<!-- 홈 -->

<div class="home">
  <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/contact_background.jpg"></div>
  <div class="home_content">
    <div class="home_title">고객센터</div>
  </div>
</div>

<!-- 문의하기 -->

<div class="contact_form_section">
  <div class="container">
    <div class="row">
      <div class="col">

        <!-- Contact Form -->
        <div class="contact_form_container">
          <div class="contact_title text-center">고객센터 상담 요청</div>
          <form action="#" id="contact_form" class="contact_form text-center">
            <input type="text" id="contact_form_name" class="contact_form_name input_field" placeholder="이름" required="required" data-error="이름을 입력해주세요.">
            <input type="text" id="contact_form_email" class="contact_form_email input_field" placeholder="전화번호 또는 이메일" required="required" data-error="전화번호 또는 이메일을 입력해주세요.">
            <input type="text" id="contact_form_subject" class="contact_form_subject input_field" placeholder="제목" required="required" data-error="제목을 입력해주세요.">
            <textarea id="contact_form_message" class="text_field contact_form_message" name="message" rows="4" placeholder="내용" required="required" data-error="내용을 입력해주세요."></textarea>
            <button type="submit" id="form_submit_button" class="form_submit_button button">문의하기<span></span><span></span><span></span></button>
          </form>
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


<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="js/contact_custom.js"></script>
<script src="js/darkmode.js"></script>
<script src="<c:url value="/webjars/sockjs-client/sockjs.min.js"/> "></script>
<script src="<c:url value="/webjars/stomp-websocket/stomp.min.js"/> "></script>
<script src="<c:url value="js/chatbot.js"/>"></script>