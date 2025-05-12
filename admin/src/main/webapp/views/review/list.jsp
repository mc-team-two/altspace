<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="ftm" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .list-group .list-group-item {
        cursor: pointer;
    }
</style>

<div class="container">
    <p class="text-muted mb-4 fs-6">
        리뷰 관리 &nbsp;&nbsp;>&nbsp;&nbsp; <strong>작성된 리뷰 조회</strong>
    </p>
    <div class="row">
        <%--host가 소유한 acc 목록 (사이드바)--%>
        <div class="col-sm-3">
            <ul class="list-group" id="accList">
                <a href="<c:url value='/review/list'/>" class="list-group-item ${param.accId == null ? 'active' : ''}" data-id="all">
                    전체보기
                </a>

                <c:forEach var="item" items="${accList}">
                    <a href="<c:url value='/review/list'/>?accId=${item.accommodationId}"
                       class="list-group-item ${param.accId == item.accommodationId ? 'active' : ''}"
                       data-id="${item.accommodationId}">
                            ${item.name}
                    </a>
                </c:forEach>
            </ul>
        </div>

        <%--작성한 리뷰 목록 (컨텐츠) --%>
        <div class="col-sm-9">
            <c:if test="${empty reviewMap}">
                <div class="card">
                    <div class="card-body" style="text-align: center">
                        <p>아직 리뷰를 남긴 게스트가 없어요.</p>
                        <i class="bi bi-three-dots"></i>
                    </div>
                </div>
            </c:if>
            <c:forEach var="entry" items="${reviewMap}">
                <div class="card mb-3">
                    <div class="card-body">

                        <!-- 리뷰 정보 출력 -->
                        <div class="mb-2">
                            <p class="text-warning">
                                <c:forEach var="i" begin="1" end="5">
                                    <c:choose>
                                        <c:when test="${i <= entry.key.grade}">
                                            <i class="bi bi-star-fill"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="bi bi-star"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </p>
                            <p class="d-flex align-items-center">
                                <i class="fas fa-user-circle fa-2x me-2 text-secondary"></i>
                                <span style="font-size:18px; font-weight:bold">${entry.key.guestId}</span>
                                <span>('${entry.key.accommodationName}'를 이용한 고객)</span>
                            </p>
                            <p>${entry.key.comment}</p>
                            <small class="text-muted">
                                작성일:<fmt:formatDate value="${entry.key.createDay}" pattern="yyyy년 MM월 dd일 HH:mm:ss"/><br>
                                수정일:<fmt:formatDate value="${entry.key.updateDay}" pattern="yyyy년 MM월 dd일 HH:mm:ss"/>
                            </small>
                        </div>

                        <!-- 답글 리스트 출력 -->
                        <hr>
                        <div class="mt-3">
                            <c:choose>
                                <c:when test="${empty entry.value}">
                                    <p class="text-muted">호스트 님의 답글을 남겨주세요. 😍</p>
                                </c:when>
                                <c:otherwise>
                                    <div class="reply-list">
                                        <c:forEach var="reply" items="${entry.value}">
                                            <div class="reply-item mb-2">
                                                <strong>내가 남긴 답글: &nbsp;</strong>
                                                <span>${reply.comment}</span>
                                                <small class="text-muted">
                                                    (<fmt:formatDate value="${reply.createDay}" pattern="yyyy-MM-dd HH:mm:ss"/>)
                                                </small>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- 답글 작성 폼 -->
                        <div class="d-flex mt-3">
                            <input type="hidden" class="reviewId" value="${entry.key.reviewId}">
                            <input type="hidden" class="userId" value="${sessionScope.user.userId}">
                            <textarea class="comment form-control me-2" rows="2" required></textarea>
                            <button class="addReplyBtn btn btn-primary" data-review-id="${entry.key.reviewId}">등록</button>
                        </div>

                    </div>
                </div>
            </c:forEach>
        </div>

<script>
    const reviewPage = {
        init: function () {
            // 리뷰 등록
            $(document).on('click', '.addReplyBtn', function () {
                let reviewId = $(this).data('review-id');
                let comment = $(this).siblings('.comment').val().trim();
                let userId = $(this).siblings('.userId').val();

                if (!userId) {
                    alert("로그인이 필요한 기능입니다.");
                    return;
                }

                if (!comment) {
                    alert("답글은 공백일 수 없습니다.");
                    return;
                }

                let replyData = {
                    reviewId: reviewId,
                    userId: userId,
                    comment: comment
                };

                reviewPage.addReply(replyData);
            });

            // 사이드바 핸들러
            $("#accList").on("click", ".list-group-item", function () {
                $("#accList").find(".list-group-item").removeClass("active");
                $(this).addClass("active");
            });
        },
        addReply: function (replyData) {
            $.ajax({
                url: "<c:url value='/review/add-reply'/>",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(replyData),
                success: function (response) {
                    alert(response);  // 성공 메시지
                    location.reload();  // 페이지 새로고침
                },
                error: function (xhr) {
                    alert('error: ' + xhr.responseText);
                }
            });
        }
    };

    $(function () {
        reviewPage.init();
    });
</script>

