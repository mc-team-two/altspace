<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>

</script>

<div class="col-sm-12">
    <table class="table table-hover">
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
            <td>${it.accommodationId}</td>
            <td>${it.checkIn}</td>
            <td>${it.checkOut}</td>
            <td><fmt:formatNumber value="${it.payAmount}" type="number" groupingUsed="true"/>원</td>
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
        </tr>
        </c:forEach>
        </tbody>
    </table>
</div>