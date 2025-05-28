<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="ftm" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .list-group .list-group-item {
        cursor: pointer;
    }
    .header-text {
        font-size: 20px;
        font-weight: bold;
    }
    .review-card[style*="display:none"] {
        display: none;
    }
</style>

<div class="container-fluid">
    <p class="text-muted mb-4 fs-6">
        리뷰 관리 &nbsp;&nbsp;>&nbsp;&nbsp; <strong>작성된 리뷰 조회</strong>
    </p>

    <small id="dataTimestamp" class="text-muted">데이터 기준일:</small>
    <%--헤더--%>
    <div class="row my-3 mx-0 bg-light rounded p-3 text-center justify-content-around">
        <div class="col p-0 border-0 rounded-2 pt-2">
            <p class="header-text">누적 리뷰수</p>
            <p id="totalReviews">
                <span class="spinner-border text-primary"></span>
            </p>
        </div>
        <div class="col border-0 rounded-2 pt-2">
            <p class="header-text">호스팅 누적 평점</p>
            <p id="averageGrade">
                <span class="spinner-border text-primary"></span>
            </p>
        </div>
        <div class="col border-0 rounded-2 pt-2">
            <p class="header-text">오늘 등록된 리뷰</p>
            <p id="todayReviews">
                <span class="spinner-border text-primary"></span>
            </p>
        </div>
        <div class="col border-0 rounded-2 pt-2">
            <p class="header-text">답글을 쓸 수 있는 리뷰</p>
            <p id="noReplyReviews">
                <span class="spinner-border text-primary"></span>
            </p>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-3 mb-3">
            <ul class="list-group bg-light" id="accList">
                <a href="<c:url value='/review/list'/>" class="list-group-item ${param.accId == null ? 'active' : ''}" data-id="all">
                    전체보기
                </a>

                <c:forEach var="item" items="${accList}">
                    <a href="<c:url value='/review/list'/>?accId=${item.accommodationId}"
                       class="list-group-item ${param.accId == item.accommodationId ? 'active' : ''}"
                       data-id="${item.accommodationId}">
                            ${item.name} (${item.reviewCount})
                    </a>
                </c:forEach>
            </ul>
        </div>

        <%--작성한 리뷰 목록 (컨텐츠)--%>
        <div class="col-sm-9 mx-auto">
            <c:if test="${empty reviewMap}">
                <div class="card mb-3">
                    <div class="card-body" style="text-align: center">
                        <p>아직 리뷰를 남긴 게스트가 없어요.</p>
                        <i class="bi bi-three-dots"></i>
                    </div>
                </div>
            </c:if>
            <%-- Review items container --%>
            <div id="reviewItemsContainer">
                <c:forEach var="rm" items="${reviewMap}" varStatus="status">
                    <div class="card mb-3 review-card" ${status.index >= 3 ? 'style="display:none;"' : ''}>
                        <div class="card-body">

                            <!-- 리뷰 정보 출력 -->
                            <div class="mb-2">
                                <p class="text-warning">
                                    <c:forEach var="i" begin="1" end="5">
                                        <c:choose>
                                            <c:when test="${i <= rm.review.grade}">
                                                <i class="bi bi-star-fill"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-star"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </p>
                                <div class="d-flex align-items-center justify-content-between mb-2">
                                    <div class="float-start">
                                        <i class="fas fa-user-circle fa-2x me-2 text-secondary"></i>
                                        <span style="font-size:18px; font-weight:bold">${rm.review.guestId}</span>
                                    </div>
                                    <div class="float-end">
                                        <button class="btn border-gray p-1">
                                            <i class="bi bi-globe2"></i><span class="ms-1">번역</span>
                                            <select class="form-select form-select-sm"
                                                    data-review-id="${rm.review.reviewId}"
                                                    data-original="${rm.review.comment}">
                                                <option value="" selected disabled hidden>언어</option>
                                                <option value="ko">한국어</option>
                                                <option value="en">영어</option>
                                                <option value="zh-CN">중국어</option>
                                                <option value="ja">일본어</option>
                                            </select>
                                        </button>
                                    </div>
                                </div>
                                <small>[${rm.review.name}]</small>
                                <p class="review-comment-text">${rm.review.comment}</p>

                                    <%--이미지 추가--%>
                                <c:if test="${not empty rm.images}">
                                    <div class="d-flex overflow-scroll">
                                        <c:forEach var="reviewImg" items="${rm.images}">
                                            <img class="pe-2" style="height: 120px; width: auto;" src="<c:url value="/imgs/no-image-available.jpeg"/>" alt="리뷰이미지">
                                            <%--<img src="<c:url value='/imgs/${reviewImg}'/>" alt="리뷰이미지" class="img-fluid mb-2" />--%>
                                        </c:forEach>
                                    </div>
                                </c:if>

                                <small class="text-muted">
                                    작성일:<fmt:formatDate value="${rm.review.createDay}" pattern="yyyy년 MM월 dd일 HH:mm:ss"/><br>
                                    수정일:<fmt:formatDate value="${rm.review.updateDay}" pattern="yyyy년 MM월 dd일 HH:mm:ss"/>
                                </small>
                            </div>

                            <!-- 답글 리스트 출력 -->
                            <hr>
                            <div class="mt-3">
                                <c:choose>
                                    <c:when test="${empty rm.reply}">
                                        <p class="text-muted">호스트 님의 답글을 남겨주세요. 😍</p>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="reply-list">
                                            <c:forEach var="reply" items="${rm.reply}">
                                                <div class="reply-item mb-3">
                                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                                        <div class="left">
                                                            <img src="<c:url value="/imgs/avatar.png"/>" alt class="w-px-30 h-auto rounded-circle" />
                                                            <strong>${sessionScope.user.name}</strong>
                                                            <small class="ms-1 text-muted"><fmt:formatDate value="${reply.createDay}" pattern="yyyy-MM-dd HH:mm:ss"/></small>
                                                        </div>
                                                        <div class="text-muted small right">
                                                            <a href="javascript:void(0);" data-review-id="${reply.replyId}" class="modifyReplyBtn">수정</a>
                                                            <a href="javascript:void(0);" data-review-id="${reply.replyId}" class="deleteReplyBtn ms-3">삭제</a>
                                                        </div>
                                                    </div>
                                                    <p>${reply.comment}</p>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- 답글 작성 폼 -->
                            <div class="d-flex mt-3">
                                <input type="hidden" class="reviewId" value="${rm.review.reviewId}">
                                <input type="hidden" class="userId" value="${sessionScope.user.userId}">
                                <textarea class="comment form-control me-2" rows="2" required></textarea>
                                <button class="addReplyBtn btn btn-primary" data-review-id="${rm.review.reviewId}">
                                    <i class="bi bi-send"></i>
                                </button>
                            </div>

                        </div>
                    </div>
                </c:forEach>
            </div>
            <%-- 더보기 버튼 --%>
            <c:if test="${not empty reviewMap && reviewMap.size() > 3}">
                <button id="loadMoreReviewsBtn" class="btn btn-outline-primary w-50 mx-auto my-4 d-block">더보기</button>
            </c:if>
        </div>
    </div>
