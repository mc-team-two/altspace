<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
    <p class="text-muted">결제 내역 > 결제 내역 조회</p>

    <!-- ✅ 상단 요약 박스 -->
    <div class="row text-center mb-4">
        <div class="col">
            <div class="border rounded py-3">
                <strong>결제 완료</strong>
                <div class="text-success fs-4">
                    <c:out value="${statusCounts.완료}" default="0"/>건
                </div>
            </div>
        </div>
        <div class="col">
            <div class="border rounded py-3">
                <strong>취소</strong>
                <div class="text-warning fs-4">
                    <c:out value="${statusCounts.취소}" default="0"/>건
                </div>
            </div>
        </div>
        <div class="col">
            <div class="border rounded py-3">
                <strong>환불</strong>
                <div class="text-danger fs-4">
                    <c:out value="${statusCounts.환불}" default="0"/>건
                </div>
            </div>
        </div>
    </div>

    <!-- ✅ 필터 영역 -->
    <div class="d-flex flex-wrap align-items-center mb-3 gap-2 justify-content-center">
        <div class="btn-group">
            <button class="btn btn-outline-primary date-btn" data-months="1">1개월</button>
            <button class="btn btn-outline-primary date-btn" data-months="3">3개월</button>
            <button class="btn btn-outline-primary date-btn" data-months="6">6개월</button>
            <button class="btn btn-outline-primary date-btn" data-months="12">12개월</button>
        </div>
        <input type="date" id="startDate" class="form-control" style="width: 160px;" />
        <span>~</span>
        <input type="date" id="endDate" class="form-control" style="width: 160px;" />
        <button id="searchBtn" class="btn btn-dark">조회 🔍</button>
    </div>

    <!-- ✅ 테이블 -->
    <div class="card">
        <div class="card-body table-responsive">
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
                        <td><a href="<c:url value='/space/detail?id=${it.accommodationId}'/>">${it.name}</a></td>
                        <td>${it.checkIn}</td>
                        <td>${it.checkOut}</td>
                        <td data-order="${it.payAmount}">
                            <fmt:formatNumber value="${it.payAmount}" type="number" groupingUsed="true"/>원
                        </td>
                        <td>${it.payMeans}</td>
                        <td data-date="${it.createDay}"><small>${it.createDay}</small></td>
                        <td data-status="${it.payStatus}">
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
<script>
    $(function () {
        let currentStatus = "전체";
        let startDate = null;
        let endDate = null;

        // DataTable 초기화
        const table = $('#paymentsTable').DataTable({
            dom: 'lfrtip',
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
            order: [[5, 'desc']] // 결제시각 컬럼 기준 정렬
        });

        // ✅ 사용자 정의 필터 함수 추가
        // $.fn.dataTable.ext.search를 사용해서 테이블에 필터링 규칙을 추가합니다.
        $.fn.dataTable.ext.search.push(
            function( settings, data, dataIndex ) {
                const rowStatus = data[6]; // '결제상태' 컬럼의 데이터 (인덱스 6)
                const rowDate = new Date(data[5]); // '결제시각' 컬럼의 데이터 (인덱스 5)를 Date 객체로 변환

                // 상태 필터 적용 (선택된 상태가 '전체'이거나, 행의 상태가 선택된 상태와 일치하는 경우)
                const statusMatch = (currentStatus === "전체" || rowStatus === currentStatus);

                // 날짜 필터 적용
                let dateMatch = true; // 기본적으로 날짜 필터는 통과

                // 시작 날짜가 설정되어 있으면, 행의 날짜가 시작 날짜보다 크거나 같아야 함
                if (startDate) {
                    const start = new Date(startDate);
                    // 시간을 00:00:00으로 설정하여 날짜 자체만 비교하도록 함
                    start.setHours(0, 0, 0, 0);
                    // 행의 날짜도 시간을 00:00:00으로 설정
                    const rowDateOnly = new Date(rowDate);
                    rowDateOnly.setHours(0, 0, 0, 0);

                    if (rowDateOnly < start) {
                        dateMatch = false;
                    }
                }

                // 종료 날짜가 설정되어 있으면, 행의 날짜가 종료 날짜보다 작거나 같아야 함
                if (endDate) {
                    const end = new Date(endDate);
                    // 시간을 23:59:59.999으로 설정하여 해당 날짜의 끝까지 포함하도록 함
                    end.setHours(23, 59, 59, 999);
                    // 행의 날짜도 시간을 설정
                    const rowDateWithTime = new Date(rowDate); // 원래 시간 포함

                    if (rowDateWithTime > end) {
                        dateMatch = false;
                    }
                }

                // 상태 필터와 날짜 필터를 모두 통과한 경우에만 true 반환 (해당 행을 보여줌)
                return statusMatch && dateMatch;
            }
        );

        // ✅ 기간 버튼 클릭 이벤트
        $('.date-btn').on('click', function() {
            const months = $(this).data('months');
            const today = new Date();
            const end = new Date(today); // 오늘 날짜가 종료일
            const start = new Date(today); // 오늘 날짜부터 계산 시작

            start.setMonth(today.getMonth() - months); // 지정된 개월 수 이전으로 설정

            // 날짜 포맷을 YYYY-MM-DD 형식으로 변환하는 함수
            const formatDate = (date) => {
                const d = new Date(date);
                let month = '' + (d.getMonth() + 1);
                let day = '' + d.getDate();
                const year = d.getFullYear();

                if (month.length < 2) month = '0' + month;
                if (day.length < 2) day = '0' + day;

                return [year, month, day].join('-');
            };

            // Date input 필드에 날짜 설정
            $('#startDate').val(formatDate(start));
            $('#endDate').val(formatDate(end));

            // 날짜 변수 업데이트 및 조회 버튼 클릭
            startDate = formatDate(start);
            endDate = formatDate(end);
            $('#searchBtn').click(); // 날짜 설정 후 조회 버튼 클릭 효과
        });

        // // ✅ 상태 선택 변경 이벤트 (조회 버튼 클릭 시 반영되도록)
        // $('#statusSelect').on('change', function() {
        //     currentStatus = $(this).val(); // 상태 변수만 업데이트
        //     // table.draw(); // 상태 변경 시 바로 필터링하려면 이 주석을 해제하세요.
        //     // 현재는 조회 버튼 클릭 시 반영되도록 합니다.
        // });

        // ✅ 조회 버튼 클릭 이벤트
        $('#searchBtn').on('click', function() {
            // 날짜 입력 필드의 값을 가져와서 전역 변수 업데이트
            startDate = $('#startDate').val();
            endDate = $('#endDate').val();
            // 상태 선택 필드의 값을 가져와서 전역 변수 업데이트
            //currentStatus = $('#statusSelect').val();

            // DataTables에 필터를 다시 적용하여 화면을 업데이트
            table.draw();
        });

        // ✅ 날짜 입력 필드 변경 시 이벤트 (선택 사항)
        // 날짜 입력 필드에서 직접 날짜를 선택했을 때 변수 업데이트
        $('#startDate, #endDate').on('change', function() {
            // startDate = $('#startDate').val(); // 조회 버튼 클릭 시 업데이트되므로 여기서 굳이 안 해도 됨
            // endDate = $('#endDate').val();   // 조회 버튼 클릭 시 업데이트되므로 여기서 굳이 안 해도 됨
        });

    });

</script>
