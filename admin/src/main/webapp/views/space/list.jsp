<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
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
--%>

<div class="container">
    <p class="text-muted">공간 관리 > 내 공간 관리</p>
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

<%-- ======== 삭제 확인 모달 시작 ======== --%>
<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">삭제 확인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>공간을 삭제하시려면 계정 비밀번호를 입력해주세요.</p>
                <%-- 삭제할 공간 ID를 저장할 숨겨진 필드 --%>
                <input type="hidden" id="deleteAccommodationId">
                <div class="mb-3">
                    <label for="deletePasswordInput" class="form-label">비밀번호</label>
                    <input type="password" class="form-control" id="deletePasswordInput" required>
                </div>
                <%-- 오류 메시지 표시 영역 --%>
                <div id="deleteErrorMsg" class="alert alert-danger d-none" role="alert">
                    오류 메시지가 여기에 표시됩니다.
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-danger" id="confirmDeleteBtn">삭제 확인</button>
            </div>
        </div>
    </div>
</div>

<%-- ... JSP 상단 코드 ... --%>

<script>
    const space_get = {
        // 삭제할 공간 ID를 임시 저장할 변수
        currentAccIdToDelete: null,
        // 모달 인스턴스를 저장할 변수
        deleteModalInstance: null,

        init: function () {
            // 모달 인스턴스 초기화
            const modalElement = document.getElementById('deleteConfirmModal');
            if (modalElement) {
                this.deleteModalInstance = new bootstrap.Modal(modalElement);

                // 모달이 닫힐 때 입력 필드와 오류 메시지 초기화
                modalElement.addEventListener('hidden.bs.modal', event => {
                    $('#deletePasswordInput').val('');
                    $('#deleteErrorMsg').addClass('d-none').text('');
                    this.currentAccIdToDelete = null; // 저장된 ID 초기화
                });
            }

            // 모달의 '삭제 확인' 버튼 클릭 이벤트 핸들러
            $('#confirmDeleteBtn').on('click', () => {
                // 👇 변경: 비밀번호와 함께 삭제 요청 보내는 함수 호출
                this.deleteWithPassword();
            });
        },
        modSpace: function (accId) {
            // detail 페이지로 이동
            window.location.href = "/space/detail?id=" + accId;
        },
        // 삭제 버튼 클릭 시 모달을 보여주는 함수
        showDeleteModal: function (accId) {
            if (!this.deleteModalInstance) {
                console.error("Delete modal instance not initialized.");
                return;
            }
            // 현재 삭제할 ID 저장
            this.currentAccIdToDelete = accId;
            // 모달 표시
            this.deleteModalInstance.show();
        },
        // 👇 변경: 비밀번호와 함께 삭제 요청을 보내는 함수
        deleteWithPassword: function () {
            const password = $('#deletePasswordInput').val();
            const accId = this.currentAccIdToDelete;
            const errorMsgDiv = $('#deleteErrorMsg');

            // 입력값 유효성 검사
            if (!password) {
                errorMsgDiv.text('비밀번호를 입력해주세요.').removeClass('d-none');
                return;
            }
            if (!accId) {
                errorMsgDiv.text('삭제할 공간 정보가 없습니다. 다시 시도해주세요.').removeClass('d-none');
                return;
            }

            // 오류 메시지 숨김 처리
            errorMsgDiv.addClass('d-none');

            // AJAX 요청: /space/del 로 accId와 password 전송
            $.ajax({
                url: "<c:url value='/space/del'/>", // URL 변경: 쿼리 파라미터 제거
                type: "POST",
                contentType: "application/json", // JSON 형태로 데이터 전송
                data: JSON.stringify({ // 요청 본문에 데이터 포함
                    accommodationId: accId,
                    password: password
                }),
                success: (response) => {
                    // 성공 시
                    alert(response || "성공적으로 삭제되었습니다.");
                    // 모달 닫기
                    if (this.deleteModalInstance) {
                        this.deleteModalInstance.hide();
                    }
                    // 페이지 새로고침
                    window.location.reload();
                },
                error: (xhr) => {
                    // 실패 시 (비밀번호 불일치, 서버 오류 등)
                    let errorText = '삭제 처리 중 오류가 발생했습니다.';
                    if (xhr.status === 401) { // 401 Unauthorized (비밀번호 불일치)
                        errorText = xhr.responseText || '비밀번호가 일치하지 않습니다.';
                    } else if (xhr.responseText) {
                        errorText = xhr.responseText;
                    }
                    // 모달 내부에 오류 메시지 표시
                    errorMsgDiv.text(errorText).removeClass('d-none');
                }
            });
        }
        // 👇 삭제: 기존 verifyPasswordAndDelete 와 performActualDelete 함수 제거
        /*
        verifyPasswordAndDelete: function () { ... },
        performActualDelete: function (accId) { ... }
        */
    };

    $(function () {
        space_get.init();
    });
</script>
