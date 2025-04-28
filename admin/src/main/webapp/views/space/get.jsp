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

<div class="col-sm-12">
    <div class="card shadow mb-4">
        <div class="card-body">
            <%--contents 시작--%>
            <div class="row py-3">
                <div class="col d-flex justify-content-start">총 ${cpage.total}개의 검색 결과</div>
                <div class="col d-flex justify-content-end">
                    <a href="<c:url value="/space/add"/>" class="btn btn-primary">
                        <span class="d-flex justify-content-center align-items-center">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-add" viewBox="0 0 16 16">
                                <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L2 8.207V13.5A1.5 1.5 0 0 0 3.5 15h4a.5.5 0 1 0 0-1h-4a.5.5 0 0 1-.5-.5V7.207l5-5 6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293z"/>
                                <path d="M16 12.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0m-3.5-2a.5.5 0 0 0-.5.5v1h-1a.5.5 0 0 0 0 1h1v1a.5.5 0 1 0 1 0v-1h1a.5.5 0 1 0 0-1h-1v-1a.5.5 0 0 0-.5-.5"/>
                            </svg>
                            <span>&nbsp;&nbsp;새 공간 추가</span>
                        </span>
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
                                <button class="btn btn-secondary btn-sm" onclick="space_get.delSpace(${item.accommodationId})">삭제</button>

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
