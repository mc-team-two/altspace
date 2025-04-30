<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>

<!-- beautify ignore:start -->
<html
    lang="ko"
    class="light-style layout-menu-fixed"
    dir="ltr"
    data-theme="theme-default"
    data-assets-path="../assets/"
    data-template="vertical-menu-template-free"
>
<head>
    <title>알트 스페이스(Alt Space)</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="../assets/img/favicon/altspace.png" />

    <%--jQuery CDN--%>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Bootstrap CSS (index.jsp의 head에 있으면 중복 불필요) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"/>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

    <%-- kakao map library --%>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoJSApiKey}&libraries=services"></script>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet"/>

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="../assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="../assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="../assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="../assets/vendor/libs/apex-charts/apex-charts.css" />

    <!-- Page CSS -->
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/main.min.css" rel="stylesheet" />

    <!-- Helpers -->
    <script src="../assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="../assets/js/config.js"></script>
</head>

<body>
<!-- Layout wrapper -->
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">

        <!-- Menu -->
        <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
            <div class="app-brand demo">
                <a href="/" class="app-brand-link">
                  <span class="app-brand-logo demo">
                    <img height="45" src="<c:url value="/imgs/Altspace_lightmode_Horizontal.png"/>" alt="알트스페이스 로고">
                  </span>
                </a>
            </div>

            <div class="menu-inner-shadow"></div>

            <ul class="menu-inner py-1">

                <!-- 공간 관리 섹션 -->
                <li class="menu-header small text-uppercase">
                    <span class="menu-header-text">스페이스 관리</span>
                </li>
                <li class="menu-item">
                    <a href='<c:url value="/space/add"/>' class="menu-link">
                        <i class="menu-icon tf-icons bx bx-add-to-queue"></i>
                        <box-icon name='add-to-queue'></box-icon>
                        <div>스페이스 추가</div>
                    </a>
                </li>
                <li class="menu-item">
                    <a href='<c:url value="/space/list"/>' class="menu-link">
                        <i class="menu-icon tf-icons bx bx-building-house"></i>
                        <div>내 스페이스 조회</div>
                    </a>
                </li>

                <!-- 결제/예약 조회 섹션 -->
                <li class="menu-header small text-uppercase">
                    <span class="menu-header-text">결제/예약 조회</span>
                </li>
                <li class="menu-item">
                    <a href='<c:url value="/payment/pay"/>' class="menu-link">
                        <i class="menu-icon tf-icons bx bx-credit-card"></i>
                        <div>결제 내역</div>
                    </a>
                </li>
                <li class="menu-item">
                    <a href='<c:url value="/payment/booking"/>' class="menu-link">
                        <i class="menu-icon tf-icons bx bx-calendar-check"></i>
                        <div>스페이스별 예약 내역</div>
                    </a>
                </li>

                <!-- 후기 관리 섹션 -->
                <li class="menu-header small text-uppercase">
                    <span class="menu-header-text">후기 관리</span>
                </li>
                <li class="menu-item">
                    <a href='<c:url value="/review/list"/>' class="menu-link">
                        <i class="menu-icon tf-icons bx bx-comment-detail"></i>
                        <div>후기 목록</div>
                    </a>
                </li>
                <li class="menu-item">
                    <a href='<c:url value="/review/check"/>' class="menu-link">
                        <i class="menu-icon tf-icons bx bx-check-shield"></i>
                        <div>후기 승인/거부</div>
                    </a>
                </li>

            </ul>
        </aside>
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page">

            <!-- Navbar -->
            <nav class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
                 id="layout-navbar">

                <div class="container-fluid d-flex justify-content-between align-items-center w-100">

                    <!-- 왼쪽: 햄버거 버튼 -->
                    <div class="d-flex align-items-center">
                        <button class="navbar-toggler layout-menu-toggle border-0 me-2" type="button">
                            <i class="bx bx-menu fs-3"></i>
                        </button>
                    </div>

                    <!-- 가운데: 페이지 제목 -->
                    <div class="position-absolute start-50 translate-middle-x">
                        <h5 class="mb-0 text-muted fw-semibold">빠르고 간편하게, Alt space</h5>
                    </div>

                    <!-- 오른쪽: 사용자 메뉴 -->
                    <div class="d-flex align-items-center">

                        <!-- 사용자 메뉴 (로그인 상태에 따라 달라짐) -->
                        <ul class="navbar-nav flex-row align-items-center ms-auto">
                            <li class="nav-item navbar-dropdown dropdown-user dropdown">

                                <!-- 로그인 상태일 경우 -->
                                <c:if test="${not empty sessionScope.user}">
                                    <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                                        <div class="d-flex align-items-center">
                                            <div class="me-2 text-end d-none d-md-block">
                                                <div class="fw-bold">${sessionScope.user.name}님</div>
                                                <small class="text-muted">환영합니다!</small>
                                            </div>
                                            <div class="avatar avatar-online">
                                                <img src="<c:url value="/imgs/avatar.png"/>" class="w-px-40 h-auto rounded-circle" alt="User" />
                                            </div>
                                        </div>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li>
                                            <a class="dropdown-item" href="<c:url value='/mypage'/>">
                                                <i class="bx bx-user me-2"></i> 마이페이지
                                            </a>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <a class="dropdown-item" href="#" id="theme-toggle-dropdown">
                                                <i class="bx bx-moon me-2"></i> 테마 설정
                                            </a>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <a class="dropdown-item" href="<c:url value='/auth/logout'/>">
                                                <i class="bx bx-power-off me-2"></i> <strong>로그아웃</strong>
                                            </a>
                                        </li>
                                    </ul>
                                </c:if>

                                <!-- 로그인 안 된 상태일 경우 -->
                                <c:if test="${empty sessionScope.user}">
                                    <a class="nav-link" href="<c:url value='/auth/login'/>">
                                        <div class="d-flex align-items-center">
                                            <span class="me-2 text-muted">로그인</span>
                                            <div class="avatar">
                                                <img src="/images/default-profile.svg" class="w-px-40 h-auto rounded-circle" alt="Login" />
                                            </div>
                                        </div>
                                    </a>
                                </c:if>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <!-- / Navbar -->

            <!-- Content wrapper -->
            <div class="content-wrapper">

                <!-- floating button -->
                <a href="#" class="btn btn-light rounded-circle d-flex justify-content-center align-items-center position-fixed shadow"
                   style="width: 60px; height: 60px; bottom: 20px; right: 20px; z-index: 1030; padding: 15px;" data-bs-toggle="tooltip">
                    <img src="<c:url value="/imgs/go_to_top.png"/>" alt="Back to top" style="width: 100%; height: 100%;" />
                </a>

                <!-- Content -->

                <div class="container" style="margin-top:30px;margin-bottom:30px">
                    <div class="row">

                        <c:choose>
                            <c:when test="${center == null}">
                                <jsp:include page="center.jsp"/>
                            </c:when>
                            <c:otherwise>
                                <jsp:include page="${center}.jsp"/>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>
                <!-- / Content -->

                <!-- Footer -->
                <footer class="content-footer footer bg-footer-theme">
                    <div class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
                        <div class="mb-2 mb-md-0">
                            ©
                            <script>
                                document.write(new Date().getFullYear());
                            </script>
                            , made with ❤️ by
                            <a href="https://themeselection.com" target="_blank" class="footer-link fw-bolder">Team2</a>
                        </div>
                    </div>
                </footer>
                <!-- / Footer -->

                <div class="content-backdrop fade"></div>
            </div>
            <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
    </div>

    <!-- Overlay -->
    <div class="layout-overlay layout-menu-toggle"></div>
</div>
<!-- / Layout wrapper -->

<!-- Calendar -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/tippy.js@6/themes/light.css" />
<script src="https://unpkg.com/@popperjs/core@2"></script>
<script src="https://unpkg.com/tippy.js@6"></script>

<!-- Booking -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<!-- Core JS -->
<!-- build:js assets/vendor/js/core.js -->
<script src="../assets/vendor/libs/jquery/jquery.js"></script>
<script src="../assets/vendor/libs/popper/popper.js"></script>
<script src="../assets/vendor/js/bootstrap.js"></script>
<script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

<script src="../assets/vendor/js/menu.js"></script>
<!-- endbuild -->

<!-- Vendors JS -->
<script src="../assets/vendor/libs/apex-charts/apexcharts.js"></script>

<!-- Main JS -->
<script src="../assets/js/main.js"></script>

<!-- Page JS -->
<script src="../assets/js/dashboards-analytics.js"></script>

<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
</body>
</html>
