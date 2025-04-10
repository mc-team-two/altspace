<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>AltSpace</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="Travelix Project">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
    <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
    <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
    <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
    <link rel="stylesheet" type="text/css" href="styles/main_styles.css">
    <link rel="stylesheet" type="text/css" href="styles/responsive.css">
</head>

<body>

<div class="super_container">

    <header class="header">

        <div class="top_bar">
            <div class="container">
                <div class="row">
                    <div class="col d-flex flex-row">
                        <div class="phone">+45 345 3324 56789</div>
                        <div class="top_bar_content ml-auto">
                            <div class="top_bar_menu">
                                <ul class="standard_dropdown top_bar_dropdown">
                                    <ul>
                                        <div class="social">
                                        <ul class="social_list">
                                            <li class="social_list_item"><a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a></li>
                                            <li class="social_list_item"><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                                            <li class="social_list_item"><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                            <li class="social_list_item"><a href="#"><i class="fa fa-dribbble" aria-hidden="true"></i></a></li>
                                            <li class="social_list_item"><a href="#"><i class="fa fa-behance" aria-hidden="true"></i></a></li>
                                            <li class="social_list_item"><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>                            <div class="top_bar_login ml-auto">
                                            <div class="login_button"><a href="login">Login</a></div>
                                            <div class="login_button"><a href="login/register">Register</a></div>
                                        </div>
                                        </ul>
                                        </div>
                                    </ul>
                                </ul>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <nav class="main_nav">
            <div class="container">
                <div class="row">
                    <div class="col main_nav_col d-flex flex-row align-items-center justify-content-lg-start">
                        <div class="logo_container">
                            <div class="logo"><a href="/"><img src="../images/Altspace_darkmode_logo_small.png" alt="AltSpace Logo">AltSpace</a></div>
                        </div>
                        <div class="main_nav_container ml-auto">
                            <ul class="main_nav_list">
                                <li class="main_nav_item"><a href="<c:url value="/"/> ">home</a></li>
                                <li class="main_nav_item"><a href="<c:url value="/about"/> ">about us</a></li>
                                <li class="main_nav_item"><a href="<c:url value="/offers"/> ">offers</a></li>
                                <li class="main_nav_item"><a href="<c:url value="/roominfo"/> ">RoomInfo</a></li>
                                <li class="main_nav_item"><a href="<c:url value="/elements"/> ">Elements</a></li>
                            </ul>
                        </div>
                        <div class="content_search ml-lg-0 ml-auto">
                            <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                 width="17px" height="17px" viewBox="0 0 512 512" enable-background="new 0 0 512 512" xml:space="preserve">
                            <g>
                                <g>
                                    <path class="fill-in" d="M495,475.9L354.3,335.2c28.7-34.6,45.1-79.1,45.1-126.8C399.4,102.7,316.7,20,200,20C83.2,20,0.5,102.7,0.5,212.4
                                         c0,113.8,91.4,205.5,205.2,205.5c47.7,0,92.2-16.3,126.8-45.1L475.9,495c11.3,11.3,29.5,11.3,40.8,0l21.2-21.2
                                         C506.3,505.4,506.3,487.1,495,475.9z M200.2,383c-94.7,0-171.5-76.8-171.5-171.5c0-94.7,76.8-171.5,171.5-171.5
                                         c94.7,0,171.5,76.8,171.5,171.5C371.7,306.2,294.9,383,200.2,383z"/>
                                </g>
                            </g>
                        </svg>
                        </div>

                        <form id="search_form" class="search_form clearfix">
                            <input type="search" class="search_input" placeholder="Search here..." required="required">
                            <button id="search_button" class="search_button"><svg version="1.1" id="Layer_2" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                                                                  width="17px" height="17px" viewBox="0 0 512 512" enable-background="new 0 0 512 512" xml:space="preserve">
                            <g>
                                <g>
                                    <path class="fill-in" d="M495,475.9L354.3,335.2c28.7-34.6,45.1-79.1,45.1-126.8C399.4,102.7,316.7,20,200,20C83.2,20,0.5,102.7,0.5,212.4
                                         c0,113.8,91.4,205.5,205.2,205.5c47.7,0,92.2-16.3,126.8-45.1L475.9,495c11.3,11.3,29.5,11.3,40.8,0l21.2-21.2
                                         C506.3,505.4,506.3,487.1,495,475.9z M200.2,383c-94.7,0-171.5-76.8-171.5-171.5c0-94.7,76.8-171.5,171.5-171.5
                                         c94.7,0,171.5,76.8,171.5,171.5C371.7,306.2,294.9,383,200.2,383z"/>
                                </g>
                            </g>
                        </svg></button>
                        </form>
                    </div>
                </div>
            </div>
        </nav>

    </header>

    <div class="main_content">
        <jsp:include page="${center}.jsp" />
    </div>

    <footer class="footer">
        <div class="container">
            <div class="row">

                <div class="col-lg-3 footer_column">
                    <div class="footer_title">about us</div>
                    <div class="footer_text">
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus quis vulputate eros, iaculis egestas. Nulla quis lorem ipsum, eu laoreet odio.</p>
                    </div>
                </div>

                <div class="col-lg-3 footer_column">
                    <div class="footer_title">why us?</div>
                    <div class="footer_text">
                        <p>Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus.</p>
                    </div>
                </div>

                <div class="col-lg-3 footer_column">
                    <div class="footer_title">here to help</div>
                    <ul class="footer_list">
                        <li><a href="#">FAQs</a></li>
                        <li><a href="#">Contact us</a></li>
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">Terms of Use</a></li>
                    </ul>
                </div>

                <div class="col-lg-3 footer_column">
                    <div class="footer_title">contact</div>
                    <div class="footer_contact">
                        <ul>
                            <li>Email: contact@altspace.com</li>
                            <li>Phone: +45 677 485 331</li>
                            <li>Address: Kongens Nytorv 06, 1050 Copenhagen K, Denmark</li>
                        </ul>
                    </div>
                </div>

            </div>
        </div>
        <div class="copyright">Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
        </div>
    </footer>
</div>

</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="js/custom.js"></script>

</body>

</html>