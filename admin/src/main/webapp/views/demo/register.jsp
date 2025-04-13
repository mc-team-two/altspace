<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>로그인</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <style>
    .login-container {
      max-width: 400px;
      margin: 50px auto;
      text-align: center;
    }

    .btn-social {
      width: 100%;
      margin-bottom: 10px;
      font-weight: bold;
    }

    .btn-kakao {
      background-color: #FEE500;
      color: #000;
    }

    .btn-naver {
      background-color: #03C75A;
      color: #fff;
    }

    .btn-google {
      background-color: #fff;
      border: 1px solid #ccc;
      color: #444;
    }

    .btn-apple {
      background-color: #000;
      color: #fff;
    }

    .divider {
      margin: 20px 0;
      font-size: 14px;
      color: #888;
    }

    .form-control {
      margin-bottom: 15px;
    }

    .footer-links {
      margin-top: 20px;
      font-size: 13px;
    }

    .footer-links a {
      margin: 0 5px;
      color: #666;
    }
  </style>
</head>
<body>
<div class="login-container">
  <img src="/images/logo.png" alt="로고" style="height: 40px;">
  <h4 class="mt-4 font-weight-bold">제일 쉬운 AI를<br>무료로 즐기세요!</h4>
  <p class="text-muted">AI를 사용할수록 똑똑해져요</p>

  <a href="/oauth2/authorization/kakao" class="btn btn-social btn-kakao">
    🟡 카카오 계정으로 1초 만에 시작하기
  </a>
  <a href="/oauth2/authorization/naver" class="btn btn-social btn-naver">
    N 네이버 계정으로 로그인
  </a>
  <a href="/oauth2/authorization/google" class="btn btn-social btn-google">
    <img src="https://img.icons8.com/color/16/000000/google-logo.png"/> 구글 계정으로 로그인
  </a>
  <a href="/oauth2/authorization/apple" class="btn btn-social btn-apple">
     Apple로 로그인
  </a>

  <div class="divider">또는</div>

  <form method="post" action="/login">
    <input type="email" name="email" class="form-control" placeholder="이메일을 입력해 주세요" required>
    <input type="password" name="password" class="form-control" placeholder="비밀번호를 입력해 주세요" required>
    <button type="submit" class="btn btn-secondary btn-block">로그인</button>
  </form>

  <div class="footer-links">
    <a href="/register">회원가입</a> |
    <a href="/find-id">아이디 찾기</a> |
    <a href="/find-password">비밀번호 찾기</a>
  </div>

  <div class="footer-links mt-4">
    <a href="/privacy">개인정보처리방침</a>
    <a href="/terms">이용약관</a>
    <a href="/youth-policy">청소년 보호정책</a>
    <a href="/location">위치정보서비스 이용약관</a>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

