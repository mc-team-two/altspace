<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                        <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="currentColor" class="bi bi-emoji-dizzy" viewBox="0 0 16 16">
                            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                            <path d="M9.146 5.146a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708.708l-.647.646.647.646a.5.5 0 0 1-.708.708l-.646-.647-.646.647a.5.5 0 1 1-.708-.708l.647-.646-.647-.646a.5.5 0 0 1 0-.708m-5 0a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 1 1 .708.708l-.647.646.647.646a.5.5 0 1 1-.708.708L5.5 7.207l-.646.647a.5.5 0 1 1-.708-.708l.647-.646-.647-.646a.5.5 0 0 1 0-.708M10 11a2 2 0 1 1-4 0 2 2 0 0 1 4 0"/>
                        </svg>
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
                            <%--평점--%>
                        <div class="mb-2">
                        <span class="text-warning">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                        </span>
                            <span class="ms-2">평점: ${item.grade}</span>
                        </div>
                            <%--커멘트--%>
                        <p class="my-3" style="color: #555;">${item.comment}</p>

                            <%--리뷰 등록/수정일--%>
                        <div class="text-muted small">
                            <p class="mb-1"><i class="fas fa-calendar-alt me-1"></i>리뷰 등록일: ${item.createDay}</p>
                            <p class="mb-0"><i class="fas fa-edit me-0"></i>리뷰 수정일: ${item.updateDay}</p>
                        </div>
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
    });
</script>
