<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f5f5f9;
        }
        .register-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 30px 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .form-group label {
            font-size: 12px;
            font-weight: bold;
            color: #555;
            text-align: left;
            display: block;
            margin-bottom: 5px;
        }
        .form-control {
            margin-bottom: 5px; /* 오류 메시지 공간 확보 */
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
        .btn-register {
            background-color: #696cff;
            border-color: #696cff;
            color: #fff;
            padding: 12px 16px;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 500;
            width: 100%;
        }
        .error-message {
            color: red;
            font-size: 0.9rem;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="register-container text-center">
        <a href="/">
            <img src="<c:url value='/images/Altspace_lightmode_Horizontal.png'/>" alt="logo" style="height: 40px;" class="mb-4">
        </a>
        <h4 class="font-weight-bold mb-3">회원가입</h4>

        <c:if test="${msg != null}">
            <div class="alert alert-danger" role="alert">
                    ${msg}
            </div>
        </c:if>

        <form id="registrationForm" method="post" action="<c:url value='/login/registerimpl'/>" class="text-left">
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="이메일을 입력해 주세요" required>
                <p id="emailError" class="error-message"></p>
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="비밀번호를 입력해 주세요" required>
                <p id="passwordError" class="error-message"></p>
            </div>
            <button type="submit" class="btn btn-block btn-register">회원가입</button>
        </form>

        <div class="mt-3">
            <a href="<c:url value="/login"/>" class="text-muted">이미 계정이 있으신가요? 로그인</a>
        </div>
    </div>
</div>

<script>
    const form = document.getElementById('registrationForm');
    const emailInput = document.getElementById('email');
    const passwordInput = document.getElementById('password');
    const emailError = document.getElementById('emailError');
    const passwordError = document.getElementById('passwordError');

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

    passwordInput.addEventListener('blur', function() {
        if (!this.value) {
            displayError(passwordError, '비밀번호는 필수 입력 항목입니다.');
        } else if (this.value.length < 8 || this.value.length > 20 || !/(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])/.test(this.value)) {
            displayError(passwordError, '비밀번호는 8~20자의 영문자, 숫자, 특수문자를 포함해야 합니다.');
        } else {
            clearError(passwordError);
        }
    });

    passwordInput.addEventListener('focus', function() {
        clearError(passwordError);
    });

    form.addEventListener('submit', function(event) {
        let isValid = true;
        if (emailError.textContent || passwordError.textContent) {
            isValid = false;
            event.preventDefault();
        }
        // 추가적인 전체 폼 유효성 검사 로직 (선택 사항)
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