</div>

<script>
    const reviewPage = {
        countUpInstances: {},

        init: function () {
            // 답글 등록
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

            // 답글 삭제
            $(document).on("click", ".deleteReplyBtn", function (e) {
                const replyId = $(this).data("review-id");
                if (confirm("정말로 삭제하시겠습니까?")) {
                    reviewPage.delReply(replyId);
                }
            });

            // 사이드바 핸들러
            $("#accList").on("click", ".list-group-item", function () {
                $("#accList").find(".list-group-item").removeClass("active");
                $(this).addClass("active");
            });

            // 번역 기능 초기화
            $(document).on('change', '.form-select.form-select-sm', function() {
                const $select = $(this);
                const selectedLang = $select.val();
                const originalText = $select.data('original');
                const $commentParagraph = $select.closest('.card-body').find('.review-comment-text');

                if (!selectedLang) {
                    $commentParagraph.text(originalText);
                    return;
                }

                if ($commentParagraph.length) {
                    reviewPage.translate(originalText, selectedLang, $commentParagraph);
                } else {
                    console.error("Could not find comment paragraph to update.");
                }
            });

            // "Load More" reviews button handler
            $('#loadMoreReviewsBtn').on('click', function() {
                reviewPage.loadMoreReviews();
            });
        },

        addReply: function (replyData) {
            $.ajax({
                url: "<c:url value='/api/review/add-reply'/>",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(replyData),
                success: function (response) {
                    //alert(response);
                    location.reload();
                },
                error: function (xhr) {
                    alert('error: ' + xhr.responseText);
                }
            });
        },

        delReply: function (replyId) {
            $.ajax({
                url: "/api/review/del-reply?replyId=" + replyId,
                type: "POST",
                success: function (response) {
                    alert(response);
                    location.reload();
                },
                error: function (xhr) {
                    alert('error: ' + xhr.responseText);
                }
            });
        },

        loadDashBoardData: function () {
            $.ajax({
                url: "<c:url value='/api/review/dashboard'/>",
                type: "POST",
                data: { hostId: "${sessionScope.user.userId}" },
                success: (resp) => {
                    this.displayTimestamp();
                    $("#totalReviews").text(resp.totalReviews.count ?? 0).removeClass("placeholder-glow");
                    $("#averageGrade").text(resp.averageGrade ?? 0 ).removeClass("placeholder-glow");
                    $("#todayReviews").text(resp.todayReviews.count ?? 0).removeClass("placeholder-glow");
                    $("#noReplyReviews").text(resp.noReplyReviews.count ?? 0).removeClass("placeholder-glow");
                },
                error: (xhr) => {
                    alert('error: ' + xhr.responseText);
                    console.error(xhr.status, xhr.responseText);
                }
            });
        },

        displayTimestamp: function() {
            const now = new Date();
            const year = now.getFullYear();
            const month = String(now.getMonth() + 1).padStart(2, '0'); // Months are 0-indexed
            const day = String(now.getDate()).padStart(2, '0');
            const hours = String(now.getHours()).padStart(2, '0');
            const minutes = String(now.getMinutes()).padStart(2, '0');
            const seconds = String(now.getSeconds()).padStart(2, '0');

            const formattedTimestamp = year + "년 " + month + "월 " + day + "일 " + hours + ":" + minutes + ":" + seconds;
            $("#dataTimestamp").text("데이터 기준일: " + formattedTimestamp);
        },

        translate: function(originalText, targetLang, $commentElement){
            if (!targetLang) {
                $commentElement.text(originalText);
                return;
            }

            $.ajax({
                type: 'POST',
                url: '<c:url value="/api/review/translate"/>',
                contentType: 'application/json',
                data: JSON.stringify({ msg: originalText, target: targetLang }),
                success: function (translatedText) {
                    if (translatedText && translatedText.trim() !== "") {
                        $commentElement.text(translatedText);
                    } else {
                        $commentElement.text(originalText);
                        alert('번역 결과를 받지 못했습니다. 원본 텍스트로 표시됩니다.');
                    }
                },
                error: function (xhr) {
                    console.error("Translation error:", xhr.responseText);
                    alert('번역 중 오류가 발생했습니다: ' + xhr.responseText);
                    $commentElement.text(originalText);
                }
            });
        },

        loadMoreReviews: function() {
            const $hiddenReviews = $('.review-card:hidden');
            const reviewsToShow = 3;

            $hiddenReviews.slice(0, reviewsToShow).slideDown();

            if ($hiddenReviews.length <= reviewsToShow) {
                $('#loadMoreReviewsBtn').hide();
            }
        }
    };

    $(function () {
        reviewPage.init();
        reviewPage.loadDashBoardData();
    });
</script>