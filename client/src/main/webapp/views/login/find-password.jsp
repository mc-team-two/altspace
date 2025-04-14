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
                background-color: #f5f5f9; /* 배경색을 로그인 페이지와 동일하게 */
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
            /* 제목 강조 */
            .find-title {
                font-size: 2.2rem; /* 더 크게 */
                font-weight: bold;
                color: #333; /* 좀 더 진한 색상 */
                margin-bottom: 15px; /* 간격 조정 */
            }
            /* 안내 문구 스타일 변경 */
            .find-subtitle {
                color: #777;
                margin-bottom: 25px; /* 간격 조정 */
                font-size: 1.1rem; /* 약간 크게 */
            }
            .form-group {
                text-align: left; /* 라벨 왼쪽 정렬 유지 */
            }
            .form-control {
                height: 50px; /* 높이 약간 증가 */
                margin-bottom: 20px; /* 입력 필드 간 간격 증가 */
                padding: 18px 16px; /* 내부 padding 약간 조정 */
                border-radius: 10px; /* 좀 더 둥글게 */
                border: 1px solid #ccc; /* 테두리 색상 변경 */
                font-size: 15px; /* 폰트 크기 약간 증가 */
                transition: border-color 0.2s, box-shadow 0.2s;
            }
            .form-control:focus {
                border-color: #696cff; /* 포커스 시 강조 색상 */
                box-shadow: 0 0 0 0.2rem rgba(105, 108, 255, 0.25); /* 포커스 시 그림자 */
            }
            .btn-find {
                height: 50px; /* 버튼 높이 약간 증가 */
                background-color: #696cff; /* 활성화 색상 기본 적용 */
                border-color: #696cff;
                color: #fff;
                font-weight: bold;
                border: none;
                border-radius: 10px;
                font-size: 16px; /* 폰트 크기 약간 증가 */
                cursor: pointer; /* 마우스 오버 시 커서 변경 */
                transition: background-color 0.2s; /* hover 효과 부드럽게 */
            }
            .btn-find:hover {
                background-color: #5658d4; /* hover 시 약간 어둡게 */
            }
            .footer-links {
                display: flex;
                flex-wrap: nowrap;
                justify-content: center;
                font-size: 14px; /* 폰트 크기 약간 증가 */
                margin-top: 25px; /* 간격 조정 */
            }
            .footer-links a {
                margin: 0 10px; /* 링크 간 간격 증가 */
                white-space: nowrap;
                color: #555; /* 링크 색상 변경 */
                text-decoration: none;
            }
            .footer-links a:hover {
                text-decoration: underline;
                color: #696cff; /* hover 시 강조 색상 */
            }
            /* 로고 스타일 (선택 사항) */
            .logo-img {
                height: 45px; /* 로고 높이 약간 증가 */
                margin-bottom: 20px; /* 간격 조정 */
            }
            /* 하단 정책 링크 스타일 */
            .policy-links {
                display: flex;
                justify-content: center;
                flex-wrap: wrap;
                font-size: 13px;
                margin-top: 30px; /* 간격 증가 */
            }
            .policy-links a {
                margin: 0 8px;
                color: #777;
                text-decoration: none;
            }
            .policy-links a:hover {
                text-decoration: underline;
                color: #696cff;
            }
        </style>
    </head>
    <body>
    <div class="find-container">
        <img src="<c:url value='/images/Altspace_lightmode_Horizontal.png'/>" alt="logo" class="mb-4 logo-img">

        <h4 class="font-weight-bold find-title">비밀번호 찾기</h4>
        <p class="text-muted find-subtitle">이메일을 입력하여 비밀번호를 찾으세요</p>

        <form id="findPasswordForm" method="post" action="/auth/find-password">
            <div class="form-group text-left">
                <label for="email" class="font-weight-bold">이메일</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력해 주세요" required>
                <p id="emailError" class="error-message"></p>
            </div>
            <button type="submit" class="btn btn-find btn-block">비밀번호 찾기</button>
        </form>

        <div class="mt-4 footer-links">
            <a href="<c:url value="/login"/>">다른 계정으로 로그인</a>
            <span>|</span>
            <a href="<c:url value="/login/find-id"/>">아이디 찾기</a>
        </div>

        <div class="policy-links mt-5">
            <a href="/privacy">개인정보처리방침</a>
            <a href="/terms">이용약관</a>
            <a href="/youth-policy">청소년 보호정책</a>
            <a href="/location">위치정보서비스 이용약관</a>
        </div>
    </div>

    <script>

        // 이메일 및 패스워드로 회원가입하려 할 시 현재 DTO 구조에서는 나머지 회원정보 사항도 다 입력하라고 강제함.
        // TODO: 가입할 때 모든 정보를 다 받을지, 아니면 구조 변경이 있을지에 대해 논의 필요
        // 논의 끝나면 바로 코드 적용 해서 가입 테스트 해볼 예정.
        
        const form = document.getElementById('findPasswordForm');
        const emailInput = document.getElementById('email');
        const emailError = document.getElementById('emailError');

        emailInput.addEventListener('blur', function() {
            if (!this.value.trim()) {
                displayError(emailError, '이메일은 필수 입력 항목입니다.');
            } else if (!isValidEmail(this.value.trim())) {
                displayError(emailError, '유효한 이메일 주소 형식이 아닙니다.');
            } else {
                clearError(emailError);
            }
        });

        emailInput.addEventListener('focus', function() {
            clearError(emailError);
        });

        form.addEventListener('submit', function(event) {
            if (emailError.textContent) {
                event.preventDefault();
            }
        });

        function displayError(element, message) {
            element.textContent = message;
        }

        function clearError(element) {
            element.textContent = '';
        }

        function isValidEmail(email) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(email);
        }
    </script>
    </body>
    </html>