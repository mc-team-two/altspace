<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
    <p class="text-muted">결제 내역 > <strong>결제 내역 조회</strong></p>
    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table id="paymentsTable" class="table table-hover">
                    <thead>
                        <tr>
                            <th>스페이스</th>
                            <th>체크인</th>
                            <th>체크아웃</th>
                            <th>금액</th>
                            <th>결제수단</th>
                            <th>결제시각</th>
                            <th>결제상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="it" items="${payments}">
                        <tr>
                            <td><a href="<c:url value="/space/detail?id=${it.accommodationId}"/>">${it.name}</a></td>
                            <td>${it.checkIn}</td>
                            <td>${it.checkOut}</td>
                            <td data-order="${it.payAmount}">
                                <fmt:formatNumber value="${it.payAmount}" type="number" groupingUsed="true"/>원
                            </td>
                            <td>${it.payMeans}</td>
                            <td><small>${it.createDay}</small></td>
                            <td>
                                <span style="
                                    <c:choose>
                                        <c:when test='${it.payStatus == "완료"}'>color: green;</c:when>
                                        <c:when test='${it.payStatus == "취소"}'>color: orange;</c:when>
                                        <c:when test='${it.payStatus == "환불"}'>color: red;</c:when>
                                    </c:choose>
                                ">
                                    ${it.payStatus}
                                </span>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    $(function(){
        new DataTable('#paymentsTable', {
            language: {
                search: "검색:",
                lengthMenu: "페이지당 _MENU_ 개 보기",
                zeroRecords: "검색 결과가 없습니다.",
                info: "전체 _TOTAL_개 중 _START_ ~ _END_",
                infoEmpty: "데이터 없음",
                infoFiltered: "(총 _MAX_개 중 필터링됨)",
                paginate: {
                    first: "처음",
                    last: "마지막",
                    next: "다음",
                    previous: "이전"
                }
            },
            order: [[5, 'desc']] // 결제시각 기준 내림차순 정렬
        });
    });

    // Custom filter
    $.fn.dataTable.ext.search.push(function (settings, data, dataIndex) {
        const statusText = data[6]; // 7번째 열 (0-based index)
        if (!currentStatus || currentStatus === "전체") {
            return true;
        }
        return statusText.trim() === currentStatus;
    });

    // 버튼 클릭 필터링
    $('.filter-btn').on('click', function () {
        $('.filter-btn').removeClass('active');
        $(this).addClass('active');

        currentStatus = $(this).data('status') || "전체";
        table.draw();
    });

</script>
