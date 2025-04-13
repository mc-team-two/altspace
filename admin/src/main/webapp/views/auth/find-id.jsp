<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>비밀번호 찾기</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    body {
      background-color: #fff;
    }
    .find-container {
      max-width: 400px;
      margin: 50px auto;
      text-align: center;
    }
    .form-control {
      height: 48px;
      font-size: 14px;
    }
    .btn-find {
      height: 48px;
      background-color: #aaa;
      color: #fff;
      font-weight: bold;
      border: none;
      border-radius: 8px;
    }
    .footer-links {
      display: flex;
      justify-content: center;
      flex-wrap: nowrap;
      font-size: 13px;
      margin-top: 20px;
    }
    .footer-links a {
      margin: 0 6px;
      white-space: nowrap;
      color: #666;
    }
  </style>
</head>
<body>
<div class="find-container">
  <img src="<c:url value='/imgs/Altspace_lightmode_Horizontal.png'/>" alt="logo" style="height: 40px;" class="mb-4">

  <h4 class="font-weight-bold">아이디 찾기</h4>
  <p class="text-muted">이메일을 입력하여 가입여부를 확인해보세요</p>

  <form method="post" action="/demo/find-password">
    <div class="form-group text-left">
      <label for="email" class="font-weight-bold">이메일</label>
      <input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력해 주세요" required>
    </div>
    <button type="submit" class="btn btn-find btn-block">아이디 찾기</button>
  </form>

  <div class="mt-4">
    <a href="/demo/login" class="d-block text-muted">다른 계정으로 로그인</a>
    <a href="/demo/find-password" class="d-block text-muted">비밀번호 찾기</a>
  </div>

  <div class="footer-links mt-5">
    <a href="/privacy">개인정보처리방침</a>
    <a href="/terms">이용약관</a>
    <a href="/youth-policy">청소년 보호정책</a>
    <a href="/location">위치정보서비스 이용약관</a>
  </div>
</div>
</body>
</html>
