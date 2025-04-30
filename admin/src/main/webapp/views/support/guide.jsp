<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .rotate-icon {
        transition: transform 0.3s ease;
    }
    .rotate-icon.rotate {
        transform: rotate(180deg);
    }
    .guide-content {
        background-color: #f8f9fa;
        padding: 15px;
        border-radius: 8px;
        margin-top: 5px;
        animation: fadeIn 0.3s ease-in-out;
    }
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(-5px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>

<script>
    document.querySelectorAll('.guide-header').forEach(row => {
        row.addEventListener('click', function (e) {
            e.preventDefault();
            const targetId = this.getAttribute('data-target');
            const collapseEl = document.querySelector(targetId);
            const icon = this.querySelector('.rotate-icon');

            // collapseEl이 null이 아닌지 확인
            if (collapseEl) {
                const bsCollapse = new bootstrap.Collapse(collapseEl, { toggle: false });
                const isShown = collapseEl.classList.contains('show');

                // 모두 닫기
                document.querySelectorAll('.collapse.show').forEach(openEl => {
                    if (openEl !== collapseEl) {
                        // 닫히는 애니메이션 추가
                        new bootstrap.Collapse(openEl).hide();
                        openEl.previousElementSibling?.querySelector('.rotate-icon')?.classList.remove('rotate');
                    }
                });

                // 현재 항목은 토글
                if (isShown) {
                    // 닫히는 애니메이션
                    bsCollapse.hide();
                    icon.classList.remove('rotate');
                } else {
                    // 여는 애니메이션
                    bsCollapse.show();
                    icon.classList.add('rotate');
                }
            } else {
                console.error(`collapseEl for targetId "${targetId}" not found.`);
            }
        });
    });
</script>

<div class="col-sm-12 mx-auto">
    <p class="text-muted mb-4 fs-6">
        호스트 센터 &nbsp;&nbsp;>&nbsp;&nbsp; <strong>운영 가이드</strong>
    </p>

    <!-- 가이드 테이블 영역 -->
    <div class="card shadow-sm border-0 rounded-4">
        <div class="card-body p-4">

            <div class="accordion" id="guideAccordion">
                <table class="table table-hover align-middle text-center fs-6">
                    <thead class="table-light">
                    <tr>
                        <th style="width: 10%; font-size: 14px;">번호</th>
                        <th style="width: 10%; font-size: 14px;">분류</th>
                        <th style="width: 85%; font-size: 14px;">제목</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="g" items="${guides}">
                        <tr class="guide-header" data-bs-toggle="collapse" data-bs-target="#content${g.guideNumber}" aria-expanded="false" aria-controls="content${g.guideNumber}" style="cursor: pointer;">
                            <td>${g.guideNumber}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${g.guideCategory == '운영'}"><i class="bx bx-cog me-1"></i> 운영</c:when>
                                    <c:when test="${g.guideCategory == '예약'}"><i class="bx bx-calendar me-1"></i> 예약</c:when>
                                    <c:when test="${g.guideCategory == '결제'}"><i class="bx bx-credit-card me-1"></i> 결제</c:when>
                                    <c:otherwise><i class="bx bx-help-circle me-1"></i> ${g.guideCategory}</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-start">
                                    ${g.guideTitle}
                                <i class="bi bi-chevron-down ms-2 rotate-icon float-end" id="icon${g.guideNumber}"></i>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="p-0">
                                <div id="content${g.guideNumber}" class="accordion-collapse collapse" data-bs-parent="#guideAccordion">
                                    <div class="guide-content">
                                            ${g.guideContent}
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- 검색창 (우측 하단) -->
    <div class="d-flex justify-content-end mt-3">
        <form action="<c:url value='/support/guide'/>" method="get" class="d-flex gap-2 align-items-center mt-3">
            <input type="text" name="keyword" class="form-control" placeholder="운영 가이드를 검색해 보세요"
                   value="${param.keyword}" style="max-width: 300px;">
            <button type="submit" class="btn btn-primary" style="min-width: 100px;">검색</button>
        </form>
    </div>

</div>
