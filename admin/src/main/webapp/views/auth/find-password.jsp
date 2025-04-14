<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>비밀번호 찾기</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

  <style>
    body {
      background-color: #f5f5f9; /* 로그인 페이지와 동일한 배경색 */
    }
    .find-container {
      max-width: 400px;
      margin: 50px auto;
      padding: 30px 20px;
      background: #fff;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      text-align: center;
    }
    .form-control {
      margin-bottom: 15px;
      padding: 20px 16px;
      border-radius: 8px;
      border: 1px solid #ced4da;
      font-size: 14px;
      transition: border-color 0.2s, box-shadow 0.2s;
    }
    .form-control:focus {
      border-color: #86b7fe;
      box-shadow: 0 0 0 0.2rem rgba(13,110,253,0.25);
    }
    .btn-find {
      height: 48px;
      background-color: #6c757d;
      border-color: #6c757d;
      color: #fff;
      font-weight: bold;
      border: none;
      border-radius: 10px;
      font-size: 15px;
    }
    /* 활성화된 버튼 색상 변경 */
    form:valid .btn-find {
      background-color: #696cff;
      border-color: #696cff;
    }
    .footer-links {
      display: flex;
      flex-wrap: nowrap;
      justify-content: center;
      font-size: 13px;
      margin-top: 20px;
    }
    .footer-links a {
      margin: 0 6px;
      white-space: nowrap;
      color: #666;
    }
    .footer-links a:hover {
      text-decoration: underline;
    }
    /* 소셜 로그인 버튼 스타일은 따로 추가할 필요 없음 */
  </style>
</head>
<body>
<div class="find-container">
  <img src="<c:url value='/imgs/Altspace_lightmode_Horizontal.png'/>" alt="logo" style="height: 40px;" class="mb-4">

  <h4 class="font-weight-bold">비밀번호 찾기</h4>
  <p class="text-muted">이메일을 입력하여 비밀번호를 찾으세요</p>

  <form method="post" action="/auth/find-password">
    <div class="form-group text-left">
      <label for="email" class="font-weight-bold">이메일</label>
      <input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력해 주세요" required>
    </div>
    <button type="submit" class="btn btn-find btn-block">아이디 찾기</button>
  </form>

  <div class="mt-4">
    <a href="/auth/login" class="d-block text-muted">다른 계정으로 로그인</a>
    <a href="/auth/find-id" class="d-block text-muted">아이디 찾기</a>
  </div>

</div>
<!-- 정책 메뉴는 화면 아래 고정 -->
<footer class="mt-auto text-center py-3">
  <div class="footer-links">
    <a href="/privacy" class="mx-2">개인정보처리방침</a>
    <a href="/terms" class="mx-2">이용약관</a>
    <a href="/youth-policy" class="mx-2">청소년 보호정책</a>
    <a href="/location" class="mx-2">위치정보서비스 이용약관</a>
  </div>
</footer>
</body>
</html>
