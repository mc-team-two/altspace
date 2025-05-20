<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- ✅ FullCalendar 스타일 -->
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/main.min.css" rel="stylesheet"/>

<style>
    #calendar {
        max-width: 900px;
        margin: 0 auto;
    }
    label {
        cursor: pointer;
    }
    .fc-daygrid-event {
        margin-bottom: 5px;
        padding: 2px;

/*        display: block;
        padding: 8px;
        font-size: 16px;
        border-radius: 6px;
        line-height: 1.6;
        height: auto;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;*/
    }
    .event-count {
        color: #6c757d;
        font-weight: normal;
    }
</style>

<script>
    const bookingPage = {
        events: [],
        calendar: null,
        lastFetchTime: null,
        init: function () {
            this.makeCalendar();
            this.bindEvents();
            this.loadData();
        },

        // ajax 요청 (data)
        loadData: function () {
            this.lastFetchTime = new Date(); // 기준 시간 저장

            $.ajax({
                url: "<c:url value='/api/booking/reservations'/>",
                data: { hostId: "${sessionScope.user.userId}" },
                success: (resp) => {
                    bookingPage.bindCounts(resp);
                    bookingPage.populateEvents(resp);
                    bookingPage.updateTimestamp();
                },
                error: (xhr) => { alert(xhr.responseText); }
            });
        },

        // 캘린더 만들기
        makeCalendar: function () {
            const calendarEl = document.getElementById("calendar");

            this.calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                locale: 'ko',
                displayEventTime: false,
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,listMonth'
                },
                eventDisplay: 'block', // Ensures events take up block space
                eventBackgroundColor: '#f8f9fa', // 모든 이벤트의 기본 배경색 (bg-light)
                eventBorderColor: '#ced4da',   // 모든 이벤트의 테두리 색상 (연한 회색)
                events: [],  // 초기 빈 이벤트
                eventContent: function(arg) {
                    // 현재 렌더링되는 이벤트 세그먼트의 날짜 (시간 정보 제거)
                    const segmentDate = new Date(arg.date);
                    segmentDate.setHours(0, 0, 0, 0);

                    // 이벤트의 실제 시작 날짜 (시간 정보 제거)
                    // arg.event.start가 null일 수 있으므로 방어 코드 추가
                    const eventStartDate = arg.event.start ? new Date(arg.event.start) : null;
                    if (eventStartDate) {
                        eventStartDate.setHours(0, 0, 0, 0);
                    }

                    // 이벤트의 실제 시작일과 현재 세그먼트의 날짜가 동일하거나,
                    // eventStartDate가 유효하지 않은 경우 (오류 방지 차원에서 일단 표시)
                    // 또는 arg.isStart가 true인 경우 (FullCalendar v5+ 에서 제공) 제목 표시
                    if (arg.isStart || (eventStartDate && segmentDate.getTime() === eventStartDate.getTime()) || !eventStartDate) {
                        return { html: arg.event.title || '' }; // 원래 제목 HTML 반환 (null 방지)
                    } else {
                        // 그 외의 경우에는 빈 HTML을 반환하여 제목을 숨김
                        // FullCalendar는 여전히 이벤트 블록의 배경색과 테두리를 렌더링함
                        return { html: '&nbsp;' }; // 공간 유지 명시
                    }
                },
                eventDidMount: function (info) {
                    // info.el이 없으면 툴팁을 붙일 수 없으므로 반환
                    if (!info.el) {
                        // console.error("Tippy: info.el is null for event", info.event);
                        return;
                    }

                    let ep = info.event.extendedProps;
                    // extendedProps의 값들이 null/undefined일 경우 '정보 없음' 등으로 대체
                    let guestName = ep.guestName || '정보 없음';
                    let location  = ep.location || '정보 없음';
                    let paymentId = ep.paymentId || '정보 없음';

                    // info.event.title이 문자열이 아니거나 비어있을 경우 대체 텍스트 사용
                    let eventTitleForTooltip = (typeof info.event.title === 'string' && info.event.title.trim() !== '') ? info.event.title : '(제목 없음)';

                    let tooltipContent =
                        '<div style="font-weight:bold; margin-bottom:4px;">' +
                        eventTitleForTooltip + // 툴팁에는 항상 전체 제목 표시
                        '</div>' +
                        '<div>게스트: ' + guestName + '</div>' +
                        '<div>위치: '   + location  + '</div>' +
                        '<div>결제ID: ' + paymentId + '</div>';

                    try {
                        tippy(info.el, {
                            content: tooltipContent,
                            allowHTML: true,
                            theme: 'light-border',
                            placement: 'top',
                            delay: [200, 0]
                        });
                    } catch (e) {
                        // console.error("Error initializing tippy:", e, "for element:", info.el, "event:", info.event);
                    }
                }
            });

            this.calendar.render();
        },

        // 이벤트 배열에 데이터 추가
        populateEvents: function (resp) {
            // const eventBackgroundColor = '#f8f9fa'; // makeCalendar에서 전역으로 설정했으므로 제거
            const eventTextColor = '#212529'; // 뱃지가 아닌 텍스트 부분의 색상

            const statusInfo = {
                upcoming:   { text: '예정', badgeClass: 'badge bg-warning text-dark' },
                finished:   { text: '완료', badgeClass: 'badge bg-primary' },
                hostingNow: { text: '진행', badgeClass: 'badge bg-success' },
                canceled:   { text: '취소', badgeClass: 'badge bg-danger' }
            };

            const types = ['upcoming', 'finished', 'hostingNow', 'canceled'];
            this.events = [];

            types.forEach(type => {
                const eventsForType = resp[type]?.data || [];
                eventsForType.forEach(event => {
                    const currentStatusInfo = statusInfo[type];
                    // event.accommodationName이 null이나 undefined일 경우 빈 문자열로 대체
                    const accommodationName = event.accommodationName || '';
                    this.events.push({
                        title: '<span class="' + currentStatusInfo.badgeClass + '">'
                            + currentStatusInfo.text + '</span> '
                            + accommodationName + " #" + event.paymentId,
                        start: event.checkIn,
                        end: event.checkOut,
                        // color: eventBackgroundColor, // 이 줄을 제거하여 전역 eventBackgroundColor 및 eventBorderColor 사용
                        textColor: eventTextColor,   // 제목의 뱃지가 아닌 부분의 텍스트 색상
                        extendedProps: {
                            paymentId: event.paymentId,
                            guestId: event.guestId,
                            guestName: event.guestName,
                            location: event.location,
                            status: type,
                            hostId: event.hostId
                        }
                    });
                });
            });
            this.renderCalendar();
        },

        // 캘린더 갱신
        renderCalendar: function () {
            this.filterEvents();
        },

        // 필터링된 이벤트만 표시
        filterEvents: function () {
            const filters = {
                upcoming: $('#upcoming').is(':checked'),
                finished: $('#finished').is(':checked'),
                hostingNow: $('#hostingNow').is(':checked'),
                canceled: $('#canceled').is(':checked')
            };

            const filteredEvents = this.events.filter(event => {
                const status = event.extendedProps.status;
                if (status === 'upcoming' && filters.upcoming) return true;
                if (status === 'finished' && filters.finished) return true;
                if (status === 'hostingNow' && filters.hostingNow) return true;
                if (status === 'canceled' && filters.canceled) return true;
                return false;
            });

            this.calendar.removeAllEvents();
            this.calendar.addEventSource(filteredEvents);
        },

        // 데이터 기준일자 계산 및 표시
        updateTimestamp: function () {
            const now = new Date();
            const diffMs = now - this.lastFetchTime;
            const diffM = Math.floor(diffMs / 60000);
            let agoText;
            if (diffM < 1) {
                agoText = '방금 전';
            } else if (diffM < 60) {
                agoText = diffM + '분 전';
            } else {
                const diffH = Math.floor(diffM / 60);
                agoText = diffH + '시간 전';
            }

            const pad = n => n.toString().padStart(2,'0');
            const d = this.lastFetchTime;
            const Y = d.getFullYear();
            const M = pad(d.getMonth()+1);
            const D = pad(d.getDate());
            let h = d.getHours();
            const ampm = h >= 12 ? '오후' : '오전';
            h = h % 12 || 12;
            const H = pad(h);
            const m = pad(d.getMinutes());
            const formatted = Y + '-' + M + '-' + D + ' ' + ampm + ' ' + H + ':' + m;

            const text = '데이터 기준일자: ' + agoText + " (" + formatted + ")";
            $('#dataTimestamp').text(text);
        },

        // 사이드바 - 체크박스 이벤트 기능
        bindEvents: function () {
            $('#all').on('change', function () {
                const isChecked = $(this).is(':checked');
                $('#upcoming, #finished, #hostingNow, #canceled').prop('checked', isChecked);
                bookingPage.filterEvents();
            });

            $('#upcoming, #finished, #hostingNow, #canceled').on('change', function () {
                const allChecked = $('#upcoming').is(':checked') &&
                    $('#finished').is(':checked') &&
                    $('#hostingNow').is(':checked') &&
                    $('#canceled').is(':checked');
                $('#all').prop('checked', allChecked);
                bookingPage.filterEvents();
            });
        },

        // 사이드바 - 이벤트 카운트 표시
        bindCounts: function(resp) {
            const updateLabelCount = function(labelId, count) {
                const $label = $('#' + labelId);
                $label.find('span.event-count').remove();
                $label.append(' <span class="event-count">(' + count + ')</span>');
            };

            updateLabelCount('canceledLabel', resp.canceled.count);
            updateLabelCount('upcomingLabel', resp.upcoming.count);
            updateLabelCount('hostingNowLabel', resp.hostingNow.count);
            updateLabelCount('finishedLabel', resp.finished.count);
        }
    };

    $(function () {
        bookingPage.init();
    });
