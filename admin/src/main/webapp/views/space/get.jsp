<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
    .list-group-item {
        cursor: pointer;
        white-space: nowrap;        /* 줄바꿈 방지 */
        font-size: clamp(0.6rem, 2vw, 1rem);  /* 화면 크기에 따라 글자 크기 자동 조절 */
    }
</style>

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
            <small class="text-muted">총 ${cpage.total}개의 검색 결과</small>
            <div class="d-flex">
                <ul class="list-group list-group-horizontal">
                    <li class="list-group-item active">전체</li>
                    <li class="list-group-item">아파트</li>
                    <li class="list-group-item">빌라</li>
                    <li class="list-group-item">단독주택</li>
                    <li class="list-group-item">오피스텔</li>
                </ul>
            </div>
            <div class="d-flex py-3">
                <ul class="list-group list-group-horizontal">
                    <li class="list-group-item active">전체</li>
                    <li class="list-group-item">공간 전체</li>
                    <li class="list-group-item">방</li>
                    <li class="list-group-item">호스텔 내 다인실</li>
                </ul>
            </div>
            <div class="row">
                <c:forEach var="item" items="${cpage.getList()}">
                    <div class="col-12 col-md-6 col-lg-4 col-5-in-row mb-4 d-flex">
                        <div class="card w-100">
                            <img class="card-img-top" height="200" width="auto" src="<c:url value='/imgs/${item.image1Name}'/>" alt="Card image">
                            <div class="card-body">
                                <h4 class="card-title">${item.name}</h4>
                                <p class="card-text">${item.location}</p>
                                <button class="btn btn-primary btn-sm" data-toggle="collapse" data-target="#acc_${item.accommodationId}">더보기</button>
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

            <%--<div class="py-2">
                <c:forEach var="item" items="${cpage.getList()}">
                <div class="card w-100" style="background-color:#eeeeee;margin-bottom:15px; max-width: 100%;">
                    <div class="card-header py-3">
                        &lt;%&ndash;상단바&ndash;%&gt;
                        <div class="d-flex justify-content-between align-items-center">
                            &lt;%&ndash;공간 이름&ndash;%&gt;
                            <div class="mb-0"><strong>${item.name}</strong></div>
                            &lt;%&ndash;펼치기/접기 버튼&ndash;%&gt;
                            <span role="button" aria-expanded="false" aria-controls="acc_${item.accommodationId}" data-toggle="collapse" data-target="#acc_${item.accommodationId}">
                                <svg width="30" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M20 7L4 7" stroke="#222222" stroke-width="1.5" stroke-linecap="round"></path>
                                    <path d="M20 12L4 12" stroke="#222222" stroke-width="1.5" stroke-linecap="round"></path>
                                    <path d="M20 17L4 17" stroke="#222222" stroke-width="1.5" stroke-linecap="round"></path>
                                </svg>
                            </span>
                        </div>

                        &lt;%&ndash;사진 캐러셀&ndash;%&gt;
                        <div id="gallery_${item.accommodationId}" class="carousel slide" data-ride="carousel">

                            <!-- The slideshow -->
                            <div class="carousel-inner">
                                <c:if test="${not empty item.image1Name}">
                                    <div class="carousel-item active">
                                    <img class="d-block mx-auto"
                                         alt="대표사진"
                                         style="max-height:200px;"
                                         src="<c:url value='/imgs/${item.image1Name}' />"
                                         onerror="this.onerror=null; this.src='<c:url value='/imgs/noImageAvailable.jpg' />';" />
                                </div>
                                </c:if>
                                <c:if test="${not empty item.image2Name}">
                                    <div class="carousel-item">
                                    <img class="d-block mx-auto"
                                         alt="대표사진"
                                         style="max-height:200px;"
                                         src="<c:url value='/imgs/${item.image2Name}' />"
                                         onerror="this.onerror=null; this.src='<c:url value='/imgs/noImageAvailable.jpg' />';" />
                                </div>
                                </c:if>
                                <c:if test="${not empty item.image3Name}">
                                    <div class="carousel-item">
                                    <img class="d-block mx-auto"
                                         alt="대표사진"
                                         style="max-height:200px;"
                                         src="<c:url value='/imgs/${item.image3Name}' />"
                                         onerror="this.onerror=null; this.src='<c:url value='/imgs/noImageAvailable.jpg' />';" />
                                </div>
                                </c:if>
                                <c:if test="${not empty item.image4Name}">
                                    <div class="carousel-item">
                                    <img class="d-block mx-auto"
                                         alt="대표사진"
                                         style="max-height:200px;"
                                         src="<c:url value='/imgs/${item.image4Name}' />"
                                         onerror="this.onerror=null; this.src='<c:url value='/imgs/noImageAvailable.jpg' />';" />
                                </div>
                                </c:if>
                                <c:if test="${not empty item.image5Name}">
                                    <div class="carousel-item">
                                    <img class="d-block mx-auto"
                                         alt="대표사진"
                                         style="max-height:200px;"
                                         src="<c:url value='/imgs/${item.image5Name}' />"
                                         onerror="this.onerror=null; this.src='<c:url value='/imgs/noImageAvailable.jpg' />';" />
                                </div>
                                </c:if>

                            </div>

                            <!-- Left and right controls -->
                            <a class="carousel-control-prev" href="#gallery_${item.accommodationId}" data-slide="prev">
                                <span class="carousel-control-prev-icon"></span>
                            </a>
                            <a class="carousel-control-next" href="#gallery_${item.accommodationId}" data-slide="next">
                                <span class="carousel-control-next-icon"></span>
                            </a>
                        </div>
                    </div>

                    <div class="card-body collapse" id="acc_${item.accommodationId}">
                        <hr>
                        <small class="text-muted">최초 등록일: <fmt:formatDate value="${item.createDay}" pattern="yyyy.MM.dd"/></small>
                        <small class="text-muted">마지막 수정: <fmt:formatDate value="${item.updateDay}" pattern="yyyy.MM.dd"/></small>
                        <div class="row">
                            <c:choose>
                                <c:when test="${item.category eq '아파트'}">
                                        <span data-toggle="tooltip" data-placement="top" title="아파트">
                                            <svg fill="#000000" height="29" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 467.5 467.5" xml:space="preserve"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g> <path d="M461.5,180.196c3.313,0,6-2.687,6-6s-2.687-6-6-6h-3.75V156.75h3.75c3.313,0,6-2.687,6-6s-2.687-6-6-6h-3.75v-16 c0-3.313-2.687-6-6-6h-53v-26c0-3.313-2.687-6-6-6h-19v-10c0-3.313-2.687-6-6-6s-6,2.687-6,6v10h-19c-3.313,0-6,2.687-6,6v26h-206 v-26c0-3.313-2.687-6-6-6h-19v-10c0-3.313-2.687-6-6-6s-6,2.687-6,6v10h-19c-3.313,0-6,2.687-6,6v26h-53c-3.314,0-6,2.687-6,6v16H6 c-3.313,0-6,2.687-6,6s2.687,6,6,6h3.75v11.445H6c-3.313,0-6,2.687-6,6s2.687,6,6,6h3.75v11.444H6c-3.313,0-6,2.687-6,6 s2.687,6,6,6h3.75v11.444H6c-3.313,0-6,2.687-6,6s2.687,6,6,6h3.75v11.444H6c-3.313,0-6,2.687-6,6s2.687,6,6,6h3.75v11.444H6 c-3.313,0-6,2.687-6,6s2.687,6,6,6h3.75v11.444H6c-3.313,0-6,2.687-6,6s2.687,6,6,6h3.75v11.444H6c-3.313,0-6,2.687-6,6 s2.687,6,6,6h3.75v11.444H6c-3.313,0-6,2.687-6,6s2.687,6,6,6h3.75v11.444H6c-3.313,0-6,2.687-6,6s2.687,6,6,6h3.75v19 c0,3.313,2.686,6,6,6h436c3.313,0,6-2.687,6-6v-19h3.75c3.313,0,6-2.687,6-6s-2.687-6-6-6h-3.75v-11.444h3.75c3.313,0,6-2.687,6-6 s-2.687-6-6-6h-3.75v-11.444h3.75c3.313,0,6-2.687,6-6s-2.687-6-6-6h-3.75v-11.444h3.75c3.313,0,6-2.687,6-6s-2.687-6-6-6h-3.75 v-11.444h3.75c3.313,0,6-2.687,6-6s-2.687-6-6-6h-3.75v-11.444h3.75c3.313,0,6-2.687,6-6s-2.687-6-6-6h-3.75v-11.444h3.75 c3.313,0,6-2.687,6-6s-2.687-6-6-6h-3.75V203.64h3.75c3.313,0,6-2.687,6-6s-2.687-6-6-6h-3.75v-11.444H461.5z M336.75,134.75v246 h-206v-246H336.75z M21.75,134.75h47v246h-47V134.75z M80.75,102.75h13v278h-13V102.75z M105.75,380.75v-278h13v278H105.75z M348.75,102.75h13v278h-13V102.75z M373.75,380.75v-278h13v278H373.75z M445.75,380.75h-47v-246h47V380.75z"></path> <path d="M40.75,156.75h9.75c3.313,0,6-2.687,6-6s-2.687-6-6-6h-9.75c-3.313,0-6,2.687-6,6S37.437,156.75,40.75,156.75z"></path> <path d="M50.5,168.196h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S53.813,168.196,50.5,168.196z"></path> <path d="M50.5,191.64h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S53.813,191.64,50.5,191.64z"></path> <path d="M50.5,215.084h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S53.813,215.084,50.5,215.084z"></path> <path d="M50.5,238.529h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S53.813,238.529,50.5,238.529z"></path> <path d="M50.5,261.973h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S53.813,261.973,50.5,261.973z"></path> <path d="M50.5,285.417h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S53.813,285.417,50.5,285.417z"></path> <path d="M50.5,308.862h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S53.813,308.862,50.5,308.862z"></path> <path d="M50.5,332.306h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S53.813,332.306,50.5,332.306z"></path> <path d="M50.5,355.75h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S53.813,355.75,50.5,355.75z"></path> <path d="M144.156,156.75h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S140.843,156.75,144.156,156.75z"></path> <path d="M144.156,180.196h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S140.843,180.196,144.156,180.196z "></path> <path d="M144.156,203.64h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S140.843,203.64,144.156,203.64z"></path> <path d="M144.156,227.084h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S140.843,227.084,144.156,227.084z "></path> <path d="M144.156,250.529h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S140.843,250.529,144.156,250.529z "></path> <path d="M144.156,273.973h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S140.843,273.973,144.156,273.973z "></path> <path d="M144.156,297.417h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S140.843,297.417,144.156,297.417z "></path> <path d="M144.156,320.862h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S140.843,320.862,144.156,320.862z "></path> <path d="M144.156,344.306h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S140.843,344.306,144.156,344.306z "></path> <path d="M224.281,355.75h-80.125c-3.313,0-6,2.687-6,6s2.687,6,6,6h80.125c3.313,0,6-2.687,6-6S227.595,355.75,224.281,355.75z"></path> <path d="M243.219,156.75h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S239.906,156.75,243.219,156.75z"></path> <path d="M243.219,180.196h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S239.906,180.196,243.219,180.196z "></path> <path d="M243.219,203.64h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S239.906,203.64,243.219,203.64z"></path> <path d="M243.219,227.084h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S239.906,227.084,243.219,227.084z "></path> <path d="M243.219,250.529h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S239.906,250.529,243.219,250.529z "></path> <path d="M243.219,273.973h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S239.906,273.973,243.219,273.973z "></path> <path d="M243.219,297.417h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S239.906,297.417,243.219,297.417z "></path> <path d="M243.219,320.862h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S239.906,320.862,243.219,320.862z "></path> <path d="M243.219,344.306h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S239.906,344.306,243.219,344.306z "></path> <path d="M243.219,367.75h80.125c3.313,0,6-2.687,6-6s-2.687-6-6-6h-80.125c-3.313,0-6,2.687-6,6S239.906,367.75,243.219,367.75z"></path> <path d="M427.5,144.75h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S430.814,144.75,427.5,144.75z"></path> <path d="M427.5,168.196h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S430.814,168.196,427.5,168.196z"></path> <path d="M427.5,191.64h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S430.814,191.64,427.5,191.64z"></path> <path d="M427.5,215.084h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S430.814,215.084,427.5,215.084z"></path> <path d="M427.5,238.529h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S430.814,238.529,427.5,238.529z"></path> <path d="M427.5,261.973h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S430.814,261.973,427.5,261.973z"></path> <path d="M427.5,285.417h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S430.814,285.417,427.5,285.417z"></path> <path d="M427.5,308.862h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S430.814,308.862,427.5,308.862z"></path> <path d="M427.5,332.306h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S430.814,332.306,427.5,332.306z"></path> <path d="M427.5,355.75h-9.75c-3.313,0-6,2.687-6,6s2.687,6,6,6h9.75c3.313,0,6-2.687,6-6S430.814,355.75,427.5,355.75z"></path> </g> </g></svg>
                                        </span>
                                </c:when>
                                <c:when test="${item.category eq '단독주택'}">
                                    <span data-toggle="tooltip" data-placement="top" title="단독주택">
                                        <svg fill="#000000" height="30" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 459 459" xml:space="preserve"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g> <path d="M453,127.15H217.92l-53.481-42.977c-2.195-1.764-5.321-1.764-7.517,0L114,118.665V107.15c0-3.313-2.687-6-6-6H61 c-3.313,0-6,2.687-6,6v58.927L2.242,208.473c-1.984,1.595-2.747,4.268-1.901,6.669S3.454,219.15,6,219.15h28v151 c0,3.313,2.686,6,6,6h413c3.314,0,6-2.687,6-6v-237C459,129.836,456.314,127.15,453,127.15z M447,139.15v68H317.473l-84.62-68H447z M67,113.15h35v15.158l-35,28.126V113.15z M160.681,96.547L298.317,207.15h-12.768l-121.107-97.321 c-2.195-1.764-5.321-1.764-7.517,0L35.819,207.15H23.045L160.681,96.547z M232,364.15h-36v-92h36V364.15z M421,286.65H307v-14.5 h114V286.65z M307,298.65h114v13.5H307V298.65z M307,324.15h114v13.5H307V324.15z M307,349.65h114v14.5H307V349.65z M447,364.15 h-14v-98c0-3.313-2.687-6-6-6H301c-3.313,0-6,2.687-6,6v98h-51v-98c0-3.313-2.686-6-6-6h-48c-3.314,0-6,2.687-6,6v98H46V214.362 l114.684-92.159l118.995,95.624c1.065,0.856,2.392,1.323,3.758,1.323H447V364.15z"></path> <path d="M140,246.15H81c-3.313,0-6,2.687-6,6v59c0,3.313,2.687,6,6,6h59c3.313,0,6-2.687,6-6v-59 C146,248.836,143.314,246.15,140,246.15z M87,258.15h22v47H87V258.15z M134,305.15h-13v-47h13V305.15z"></path> </g> </g></svg>
                                    </span>
                                </c:when>
                                <c:when test="${item.category eq '빌라'}">
                                    <span data-toggle="tooltip" data-placement="top" title="빌라">
                                        <svg fill="#000000" height="30" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 456 456" xml:space="preserve"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g> <path d="M163.142,126.851h44.812c3.313,0,6-2.687,6-6V50c0-3.313-2.687-6-6-6h-44.812c-3.313,0-6,2.687-6,6v70.851 C157.142,124.165,159.828,126.851,163.142,126.851z M169.142,75h10.409v39.851h-10.409V75z M191.55,114.851V75h10.403v39.851 H191.55z M201.953,56v7h-32.812v-7H201.953z"></path> <path d="M248.047,126.851h44.812c3.313,0,6-2.687,6-6V50c0-3.313-2.687-6-6-6h-44.812c-3.313,0-6,2.687-6,6v70.851 C242.047,124.165,244.734,126.851,248.047,126.851z M254.047,75h10.406v39.851h-10.406V75z M276.453,114.851V75h10.406v39.851 H276.453z M286.859,56v7h-32.812v-7H286.859z"></path> <path d="M163.142,223.234h44.812c3.313,0,6-2.687,6-6v-70.851c0-3.313-2.687-6-6-6h-44.812c-3.313,0-6,2.687-6,6v70.851 C157.142,220.547,159.828,223.234,163.142,223.234z M169.142,171.667h10.409v39.567h-10.409V171.667z M191.55,211.234v-39.567 h10.403v39.567H191.55z M201.953,152.383v7.284h-32.812v-7.284H201.953z"></path> <path d="M248.047,223.234h44.812c3.313,0,6-2.687,6-6v-70.851c0-3.313-2.687-6-6-6h-44.812c-3.313,0-6,2.687-6,6v70.851 C242.047,220.547,244.734,223.234,248.047,223.234z M254.047,171.667h10.406v39.567h-10.406V171.667z M276.453,211.234v-39.567 h10.406v39.567H276.453z M286.859,152.383v7.284h-32.812v-7.284H286.859z"></path> <path d="M163.142,319.617h44.812c3.313,0,6-2.687,6-6v-70.851c0-3.313-2.687-6-6-6h-44.812c-3.313,0-6,2.687-6,6v70.851 C157.142,316.93,159.828,319.617,163.142,319.617z M169.142,268.333h10.409v39.284h-10.409V268.333z M191.55,307.617v-39.284 h10.403v39.284H191.55z M201.953,248.766v7.567h-32.812v-7.567H201.953z"></path> <path d="M248.047,319.617h44.812c3.313,0,6-2.687,6-6v-70.851c0-3.313-2.687-6-6-6h-44.812c-3.313,0-6,2.687-6,6v70.851 C242.047,316.93,244.734,319.617,248.047,319.617z M254.047,268.333h10.406v39.284h-10.406V268.333z M276.453,307.617v-39.284 h10.406v39.284H276.453z M286.859,248.766v7.567h-32.812v-7.567H286.859z"></path> <path d="M163.142,416h44.812c3.313,0,6-2.687,6-6v-70.851c0-3.313-2.687-6-6-6h-44.812c-3.313,0-6,2.687-6,6V410 C157.142,413.313,159.828,416,163.142,416z M169.142,365h10.409v39h-10.409V365z M191.55,404v-39h10.403v39H191.55z M201.953,345.149V353h-32.812v-7.851H201.953z"></path> <path d="M353,0H103c-3.314,0-6,2.686-6,6v20c0,3.314,2.686,6,6,6h17.585v418c0,3.314,2.686,6,6,6h202.831c3.313,0,6-2.686,6-6V32 H353c3.314,0,6-2.686,6-6V6C359,2.686,356.314,0,353,0z M286.859,373.409C285.815,372.531,284.47,372,283,372c-3.313,0-6,2.687-6,6 v11c0,3.313,2.687,6,6,6c1.47,0,2.815-0.531,3.859-1.409V425h-32.812v-79.85h32.812V373.409z M254.047,437h32.812v7h-32.812V437z M323.416,444h-24.557v-98.85h2.594c3.313,0,6-2.687,6-6s-2.687-6-6-6h-62c-3.313,0-6,2.687-6,6s2.687,6,6,6h2.594V444H132.585V32 h190.831V444z M347,20H109v-8h238V20z"></path> </g> </g></svg>
                                    </span>
                                </c:when>
                                <c:when test="${item.category eq '오피스텔'}">
                                    <span data-toggle="tooltip" data-placement="top" title="오피스텔">
                                        <svg fill="#000000" height="25" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 440 440" xml:space="preserve"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g> <path d="M432.5,0h-128c-3.313,0-6,2.686-6,6v43h-157V6c0-3.314-2.686-6-6-6H7.5c-3.314,0-6,2.686-6,6v428c0,3.314,2.686,6,6,6h425 c3.313,0,6-2.686,6-6V6C438.5,2.686,435.814,0,432.5,0z M129.5,428h-116V12h116V428z M298.5,61v367H284v-92c0-3.313-2.687-6-6-6 H162c-3.313,0-6,2.687-6,6v92h-14.5V61H298.5z M236.5,342v10h-33v-10H236.5z M272,342v10h-23.5v-10H272z M191.5,352H168v-10h23.5 V352z M168,364h23.5v64H168V364z M203.5,364h33v64h-33V364z M248.5,364H272v64h-23.5V364z M426.5,428h-116V12h116V428z"></path> <path d="M162,313h116c3.313,0,6-2.687,6-6v-36.526c0-3.313-2.687-6-6-6H162c-3.313,0-6,2.687-6,6V307 C156,310.313,158.686,313,162,313z M203.5,301v-24.526h33V301H203.5z M272,301h-23.5v-24.526H272V301z M168,276.474h23.5V301H168 V276.474z"></path> <path d="M162,250.842h116c3.313,0,6-2.687,6-6v-36.526c0-3.313-2.687-6-6-6H162c-3.313,0-6,2.687-6,6v36.526 C156,248.155,158.686,250.842,162,250.842z M203.5,238.842v-24.526h33v24.526H203.5z M272,238.842h-23.5v-24.526H272V238.842z M168,214.316h23.5v24.526H168V214.316z"></path> <path d="M162,188.684h116c3.313,0,6-2.687,6-6v-36.526c0-3.313-2.687-6-6-6H162c-3.313,0-6,2.687-6,6v36.526 C156,185.997,158.686,188.684,162,188.684z M203.5,176.684v-24.526h33v24.526H203.5z M272,176.684h-23.5v-24.526H272V176.684z M168,152.158h23.5v24.526H168V152.158z"></path> <path d="M162,126.526h116c3.313,0,6-2.687,6-6V84c0-3.313-2.687-6-6-6H162c-3.313,0-6,2.687-6,6v36.526 C156,123.839,158.686,126.526,162,126.526z M203.5,114.526V90h33v24.526H203.5z M272,114.526h-23.5V90H272V114.526z M168,90h23.5 v24.526H168V90z"></path> <path d="M53,404h37c3.313,0,6-2.687,6-6V39c0-3.313-2.687-6-6-6H53c-3.313,0-6,2.687-6,6v359C47,401.313,49.686,404,53,404z M59,392v-32.875h25V392H59z M84,134.75v32.875H59V134.75H84z M59,122.75V89.875h25v32.875H59z M84,179.625V212.5H59v-32.875H84z M84,224.5v32.875H59V224.5H84z M84,269.375v32.875H59v-32.875H84z M84,314.25v32.875H59V314.25H84z M84,45v32.875H59V45H84z"></path> <path d="M350,404h37c3.313,0,6-2.687,6-6V39c0-3.313-2.687-6-6-6h-37c-3.313,0-6,2.687-6,6v359C344,401.313,346.687,404,350,404z M356,392v-32.875h25V392H356z M381,134.75v32.875h-25V134.75H381z M356,122.75V89.875h25v32.875H356z M381,179.625V212.5h-25 v-32.875H381z M381,224.5v32.875h-25V224.5H381z M381,269.375v32.875h-25v-32.875H381z M381,314.25v32.875h-25V314.25H381z M381,45 v32.875h-25V45H381z"></path> </g> </g></svg>
                                    </span>
                                </c:when>
                            </c:choose>
                        </div>

                        <div class="row d-flex">
                            <div class="col-auto"><img height="150px" src="<c:url value="/imgs/${item.image1Name}"/>" alt="대표사진"></div>
                            <span><img height="150px" src="<c:url value="/imgs/${item.image2Name}"/>" alt="세부사진1"></span>
                            <span><img height="150px" src="<c:url value="/imgs/${item.image3Name}"/>" alt="세부사진2"></span>
                            <span><img height="150px" src="<c:url value="/imgs/${item.image4Name}"/>" alt="세부사진3"></span>
                            <span><img height="150px" src="<c:url value="/imgs/${item.image5Name}"/>" alt="세부사진4"></span>
                        </div>
                        <div class="row" style="margin-top: 10px;">
                            <div style="display: flex; gap: 10px;">
                                <button onclick="space_get.modSpace(${item.accommodationId})" type="button" class="btn btn-primary" style="width:50%;">수정하기</button>
                                <button onclick="space_get.delSpace(${item.accommodationId})" type="button" class="btn btn-danger" style="width:50%;">삭제하기</button>
                            </div>
                        </div>
                        <div class="row">
                            <div>최초 등록: ${item.createDay}</div>
                            <div>최종 수정:${item.updateDay}</div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            </div>--%>
        </div>
        <jsp:include page="../page.jsp"/>
        <div class="d-flex justify-content-center" style="padding-bottom:15px;">
            <small class="text-muted">${cpage.pageNum} - ${cpage.pages}</small>
        </div>

    </div>
</div>
