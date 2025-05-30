<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .form-group {
        margin-bottom: 15px;
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
    const spaceAddPage = {
        map: null,
        geocoder: null,
        marker: null,
        init: function () {
            // 인원 증감 버튼
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

            // 지도 표시하는 버튼
            $('#search-btn').click(()=>{
                this.displayMap();
            })

            // 저장(등록)
            $('#spaceAddForm').on('submit', (e) => {
                e.preventDefault();
                if (spaceAddPage.validateForm()) {
                    let c = confirm('저장하시겠습니까?');
                    if (c === true ) {
                        const formData = new FormData($('#spaceAddForm')[0]);
                        this.addImpl(formData);
                    }
                }
            });
        },
        validateForm: function () {
            // 위치
            if ($('#location').val() === '') {
                alert("위치를 입력해주세요.");
                $('#location').focus();
                return false;
            }

            // 공간 명칭
            if ($('#name').val().trim() === '') {
                alert("스페이스 이름을 입력해주세요.");
                $('#name').focus();
                return false;
            }

            // 대표 사진 체크
            const mainImageElement = $("#image1")[0]; // 수정된 부분
            if (!mainImageElement.files || mainImageElement.files.length === 0) {
                alert("대표 사진은 필수입니다.");
                $("#image1").focus(); // jQuery 객체로 focus
                return false;
            }

            return true;
        },
        addImpl: function (formData) {
            $.ajax({
                url: "<c:url value="/api/space/add"/>",
                type: "POST",
                data: formData, // FormData 객체를 직접 전송
                processData: false, // jQuery가 데이터를 쿼리 문자열로 변환하지 않도록 설정
                contentType: false, // jQuery가 Content-Type 헤더를 설정하지 않도록 설정 (브라우저가 multipart/form-data로 자동 설정)
                success:function(resp) {
                    alert(resp);
                    location.href="<c:url value="/space/list"/>";
                },
                error: function(xhr) {
                    alert(xhr.responseText);
                }
            });
        },
        initMap: function(){
            $('#map').css({
                width: '100%',
                height: '300px'
            }).show();

            let container = $('#map').get(0);   // DOM
            let option = {
                center: new kakao.maps.LatLng(37.518276, 126.957746), // 지도의 중심좌표
                level: 5 // 지도의 확대 레벨
            }

            // 지도를 미리 생성
            this.map = new kakao.maps.Map(container, option);
            //주소-좌표 변환 객체를 생성
            this.geocoder = new kakao.maps.services.Geocoder();
            //마커를 미리 생성
            this.marker = new kakao.maps.Marker({
                position: new kakao.maps.LatLng(37.518276, 126.957746),
                map: this.map
            });
        },
        displayMap: function() {
            this.initMap();

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
        }
    };
    $(function(){
        spaceAddPage.init();
    });
    function previewImage(input, previewId) {
        const previewContainer = document.getElementById(previewId);
        previewContainer.innerHTML = "";

        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function (e) {
                const img = document.createElement("img");
                img.src = e.target.result;
                img.style.width = "100%";
                img.style.height = "120px";
                img.style.objectFit = "cover";
                img.style.borderRadius = "8px";

                const removeBtn = document.createElement("button");
                removeBtn.textContent = "제거";
                removeBtn.className = "btn btn-sm btn-outline-danger btn-block mt-1";
                removeBtn.onclick = function () {
                    input.value = "";
                    previewContainer.innerHTML = "";
                };

                previewContainer.appendChild(img);
                previewContainer.appendChild(removeBtn);
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
    function limitDetailImages(currentInput) {
        const detailInputs = document.querySelectorAll('input[id^="image"]:not(#image1)');
        let count = 0;

        detailInputs.forEach(input => {
            if (input.files.length > 0) count++;
        });

        if (count > 4) {
            alert("상세 사진은 최대 4장까지만 업로드할 수 있습니다.");
            currentInput.value = "";
            const previewId = "preview" + currentInput.id.replace("image", "");
            document.getElementById(previewId).innerHTML = "";
        }
    }
</script>

<div class="container">
    <p class="text-muted">스페이스 관리 > 내 스페이스 > <strong>스페이스 등록</strong></p>
    <div class="card shadow mb-4">
        <div class="card-body">
            <div class="table-responsive">
                <form id="spaceAddForm" style="overflow-x:hidden">
                    <h1 class="h3 mb-2 text-gray-800">기본 정보</h1>
                    <div class="row">
                    <%--category--%>
                    <div class="form-group col-sm-4">
                        <label class="mb-1 font-weight-bold text-primary" for="category">
                            건물 유형
                        </label>
                        <select class="form-control" id="category" name="category">
                            <option value="아파트">아파트</option>
                            <option value="단독주택">단독주택</option>
                            <option value="오피스텔">오피스텔</option>
                            <option value="빌라">빌라</option>
                        </select>
                    </div>
                    <%--roomType--%>
                    <div class="form-group col-sm-4">
                        <label class="mb-1 font-weight-bold text-primary" for="roomType">
                            공간 유형
                        </label>
                        <select class="form-control" id="roomType" name="roomType">
                            <option value="공간 전체">공간 전체: 게스트가 숙소 전체 단독으로 사용</option>
                            <option value="방">방: 단독으로 사용하는 개인실과 공용 공간이 있는 형태</option>
                            <option value="호스텔 내 다인실">호스텔 내 다인실: 직원이 상주하는 전문 숙박시설</option>
                        </select>
                    </div>

                    <%--personMax--%>
                    <div class="form-group col-sm-4">
                        <label class="mb-1 font-weight-bold text-primary" for="personMax">
                            최대 수용 인원 (최소 2인)
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
                            <input type="number" class="form-control text-center border-left-0 border-right-0"
                                   id="personMax" name="personMax" min="2" value="2" readonly>
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
                    </div>
                    <%--location--%>
                    <div class="form-group">
                        <label class="mb-1 font-weight-bold text-primary" for="location">
                            위치
                        </label>
                        <div class="input-group" style="border: 1px solid #ccc; border-radius: 5px; padding: 0;">
                            <div style="margin-left:10px; background-color: transparent; display: flex; align-items: center; justify-content: center;">
                              <svg fill="#222222" width="20" height="20" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 413.099 413.099">
                                <path d="M206.549,0c-82.6,0-149.3,66.7-149.3,149.3c0,28.8,9.2,56.3,22,78.899l97.3,168.399c6.1,11,18.4,16.5,30,16.5 c11.601,0,23.3-5.5,30-16.5l97.3-168.299c12.9-22.601,22-49.601,22-78.901C355.849,66.8,289.149,0,206.549,0z M206.549,193.4 c-30,0-54.5-24.5-54.5-54.5s24.5-54.5,54.5-54.5s54.5,24.5,54.5,54.5C261.049,169,236.549,193.4,206.549,193.4z"></path>
                              </svg>
                            </div>
                            <input type="text" class="form-control" id="location" placeholder="공간 주소를 입력하세요" name="location" style="border: none; background-color: #fff" readonly>
                            <div class="input-group-append" style="border: none;">
                                <button id="search-btn" class="btn btn-primary" type="button" style="border: none; border-radius: 0 5px 5px 0;">검색</button>
                            </div>
                        </div>
                        <div id="map" style="display:none;margin-top:10px;border-radius:5px;"></div>
                    </div>

                    <%--lat, lng (hidden)--%>
                    <div>
                        <input id="lat" name="latitude" type="hidden" step="any">
                        <input id="lng" name="longitude" type="hidden" step="any">
                    </div>


                    <hr>
                    <h1 class="h3 mb-2 text-gray-800">상세 정보</h1>
                    <%--image1--%>
                    <div class="form-group border p-3 rounded mb-4">
                        <label for="image1" class="mb-2 font-weight-bold text-primary">
                            대표 사진 (필수)
                        </label>
                        <input type="file" class="form-control mb-2" id="image1" name="image1" accept="image/*" onchange="previewImage(this, 'preview1')">
                        <div id="preview1" class="image-preview" style="max-width: 300px;"></div>
                    </div>

                    <%--detail image--%>
                    <div class="form-group border p-3 rounded">
                        <label class="mb-2 font-weight-bold text-secondary" for="location">
                            상세 사진 (선택, 최대 4장)
                        </label>
                        <div class="d-flex flex-wrap gap-3">
                            <c:forEach var="i" begin="2" end="5">
                                <div style="width: 240px;">
                                    <input type="file" class="form-control mb-2" id="image${i}" name="image${i}" accept="image/*"
                                           onchange="limitDetailImages(this); previewImage(this, 'preview${i}')">
                                    <div id="preview${i}" class="image-preview"></div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <%--name--%>
                    <div class="form-group">
                        <label class="mb-1 font-weight-bold text-primary" for="name">
                            스페이스 이름
                        </label>
                        <input type="text" class="form-control" id="name" placeholder="스페이스 이름은 필수입니다." value="진만이네 별장" name="name">
                    </div>
                    <%--description--%>
                    <div class="form-group">
                        <label class="mb-1 font-weight-bold text-primary" for="description">
                            스페이스 소개글 (최대 150자)
                        </label>
                        <textarea class="form-control" name="description" id="description" style="resize: none !important;">백현동에서 가까운 별장</textarea>
                    </div>
                    <%--notice--%>
                    <div class="form-group">
                        <label class="mb-1 font-weight-bold text-primary" for="notice">
                            스페이스 공지사항
                        </label>
                        <textarea class="form-control overflow-auto" name="notice" id="notice" style="min-height: 120px;">이용 규칙 설명해드립니다~ ...</textarea>
                    </div>

                    <hr>
                    <h1 class="h3 mb-2 text-gray-800">추가 옵션</h1>
                    <%--breakfast--%>
                    <div class="form-group">
                        <label class="switch">
                            <input type="checkbox" name="breakfast" id="breakfast">
                            <span class="slider round"></span>
                            조식 포함
                        </label>
                    </div>
                    <%--pool--%>
                    <div class="form-group">
                        <label class="switch">
                            <input type="checkbox" name="pool" id="pool">
                            <span class="slider round"></span>
                            수영장 포함
                        </label>
                    </div>
                    <%--barbecue--%>
                    <div class="form-group">
                        <label class="switch">
                            <input type="checkbox" name="barbecue" id="barbecue">
                            <span class="slider round"></span>
                            바베큐 가능
                        </label>
                    </div>
                    <%--pet--%>
                    <div class="form-group">
                        <label class="switch">
                            <input type="checkbox" name="pet" id="pet">
                            <span class="slider round"></span>
                            반려동물 동반 가능
                        </label>
                    </div>

                    <hr>
                    <h1 class="h3 mb-2 text-gray-800">가격 설정</h1>
                    <%--priceNight--%>
                    <div class="form-group">
                        <label class="mb-1 font-weight-bold text-primary" for="priceNight">
                            1박당 가격
                        </label>

                        <div class="d-flex align-items-center">
                            <input
                                    type="number"
                                    id="priceValue"
                                    class="form-control mr-3"
                                    min="0"
                                    max="500000"
                                    step="1000"
                                    value="15000"
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
                                    value="15000"
                                    oninput="document.getElementById('priceValue').value = this.value"
                            >
                        </div>
                    </div>
                    <button id="btn_add" type="submit" class="btn btn-primary mt-3">
                        스페이스 등록하기
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