</script>

<div class="col-sm-12">
    <p class="text-muted">스페이스 관리 > 내 스페이스 > <strong>예약 캘린더</strong></p>
    <div class="card">
        <div class="card-body">
            <div class="row">
                <div class="col-sm-3">
                    <ul class="list-group mb-3">
                        <li class="list-group-item d-flex align-items-center justify-content-between"
                        style="background-color: #f5f5f9">
                            <label for="all"><strong>전체보기</strong></label>
                            <input type="checkbox" class="form-check-input" id="all" checked>
                        </li>
                        <li class="list-group-item d-flex align-items-center justify-content-between">
                            <label for="upcoming" id="upcomingLabel">
                                호스팅 예정된 예약
                            </label>
                            <input type="checkbox" class="form-check-input" id="upcoming" checked>
                        </li>
                        <li class="list-group-item d-flex align-items-center justify-content-between">
                            <label for="finished" id="finishedLabel">호스팅 완료된 예약</label>
                            <input type="checkbox" class="form-check-input" id="finished" checked>
                        </li>
                        <li class="list-group-item d-flex align-items-center justify-content-between">
                            <label for="hostingNow" id="hostingNowLabel">호스팅 진행중 예약</label>
                            <input type="checkbox" class="form-check-input" id="hostingNow" checked>
                        </li>
                        <li class="list-group-item d-flex align-items-center justify-content-between">
                            <label for="canceled" id="canceledLabel">취소/환불된 예약</label>
                            <input type="checkbox" class="form-check-input" id="canceled" checked>
                        </li>
                    </ul>
                    <small class="text-muted px-1" id="dataTimestamp"></small>
                </div>
                <div class="col-sm-9">
                    <div id="calendar" class="ms-0">
                        <div class="p-5 d-flex justify-content-center align-items-center flex-column">
                            <span class="mb-2">예약 일정을 불러오는 중...</span>
                            <p class="spinner-border text-primary mt-2"></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>