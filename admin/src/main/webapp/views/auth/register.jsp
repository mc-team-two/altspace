<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
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

    /* 또는 */
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
  </style>
</head>
<body>
<div class="container">
  <div class="register-container text-center">

    <%--logo--%>
    <a href="/">
      <img src="<c:url value='/imgs/Altspace_lightmode_Horizontal.png'/>" alt="logo" style="height: 40px;" class="mb-4">
    </a>

    <%--error message--%>
    <c:if test="${msg != null}">
      <div class="alert alert-danger" role="alert">
          ${msg}
      </div>
    </c:if>

    <%--social login buttons--%>
    <a href="/auth/kakao/authorize" class="btn btn-social btn-kakao">
      <img src="<c:url value='/imgs/social_kakao_icon.svg'/>" width="24">카카오 계정으로 가입하기
    </a>
    <a href="/auth/naver/authorize" class="btn btn-social btn-naver">
      <img src="<c:url value='/imgs/social_naver_icon.svg'/>" width="24">네이버 계정으로 가입하기
    </a>
    <a href="/auth/google/authorize" class="btn btn-social btn-google">
      <img src="<c:url value='/imgs/social_google_icon.svg'/>" width="24">구글 계정으로 가입하기
    </a>

    <div class="divider">또는</div>

    <%--register form--%>
    <form id="registrationForm" method="post" action="<c:url value='/auth/registerimpl'/>" class="text-left">
      <%--role (using default value)--%>
      <input type="hidden" name="role" class="form-control" value="호스트" required>

      <%--email--%>
      <div class="form-group">
          <label for="email">이메일</label>
          <div class="input-group">
            <input type="email" id="email" name="email" class="form-control" placeholder="이메일을 입력해 주세요" required value="host01@example.com">
            <div class="input-group-append">
              <span id="btn-chk-email" class="btn btn-dark">중복확인</span>
            </div>
          </div>
          <p id="email-feedback" style="font-size:12px;"></p>
        </div>

      <%--pwd--%>
      <div class="form-group">
        <label for="pwd1">비밀번호</label>
        <input type="password" id="pwd1" name="password" class="form-control"
               placeholder="비밀번호를 입력해 주세요" required value="pwd1234!!">
        <p id="pwd1-feedback" style="font-size:12px;"></p>
      </div>
      <div class="form-group">
          <label for="pwd2">비밀번호 확인</label>
          <input type="password" id="pwd2" class="form-control"
                 placeholder="비밀번호를 입력해 주세요" required value="pwd1234!!">
          <p id="pwd2-feedback" style="font-size:12px;"></p>
      </div>

      <%--name--%>
      <div class="form-group">
        <label for="name">이름</label>
        <input type="text" id="name" name="name" class="form-control"
               placeholder="이름을 입력해 주세요" required value="이말숙">
          <p id="name-feedback" style="font-size:12px;"></p>
      </div>

      <%--phone--%>
      <div class="form-group">
        <label for="phone">전화번호</label>
        <input type="text" id="phone" name="phone" maxlength="13" class="form-control"
               placeholder="전화번호를 입력해 주세요" required value="010-1234-5678">
          <p id="phone-feedback" style="font-size:12px;"></p>
      </div>

      <button id="btn-register" type="submit" class="btn btn-block btn-register">회원가입</button>
    </form>

    <%--login page swap--%>
    <div class="mt-3">
      <a href="<c:url value="/auth/login"/>" class="text-muted">이미 계정이 있으신가요? 로그인</a>
    </div>
  </div>
</div>

