<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<head>
  <title>Altspace | 고객센터</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="Travelix Project">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
  <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <link rel="stylesheet" type="text/css" href="styles/contact_styles.css">
  <link rel="stylesheet" type="text/css" href="styles/contact_responsive.css">
</head>


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

      </div>
    </div>
  </div>
</div>


<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="js/contact_custom.js"></script>