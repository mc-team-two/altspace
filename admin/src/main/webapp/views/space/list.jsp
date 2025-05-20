<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
    .carousel-inner .carousel-item img {
        height: 240px;
        width: 100%;
        object-fit: contain;
        background-color: #eeeeee;
    }
    .card {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .card:hover {
        transform: translateY(-8px);
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    }
</style>

<script>
    const space_get = {
        init:function(){
        },
        modSpace:function(accId){
            location.href = "<c:url value="/space/mod?id="/>" + accId;
        },
        delSpace:function(accId){
            let c = confirm('정말 삭제하시겠습니까?\n복구할 수 없습니다.');
            if (c) {
                $.ajax({
                    url: "<c:url value='/api/space/del'/>?id=" + accId,
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
    <p class="text-muted">스페이스 관리 > <strong>내 스페이스</strong></p>
            <%--contents 시작--%>
            <div class="row py-3">
                <div class="col d-flex justify-content-start">총 <strong>${cpage.total}</strong>개의 스페이스</div>
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
                            <img class="card-img-top" height="200" width="auto" src="<c:url value='/imgs/${item.image1Name}'/>" alt="Card image"
                                 style="cursor: pointer;"
                                 data-bs-toggle="modal" data-bs-target="#acc_${item.accommodationId}">
                            <div class="card-body">
                                <h4 class="card-title">${item.name}</h4>
                                <p class="card-text">${item.location}</p>
                                <div class="float-end">
                                    <a href="javascript:void(0);" onclick="space_get.modSpace(${item.accommodationId})" class="mx-4">수정</a>
                                    <a href="javascript:void(0);" onclick="space_get.delSpace(${item.accommodationId})">삭제</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%--상세보기 모달--%>
                    <div class="modal fade" id="acc_${item.accommodationId}" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">

                                <%-- Modal Header --%>
                                <div class="modal-header">
                                    <div class="modal-title">
                                        <h4 class="mb-0">${item.name}</h4>
                                        <p class="mb-1">${item.location}</p>
                                    </div>
                                </div>
                                <hr class="my-0">
                                <%-- Modal body --%>
                                <div class="modal-body">

                                    <%-- Carousel (Gallery) --%>
                                    <div id="gallery_${item.accommodationId}" class="carousel slide" data-bs-ride="carousel" data-bs-interval="false">

                                        <!-- Indicators/dots -->
                                        <div class="carousel-indicators">
                                            <button type="button" data-bs-target="#gallery_${item.accommodationId}" data-bs-slide-to="0" class="active"></button>
                                            <button type="button" data-bs-target="#gallery_${item.accommodationId}" data-bs-slide-to="1"></button>
                                            <button type="button" data-bs-target="#gallery_${item.accommodationId}" data-bs-slide-to="2"></button>
                                            <button type="button" data-bs-target="#gallery_${item.accommodationId}" data-bs-slide-to="3"></button>
                                            <button type="button" data-bs-target="#gallery_${item.accommodationId}" data-bs-slide-to="4"></button>
                                        </div>

                                        <!-- The slideshow/carousel -->
                                            <%-- EL 3.0 이상에서 사용 가능한 리스트 생성 문법 사용 --%>
                                        <c:set var="imageFileNames" value="${[item.image1Name, item.image2Name, item.image3Name, item.image4Name, item.image5Name]}" />
                                        <c:set var="imageCaptions" value="${['대표사진', '상세사진1', '상세사진2', '상세사진3', '상세사진4']}" />

                                        <div class="carousel-inner">
                                            <c:forEach varStatus="loop" begin="0" end="4">
                                                <c:set var="currentImageName" value="${imageFileNames[loop.index]}" />
                                                <c:set var="currentCaption" value="${imageCaptions[loop.index]}" />
                                                <div class="carousel-item ${loop.first ? 'active' : ''}">
                                                    <c:choose>
                                                        <c:when test="${empty currentImageName}">
                                                            <img src="<c:url value='../imgs/no-image-available.jpeg'/>" alt="${currentCaption} (이미지 없음)" class="d-block">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="<c:url value='../imgs/${currentImageName}'/>" alt="${currentCaption}" class="d-block">
                                                            <div class="carousel-caption">${currentCaption}</div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </c:forEach>
                                        </div>

                                        <!-- Left and right controls/icons -->
                                        <button class="carousel-control-prev" type="button" data-bs-target="#gallery_${item.accommodationId}" data-bs-slide="prev">
                                            <span class="carousel-control-prev-icon"></span>
                                        </button>
                                        <button class="carousel-control-next" type="button" data-bs-target="#gallery_${item.accommodationId}" data-bs-slide="next">
                                            <span class="carousel-control-next-icon"></span>
                                        </button>
                                    </div>

                                    <%-- data --%>
                                        <div class="container-fluid mt-4 p-3 shadow-sm bg-white rounded">
                                            <div class="row">
                                                <div class="col-12 col-md-6">
                                                    <p><strong>건물 유형:</strong> ${item.category}</p>
                                                    <p><strong>공간 유형:</strong> ${item.roomType}</p>
                                                </div>
                                                <div class="col-12 col-md-6">
                                                    <p><strong>1박 요금:</strong> <fmt:formatNumber value="${item.priceNight}" pattern="###,###"/> 원</p>
                                                    <p><strong>예약 가능 여부:</strong> ${item.status}</p>
                                                </div>
                                            </div>
                                            <div class="mt-3">
                                                <ul class="list-unstyled d-flex flex-wrap">
                                                    <li class="me-2 mb-2"><strong>제공옵션:</strong></li>
                                                    <c:if test="${item.breakfast}">
                                                        <li class="badge bg-success me-2 mb-2">#조식포함</li>
                                                    </c:if>
                                                    <c:if test="${item.pool}">
                                                        <li class="badge bg-primary me-2 mb-2">#수영장</li>
                                                    </c:if>
                                                    <c:if test="${item.barbecue}">
                                                        <li class="badge bg-warning me-2 mb-2">#바베큐</li>
                                                    </c:if>
                                                    <c:if test="${item.pet}">
                                                        <li class="badge bg-info me-2 mb-2">#펫동반가능</li>
                                                    </c:if>
                                                </ul>
                                            </div>
                                            <div class="mt-3">
                                                <p><strong>등록일:</strong> <fmt:formatDate value="${item.createDay}" pattern="yyyy년 MM월 dd일 HH:mm:ss"/></p>
                                                <p><strong>수정일:</strong> <fmt:formatDate value="${item.updateDay}" pattern="yyyy년 MM월 dd일 HH:mm:ss"/></p>
                                            </div>
                                        </div>
                                </div>

                                <!-- Modal footer -->
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                </div>

                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

        <jsp:include page="components/page.jsp"/>
        <div class="d-flex justify-content-center" style="padding-bottom:15px;">
            <small class="text-muted">${cpage.pageNum} - ${cpage.pages}</small>
        </div>
</div>