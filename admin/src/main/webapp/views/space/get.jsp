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
        <div class="card-header py-3">
            <h2>스페이스 목록 조회 탭</h2>
            <p>총 ${fn:length(data)}개의 검색결과</p>
        </div>
        <div class="card-body">
            <c:forEach var="item" items="${data}" varStatus="status">
                <div class="card" style="background-color:#eeeeee;margin-bottom:15px;">
                    <div class="card-header">
                        <div class="row">
                            <div class="col-sm-10">
                                <h2>#${status.count}. ${item.name}</h2>
                            </div>
                            <div class="col-sm-2">
                                <button type="button">펼치기</button>
                                <button type="button">접기</button>
                            </div>
                            <hr>
                        </div>
                    </div>

                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-8">
                                <p><img width="100%;" src="<c:url value='/imgs/타오1.jpg'/>" alt="대표사진"></p>
                                <div style="display:flex; flex-direction: row;">
                                    <span><img width="100%" src="<c:url value='/imgs/타오2.jpg'/>" alt="사진2"></span>
                                    <span><img width="100%" src="<c:url value='/imgs/타오3.jpg'/>" alt="사진3"></span>
                                    <span><img width="100%" src="<c:url value='/imgs/타오4.jpg'/>" alt="사진4"></span>
                                    <span><img width="100%" src="<c:url value='/imgs/타오5.jpg'/>" alt="사진5"></span>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div>숙소 명칭: ${item.name}</div>
                                <div>위치: ${item.location}</div>
                                <div>위도: ${item.latitude}</div>
                                <div>경도: ${item.longitude}</div>
                                <div>소개글: ${item.description}</div>
                                <div>최대 수용 인원: ${item.personMax}</div>
                                <div>1박당 요금: <fmt:formatNumber value="${item.priceNight}" pattern="#,###"/>원</div>
                                <div>예약 접수 상태: ${item.status}</div>
                                <div>건물 유형: ${item.category}</div>
                                <div>객실 유형: ${item.roomType}</div>
                                <div>제공 옵션:
                                    <c:if test="${item.breakfast}"><span>#조식제공</span></c:if>
                                    <c:if test="${item.pool}"><span>#수영장</span></c:if>
                                    <c:if test="${item.pet}"><span>#반려동물동반가능</span></c:if>
                                    <c:if test="${item.barbecue}"><span>#바베큐그릴제공</span></c:if>
                                </div>
                            </div>
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
        </div>
    </div>
</div>
