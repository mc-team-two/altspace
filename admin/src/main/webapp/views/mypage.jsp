<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
  const mypage = {
    init: function () {
      $('#delete-btn').click(() => {
        const c = confirm('탈퇴하시겠습니까?\n모든 정보가 삭제되고 이 작업은 되돌릴 수 없습니다.');
        if (c === true) {
          window.location.href = "<c:url value='/auth/del'/>";
        }
      });

      $('#logout-btn').click(() => {
        window.location.href = "<c:url value='/auth/logout'/>";
      });

      $('#mod-btn').click(() => {
        // 수정 페이지로 이동
        window.location.href = "<c:url value='/auth/mod'/>";
      });
    }
  };

  $(function() {
    mypage.init();
  });
</script>

<div class="container mt-5" style="max-width: 400px;">
  <div class="text-center mb-4">
    <svg xmlns="http://www.w3.org/2000/svg" width="78" height="78" viewBox="0 0 20 20" fill="none">
      <circle cx="10" cy="6" r="4" fill="#C4C4C4"/>
      <path d="M2 18c0-3.333 2.667-6 6-6h4c3.333 0 6 2.667 6 6" fill="#C4C4C4"/>
    </svg>
  </div>

  <form>
    <div class="form-group">
      <label for="name">이름</label>
      <input type="text" class="form-control" id="name" name="name" value="${user.name}">
    </div>

    <div class="form-group">
      <label for="phone">휴대폰</label>
      <input type="text" class="form-control" id="phone" value="${user.phone}" readonly>
    </div>

    <div class="form-group">
      <label for="email">이메일</label>
      <div class="input-group">
        <input type="text" class="form-control border-right-0" id="email" value="${user.email}" readonly>

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
      <input type="text" class="form-control" id="role" value="${user.role}" readonly>
    </div>

    <br>
    <div class="d-flex justify-content-end mb-4">
      <button id="mod-btn" type="submit" class="btn btn-secondary">변경하기</button>
    </div>
  </form>

  <div class="d-flex justify-content-center">
    <button id="delete-btn" class="btn btn-link text-dark mr-2">회원 탈퇴</button>
    <button id="logout-btn" class="btn btn-dark">로그아웃</button>
  </div>
</div>
