<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="ftm" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .list-group .list-group-item {
        cursor: pointer;
    }
    #replyText {
        resize:none;
        border-radius: 15px;
    }
</style>

<div class="container">
    <p class="text-muted mb-4 fs-6">
        리뷰 관리 &nbsp;&nbsp;>&nbsp;&nbsp; <strong>작성된 리뷰 조회</strong>
    </p>
    <div class="row">
        <%--host가 소유한 acc 목록--%>
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

        <%--리뷰 부분--%>
        <div class="col-sm-9">
            <c:if test="${empty rvList}">
                <div class="card">
                    <div class="card-body" style="text-align: center">
                        <p>아직 리뷰를 남긴 게스트가 없어요.</p>
                        <i class="bi bi-three-dots"></i>
                    </div>
                </div>
            </c:if>

            <c:forEach var="item" items="${rvList}">
                <div class="card mb-3">
                    <div class="card-body">
                        <%--유저 프로필--%>
                        <div class="d-flex align-items-center mb-2">
                            <i class="fas fa-user-circle fa-2x me-2 text-secondary"></i>
                            <h5 class="mb-0">${item.guestId}</h5>
                        </div>

                        <%--별 + 평점--%>
                        <div class="mb-2">
                            <span class="text-warning">
                                <c:forEach var="i" begin="1" end="5">
                                    <c:choose>
                                        <c:when test="${i <= item.grade}">
                                            <i class="bi bi-star-fill"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="bi bi-star"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </span>
                            <span class="ms-2">평점: ${item.grade}</span>
                        </div>

                        <%--숙소 이름--%>
                        <div class="mb-2">${item.accommodationName}</div>

                        <%--커멘트--%>
                        <p class="mb-3" style="color: #555;">${item.comment}</p>

                        <%--리뷰 등록/수정일--%>
                        <div class="text-muted small">
                            <p class="mb-1">
                                <i class="fas fa-calendar-alt me-1"></i>
                                리뷰 등록일:
                                <ftm:formatDate pattern="yyyy년 MM월 dd일 HH:mm:ss" value="${item.createDay}"/>
                            </p>
                            <p class="mb-0">
                                <i class="fas fa-edit me-0"></i>
                                리뷰 수정일:
                                <ftm:formatDate pattern="yyyy년 MM월 dd일 HH:mm:ss" value="${item.updateDay}"/>
                            </p>
                        </div>
                    </div>

                    <%--호스트 답글--%>
                    <div class="d-flex px-3 mb-3">
                        <textarea class="flex-grow-1" rows="2" style="padding:10px;resize:none; border-radius:15px;"></textarea>
                        <button class="btn btn-primary ms-2" style="resize:none; border-radius:10px;">등록</button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<script>
    $(function () {
        // 리스트 그룹 핸들러 (선택한 아이템 강조)
        const $accList = $("#accList");

        $accList.on("click", ".list-group-item", function () {
            // 모든 아이템에서 active 클래스 제거
            $accList.find(".list-group-item").removeClass("active");
            // 클릭된 아이템에 active 클래스 추가
            $(this).addClass("active");
        });

        $(".auto-resize").each(function () {
            this.style.height = "48px"; // 초기 높이
            this.style.overflowY = "hidden";
        }).on("input", function () {
            this.style.height = "48px"; // 최소 높이
            this.style.height = (this.scrollHeight) + "px";
        });
    });
</script>
