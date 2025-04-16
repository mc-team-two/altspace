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
    <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon1.ico" />

    <%--jQuery CDN--%>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

    <!-- Helpers -->
    <script src="../assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="../assets/js/config.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                <svg
                        width="25"
                        viewBox="0 0 25 42"
                        version="1.1"
                        xmlns="http://www.w3.org/2000/svg"
                        xmlns:xlink="http://www.w3.org/1999/xlink"
                >
                  <defs>
                    <path
                            d="M13.7918663,0.358365126 L3.39788168,7.44174259 C0.566865006,9.69408886 -0.379795268,12.4788597 0.557900856,15.7960551 C0.68998853,16.2305145 1.09562888,17.7872135 3.12357076,19.2293357 C3.8146334,19.7207684 5.32369333,20.3834223 7.65075054,21.2172976 L7.59773219,21.2525164 L2.63468769,24.5493413 C0.445452254,26.3002124 0.0884951797,28.5083815 1.56381646,31.1738486 C2.83770406,32.8170431 5.20850219,33.2640127 7.09180128,32.5391577 C8.347334,32.0559211 11.4559176,30.0011079 16.4175519,26.3747182 C18.0338572,24.4997857 18.6973423,22.4544883 18.4080071,20.2388261 C17.963753,17.5346866 16.1776345,15.5799961 13.0496516,14.3747546 L10.9194936,13.4715819 L18.6192054,7.984237 L13.7918663,0.358365126 Z"
                            id="path-1"
                    ></path>
                    <path
                            d="M5.47320593,6.00457225 C4.05321814,8.216144 4.36334763,10.0722806 6.40359441,11.5729822 C8.61520715,12.571656 10.0999176,13.2171421 10.8577257,13.5094407 L15.5088241,14.433041 L18.6192054,7.984237 C15.5364148,3.11535317 13.9273018,0.573395879 13.7918663,0.358365126 C13.5790555,0.511491653 10.8061687,2.3935607 5.47320593,6.00457225 Z"
                            id="path-3"
                    ></path>
                    <path
                            d="M7.50063644,21.2294429 L12.3234468,23.3159332 C14.1688022,24.7579751 14.397098,26.4880487 13.008334,28.506154 C11.6195701,30.5242593 10.3099883,31.790241 9.07958868,32.3040991 C5.78142938,33.4346997 4.13234973,34 4.13234973,34 C4.13234973,34 2.75489982,33.0538207 2.37032616e-14,31.1614621 C-0.55822714,27.8186216 -0.55822714,26.0572515 -4.05231404e-15,25.8773518 C0.83734071,25.6075023 2.77988457,22.8248993 3.3049379,22.52991 C3.65497346,22.3332504 5.05353963,21.8997614 7.50063644,21.2294429 Z"
                            id="path-4"
                    ></path>
                    <path
                            d="M20.6,7.13333333 L25.6,13.8 C26.2627417,14.6836556 26.0836556,15.9372583 25.2,16.6 C24.8538077,16.8596443 24.4327404,17 24,17 L14,17 C12.8954305,17 12,16.1045695 12,15 C12,14.5672596 12.1403557,14.1461923 12.4,13.8 L17.4,7.13333333 C18.0627417,6.24967773 19.3163444,6.07059163 20.2,6.73333333 C20.3516113,6.84704183 20.4862915,6.981722 20.6,7.13333333 Z"
                            id="path-5"
                    ></path>
                  </defs>
                  <g id="g-app-brand" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                    <g id="Brand-Logo" transform="translate(-27.000000, -15.000000)">
                      <g id="Icon" transform="translate(27.000000, 15.000000)">
                        <g id="Mask" transform="translate(0.000000, 8.000000)">
                          <mask id="mask-2" fill="white">
                            <use xlink:href="#path-1"></use>
                          </mask>
                          <use fill="#696cff" xlink:href="#path-1"></use>
                          <g id="Path-3" mask="url(#mask-2)">
                            <use fill="#696cff" xlink:href="#path-3"></use>
                            <use fill-opacity="0.2" fill="#FFFFFF" xlink:href="#path-3"></use>
                          </g>
                          <g id="Path-4" mask="url(#mask-2)">
                            <use fill="#696cff" xlink:href="#path-4"></use>
                            <use fill-opacity="0.2" fill="#FFFFFF" xlink:href="#path-4"></use>
                          </g>
                        </g>
                        <g
                                id="Triangle"
                                transform="translate(19.000000, 11.000000) rotate(-300.000000) translate(-19.000000, -11.000000) "
                        >
                          <use fill="#696cff" xlink:href="#path-5"></use>
                          <use fill-opacity="0.2" fill="#FFFFFF" xlink:href="#path-5"></use>
                        </g>
                      </g>
                    </g>
                  </g>
                </svg>
              </span>
                    <span class="app-brand-text demo menu-text fw-bolder">Alt Space 관리자</span>
                </a>

                <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
                    <i class="bx bx-chevron-left bx-sm align-middle"></i>
                </a>
            </div>

            <div class="menu-inner-shadow"></div>

            <ul class="menu-inner py-1">
                <!-- 1. 대시보드 -->
                <li class="menu-item">
                    <a href="javascript:void(0);" class="menu-link menu-toggle">
                        <i class="menu-icon tf-icons bx bx-home-circle"></i>
                        <div data-i18n="Analytics">주요 지표</div>
                    </a>

                    <ul class="menu-sub">
                        <li class="menu-item">
                            <a href='<c:url value="/dashboard/dashboard1"/>' class="menu-link">
                                <div data-i18n="Without menu">전체 통계(예약 수, 수익)</div>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href='<c:url value="/dashboard/dashboard2"/>' class="menu-link">
                                <div data-i18n="Without navbar">최근 활동 로그</div>
                            </a>
                        </li>
                    </ul>
                </li>

                <!-- 2. 공간 관리 -->
                <li class="menu-item">
                    <a href="javascript:void(0);" class="menu-link menu-toggle">
                        <i class="menu-icon tf-icons bx bx-layout"></i>
                        <div data-i18n="Layouts">공간 관리</div>
                    </a>

                    <ul class="menu-sub">
                        <li class="menu-item">
                            <a href='<c:url value="/space/add"/>' class="menu-link">
                                <div data-i18n="Without navbar">공간 추가</div>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href='<c:url value="/space/get"/>' class="menu-link">
                                <div data-i18n="Without menu">내 공간 관리</div>
                            </a>
                        </li>
                    </ul>
                </li>

                <!-- 3. 예약 관리 -->
                <li class="menu-item">
                    <a href="javascript:void(0);" class="menu-link menu-toggle">
                        <i class="menu-icon tf-icons bx bx-dock-top"></i>
                        <div data-i18n="Account Settings">예약 관리</div>
                    </a>
                    <ul class="menu-sub">
                        <li class="menu-item">
                            <a href='<c:url value="/book/book1"/>' class="menu-link">
                                <div data-i18n="Without menu">예약 목록</div>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href='<c:url value="/book/book2"/>' class="menu-link">
                                <div data-i18n="Container">예약 상태 변경</div>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href='<c:url value="/book/book3"/>' class="menu-link">
                                <div data-i18n="Fluid">예약 내역 검색 및 필터링</div>
                            </a>
                        </li>
                    </ul>
                </li>

                <!-- 4. 고객 관리 -->
                <li class="menu-item">
                    <a href="javascript:void(0);" class="menu-link menu-toggle" onclick="toggleMenu()">
                        <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                        <div data-i18n="Authentications">고객 관리</div>
                    </a>
                    <ul class="menu-sub">
                        <li class="menu-item">
                            <a href='<c:url value="/cust/cust1"/>' class="menu-link">
                                <div data-i18n="Without menu">고객 목록</div>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href='<c:url value="/cust/cust2"/>' class="menu-link">
                                <div data-i18n="Container">고객 정보 조회</div>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href='<c:url value="/cust/cust3"/>' class="menu-link">
                                <div data-i18n="Fluid">고객 예약 내역</div>
                            </a>
                        </li>
                    </ul>
                </li>

                <!-- 5. 결제 관리 -->
                <li class="menu-item">
                    <a href="javascript:void(0);" class="menu-link menu-toggle">
                        <i class="menu-icon tf-icons bx bx-cube-alt"></i>
                        <div data-i18n="Misc">결제 관리</div>
                    </a>
                    <ul class="menu-sub">
                        <li class="menu-item">
                            <a href='<c:url value="/payment/payment1"/>' class="menu-link">
                                <div data-i18n="Without menu">결제 내역</div>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href='<c:url value="/payment/payment2"/>' class="menu-link">
                                <div data-i18n="Container">결제 상태 확인</div>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href='<c:url value="/payment/payment3"/>' class="menu-link">
                                <div data-i18n="Fluid">환불 처리</div>
                            </a>
                        </li>
                    </ul>
                </li>

                <!-- 6. 리뷰 관리 -->
                <li class="menu-item">
                    <a href="javascript:void(0);" class="menu-link menu-toggle">
                        <i class="menu-icon tf-icons bx bx-collection"></i>
                        <div data-i18n="Basic">후기 관리</div>
                    </a>
                    <ul class="menu-sub">
                        <li class="menu-item">
                            <a href='<c:url value="/review/review1"/>' class="menu-link">
                                <div data-i18n="Without menu">후기 목록</div>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href='<c:url value="/review/review2"/>' class="menu-link">
                                <div data-i18n="Container">후기 승인/거부</div>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href='<c:url value="/review/review3"/>' class="menu-link">
                                <div data-i18n="Fluid">후기 응답</div>
                            </a>
                        </li>
                    </ul>
                </li>

                <!-- 7. 설정 -->
                <li class="menu-item">
                    <a href="javascript:void(0)" class="menu-link menu-toggle">
                        <i class="menu-icon tf-icons bx bx-box"></i>
                        <div data-i18n="User interface">설정</div>
                    </a>
                    <ul class="menu-sub">
                        <li class="menu-item">
                            <a href='<c:url value="/setting/setting1"/>' class="menu-link">
                                <div data-i18n="Accordion">계정 설정(호스트 정보)</div>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href='<c:url value="/setting/setting2"/>' class="menu-link">
                                <div data-i18n="Alerts">알림 및 이메일 설정</div>
                            </a>
                        </li>
                    </ul>
                </li>

            </ul>
        </aside>
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page">


            <!-- Navbar -->
            <nav class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
                 id="layout-navbar">

                <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
                    <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
                        <i class="bx bx-menu bx-sm"></i>
                    </a>
                </div>

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
