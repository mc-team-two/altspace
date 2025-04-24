<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>예약 달력</title>
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/main.min.css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
</head>
<body>
<div class="container my-4">
    <h3 class="mb-4">스페이스 ${filteredId} 예약 달력</h3>
    <a href="<c:url value='/payment/booking'/>" class="btn btn-outline-secondary btn-sm mb-3">내 스페이스 목록</a>
    <div id="calendar"></div>
</div>

<style>
    #calendar { max-width: 900px; margin: 0 auto; }
</style>

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/main.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const events = [
            <c:forEach var="pay" items="${payments}" varStatus="loop">
            <c:if test="${pay.payStatus eq '완료'}">
            {
                title: '예약 (${pay.payStatus}) - ${pay.payAmount}원',
                start: '${pay.checkIn}',
                end: '${pay.checkOut}',
                color: '#28a745'
            }<c:if test="${!loop.last}">,</c:if>
            </c:if>
            </c:forEach>
        ];

        const calendarEl = document.getElementById('calendar');
        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'ko',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,listMonth'
            },
            events: events
        });
        calendar.render();
    });
</script>

</body>
</html>
