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
                    <span class="menu-header-text">공간 관리</span>
                </li>
                <li class="menu-item">
                    <a href='<c:url value="/space/add"/>' class="menu-link">
                        <i class="menu-icon tf-icons bx bx-add-to-queue"></i>
                        <box-icon name='add-to-queue'></box-icon>
                        <div>공간 추가</div>
                    </a>
                </li>
                <li class="menu-item">
                    <a href='<c:url value="/space/list"/>' class="menu-link">
                        <i class="menu-icon tf-icons bx bx-building-house"></i>
                        <div>내 공간 관리</div>
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
                        <div>공간별 예약 내역</div>
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

                <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
                    <!-- Search -->
                    <div class="navbar-nav align-items-center">
                        <div class="nav-item d-flex align-items-center">
                            <i class="bx bx-search fs-4 lh-0"></i>
                            <input
                                    type="text"
                                    class="form-control border-0 shadow-none"
                                    placeholder="Search..."
                                    aria-label="Search..."
                            />
                        </div>
                    </div>
                    <!-- /Search -->

                    <ul class="navbar-nav flex-row align-items-center ms-auto">
                        <!-- User -->
                        <li class="nav-item navbar-dropdown dropdown-user dropdown">

                            <!-- 로그인 상태일 경우 -->
                            <c:if test="${not empty sessionScope.user}">
                                <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                                    <div class="avatar avatar-online">
                                        <svg class="w-px-40 h-auto rounded-circle" xmlns="http://www.w3.org/2000/svg" width="78" height="78" viewBox="0 0 20 20" fill="none">
                                            <circle cx="10" cy="6" r="4" fill="#C4C4C4"/>
                                            <path d="M2 18c0-3.333 2.667-6 6-6h4c3.333 0 6 2.667 6 6" fill="#C4C4C4"/>
                                        </svg>
                                    </div>
                                </a>
                            </c:if>

                            <!-- 로그인 안 된 상태일 경우 -->
                            <c:if test="${empty sessionScope.user}">
                                <a class="nav-link hide-arrow" href="<c:url value='/auth/login'/>">
                                    <div class="avatar">
                                        <svg class="w-px-40 h-auto rounded-circle" xmlns="http://www.w3.org/2000/svg" width="78" height="78" viewBox="0 0 20 20" fill="none">
                                            <circle cx="10" cy="6" r="4" fill="#C4C4C4"/>
                                            <path d="M2 18c0-3.333 2.667-6 6-6h4c3.333 0 6 2.667 6 6" fill="#C4C4C4"/>
                                        </svg>
                                    </div>
                                </a>
                            </c:if>

                            <!-- 드롭다운 메뉴 (로그인한 경우만 의미 있음) -->
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li>
                                    <a class="dropdown-item" href="<c:url value='/mypage'/>">
                                        <i class="bx bx-user me-2"></i>
                                        <span class="align-middle">마이페이지</span>
                                    </a>
                                </li>
                                <li><div class="dropdown-divider"></div></li>
                                <li>
                                    <a class="dropdown-item" href="#">
                                        <i class="bx bx-cog me-2"></i>
                                        <span class="align-middle">테마 설정</span>
                                    </a>
                                </li>
                                <li><div class="dropdown-divider"></div></li>
                                <li>
                                    <a class="dropdown-item" href="<c:url value='/auth/logout'/>">
                                        <i class="bx bx-power-off me-2"></i>
                                        <span class="align-middle"><strong>로그아웃</strong></span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!--/ User -->
                    </ul>
                </div>
            </nav>
            <!-- / Navbar -->

            <!-- Content wrapper -->
            <div class="content-wrapper">

                <!-- floating button -->
                <a href="#" class="btn btn-light rounded-circle d-flex justify-content-center align-items-center position-fixed shadow"
                   style="width: 60px; height: 60px; bottom: 20px; right: 20px; z-index: 1030; padding: 15px;" data-bs-toggle="tooltip" title="1:1 대화창">
                    <svg width="64px" height="64px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                        <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                        <g id="SVGRepo_iconCarrier">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M18.3121 23.3511C17.4463 23.0228 16.7081 22.5979 16.1266 22.1995C14.8513 22.7159 13.4578 23 12 23C5.92487 23 1 18.0751 1 12C1 5.92487 5.92487 1 12 1C18.0751 1 23 5.92487 23 12C23 14.2788 22.306 16.3983 21.1179 18.1551C21.0425 19.6077 21.8054 20.9202 22.5972 22.0816C23.2907 23.0987 23.1167 23.9184 21.8236 23.9917C21.244 24.0245 19.9903 23.9874 18.3121 23.3511ZM3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12C21 13.9503 20.3808 15.7531 19.328 17.2262C18.8622 17.8782 19.1018 19.0998 19.2616 19.8011C19.4167 20.4818 19.7532 21.2051 20.0856 21.8123C19.7674 21.7356 19.4111 21.6288 19.0212 21.481C18.1239 21.1407 17.3824 20.6624 16.8594 20.261C16.5626 20.0332 16.1635 19.9902 15.825 20.1494C14.6654 20.6947 13.3697 21 12 21C7.02944 21 3 16.9706 3 12ZM8.03001 15.2425C7.87428 14.6196 8.36619 14.0002 9.00016 13.9998H15.0002C15.6333 14.0002 16.126 14.6172 15.9703 15.24C15.4525 16.9881 13.7854 18 12.0002 18C10.2834 18 8.46902 16.9986 8.03001 15.2425ZM16.5 10C16.5 10.8284 15.8284 11.5 15 11.5C14.1716 11.5 13.5 10.8284 13.5 10C13.5 9.17157 14.1716 8.5 15 8.5C15.8284 8.5 16.5 9.17157 16.5 10ZM9 11.5C9.82843 11.5 10.5 10.8284 10.5 10C10.5 9.17157 9.82843 8.5 9 8.5C8.17157 8.5 7.5 9.17157 7.5 10C7.5 10.8284 8.17157 11.5 9 11.5Z" fill="#233446"></path> </g>
                    </svg>
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
