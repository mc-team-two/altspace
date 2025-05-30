<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>로그인</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <%--jQuery--%>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <%--bootstrap--%>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f5f5f9;
        }
        .login-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 30px 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        /* 소셜 로그인 버튼 영역 */
        .btn-social {
            width: 100%;
            margin-bottom: 10px;
            font-weight: bold;
            padding: 12px 16px;         /* 버튼 padding 추가 */
            border-radius: 10px;        /* 둥글게 만듦 */
            font-size: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .btn-social img {
            margin-right: 8px;
        }
        .btn-kakao {
            background-color: #FEE500;
            color: #444;
        }
        .btn-naver {
            background-color: #03C75A;
            color: #333;
        }
        .btn-google {
            background-color: #fff;
            border: 1px solid #ccc;
            color: #444;
        }
        /* 하단 메뉴 영역 */
        .divider {
            margin: 20px 0;
            text-align: center;
            position: relative;
            font-size: 14px;
            color: #888;
        }
        .divider::before,
        .divider::after {
            content: '';
            position: absolute;
            top: 50%;
            width: 40%;
            height: 1px;
            background-color: #ddd;
        }
        .divider::before {
            left: 0;
        }
        .divider::after {
            right: 0;
        }
        /* input 영역 */
        .form-group label {
            font-size: 12px;
            font-weight: bold;
            color: #555;
            text-align: left;
            display: block;
            margin-bottom: 5px;
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
        /* footer 영역 */
        .footer-links {
            display: flex;
            justify-content: center;
            font-size: 13px;
            margin-top: 15px;
            flex-wrap: wrap;
        }
        .footer-links a {
            color: #666;
            text-decoration: none;
            white-space: nowrap;
        }
        .footer-links a:hover {
            text-decoration: underline;
        }
        .footer-links .divider-pipe {
            margin: 0 6px;
            color: #ccc;
        }
        /* 로그인 버튼, 색상 변경 */
        .login-btn {
            background-color: #6c757d;
            border-color: #6c757d;
            color: #fff;
            padding: 12px 16px;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 500;
        }
        form:valid .login-btn {
            background-color: #696cff;
            border-color: #696cff;
            color: #fff;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="login-container text-center">

        <a href="<c:url value="/"/>">
            <img src="<c:url value='/imgs/Altspace_lightmode_Horizontal.png'/>" alt="logo" style="height: 40px;" class="mb-4">
        </a>

        <a href="<c:url value="/auth/kakao/authorize"/>" class="btn btn-social btn-kakao">
            <img src="<c:url value='/imgs/social_kakao_icon.svg'/>" width="24" alt="">카카오 계정으로 로그인
        </a>
        <a href="<c:url value="/auth/naver/authorize"/>" class="btn btn-social btn-naver">
            <img src="<c:url value='/imgs/social_naver_icon.svg'/>" width="24" alt="">네이버 계정으로 로그인
        </a>
        <a href="<c:url value="/auth/google/authorize"/>" class="btn btn-social btn-google">
            <img src="<c:url value='/imgs/social_google_icon.svg'/>" width="24" alt="">구글 계정으로 로그인
        </a>

        <div class="divider">또는</div>

        <div class="alert alert-danger" style="display:none;" id="login-alert"></div>

        <form id="loginForm" method="post" action="<c:url value="/api/auth/login"/>" class="text-left">
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="이메일을 입력해 주세요" required value="host@example.com">
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="비밀번호를 입력해 주세요" required value="password123!!">
            </div>
            <button id="login-btn" type="submit" class="btn btn-block login-btn">로그인</button>
        </form>

        <div class="footer-links mt-3">
            <a href="<c:url value="/auth/register"/>">회원가입</a>
            <span class="divider-pipe">|</span>
            <a href="<c:url value="/auth/find-account"/>">ID/PW 찾기</a>
        </div>

    </div>
</div>
<script>
    const loginPage = {
        init:function(){
            $('#email').on('focus', function(){
                $('#login-alert').fadeOut(300); // 300ms 동안 서서히 사라짐
            });

            $('#password').on('focus', function(){
                $('#login-alert').fadeOut(300);
            });
            $('#loginForm').on('submit', function(e) {
                e.preventDefault();
                const formData = {
                    "email": $("#email").val(),
                    "password": $("#password").val()
                };
                loginPage.loginImpl(formData);
            })
        },
        loginImpl:function(formData){
            $.ajax({
                url: "<c:url value='/api/auth/login'/>",
                type: "POST",
                contentType: "application/x-www-form-urlencoded",
                data: formData,
                beforeSend: function () {
                    $('#login-btn').prop('disabled', true).text('처리 중...');
                },
                success: function (response) {
                    console.log(response);
                    window.location.href = "<c:url value='/'/>";
                },
                error: function (xhr) {
                    $('#login-alert').text(xhr.responseText).fadeIn(300);
                    $('#login-btn').prop('disabled', false).text('로그인');
                }
            });
        },
    };
    $(function(){
        loginPage.init();
    });
</script>
</body>
</html>
