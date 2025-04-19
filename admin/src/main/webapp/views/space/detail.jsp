<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .form-group {
        margin-bottom: 15px;
    }
    .button {
        margin-top: 10px; /* 원하는 간격으로 조정 */
    }

    #map{
        width: 100%;
        height: 200px;
    }

    .switch {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        font-size: 16px;
    }

    .switch input {
        display: none;
    }

    .slider {
        position: relative;
        width: 40px;
        height: 20px;
        background-color: #ccc;
        border-radius: 20px;
        transition: 0.4s;
        cursor: pointer;
    }

    .slider::before {
        content: "";
        position: absolute;
        width: 16px;
        height: 16px;
        left: 2px;
        top: 2px;
        background-color: white;
        border-radius: 50%;
        transition: 0.4s;
    }

    input:checked + .slider {
        background-color: #4CAF50;
    }

    input:checked + .slider::before {
        transform: translateX(20px);
    }

    .slider.round {
        border-radius: 34px;
    }

    .slider.round::before {
        border-radius: 50%;
    }
</style>

<script>
    const space_update = {
        map: null,
        geocoder: null,
        marker: null,
        init: function () {
            $('#plus-btn').click(() => {
                let val = Number($('#personMax').val());
                $('#personMax').val(val + 1);
            });
            $('#minus-btn').click(() => {
                let val = Number($('#personMax').val());
                if (val > 2) { // 최소값 2 유지
                    $('#personMax').val(val - 1);
                }
            });
            $('#btn_update').click(() => {
                if (this.validateForm()) {
                    let c = confirm('스페이스 정보를 수정하시겠습니까?');
                    if (c === true) {
                        this.send();
                    }
                }
            });
            $('#search-btn').on('click', function(){
                space_update.displayMap(); // 주소 검색 팝업은 이때만 뜰 수 있도록 함.
            });
        },
        validateForm: function () {
            let isValid = true;

            // 공간 명칭 체크
            if ($('#location').val() === '') {
                alert("위치를 입력해주세요.");
                isValid = false;
            }

            // 이미지 체크 (대표 사진)
            if ($('#image1').val() === '') {
                alert("대표 사진을 업로드해주세요.");
                isValid = false;
            }

            // 스페이스 명칭 체크
            if ($('#name').val().trim() === '') {
                alert("스페이스 이름을 입력해주세요.");
                isValid = false;
            }

            return isValid;
        },
        initMap: function(){
            $('#map').css({
                width: '100%',
                height: '300px'
            });
            $('#map').show();

            let container = $('#map').get(0);   // DOM
            let option = {
                center: new kakao.maps.LatLng(${data.latitude}, ${data.longitude}),    //지도의 중심 좌표
                level: 5 // 지도의 확대 레벨
            }

            // 지도를 미리 생성
            this.map = new kakao.maps.Map(container, option);
            //주소-좌표 변환 객체를 생성
            this.geocoder = new kakao.maps.services.Geocoder();
            //마커를 미리 생성
            this.marker = new kakao.maps.Marker({
                position: new kakao.maps.LatLng(${data.latitude}, ${data.longitude}),
                map: this.map
            });
        },
        displayMap: function () {
            this.initMap(); // 지도 초기화

            let map = this.map;
            let geocoder = this.geocoder;
            let marker = this.marker;

            // 주소 검색 api 열기
            new daum.Postcode({
                oncomplete: function(data) {
                    var addr = data.address;    // 최종 주소 변수

                    // 주소 정보를 검색 필드에 넣기
                    $("#location").val(addr);
                    geocoder.addressSearch(addr, function(result, status) {

                        // 정상적으로 검색이 완료됐으면
                        if (status === kakao.maps.services.Status.OK) {
                            // 위경도값
                            let coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                            // input 창에 display
                            $('#lat').val(result[0].y);
                            $('#lng').val(result[0].x);

                            // 기존 마커 제거
                            marker.setMap(null);

                            // 결과값으로 받은 위치를 마커로 표시합니다
                            marker = new kakao.maps.Marker({
                                map: map,
                                position: coords
                            });

                            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                            map.setCenter(coords);
                        }
                    });
                }
            }).open();
        },
        send: function () {
            $('#space_update_form').attr({
                'method': 'post',
                'enctype': 'multipart/form-data',
                'action': '<c:url value="/space/updatespace"/>'
            });
            $('#space_update_form').submit();
            alert("스페이스 정보가 수정되었습니다.")
        }
    };
    $(function(){
        space_update.init();
        space_update.initMap(); // 지도만 미리 보여주기 (팝업 없이)
    });
