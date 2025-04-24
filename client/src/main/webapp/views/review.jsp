<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>리뷰 작성</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- Bootstrap 4 -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<script>
  const change = {
    init: function () {

      $('#review_btn').click(()=>{
        this.review();
      });
    },
    review:function(){
      $('#data_add').attr({
        'method':'post',
        'action':'<c:url value="/review/reviewUpload?id=${accomm.accommodationId}"/>'
      });
      $('#data_add').submit();
    }
  }
  $(document).ready(function () {
    change.init();
  });
</script>

<div class="container mt-5">
  <h2 class="mb-4">숙소 리뷰 작성</h2>
  <form id="data_add">
    <!-- 숙소 이름 (예: 드롭다운 또는 hidden input) -->
    <div class="form-group">
      <input type="hidden" name="accommodationId" value="${accomm.accommodationId}">
      <input type="hidden" name="guestId" value="${sessionScope.user.userId}">

      <p><strong>숙소 이름:</strong> ${accomm.name}</p>
      <p><strong>위치:</strong> ${accomm.location}</p>
      <label for="guestName">작성자 이름</label>
      <input type="text" class="form-control" id="guestName" value="${sessionScope.user.name}">
    </div>
    <!-- 평점 선택 -->
    <div class="form-group">
      <label for="grade">평점</label>
      <select class="form-control" id="grade" name="grade" required>
        <option value="">선택</option>
        <option value="1">1점</option>
        <option value="2">2점</option>
        <option value="3">3점</option>
        <option value="4">4점</option>
        <option value="5">5점</option>
      </select>
    </div>
    <!-- 리뷰 내용 -->
    <div class="form-group">
      <label for="comment">리뷰 내용</label>
      <textarea class="form-control" id="comment" name="comment" rows="5" placeholder="리뷰를 작성해주세요" required></textarea>
    </div>
  </form>
  <!-- 제출 버튼 -->
  <button class="btn btn-primary" id="review_btn">리뷰 업로드</button>
</div>

</body>
</html>
