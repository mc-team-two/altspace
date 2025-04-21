<%--
  Created by IntelliJ IDEA.
  User: ishot
  Date: 25. 4. 7.
  Time: 오후 2:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>


<!-- 푸터 -->

<footer class="footer">
    <div class="container">
        <div class="row">

            <!-- 회사 정보 -->
            <div class="col-lg-3 footer_column">
                <div class="footer_col">
                    <div class="footer_content footer_about">
                        <div class="logo_container footer_logo">
                            <div class="logo"><a href="#"><img src="images/logo.png" alt=""></a></div>
                        </div>
                        <p class="footer_about_text">(주)알트스페이스 | 대표이사: 이예진 | 사업자 등록번호: 123-81-45678 | 통신판매업신고: 2025-서울영등포-0001 |
                            관광사업자 등록번호: 제2025-00001호 | 주소: 서울 영등포구 여의동로 330 (여의도동, 알트타워) | 호스팅 서비스 제공자: (주)알트스페이스그룹</p>
                        <ul class="footer_social_list">
                            <li class="footer_social_item"><a href="#"><i class="fa fa-pinterest"></i></a></li>
                            <li class="footer_social_item"><a href="#"><i class="fa fa-facebook-f"></i></a></li>
                            <li class="footer_social_item"><a href="#"><i class="fa fa-twitter"></i></a></li>
                            <li class="footer_social_item"><a href="#"><i class="fa fa-dribbble"></i></a></li>
                            <li class="footer_social_item"><a href="#"><i class="fa fa-behance"></i></a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- 기존 템플릿 내용 삭제 후 정렬을 위한 빈 칸으로 활용 -->
            <div class="col-lg-3 footer_column">
                <div class="footer_col">
                    <%--<div class="footer_title">blog posts</div>
                    <div class="footer_content footer_blog">

                        <!-- Footer blog item -->
                        <div class="footer_blog_item clearfix">
                            <div class="footer_blog_image"><img src="images/footer_blog_1.jpg" alt="https://unsplash.com/@avidenov"></div>
                            <div class="footer_blog_content">
                                <div class="footer_blog_title"><a href="blog.html">Travel with us this year</a></div>
                                <div class="footer_blog_date">Nov 29, 2017</div>
                            </div>
                        </div>

                        <!-- Footer blog item -->
                        <div class="footer_blog_item clearfix">
                            <div class="footer_blog_image"><img src="images/footer_blog_2.jpg" alt="https://unsplash.com/@deannaritchie"></div>
                            <div class="footer_blog_content">
                                <div class="footer_blog_title"><a href="blog.html">New destinations for you</a></div>
                                <div class="footer_blog_date">Nov 29, 2017</div>
                            </div>
                        </div>

                        <!-- Footer blog item -->
                        <div class="footer_blog_item clearfix">
                            <div class="footer_blog_image"><img src="images/footer_blog_3.jpg" alt="https://unsplash.com/@bergeryap87"></div>
                            <div class="footer_blog_content">
                                <div class="footer_blog_title"><a href="blog.html">Travel with us this year</a></div>
                                <div class="footer_blog_date">Nov 29, 2017</div>
                            </div>
                        </div>

                    </div>--%>
                </div>
            </div>


            <!-- 태그 -->
            <div class="col-lg-3 footer_column">
                <div class="footer_col">
                    <div class="footer_title">태그</div>
                    <div class="footer_content footer_tags">
                        <ul class="tags_list clearfix">
                            <li class="tag_item"><a href="#">바캉스</a></li>
                            <li class="tag_item"><a href="#">호캉스</a></li>
                            <li class="tag_item"><a href="#">페스티벌</a></li>
                            <li class="tag_item"><a href="#">파티</a></li>
                            <li class="tag_item"><a href="#">프라이빗</a></li>
                            <li class="tag_item"><a href="#">마운틴뷰</a></li>
                            <li class="tag_item"><a href="#">시티뷰</a></li>
                            <li class="tag_item"><a href="#">오션뷰</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- 연락처 -->
            <div class="col-lg-3 footer_column">
                <div class="footer_col">
                    <div class="footer_title">연락처</div>
                    <div class="footer_content footer_contact">
                        <ul class="contact_info_list">
                            <li class="contact_info_item d-flex flex-row">
                                <div><div class="contact_info_icon"><img src="images/placeholder.svg" alt=""></div></div>
                                <div class="contact_info_text">서울 영등포구 여의동로 330 (여의도동, 알트타워)</div>
                            </li>
                            <li class="contact_info_item d-flex flex-row">
                                <div><div class="contact_info_icon"><img src="images/phone-call.svg" alt=""></div></div>
                                <div class="contact_info_text">02-1234-5678 / 1588-1588</div>
                            </li>
                            <li class="contact_info_item d-flex flex-row">
                                <div><div class="contact_info_icon"><img src="images/message.svg" alt=""></div></div>
                                <div class="contact_info_text"><a href="mailto:help.alt@altspace.com?Subject=Hello" target="_top">help.alt@altspace.com</a></div>
                            </li>
                            <li class="contact_info_item d-flex flex-row">
                                <div><div class="contact_info_icon"><img src="images/planet-earth.svg" alt=""></div></div>
                                <div class="contact_info_text"><a href="https://altspace.com/help">www.altspace.com/help</a></div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>
</footer>


<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="js/custom.js"></script>