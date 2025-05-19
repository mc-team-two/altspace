/* JS Document */

/******************************

 [Table of Contents]

 1. Vars and Inits
 2. Set Header
 3. Init Home Slider
 4. Init Menu
 5. Init Search
 6. Init CTA Slider
 7. Init Testimonials Slider
 8. Init Search Form
 9. Geolocation


 ******************************/

$(document).ready(function () {
    "use strict";

    /*

    1. Vars and Inits

    */

    var menu = $('.menu');
    var menuActive = false;
    var header = $('.header');
    var searchActive = false;

    setHeader();

    $(window).on('resize', function () {
        setHeader();
    });

    $(document).on('scroll', function () {
        setHeader();
    });

    initHomeSlider();
    initMenu();
    initSearch();
    initCtaSlider();
    initTestSlider();
    initSearchForm();

    /*

    2. Set Header

    */

    function setHeader() {
        if (window.innerWidth < 992) {
            if ($(window).scrollTop() > 100) {
                header.addClass('scrolled');
            } else {
                header.removeClass('scrolled');
            }
        } else {
            if ($(window).scrollTop() > 100) {
                header.addClass('scrolled');
            } else {
                header.removeClass('scrolled');
            }
        }
        if (window.innerWidth > 991 && menuActive) {
            closeMenu();
        }
    }

    /*

    3. Init Home Slider

    */

    function initHomeSlider() {
        if ($('.home_slider').length) {
            var homeSlider = $('.home_slider');

            homeSlider.owlCarousel(
                {
                    items: 1,
                    loop: true,
                    autoplay: false,
                    smartSpeed: 1200,
                    dotsContainer: 'main_slider_custom_dots'
                });

            /* Custom nav events */
            if ($('.home_slider_prev').length) {
                var prev = $('.home_slider_prev');

                prev.on('click', function () {
                    homeSlider.trigger('prev.owl.carousel');
                });
            }

            if ($('.home_slider_next').length) {
                var next = $('.home_slider_next');

                next.on('click', function () {
                    homeSlider.trigger('next.owl.carousel');
                });
            }

            /* Custom dots events */
            if ($('.home_slider_custom_dot').length) {
                $('.home_slider_custom_dot').on('click', function () {
                    $('.home_slider_custom_dot').removeClass('active');
                    $(this).addClass('active');
                    homeSlider.trigger('to.owl.carousel', [$(this).index(), 300]);
                });
            }

            /* Change active class for dots when slide changes by nav or touch */
            homeSlider.on('changed.owl.carousel', function (event) {
                $('.home_slider_custom_dot').removeClass('active');
                $('.home_slider_custom_dots li').eq(event.page.index).addClass('active');
            });

            // add animate.css class(es) to the elements to be animated
            function setAnimation(_elem, _InOut) {
                // Store all animationend event name in a string.
                // cf animate.css documentation
                var animationEndEvent = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';

                _elem.each(function () {
                    var $elem = $(this);
                    var $animationType = 'animated ' + $elem.data('animation-' + _InOut);

                    $elem.addClass($animationType).one(animationEndEvent, function () {
                        $elem.removeClass($animationType); // remove animate.css Class at the end of the animations
                    });
                });
            }

            // Fired before current slide change
            homeSlider.on('change.owl.carousel', function (event) {
                var $currentItem = $('.home_slider_item', homeSlider).eq(event.item.index);
                var $elemsToanim = $currentItem.find("[data-animation-out]");
                setAnimation($elemsToanim, 'out');
            });

            // Fired after current slide has been changed
            homeSlider.on('changed.owl.carousel', function (event) {
                var $currentItem = $('.home_slider_item', homeSlider).eq(event.item.index);
                var $elemsToanim = $currentItem.find("[data-animation-in]");
                setAnimation($elemsToanim, 'in');
            })
        }
    }

    /*

    4. Init Menu

    */

    function initMenu() {
        if ($('.hamburger').length && $('.menu').length) {
            var hamb = $('.hamburger');
            var close = $('.menu_close_container');

            hamb.on('click', function () {
                if (!menuActive) {
                    openMenu();
                } else {
                    closeMenu();
                }
            });

            close.on('click', function () {
                if (!menuActive) {
                    openMenu();
                } else {
                    closeMenu();
                }
            });


        }
    }

    function openMenu() {
        menu.addClass('active');
        menuActive = true;
    }

    function closeMenu() {
        menu.removeClass('active');
        menuActive = false;
    }

    /*

    5. Init Search

    */

    function initSearch() {
        if ($('.search_tab').length) {
            $('.search_tab').on('click', function () {
                $('.search_tab').removeClass('active');
                $(this).addClass('active');
                var clickedIndex = $('.search_tab').index(this);

                var panels = $('.search_panel');
                panels.removeClass('active');
                $(panels[clickedIndex]).addClass('active');
            });
        }
    }

    /*

    6. Init CTA Slider

    */

    function initCtaSlider() {
        if ($('.cta_slider').length) {
            var ctaSlider = $('.cta_slider');

            ctaSlider.owlCarousel(
                {
                    items: 1,
                    loop: true,
                    autoplay: false,
                    nav: false,
                    dots: false,
                    smartSpeed: 1200
                });

            /* Custom nav events */
            if ($('.cta_slider_prev').length) {
                var prev = $('.cta_slider_prev');

                prev.on('click', function () {
                    ctaSlider.trigger('prev.owl.carousel');
                });
            }

            if ($('.cta_slider_next').length) {
                var next = $('.cta_slider_next');

                next.on('click', function () {
                    ctaSlider.trigger('next.owl.carousel');
                });
            }
        }
    }

    /*

    7. Init Testimonials Slider

    */

    function initTestSlider() {
        if ($('.test_slider').length) {
            var testSlider = $('.test_slider');

            testSlider.owlCarousel(
                {
                    loop: true,
                    nav: false,
                    dots: false,
                    smartSpeed: 1200,
                    margin: 30,
                    responsive:
                        {
                            0: {items: 1},
                            480: {items: 1},
                            768: {items: 2},
                            992: {items: 3}
                        }
                });

            /* Custom nav events */
            if ($('.test_slider_prev').length) {
                var prev = $('.test_slider_prev');

                prev.on('click', function () {
                    testSlider.trigger('prev.owl.carousel');
                });
            }

            if ($('.test_slider_next').length) {
                var next = $('.test_slider_next');

                next.on('click', function () {
                    testSlider.trigger('next.owl.carousel');
                });
            }
        }
    }

    /*

    8. Init Search Form

    */

    function initSearchForm() {
        if ($('.search_form').length) {
            var searchForm = $('.search_form');
            var searchInput = $('.search_content_input');
            var searchButton = $('.content_search');

            searchButton.on('click', function (event) {
                event.stopPropagation();

                if (!searchActive) {
                    searchForm.addClass('active');
                    searchActive = true;

                    $(document).one('click', function closeForm(e) {
                        if ($(e.target).hasClass('search_content_input')) {
                            $(document).one('click', closeForm);
                        } else {
                            searchForm.removeClass('active');
                            searchActive = false;
                        }
                    });
                } else {
                    searchForm.removeClass('active');
                    searchActive = false;
                }
            });
        }
    }

    // 9. Geolocation
// 위치 정보 가져오기 버튼 이벤트 리스너
    $("#geolocationBtn").on("click", function () {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(searchAccommodationsNearLocation, handleLocationError);
        } else {
            alert("이 브라우저에서는 위치 정보를 지원하지 않습니다.");
        }
    });

    function searchAccommodationsNearLocation(position) {
        const latitude = position.coords.latitude;
        const longitude = position.coords.longitude;
        const radius = 10000; // 10km 반경으로 설정.
        const extras = [];

        // withRating 변수 선언 및 값 할당
        const withRating = true; // 또는 사용자의 선택에 따라 동적으로 설정

        // Collect selected extras
        if ($('#search_extras_1').prop('checked')) {
            extras.push('breakfast');
        }
        if ($('#search_extras_2').prop('checked')) {
            extras.push('pet');
        }
        if ($('#search_extras_3').prop('checked')) {
            extras.push('barbecue');
        }
        if ($('#search_extras_4').prop('checked')) {
            extras.push('pool');
        }

        const url = `/search-accommodations-geo?latitude=${latitude}&longitude=${longitude}&radius=${radius}&extras=${extras.join('&extras=')}&withRating=${withRating}`;

        $.ajax({
            url: url,
            type: "GET",
            success: function (accommodationsWithRating) { 
                displayGeoSearchResults(accommodationsWithRating);
            },
            error: function (error) {
                alert("주변 숙소 검색에 실패했습니다.");
                console.error(error);
            }
        });
    }

// 위치 정보 가져오기 실패 시 처리 함수
    function handleLocationError(error) {
        switch (error.code) {
            case error.PERMISSION_DENIED:
                alert("위치 정보 접근 권한이 거부되었습니다.");
                break;
            case error.POSITION_UNAVAILABLE:
                alert("위치 정보를 사용할 수 없습니다.");
                break;
            case error.TIMEOUT:
                alert("위치 정보 요청 시간이 초과되었습니다.");
                break;
            case error.UNKNOWN_ERROR:
                alert("알 수 없는 오류가 발생했습니다.");
                break;
        }
    }

    // 검색 추천을 화면에 표시하는 함수
    function displaySearchSuggestions(accomsuggestions) {
        const SearchSuggestions = $("SearchSuggestions");

    }

// 검색 결과를 화면에 표시하는 함수
    function displayGeoSearchResults(accommodationsWithRating) {
        const offersGrid = $(".offers_grid");
        offersGrid.empty();
        $(".blog_navigation").hide();

        if (accommodationsWithRating && accommodationsWithRating.length > 0) {
            $.each(accommodationsWithRating, function (index, item) {
                const accommodation = item.accommodation;
                const rating = item.roundedRating;
                const ratingClass = `rating_${rating}`;
                let imageUrl = '';
                if (accommodation.image1Name) {
                    imageUrl = `/images/${accommodation.image1Name}`;
                } else {
                    imageUrl = `/images/default.jpg`;
                }

                const barbecueIcon = accommodation.barbecue ? `<li class="offers_icons_item" data-popper-content="바베큐 시설 안내"><i class="fa fa-fire" aria-hidden="true" title="바베큐"></i></li>` : '';
                const breakfastIcon = accommodation.breakfast ? `<li class="offers_icons_item" data-popper-content="맛있는 조식 제공"><i class="fa fa-coffee" aria-hidden="true" title="조식"></i></li>` : '';
                const petIcon = accommodation.pet ? `<li class="offers_icons_item" data-popper-content="반려동물 동반 가능"><i class="fa fa-paw" aria-hidden="true" title="반려동물"></i></li>` : '';
                const poolIcon = accommodation.pool ? `<li class="offers_icons_item" data-popper-content="시원한 수영장 이용"><i class="fa fa-tint" aria-hidden="true" title="수영장"></i></li>` : '';

                const listItem = `
         <div class="offers_item ${ratingClass}">
            <div class="row">
               <div class="col-lg-1 temp_col"></div>
               <div class="col-lg-3 col-1680-4">
                  <div class="offers_image_container">
                     <div class="offers_image_background" style="background-image:url('${imageUrl}')"></div>
                         <div class="offer_name"><a href="/detail?id=${accommodation.accommodationId}">${accommodation.name}</a></div>
                  </div>
               </div>
                       <div class="col-lg-8">
                           <div class="offers_content">
                               <div class="offers_price">$${accommodation.priceNight}<span>per night</span></div>
                               <div class="rating_r rating_r_${rating} offers_rating" data-rating="${rating}">
                                   <i></i><i></i><i></i><i></i><i></i>
                               </div>
                               <p class="offers_text">${accommodation.description}</p>
                               <div class="offers_icons">
                                   <ul class="offers_icons_list">
                                       ${barbecueIcon}
                                       ${breakfastIcon}
                                       ${petIcon}
                                       ${poolIcon}
                                   </ul>
                               </div>
                               <div class="button book_button"><a href="/detail?id=${accommodation.accommodationId}">상세보기<span></span><span></span><span></span></a></div>
                               <div class="offer_reviews">
                                   <div class="offer_reviews_content">
                                       <div class="offer_reviews_title">
                                           ${getRatingText(rating)}
                                       </div>
                                       <div class="offer_reviews_subtitle"> 리뷰 평점: </div>
                                   </div>
                                   <div class="offer_reviews_rating text-center">
                                       ${rating}
                                   </div>
                               </div>
                           </div>
                       </div>
                   </div>
               </div>
           `;
                offersGrid.append(listItem);
            });

            // 검색 결과가 그려진 후에 팝업 기능 활성화
            initIconPopper();

        } else {
            offersGrid.html("<p>반경 10km 이내에 숙소가 없습니다!</p>");
        }
    }

    function getRatingText(rating) {
        if (rating >= 4) return "최고예요!";
        if (rating === 3) return "좋아요!";
        if (rating === 2) return "괜찮아요!";
        if (rating === 1) return "그저 그래요!";
        return "평가가 없어요";
    }

// 팝업 기능을 초기화하는 함수
    function initIconPopper() {
        const tooltipTriggers = document.querySelectorAll('.offers_icons_item[data-popper-content]');

        tooltipTriggers.forEach(trigger => {
            const tooltip = document.createElement('div');
            tooltip.classList.add('popper-tooltip');
            tooltip.textContent = trigger.dataset.popperContent;
            document.body.appendChild(tooltip);

            // 1.x 버전의 Popper 사용
            const popperInstance = new Popper(trigger, tooltip, {
                placement: 'top',
                modifiers: {
                    offset: {
                        offset: '0, 8',
                    },
                    arrow: {
                        element: '.popper-arrow',
                    },
                },
            });

            const showEvents = ['mouseenter', 'focus'];
            const hideEvents = ['mouseleave', 'blur'];

            showEvents.forEach(event => {
                trigger.addEventListener(event, () => {
                    tooltip.classList.add('active');
                    popperInstance.update();
                });
            });

            hideEvents.forEach(event => {
                trigger.addEventListener(event, () => {
                    tooltip.classList.remove('active');
                });
            });
        });
    }

    // 10. search

    /*
    // 검색 버튼 클릭 이벤트 리스너
     */
    $("#searchAccommodationBtn").on("click", function () {
        const location = $("#searchInput").val();
        const checkIn = $("#checkInInput").val();
        const checkOut = $("#checkOutInput").val();
        const personnel = $("#adults_1").val();
        const extras = [];

        if ($('#search_extras_1').prop('checked')) {
            extras.push('breakfast');
        }
        if ($('#search_extras_2').prop('checked')) {
            extras.push('pet');
        }
        if ($('#search_extras_3').prop('checked')) {
            extras.push('barbecue');
        }
        if ($('#search_extras_4').prop('checked')) {
            extras.push('pool');
        }

        // 유효성 검사
        if (!location) {
            alert("지역 정보를 채워넣어 주세요.");
            return; // 검색 로직 중단
        }

        if (!checkIn) {
            alert("체크인 날짜를 채워넣어 주세요.");
            return; // 검색 로직 중단
        }

        if (!checkOut) {
            alert("체크아웃 날짜를 채워넣어 주세요.");
            return; // 검색 로직 중단
        }

        // 모든 필수 정보가 입력되었으면 검색 로직 실행
        searchAccommodationsByLocation(location, checkIn, checkOut, extras);
    });

    function searchAccommodationsByLocation(location, checkIn, checkOut, personnel, extras) {
        // 검색결과를 db에서 받아오기 위한 요청
        $.ajax({
            url: "/search-accommodations",
            type: "GET",
            data: {
                location: location,
                checkInDate: checkIn,
                checkOutDate: checkOut,
                personnel: personnel,
                withRating: true,
                extras: extras
            },
            dataType: "json",
            success: function (accommodations) {
                displaySearchResults(accommodations);
            },
            error: function (error) {
                alert("숙소 검색에 실패했습니다.");
                console.error(error);
            }
        });

        // 검색 버튼을 누름과 동시에 요청을 보내, 제미나이로부터 데이터를 받아오기 위한 요청
        $.ajax({
            url: "/search-accomsuggestions",
            type: "POST",
            contentType: "application/json", // JSON 형식 명시
            data: JSON.stringify({

                //목적지, 체크인 날짜, 체크아웃 날짜, 인원, 기타 조건들.
                location: location,
                checkIn: checkIn,
                checkOut: checkOut,
                personnel: parseInt(personnel) || 1, // empty 안들어가게 최소 1명 고정.
                extras: extras
            }),
            success: function (accomsuggestions) {
                displaySearchSuggestions(accomsuggestions);
            },
            error: function (error) {
                alert("AI 답변을 가져오는 데에 실패했습니다.");
                console.error(error);
            }
        });
    }

    function displaySearchResults(accommodationsWithRating) {
        const offersGrid = $(".offers_grid");
        offersGrid.empty();
        $(".blog_navigation").hide(); // 대체 가능

        if (accommodationsWithRating && accommodationsWithRating.length > 0) {
            $.each(accommodationsWithRating, function (index, item) {
                const accommodation = item.accommodation;
                const rating = item.roundedRating;
                const ratingClass = `rating_${rating}`;
                let imageUrl = '';
                if (accommodation.image1Name) {
                    imageUrl = `/images/${accommodation.image1Name}`;
                } else {
                    imageUrl = `/images/default.jpg`;
                }

                const barbecueIcon = accommodation.barbecue ? `<li class="offers_icons_item" data-popper-content="바베큐 시설 안내"><i class="fa fa-fire" aria-hidden="true" title="바베큐"></i></li>` : '';
                const breakfastIcon = accommodation.breakfast ? `<li class="offers_icons_item" data-popper-content="맛있는 조식 제공"><i class="fa fa-coffee" aria-hidden="true" title="조식"></i></li>` : '';
                const petIcon = accommodation.pet ? `<li class="offers_icons_item" data-popper-content="반려동물 동반 가능"><i class="fa fa-paw" aria-hidden="true" title="반려동물"></i></li>` : '';
                const poolIcon = accommodation.pool ? `<li class="offers_icons_item" data-popper-content="시원한 수영장 이용"><i class="fa fa-tint" aria-hidden="true" title="수영장"></i></li>` : '';

                const listItem = `
             <div class="offers_item ${ratingClass}">
                <div class="row">
                   <div class="col-lg-1 temp_col"></div>
                   <div class="col-lg-3 col-1680-4">
                      <div class="offers_image_container">
                         <div class="offers_image_background" style="background-image:url('${imageUrl}')"></div>
                             <div class="offer_name"><a href="/detail?id=${accommodation.accommodationId}">${accommodation.name}</a></div>
                      </div>
                   </div>
                           <div class="col-lg-8">
                               <div class="offers_content">
                                   <div class="offers_price">$${accommodation.priceNight}<span>per night</span></div>
                                   <div class="rating_r rating_r_${rating} offers_rating" data-rating="${rating}">
                                       <i></i><i></i><i></i><i></i><i></i>
                                   </div>
                                   <p class="offers_text">${accommodation.description}</p>
                                   <div class="offers_icons">
                                       <ul class="offers_icons_list">
                                           ${barbecueIcon}
                                           ${breakfastIcon}
                                           ${petIcon}
                                           ${poolIcon}
                                       </ul>
                                   </div>
                                   <div class="button book_button"><a href="/detail?id=${accommodation.accommodationId}">상세보기<span></span><span></span><span></span></a></div>
                                   <div class="offer_reviews">
                                       <div class="offer_reviews_content">
                                           <div class="offer_reviews_title">
                                               ${getRatingText(rating)}
                                           </div>
                                           <div class="offer_reviews_subtitle"> 리뷰 평점: </div>
                                       </div>
                                       <div class="offer_reviews_rating text-center">
                                           ${rating}
                                       </div>
                                   </div>
                               </div>
                           </div>
                       </div>
                   </div>
               `;
                offersGrid.append(listItem);
            });

            // 검색 결과가 그려진 후에 팝업 기능 활성화
            initIconPopper();

        } else {
            offersGrid.html("<p>검색 결과가 없습니다.</p>");
        }
    }

    function getRatingText(rating) {
        if (rating >= 4) return "최고예요!";
        if (rating === 3) return "좋아요!";
        if (rating === 2) return "괜찮아요!";
        if (rating === 1) return "그저 그래요!";
        return "평가가 없어요";
    }

    let weatherChartInstance = null; // 차트 인스턴스 저장용

// 제미나이 응답을 받아서 출력하는 함수
    function displaySearchSuggestions(data) {
        const container = $("#travel-insight-container");
        const summaryBox = $("#travel-summary");
        const insightItem = $("#travel-insight-item");
        const tipsList = $("#travel-tips");

        const rawLines = data.summary.split("\n");
        const summaryText = rawLines[0]; // 첫 줄 요약
        const tips = rawLines.filter(line => /^[0-9]+\./.test(line)); // 번호로 시작하는 줄만

        // 보이게 만들기
        container.removeClass("d-none");

        // 요약 텍스트 (한 줄) 표시
        summaryBox.html(`<p>${summaryText}</p>`);

        // 전체 요약을 travel-insight-item에도 보여주기
        insightItem.html(`<div class="alert alert-info">${data.summary.replace(/\n/g, "<br>")}</div>`);

        // 리스트로 여행 팁 뿌리기
        tipsList.empty();
        tips.forEach(line => {
            tipsList.append(`<li class="list-group-item">${line}</li>`);
        });

        // 차트는 여기서 호출
        renderWeatherChart();
    }

    function renderWeatherChart() {
        const canvas = document.getElementById("weatherChart");
        if (!canvas) {
            console.warn("weatherChart 캔버스가 존재하지 않습니다.");
            return;
        }

        const ctx = canvas.getContext("2d");
        if (!ctx) {
            console.warn("Canvas context를 가져올 수 없습니다.");
            return;
        }

        // 기존 차트 제거 (있으면)
        if (weatherChartInstance) {
            weatherChartInstance.destroy();
        }

        weatherChartInstance = new Chart(ctx, {
            type: "line",
            data: {
                labels: ["5/21", "5/22"],
                datasets: [
                    {
                        label: "최고 기온",
                        data: [25, 24],
                        borderWidth: 2,
                        fill: false,
                    },
                    {
                        label: "최저 기온",
                        data: [17, 16],
                        borderWidth: 2,
                        fill: false,
                    },
                ],
            },
            options: {
                animation: {
                    duration: 1500,
                    easing: "easeOutQuart"
                },
                scales: {
                    y: {
                        beginAtZero: false,
                        title: {
                            display: true,
                            text: "°C"
                        }
                    }
                },
                plugins: {
                    legend: {
                        position: "bottom"
                    },
                    title: {
                        display: true,
                        text: "서울 5월 말 날씨 예측"
                    }
                }
            }
        });
    }

// 팝업 기능을 초기화하는 함수
    function initIconPopper() {
        const tooltipTriggers = document.querySelectorAll('.offers_icons_item[data-popper-content]');

        tooltipTriggers.forEach(trigger => {
            const tooltip = document.createElement('div');
            tooltip.classList.add('popper-tooltip');
            tooltip.textContent = trigger.dataset.popperContent;
            document.body.appendChild(tooltip);

            // 1.x 버전의 Popper 사용
            const popperInstance = new Popper(trigger, tooltip, {
                placement: 'top',
                modifiers: {
                    offset: {
                        offset: '0, 8',
                    },
                    arrow: {
                        element: '.popper-arrow',
                    },
                },
            });

            const showEvents = ['mouseenter', 'focus'];
            const hideEvents = ['mouseleave', 'blur'];

            showEvents.forEach(event => {
                trigger.addEventListener(event, () => {
                    tooltip.classList.add('active');
                    popperInstance.update();
                });
            });

            hideEvents.forEach(event => {
                trigger.addEventListener(event, () => {
                    tooltip.classList.remove('active');
                });
            });
        });
    }

});