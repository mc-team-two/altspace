<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>리뷰 수정</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap 4 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>


<!-- 이 부분은 <script> 위에 있어야 JSP에서 먼저 해석됨 -->
<c:url value="/review/update" var="updateUrl">
    <c:param name="id" value="${review.accommodationId}" />
</c:url>
<c:url value="/review/delete" var="deleteUrl">
    <c:param name="rvId" value="${review.reviewId}" />
    <c:param name="acId" value="${review.accommodationId}" />
</c:url>
<script>
    const reviewEdit = {
        init: function () {
            $('#review_update_btn').click(() => {
                this.update();
            });
            $('#review_delete_btn').click(() => {
                this.deldate();
            });
        },
        update: function () {
            $('#review_edit_form').attr({
                'method': 'post',
                'action': '${updateUrl}'
            });
            $('#review_edit_form').submit();
        },
        deldate: function () {
            $('#review_edit_form').attr({
                'method': 'post',
                'action': '${deleteUrl}'
            });
            $('#review_edit_form').submit();
        }
    }

    $(document).ready(function () {
        reviewEdit.init();
    });
</script>

<div class="container mt-5">
    <h2 class="mb-4">리뷰 수정</h2>
    <form id="review_edit_form">
        <input type="hidden" name="reviewId" value="${review.reviewId}">
        <input type="hidden" name="accommodationId" value="${review.accommodationId}">

        <!-- 숙소 정보 -->
        <p><strong>숙소 이름:</strong> ${review.name}</p>
        <p><strong>위치:</strong> ${review.location}</p>

        <!-- 작성자 -->
        <div class="form-group">
            <label for="guestName">작성자 이름</label>
            <input type="text" class="form-control" id="guestName" name="guestId" value="${review.guestId}" readonly>
        </div>

        <!-- 평점 수정 -->
        <div class="form-group">
            <label for="grade">평점</label>
            <select class="form-control" id="grade" name="grade" required>
                <option value="">선택</option>
                <c:forEach var="i" begin="1" end="5">
                    <option value="${i}" ${review.grade == i ? 'selected' : ''}>${i}점</option>
                </c:forEach>
            </select>
        </div>

        <!-- 리뷰 내용 수정 -->
        <div class="form-group">
            <label for="comment">리뷰 내용</label>
            <textarea class="form-control" id="comment" name="comment" rows="5" required>${review.comment}</textarea>
        </div>
    </form>

    <!-- 수정/삭제 버튼 -->
    <button class="btn btn-primary" id="review_update_btn">수정하기</button>
    <button class="btn btn-danger" id="review_delete_btn">삭제하기</button>
</div>

</body>
</html>
