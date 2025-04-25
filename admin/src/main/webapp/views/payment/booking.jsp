<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .card {
        position: relative;
        background: linear-gradient(to bottom, #f7f8fa, #e1e6eb); /* 그라데이션 배경 */
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .card:hover {
        transform: translateY(-10px); /* 카드 호버시 살짝 위로 올라오는 효과 */
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 */
    }

    .card-img-top {
        object-fit: cover;
        height: 180px; /* 이미지 고정 크기 */
    }

    .card-title {
        font-size: 1.1rem;
        color: #333;
    }

    .card-text {
        font-size: 0.9rem;
        color: #ffffff;
    }

    .btn-primary {
        background-color: #696cff;
        border: none;
        border-radius: 30px;
    }

    .btn-primary:hover {
        background-color: #696cff;
    }
</style>

<div class="container my-4">
    <h3 class="mb-4">내 스페이스 예약 조회</h3>
    <div class="row">
        <c:forEach var="pay" items="${payments}">
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card h-100 shadow-sm border-0 rounded-lg overflow-hidden">
                    <!-- 카드 상단 이미지 -->
                    <img src="${pageContext.request.contextPath}/imgs/${pay.image1Name}"
                         class="card-img-top" alt="${pay.name}">
                    <div class="card-body text-center p-4">
                        <h5 class="card-title font-weight-bold mb-3">${pay.name}</h5>
                        <p class="card-text text-muted mb-3">${pay.location}</p>
                        <a href="<c:url value='/payment/detail?accommodationId=${pay.accommodationId}'/>"
                           class="btn btn-primary btn-block py-2 d-flex justify-content-center align-items-center">
                            예약 내역 보기
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>