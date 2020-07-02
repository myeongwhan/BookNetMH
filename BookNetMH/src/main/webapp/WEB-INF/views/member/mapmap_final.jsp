<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>지도 생성하기</title>
</head>
<body>
	<div class="map_wrap">
		<div id="map"
			style="width: 100%; height: 350px; position: relative; overflow: hidden;"></div>
		<div class="hAddr">
			<span class="title">지도중심기준 행정동 주소정보</span> <span id="centerAddr"></span>
		</div>
	</div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4e007890c1de552b09210e1d028ac98d&libraries=services"></script>
	<script type="text/javascript" src="../js/jquery-3.5.0.min.js"></script>
	<script>
		var qwer = 'qwer';

		// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new kakao.maps.InfoWindow({
			zIndex : 1
		});

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);
		
		// 지도에 마커를 표시하는 함수입니다
		function displayMarker(place) {
			// 마커를 생성하고 지도에 표시합니다
			var marker = new kakao.maps.Marker({
				map : map,
				position : new kakao.maps.LatLng(place.y, place.x)
			});

			// 마커에 클릭이벤트를 등록합니다
			kakao.maps.event.addListener(marker, 'click', function() {
				// 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
				infowindow
						.setContent('<div style="padding:5px;font-size:12px;">'
								+ place.place_name + '</div>');
				infowindow.open(map, marker);
			});
		}
		
		function zxcv() {	//	 주소값 뽑는 함수
			$(function(){
				$.ajax({	// 결과: 경기도 성남시 분당구 삼평동
				    url: 'https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=127.1086228&y=37.4012191',
				    headers: { 'Authorization': 'KakaoAK 10cfef9c1973cbaef3bc15ab95dcbac5' },
				    type: 'GET',
				    success: function(data){
				    	alert(data.documents[0].address_name);
				    },
				    erorr: function(){
				    	alert('통신오류');
				    }
				});
			});
		}
		
		function asdf(position) {
			alert('현재위치 실행');
			var lat = position.coords.latitude; // 위도
			lon = position.coords.longitude;// 경도
			map.setCenter(new kakao.maps.LatLng(lat, lon));
// 			alert(map.getCenter().getLng());
			alert('현재위치 종료');
			alert(qwer);
// 			callback();
		}
		
// 		function qqqq() {
// 			asdf();
// 		}
		
		
		
		// 1
		
		zxcv();
		navigator.geolocation.getCurrentPosition(asdf);

// 		주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'idle', function() {
			alert('좌표바뀜 실행');
			searchAddrFromCoords(map.getCenter(), displayCenterInfo);
			alert('좌표바뀜 종료 ');
		});

		function searchAddrFromCoords(coords, callback) {
			// 좌표로 행정동 주소 정보를 요청합니다
			alert('searchAddrFromCoords');
// 			alert(coords.getLng());
			geocoder.coord2RegionCode(coords.getLng(), coords.getLat(),
					callback);
			alert('searchAddrFromCoords 종료');
		}

		function searchDetailAddrFromCoords(coords, callback) {
			// 좌표로 법정동 상세 주소 정보를 요청합니다
			geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
		}

		// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
		function displayCenterInfo(result, status) {
			alert('# displayCenterInfo');
			if (status === kakao.maps.services.Status.OK) {
				var infoDiv = document.getElementById('centerAddr');

				for (var i = 0; i < result.length; i++) {
					// 행정동의 region_type 값은 'H' 이므로
					if (result[i].region_type === 'H') {
						infoDiv.innerHTML = result[i].address_name;
						qwer = result[i].address_name;
 						break;
					}
				}
			}
			alert(qwer);
			alert(typeof qwer);
		}

		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();

		// 키워드로 장소를 검색합니다
		alert(qwer);
		zxcv();
		ps.keywordSearch('해운대', placesSearchCB);

		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
			alert('키워드검색 실행');
			if (status === kakao.maps.services.Status.OK) {

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
				// LatLngBounds 객체에 좌표를 추가합니다
				var bounds = new kakao.maps.LatLngBounds();

				for (var i = 0; i < data.length; i++) {
					displayMarker(data[i]);
					bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
				}

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
				map.setBounds(bounds);
			}
			alert('키워드검색 종료');
		}
		// 		geocoder.coord2RegionCode(wido, gyeongdo, 
		// 			function(result, status) {
		// 			    if (status === kakao.maps.services.Status.OK) {

		// 			       qwer = result[0].address_name;
		// 			    }

		// 			    alert(qwer);
		// 			}
		// 		);
	</script>
</body>
</html>