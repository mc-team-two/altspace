<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<style>

    .form-group label {
        margin-top: 10px; /* 원하는 간격으로 조정 */
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

    var map;
    var marker;

    function initMap(lat, lng) {
        var mapContainer = document.getElementById('map');
        var mapOption = {
            center: new kakao.maps.LatLng(lat, lng),
            level: 3
        };

        map = new kakao.maps.Map(mapContainer, mapOption);

        marker = new kakao.maps.Marker({
            position: new kakao.maps.LatLng(lat, lng)
        });
        marker.setMap(map);
    }

    $(document).ready(function() {
        $('#searchBtn').click(function() {
            var address = $('#address').val();
            $.ajax({
                url: 'https://dapi.kakao.com/v2/local/search/address.json',
                type: 'GET',
                headers: {
                    'Authorization': 'KakaoAK YOUR_REST_API_KEY'
                },
                data: {
                    query: address
                },
                success: function(data) {
                    if (data.documents.length > 0) {
                        var lat = data.documents[0].y;
                        var lng = data.documents[0].x;
                        initMap(lat, lng);
                    } else {
                        alert('주소를 찾을 수 없습니다.');
                    }
                },
                error: function() {
                    alert('주소 검색에 실패했습니다.');
                }
            });
        });
    });

    const person_max = {
        init:function(){
            $('#btnup').click(()=>{
                let txt = $('#count').text();
                let num = Number(txt) + 1;
                $('#person_max').text(num);
            });
            $('#btndown').click(()=>{
                let txt = $('#person_max').text();
                let num = Number(txt) - 1;
                $('#person_max').text(num);
            });
        }
    }
    $().ready(function(){
        person_max.init();
    });

    let space_add = {
        init:function(){

            $('#space_add_form > #btn_add').click(()=>{

                let c = confirm('공간을 추가하시겠습니까?');
                if(c == true){
                    this.send();
                }
            });
        },
        send:function(){
            $('#space_add_form').attr({
                'method':'post',
                'enctype':'multipart/form-data',
                'action':'<c:url value="#"/>'
            });
            $('#space_add_form').submit();
        }
    };
    $(function(){
        space_add.init();
    });
</script>



<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">공간 추가</h1>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">나의 공간을 제공해 보세요!</h6>
        </div>

        <div class="card-body">
            <div class="table-responsive">
                <form id="space_add_form">

                    <div class="form-group">
                        <label for="name">공간 이름</label>
                        <input type="text" class="form-control" id="name" placeholder="공간 이름을 입력하세요." name="spaceName">
                    </div>

                    <div class="form-group">
                        <label for="description">상세 설명</label>
                        <textarea class="form-control" name="description" placeholder="#서울역 근처 #침대 2개" id="description"></textarea>
                    </div>

                    <div class="row">
                        <div class="col-sm-5">
                            <div class="form-group">
                                <label for="location">공간 위치</label>
                                <input type="text" class="form-control" id="location" placeholder="공간 주소를 입력하세요" name="location">
                                <button id="searchBtn" class="btn btn-primary mt-3">검색</button>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div id="map">지도를 이곳에 가져옵니다.</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="price_night">1박당 가격</label>
                        <input type="number" class="form-control" id="price_night" min="0" placeholder="가격을 입력하세요." name="price_night">
                    </div>

                    <div class="form-group">
                        <label for="person_max">최대 수용 인원</label>
                        <input type="number" class="form-control" name="person_max" min="0" placeholder="최대 수용 인원을 입력하세요." id="person_max">
                    </div>

                    <div class="form-group">
                        <label class="switch">
                            <input type="checkbox" name="status" id="status">
                            <span class="slider round"></span>
                            사용 가능
                        </label>
                    </div>

                    <div class="form-group">
                        <label class="switch">
                            <input type="checkbox" name="breakfast" id="breakfast">
                            <span class="slider round"></span>
                            조식 포함
                        </label>
                    </div>

                    <div class="form-group">
                        <label class="switch">
                            <input type="checkbox" name="pool" id="pool">
                            <span class="slider round"></span>
                            수영장 포함
                        </label>
                    </div>

                    <div class="form-group">
                        <label class="switch">
                            <input type="checkbox" name="barbecue" id="barbecue">
                            <span class="slider round"></span>
                            바베큐 가능
                        </label>
                    </div>

                    <div class="form-group">
                        <label class="switch">
                            <input type="checkbox" name="pet" id="pet">
                            <span class="slider round"></span>
                            반려동물 동반 가능
                        </label>
                    </div>

                    <div class="form-group">
                        <label for="category">공간 건물 유형</label>
                        <select class="form-control" id="category" name="category">
                            <option value="아파트">아파트</option>
                            <option value="단독주택">단독주택</option>
                            <option value="오피스텔">오피스텔</option>
                            <option value="빌라">빌라</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="room_type">사용할 공간 유형</label>
                        <select class="form-control" id="room_type" name="room_type">
                            <option value="공간 전체">공간 전체: 게스트가 숙소 전체 단독으로 사용</option>
                            <option value="방">방: 단독으로 사용하는 개인실과 공용 공간이 있는 형태</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="image">공간 사진 추가</label>
                        <input type="file" class="form-control" id="image" placeholder="Enter name" name="image">
                    </div>

                    <button id="btn_add" type="button" class="btn btn-primary mt-3">공간 추가하기</button>

                </form>
            </div>
        </div>
    </div>

</div>


