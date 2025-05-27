<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>계정 찾기 | 알트스페이스</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <style>
    body {
      background-color: #f5f5f9;
    }

    .find-container {
      max-width: 400px;
      margin: 50px auto;
      padding: 30px 20px;
      background: #fff;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      text-align: center;
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
      height: 48px;
      font-size: 14px;
    }

    .form-control:focus {
      border-color: #86b7fe;
      box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
    }

    .btn-find {
      height: 48px;
      background-color: #6c757d; /* 약간 진한 회색 */
      border-color: #6c757d;
      color: #fff;
      font-size: 15px;
      font-weight: bold;
      border-radius: 8px;
      margin-top: 16px; /* 입력창과 버튼 사이 간격 */
      width: 100%;
    }
    .btn-find:hover {
      background-color: #6c757d; /* 기본 색상 고정 */
      border-color: #6c757d; /* 테두리도 고정 */
    }
    form:valid .btn-find {
      background-color: #696cff;
      border-color: #696cff;
      color: #fff;
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
  </style>

</head>
<body>
<div class="find-container">
  <a href="<c:url value="/"/>">
    <img src="<c:url value='/images/Altspace_lightmode_Horizontal.png'/>" alt="logo" style="height: 40px;" class="mb-4">
  </a>

  <h6><strong>이메일 주소로 계정 찾기</strong></h6>
  <p style="font-size:12px;">
    회원정보에 등록된 메일 주소로 아이디/비밀번호를 알려드립니다.<br>
    메일 주소를 입력하고 "ID/PW 찾기" 버튼을 클릭해 주세요.
  </p>

  <div id="msg" class="alert alert-light" role="alert" style="display: none;">
    여기에 알림 메시지
  </div>

  <form>
    <div class="form-floating mb-3 mt-3">
      <input type="email" class="form-control" id="email" placeholder="Enter email" name="email" required>
      <label for="email">이메일</label>
    </div>
    <button id="findBtn" type="button" class="btn btn-find">ID/PW 찾기</button>
  </form>

  <div class="footer-links mt-3">
    <a href="<c:url value="/login/register"/>">회원가입</a>
    <span class="divider-pipe">|</span>
    <a href="<c:url value="/login"/>">로그인</a>
  </div>

</div>

<script>
  const findAccountPage = {
    $findBtn : $("#findBtn"),
    $email : $("#email"),

    init: function() {
      // ID/PW 찾기 버튼 클릭 -> 핸들러
      this.$findBtn.click(() => {
        this.handleFind();
      });

      // 이메일 input에서 엔터키 눌렀을 때 -> 핸들러
      this.$email.on("keypress", (e) => {
        if (e.which === 13) {
          e.preventDefault(); // form 제출 방지
          this.handleFind();
        }
      });

      // msg가 표시된 상태에서 입력칸에 포커스 -> msg 지우기, 버튼 보이기
      this.$email.on('focus', function(){
        $('#msg').fadeOut(300);
        findAccountPage.$findBtn
                .prop("disabled", false)
                .html('ID/PW 찾기')
                .show();
      })
    },
    handleFind: function() {
      // 입력값 유효성 체크
      let inputVal = this.$email.val().trim();
      if (!inputVal || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(inputVal)) {
        alert('올바른 형식의 이메일이 아닙니다.');
        return;
      }

      // findAccountImpl 호출
      this.findAccountImpl(inputVal);
    },
    findAccountImpl: function(emailVal) {
      $.ajax({
        url: "<c:url value='/api/auth/find-account'/>",
        type: 'POST',
        contentType: 'application/x-www-form-urlencoded',
        data: { email: emailVal },
        beforeSend: function () {
          // 버튼을 스피너로 변경
          findAccountPage.$findBtn
                  .prop('disabled', true)
                  .html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 메일 전송 중...');
        },
        success: function(resp) {
          // 성공 시 버튼 숨기기
          findAccountPage.$findBtn.hide();
          $('#msg').html(resp.replace(/\n/g, '<br>')).fadeIn();
        },
        error: function(xhr) {
          $('#msg').html(xhr.responseText.replace(/\n/g, '<br>')).fadeIn();

          // 오류 발생 시 버튼 원래대로 복구
          findAccountPage.$findBtn
                  .prop("disabled", false)
                  .html('ID/PW 찾기');
        }
      });
    }
  };

  $(function () {
    findAccountPage.init();
  });

</script>

</body>
</html>
