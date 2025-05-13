<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
  const mypage = {
    init: function () {
      const self = this;

      $('#name').keyup(() => {
        let curName = '${user.name}';
        let nameInputVal = $('#name').val().trim();

        if (curName !== nameInputVal) {
          $('#btn-mod').removeAttr('disabled');
          return;
        }

        $('#btn-mod').attr('disabled', true);
      });

      $('#btn-mod').click(() => {
        let targetId = '${user.userId}';
        let nameInputVal = $('#name').val().trim();

        // 이름 유효성 검사
        if (nameInputVal === "") {
          self.showToast('이름은 필수 입력 항목입니다.');
          $('#name').focus();
          return;
        }

        if (!/^[가-힣]{2,10}$/.test(nameInputVal)) {
          self.showToast('이름은 2~10자의 한글로만 구성되어야 합니다.');
          $('#name').focus();
          return;
        }

        // 비동기 요청
        $.ajax({
          url: "<c:url value='/auth/mod?id='/>" + targetId + '&name=' + nameInputVal,
          type: 'POST',
          success: (resp) => {
            self.showToast(resp);
            setTimeout(() => {
              window.location.reload();
            }, 1500);
          },
          error: (xhr) => {
            self.showToast(xhr.responseText);
          }
        });
      });

      $('#btn-del').click(() => {
        const targetId = '${user.userId}';
        const c = confirm('정말 탈퇴하시겠습니까?\n모든 정보가 삭제되고 이 작업은 되돌릴 수 없습니다.');
        if (c) {
          $.ajax({
            url: "<c:url value='/auth/del?id='/>" + targetId,
            type: 'POST',
            success: (resp) => {
              self.showToast(resp);
              setTimeout(() => {
                window.location.href = "<c:url value='/'/>";
              }, 1500);
            },
            error: (xhr) => {
              self.showToast(xhr.responseText);
            }
          });
        }
      });

      $('#editPwdBtn').click(() => {
        const oldPwd = $('#pwd0').val().trim();
        const newPwd = $('#pwd1').val().trim();
        const confirmPwd = $('#pwd2').val().trim();

        // 입력값 유효성 검사
        if (!oldPwd || !newPwd || !confirmPwd) {
          self.showToast('모든 필드를 입력해주세요.');
          return;
        }

        if (newPwd !== confirmPwd) {
          self.showToast('변경할 비밀번호가 서로 다릅니다.');
          return;
        }

        if (!/^[a-zA-Z0-9!@#$%^&*]{8,20}$/.test(newPwd)) {
          self.showToast('비밀번호는 8~20자 사이의 영문, 숫자 및 특수문자(!@#$%^&*)로 구성되어야 합니다.');
          return;
        }

        $.ajax({
          url: "<c:url value='/change-pwd-impl'/>",
          type: "POST",
          contentType: "application/json",
          data: JSON.stringify({
            oldPwd: oldPwd,
            newPwd: newPwd
          }),
          success: (resp) => {
            $('#msg').removeClass('alert-danger').addClass('alert-success');
            self.showToast(resp);
            $('#pwd0, #pwd1, #pwd2').val('');
          },
          error: (xhr) => {
            self.showToast(xhr.responseText || '비밀번호 변경 중 오류가 발생했습니다.');
          }
        });
      });
    },

    showToast: function (msg) {
      const msgField = $('#msg'); // msgField로 변경
      msgField.text(msg).fadeIn(300);

      setTimeout(() => {
        msgField.fadeOut(300);
      }, 3500);
    }
  };

  $(function () {
    mypage.init();
  });
</script>


<style>
  .form-control {
    border-radius: 0.5em;
    margin-bottom: 15px;
  }
</style>

<div class="container-fluid">
  <div class="row">
    <%--보조 사이드바 영역--%>
    <div class="col-sm-3 my-4">
      <ul class="list-group bg-light" role="tablist">
        <li class="list-group-item">
          <a href="#menu1" class="list-group-item-action active" data-bs-toggle="tab"
          style="color: rgb(105, 108, 255);">
            회원정보 변경</a>
        </li>
        <li class="list-group-item">
          <a href="#menu2" class="list-group-item-action" data-bs-toggle="tab"
             style="color: rgb(105, 108, 255);">
            비밀번호 재설정</a>
        </li>
        <li class="list-group-item">
          <a href="javascript:void(0);" id="btn-del" class="text-muted">회원탈퇴</a>
        </li>
        <li class="list-group-item">
          <a href="<c:url value='/auth/logout'/>" class="text-muted">로그아웃</a>
        </li>
      </ul>
    </div>

    <%--페이지 컨텐츠 영역--%>
    <div class="col-sm-6 tab-content">
      <%--탭1--%>
      <div id="menu1" class="tab-pane active card card-body">
        <h3>회원정보 변경</h3>

        <div class="form-group">
          <label for="name">이름</label>
          <input type="text" class="form-control" id="name" value="${user.name}">
        </div>

        <div class="form-group">
          <label for="phone">휴대폰</label>

          <input type="text" class="form-control" id="phone" value="${user.phone}" readonly
                 style="background-color: #eeeeee !important;">
        </div>

        <div class="form-group">
          <label for="email">이메일</label>
          <div class="input-group">
            <input type="text" class="form-control border-right-0" id="email" value="${user.email}" readonly style="background-color: #eeeeee !important;">
            <%--소셜 로그인 제공업체 아이콘--%>
            <c:if test="${socialUser.provider != null}">
              <div class="input-group-append">
              <span class="input-group-text bg-white border-left-0 pl-2 pr-2">
                <c:choose>
                  <c:when test="${socialUser.provider == 'google'}">
                    <img src="/imgs/social_google_icon.svg" alt="Google" style="height: 20px;">
                  </c:when>
                  <c:when test="${socialUser.provider == 'naver'}">
                    <img src="/imgs/social_naver_icon.svg" alt="naver" style="height: 20px;">
                  </c:when>
                  <c:when test="${socialUser.provider == 'kakao'}">
                    <img src="/imgs/social_kakao_icon.svg" alt="kakao" style="height: 20px;">
                  </c:when>
                </c:choose>
              </span>
              </div>
            </c:if>
          </div>
        </div>

        <div class="form-group">
          <label for="role">가입 유형</label>
          <input type="text" class="form-control" id="role" value="${user.role}" readonly style="background-color: #eeeeee !important;">
        </div>

        <br>
        <div class="d-flex justify-content-end mb-4">
          <button id="btn-mod" type="button" class="btn btn-dark" disabled>변경사항 저장</button>
        </div>

      </div>

      <%--탭2--%>
      <div id="menu2" class="tab-pane fade card card-body">
        <h3>비밀번호 변경</h3>
        <form action="javascript:void(0);" class="form-group">
          <label for="pwd0"> 현재 비밀번호 입력</label>
          <input type="text" class="form-control" id="pwd0" name="oldPwd" required>

          <label for="pwd1"> 비밀번호 입력</label>
          <input type="text" class="form-control" id="pwd1" name="newPwd" required>

          <label for="pwd2"> 비밀번호 재입력</label>
          <input type="text" class="form-control" id="pwd2" required>

          <div id="msg" class="alert-danger px-3 py-2"
               style="border-radius: 0.5em; display: none;">여기에 메시지</div>

          <button type="button" class="btn btn-dark mt-3" id="editPwdBtn">변경</button>
        </form>
      </div>
    </div>
  </div>
</div>
