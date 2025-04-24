<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container my-4">
    <h3 class="mb-4">스페이스 예약 내역 조회</h3>
    <div class="row">
        <c:forEach var="pay" items="${payments}">
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <h5 class="card-title">스페이스 번호: ${pay.accommodationId}</h5>
                        <a href="<c:url value='/payment/detail?accommodationId=${pay.accommodationId}'/>"
                           class="btn btn-primary mt-2">
                            예약 내역 보기
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