</script>

<div class="col-sm-12">

    <div class="card shadow mb-4">

        <div class="card-header">
            <h2>스페이스 수정하기</h2>
        </div>

        <div class="card-body">
            <div class="table-responsive">
                <form id="space_update_form" style="overflow-x:hidden">
                    <h1 class="h3 mb-2 text-gray-800">기본 정보</h1>
                    <div class="row">

                        <input type="hidden" name="accommodationId" value="${data.accommodationId}">
                        <input type="hidden" name="status" value="활성">

                    <%--category--%>
                    <div class="form-group col-sm-4">
                        <label for="category">
                            <h6 class="m-0 font-weight-bold text-primary">건물 유형</h6>
                        </label>
                        <select class="form-control" id="category" name="category">
                            <option value="아파트" <c:if test="${data.category eq '아파트'}">selected</c:if>>아파트</option>
                            <option value="단독주택" <c:if test="${data.category eq '단독주택'}">selected</c:if>>단독주택</option>
                            <option value="오피스텔" <c:if test="${data.category eq '오피스텔'}">selected</c:if>>오피스텔</option>
                            <option value="빌라" <c:if test="${data.category eq '빌라'}">selected</c:if>>빌라</option>
                        </select>
                    </div>
                    <%--roomType--%>
                    <div class="form-group col-sm-4">
                        <label for="roomType">
                            <h6 class="m-0 font-weight-bold text-primary">공간 유형</h6>
                        </label>
                        <select class="form-control" id="roomType" name="roomType">
                            <option value="공간 전체" <c:if test="${data.roomType eq '공간 전체'}">selected</c:if>>
                                공간 전체: 게스트가 숙소 전체 단독으로 사용
                            </option>
                            <option value="방" <c:if test="${data.roomType eq '방'}">selected</c:if>>
                                방: 단독으로 사용하는 개인실과 공용 공간이 있는 형태
                            </option>
                            <option value="호스텔 내 다인실" <c:if test="${data.roomType eq '호스텔 내 다인실'}">selected</c:if>>
                                호스텔 내 다인실: 직원이 상주하는 전문 숙박시설
                            </option>
                        </select>
                    </div>

                    <%--personMax--%>
                    <div class="form-group col-sm-4">
                        <label for="personMax">
                            <h6 class="m-0 font-weight-bold text-primary">최대 수용 인원 (최소 2인)</h6>
                        </label>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <div id="minus-btn" role="button"
                                     class="d-flex align-items-center justify-content-center rounded-circle"
                                     style="width: 32px; height: 32px; background-color: #fff; cursor: pointer;">
                                    <svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" fill="#333333" width="20" height="20">
                                        <path d="M532,1117 C524.268,1117 518,1110.73 518,1103 C518,1095.27 524.268,1089 532,1089 C539.732,1089 546,1095.27 546,1103 C546,1110.73 539.732,1117 532,1117 Z
                                            M532,1087 C523.163,1087 516,1094.16 516,1103 C516,1111.84 523.163,1119 532,1119 C540.837,1119 548,1111.84 548,1103 C548,1094.16 540.837,1087 532,1087 Z
                                            M538,1102 L526,1102 C525.447,1102 525,1102.45 525,1103 C525,1103.55 525.447,1104 526,1104 L538,1104 C538.553,1104 539,1103.55 539,1103 C539,1102.45 538.553,1102 538,1102 Z"
                                              transform="translate(-516 -1087)"></path>
                                    </svg>
                                </div>
                            </div>

                            <input type="number"
                                   class="form-control text-center border-left-0 border-right-0"
                                   id="personMax" name="personMax"
                                   min="2"
                                   value="${data.personMax}"
                                   readonly>
                            <div class="input-group-append">
                                <div id="plus-btn" role="button"
                                     class="d-flex align-items-center justify-content-center rounded-circle"
                                     style="width: 32px; height: 32px; background-color: #fff; cursor: pointer;">
                                    <svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" fill="#000000" width="20" height="20">
                                        <path d="M480,1117 C472.268,1117 466,1110.73 466,1103 C466,1095.27 472.268,1089 480,1089 C487.732,1089 494,1095.27 494,1103 C494,1110.73 487.732,1117 480,1117 L480,1117 Z M480,1087 C471.163,1087 464,1094.16 464,1103 C464,1111.84 471.163,1119 480,1119 C488.837,1119 496,1111.84 496,1103 C496,1094.16 488.837,1087 480,1087 L480,1087 Z M486,1102 L481,1102 L481,1097 C481,1096.45 480.553,1096 480,1096 C479.447,1096 479,1096.45 479,1097 L479,1102 L474,1102 C473.447,1102 473,1102.45 473,1103 C473,1103.55 473.447,1104 474,1104 L479,1104 L479,1109 C479,1109.55 479.447,1110 480,1110 C480.553,1110 481,1109.55 481,1109 L481,1104 L486,1104 C486.553,1104 487,1103.55 487,1103 C487,1102.45 486.553,1102 486,1102 L486,1102 Z"
                                              transform="translate(-464 -1087)"></path>
                                    </svg>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--location--%>
                    <div class="form-group">
                        <label for="location">
                            <h6 class="m-0 font-weight-bold text-primary">위치</h6>
                        </label>
                        <div class="input-group" style="border: 1px solid #ccc; border-radius: 5px; padding: 0;">
                            <div style="margin-left:10px; background-color: transparent; display: flex; align-items: center; justify-content: center;">
                              <svg fill="#222222" width="20" height="20" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 413.099 413.099">
                                <path d="M206.549,0c-82.6,0-149.3,66.7-149.3,149.3c0,28.8,9.2,56.3,22,78.899l97.3,168.399c6.1,11,18.4,16.5,30,16.5 c11.601,0,23.3-5.5,30-16.5l97.3-168.299c12.9-22.601,22-49.601,22-78.901C355.849,66.8,289.149,0,206.549,0z M206.549,193.4 c-30,0-54.5-24.5-54.5-54.5s24.5-54.5,54.5-54.5s54.5,24.5,54.5,54.5C261.049,169,236.549,193.4,206.549,193.4z"></path>
                              </svg>
                            </div>
                            <input type="text" class="form-control" id="location" placeholder="공간 주소를 입력하세요" name="location" value="${data.location}" style="border: none; background-color: #fff" readonly>
                            <div class="input-group-append" style="border: none;">
                                <button id="search-btn" class="btn btn-primary" type="button" style="border: none; border-radius: 0 5px 5px 0;">검색</button>
                            </div>
                        </div>
                        <div id="map" style="margin-top:10px;border-radius:5px;"></div>
                    </div>

                    <%--lat, lng (hidden)--%>
                    <div>
                        <input id="lat" name="latitude" type="hidden" step="any" value="${data.latitude}">
                        <input id="lng" name="longitude" type="hidden" step="any" value="${data.longitude}">
                    </div>

                    <hr>
                    <h1 class="h3 mb-2 text-gray-800">상세 정보</h1>
                    <%--image1--%>
                    <div class="form-group">
                        <label for="image1"><h6 class="m-0 font-weight-bold text-primary">대표 사진</h6></label>
                        <input type="file" class="form-control" id="image1" placeholder="Enter name" name="image1">
                    </div>

                    <%--detail image--%>
                    <div class="form-group">
                        <label for="image2"><h6 class="m-0 font-weight-bold text-primary">상세 사진</h6></label>
                        <input type="file" class="form-control mb-2" id="image2" name="image2">
                        <input type="file" class="form-control mb-2" id="image3" name="image3">
                        <input type="file" class="form-control mb-2" id="image4" name="image4">
                        <input type="file" class="form-control" id="image5" name="image5">
                    </div>

                    <%--name--%>
                    <div class="form-group">
                        <label for="name">
                            <h6 class="m-0 font-weight-bold text-primary">스페이스 이름</h6>
                        </label>
                        <input type="text" class="form-control" id="name" placeholder="스페이스 이름은 필수입니다." value="${data.name}" name="name">
                    </div>
                    <%--description--%>
                    <div class="form-group">
                        <label for="description">
                            <h6 class="m-0 font-weight-bold text-primary">스페이스 소개</h6>
                        </label>
                        <textarea class="form-control" name="description" id="description" style="resize: none !important;">${data.description}</textarea>
                    </div>

                    <hr>
                    <h1 class="h3 mb-2 text-gray-800">추가 옵션</h1>
                    <%--breakfast--%>
                    <div class="form-group">
                        <label class="switch">
                            <input type="checkbox" name="breakfast" id="breakfast"
                                   <c:if test="${data.breakfast == 'true'}">checked</c:if>>
                            <span class="slider round"></span>
                            조식 포함
                        </label>
                    </div>
                    <%--pool--%>
                    <div class="form-group">
                        <label class="switch">
                            <input type="checkbox" name="pool" id="pool"
                                   <c:if test="${data.pool == 'true'}">checked</c:if>>
                            <span class="slider round"></span>
                            수영장 포함
                        </label>
                    </div>
                    <%--barbecue--%>
                    <div class="form-group">
                        <label class="switch">
                            <input type="checkbox" name="barbecue" id="barbecue"
                                   <c:if test="${data.barbecue == 'true'}">checked</c:if>>
                            <span class="slider round"></span>
                            바베큐 가능
                        </label>
                    </div>
                    <%--pet--%>
                    <div class="form-group">
                        <label class="switch">
                            <input type="checkbox" name="pet" id="pet"
                                   <c:if test="${data.pet == 'true'}">checked</c:if>>
                            <span class="slider round"></span>
                            반려동물 동반 가능
                        </label>
                    </div>

                    <hr>
                    <h1 class="h3 mb-2 text-gray-800">가격 설정</h1>
                    <%--priceNight--%>
                    <div class="form-group">
                        <label for="priceNight">
                            <h6 class="m-0 font-weight-bold text-primary">1박당 가격</h6>
                        </label>

                        <div class="d-flex align-items-center">
                            <input
                                    type="number"
                                    id="priceValue"
                                    class="form-control mr-3"
                                    min="0"
                                    max="500000"
                                    step="1000"
                                    value="${data.priceNight}"
                                    oninput="document.getElementById('priceNight').value = this.value"
                                    style="max-width: 120px;"
                            >

                            <input
                                    type="range"
                                    class="custom-range flex-grow-1"
                                    id="priceNight"
                                    name="priceNight"
                                    min="0"
                                    max="500000"
                                    step="1000"
                                    value="${data.priceNight}"
                                    oninput="document.getElementById('priceValue').value = this.value"
                            >
                        </div>
                    </div>
                </form>

                <button id="btn_update" type="button" class="btn btn-primary mt-3">
                    스페이스 수정하기
                </button>
            </div>
        </div>

    </div>

</div>

