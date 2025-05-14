<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
    const space_get = {
        init:function(){},
        modSpace:function(accId){
            // detail 페이지로 이동
            window.location.href=
                "/space/detail?id=" + accId;
        },
        delSpace:function(accId){
            let c = confirm('정말 삭제하시겠습니까?\n복구할 수 없습니다.');
            if (c) {
                $.ajax({
                    url: "<c:url value='/space/del'/>?id=" + accId,
                    type: "POST",
                    success: (response) => {
                        alert(response);
                        window.location.reload();
                    },
                    error: (xhr) => {
                        alert(xhr.responseText);
                    }
                });
            }
        },
    };
    $(function(){
        space_get.init();
    })
</script>

<div class="container-fluid">
    <p class="text-muted">공간 관리 > 내 공간 관리</p>
    <div class="card shadow mb-4">
        <div class="card-body">
            <%--contents 시작--%>
            <div class="row py-3">
                <div class="col d-flex justify-content-start">총 ${cpage.total}개의 스페이스</div>
                <div class="col d-flex justify-content-end">
                    <a href="<c:url value="/space/add"/>"
                       class="btn btn-primary d-flex align-items-center flex-nowrap"
                       style="min-width: 130px; white-space: nowrap;">
                        <i class="bi bi-house-add me-2"></i>
                        <span>새 공간 추가</span>
                    </a>
                </div>
            </div>
            <div class="row">
                <c:forEach var="item" items="${cpage.getList()}">
                    <div class="col-12 col-md-6 col-lg-4 col-5-in-row mb-4 d-flex">
                        <div class="card w-100">
                            <img class="card-img-top" height="200" width="auto" src="<c:url value='/imgs/${item.image1Name}'/>" alt="Card image">
                            <div class="card-body">
                                <h4 class="card-title">${item.name}</h4>
                                <p class="card-text">${item.location}</p>
                                <button class="btn btn-primary btn-sm" data-bs-toggle="collapse" data-bs-target="#acc_${item.accommodationId}">더보기</button>
                                <button class="btn btn-dark btn-sm" onclick="space_get.modSpace(${item.accommodationId})">수정</button>
                                <button class="btn btn-secondary btn-sm" onclick="space_get.showDeleteModal(${item.accommodationId})">삭제</button>

                                <div id="acc_${item.accommodationId}" class="collapse">
                                    <hr>
                                    <p>예약 가능 여부: ${item.status}</p>
                                    <p>건물 유형: ${item.category}</p>
                                    <p>공간 유형: ${item.roomType}</p>
                                    <p>1박 요금: <fmt:formatNumber value="${item.priceNight}" pattern="###,###"/> 원</p>
                                    <p>
                                    제공옵션:
                                    <c:if test="${item.breakfast}">
                                        <span>#조식포함</span>
                                    </c:if>
                                    <c:if test="${item.pool}">
                                        <span>#수영장</span>
                                    </c:if>
                                    <c:if test="${item.barbecue}">
                                        <span>#바베큐</span>
                                    </c:if>
                                    <c:if test="${item.pet}">
                                        <span>#펫동반가능</span>
                                    </c:if>
                                    </p>
                                    <p>등록일:${item.createDay}</p>
                                    <p>수정일:${item.updateDay}</p>

                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <jsp:include page="../page.jsp"/>
        <div class="d-flex justify-content-center" style="padding-bottom:15px;">
            <small class="text-muted">${cpage.pageNum} - ${cpage.pages}</small>
        </div>

    </div>
</div>