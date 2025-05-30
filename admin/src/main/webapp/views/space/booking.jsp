<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
    }
    .event-count {
        color: #6c757d;
        font-weight: normal;
    }
    .fc-col-header-cell {
        background-color: #e9ecef; /* Light grey background */
    }
    .fc-day-today .fc-daygrid-day-number {
        color: black;
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
                eventDisplay: 'block',
                eventBackgroundColor: '#f8f9fa',
                eventBorderColor: '#ced4da',
                events: [],
                dayHeaderFormat: { weekday: 'long' },
                dayHeaderDidMount: function(arg) {
                    // arg.el ==> <th> 요소
                    // arg.dow ==> 요일 (0: 일요일, 6: 토요일)
                    // arg.text ==> 포맷팅된 요일 텍스트 ("일요일")
                    if (!arg.el) return;    // list 일 때 코드 작동 중지 방어용

                    const textElement = arg.el.querySelector('.fc-col-header-cell-cushion');
                    if (textElement) {
                        if (arg.dow === 0) {
                            textElement.style.color = '#dc3545'; // 일요일
                        } else if (arg.dow === 6) {
                            textElement.style.color = '#0d7af6'; // 토요일
                        }
                    }
                },
                eventContent: function(arg) {
                    if (arg.view.type.startsWith('list')) {
                        return { html: (arg.event.title && arg.event.title.trim() !== '') ? arg.event.title : '&nbsp;' };
                    }
                    else if (arg.view.type === 'dayGridMonth') {
                        const segmentDate = new Date(arg.date);
                        segmentDate.setHours(0, 0, 0, 0);

                        const eventStartDate = arg.event.start ? new Date(arg.event.start) : null;
                        if (eventStartDate) {
                            eventStartDate.setHours(0, 0, 0, 0);
                        }

                        const displayTitle = arg.isStart || (eventStartDate && segmentDate.getTime() === eventStartDate.getTime()) || !eventStartDate;

                        if (displayTitle) {
                            return { html: (arg.event.title && arg.event.title.trim() !== '') ? arg.event.title : '&nbsp;' };
                        } else {
                            return { html: '&nbsp;' };
                        }
                    }
                    else {
                        return { html: (arg.event.title && arg.event.title.trim() !== '') ? arg.event.title : '&nbsp;' };
                    }
                },
                eventDidMount: function (info) {
                    if (!info.el) {
                        return;
                    }

                    let ep = info.event.extendedProps;
                    let guestName = ep.guestName || '정보 없음';
                    let location  = ep.location || '정보 없음';
                    let paymentId = ep.paymentId || '정보 없음';

                    let eventTitleForTooltip = (typeof info.event.title === 'string' && info.event.title.trim() !== '') ? info.event.title : '(제목 없음)';

                    let tooltipContent =
                        '<div style="font-weight:bold; margin-bottom:4px;">' +
                        eventTitleForTooltip +
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
                        console.error("Error initializing tippy:", e, "for element:", info.el, "event:", info.event);
                    }
                }
            });

            this.calendar.render();
        },

        // 이벤트 배열에 데이터 추가
        populateEvents: function (resp) {
            const eventTextColor = '#212529';

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
                    const accommodationName = event.accommodationName || '';
                    this.events.push({
                        title: '<span class="' + currentStatusInfo.badgeClass + '">'
                            + currentStatusInfo.text + '</span> '
                            + accommodationName + " #" + event.paymentId,
                        start: event.checkIn,
                        end: event.checkOut,
                        textColor: eventTextColor,
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