<script>
    const registerPage = {
        isEmailDuplicateChecked : false,
        init:function(){
            // 이메일 중복 확인 버튼
            $('#btn-chk-email').click(() => {
                const val = $('#email').val().trim();
                if (!val || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val)) {
                    this.checkFormValidity();
                    return;
                }

                $('#btn-chk-email').prop('disabled', true);
                $.ajax({
                    url: "<c:url value='/auth/check-email'/>",
                    type: 'POST',
                    data: { email: val },
                    success: (resp) => {
                        $('#email-feedback').text(resp).css('color', 'green');
                        $('#email').addClass('is-valid').removeClass('is-invalid');
                        isEmailDuplicateChecked = true;
                        $('#btn-chk-email').removeClass('btn-dark').addClass('btn-outline-secondary');
                        this.checkFormValidity();
                    },
                    error: (xhr) => {
                        $('#email-feedback').text(xhr.responseText).css('color', 'red');
                        $('#email').addClass('is-invalid').removeClass('is-valid');
                        isEmailDuplicateChecked = false;
                        $('#btn-chk-email').prop('disabled', false);
                        this.checkFormValidity();
                    }
                });
            });

            // 이메일 입력 시 실시간 감지
            $('#email').on('input', () => {
                $('#email').removeClass('is-valid');
                this.isEmailDuplicateChecked = false;
                $('#btn-chk-email').prop('disabled', false)
                    .removeClass('btn-outline-secondary')
                    .addClass('btn-dark');
                this.checkFormValidity();
            });

            $('#email').on('keyup blur', ()=>{
                this.validateEmailFormatOnly();
            })

            // 비밀번호 유효성 검사
            $('#pwd1').on('input blur', function () {
                const val = $(this).val().trim();
                if (!val) {
                    $('#pwd1-feedback').text('비밀번호는 공백이 될 수 없습니다.').css('color', 'red');
                    $(this).addClass('is-invalid').removeClass('is-valid');
                } else if (val.length < 8 || val.length > 20 || !/(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])/.test(val)) {
                    $('#pwd1-feedback').text('비밀번호는 8~20자의 영문자, 숫자, 특수문자를 포함해야 합니다.').css('color', 'red');
                    $(this).addClass('is-invalid').removeClass('is-valid');
                } else {
                    $('#pwd1-feedback').text('');
                    $(this).addClass('is-valid').removeClass('is-invalid');
                }
                registerPage.checkFormValidity();
            });

            // 비밀번호 확인
            $('#pwd2').on('input blur', function () {
                const val = $(this).val().trim();
                if (val !== $('#pwd1').val().trim()) {
                    $('#pwd2-feedback').text('입력한 비밀번호가 다릅니다.').css('color', 'red');
                    $(this).addClass('is-invalid').removeClass('is-valid');
                } else {
                    $('#pwd2-feedback').text('');
                    $(this).addClass('is-valid').removeClass('is-invalid');
                }
                registerPage.checkFormValidity();
            });

            // 이름 유효성 검사
            $('#name').on('input blur', function () {
                const val = $(this).val().trim();
                if (!val) {
                    $('#name-feedback').text('이름 값은 공백이 될 수 없습니다.').css('color', 'red');
                    $(this).addClass('is-invalid').removeClass('is-valid');
                } else if (!/^[가-힣]{2,10}$/.test(val)) {
                    $('#name-feedback').text('이름은 2~10자의 한글로만 구성되어야 합니다.').css('color', 'red');
                    $(this).addClass('is-invalid').removeClass('is-valid');
                } else {
                    $('#name-feedback').text('');
                    $(this).addClass('is-valid').removeClass('is-invalid');
                }
                registerPage.checkFormValidity();
            });

            // 전화번호 입력 자동 하이픈
            $('#phone').on('input', function () {
                let raw = $(this).val().replace(/\D/g, '');
                if (raw.length > 11) raw = raw.slice(0, 11);

                let formatted = '';
                if (raw.length <= 3) {
                    formatted = raw;
                    if (raw.length === 3) formatted += '-';
                } else if (raw.length <= 7) {
                    formatted = raw.slice(0, 3) + '-' + raw.slice(3);
                    if (raw.length === 7) formatted += '-';
                } else {
                    formatted = raw.slice(0, 3) + '-' + raw.slice(3, 7) + '-' + raw.slice(7);
                }

                $(this).val(formatted);
            });

            // 전화번호 유효성 검사
            $('#phone').on('blur keyup', function () {
                const val = $(this).val().trim();
                if (!/^01(?:0|1|[6-9])-\d{3,4}-\d{4}$/.test(val)) {
                    $('#phone-feedback').text('유효한 전화번호 형식이 아닙니다.').css('color', 'red');
                    $(this).addClass('is-invalid').removeClass('is-valid');
                } else {
                    $('#phone-feedback').text('');
                    $(this).addClass('is-valid').removeClass('is-invalid');
                }
                registerPage.checkFormValidity();
            });
        },
        validateEmailFormatOnly:function(){
            const val = $('#email').val().trim();
            if (!val) {
                $('#email-feedback').text('이메일 값은 공백이 될 수 없습니다.').css('color', 'red');
                $('#email').addClass('is-invalid').removeClass('is-valid');
            } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val)) {
                $('#email-feedback').text('유효한 이메일 형식이 아닙니다.').css('color', 'red');
                $('#email').addClass('is-invalid').removeClass('is-valid');
            } else {
                $('#email-feedback').text('중복 확인을 눌러주세요.').css('color', 'orange');
                $('#email').addClass('is-invalid').removeClass('is-valid');
            }
            registerPage.isEmailDuplicateChecked = false;
            registerPage.checkFormValidity();
        },
        checkFormValidity: function() {
            const fields = ['#email', '#pwd1', '#pwd2', '#name', '#phone'];
            const allValid = fields.every(field => $(field).hasClass('is-valid'));

            $('#btn-register').prop('disabled', !allValid);
        }
    };
    $(function(){
        registerPage.init();
        registerPage.checkFormValidity();
    });
</script>



</body>
</html>