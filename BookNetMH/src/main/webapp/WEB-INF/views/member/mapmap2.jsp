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
	<!-- 지도를 표시할 div 입니다 -->
	<div id="map" style="width: 100%; height: 350px;"></div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4e007890c1de552b09210e1d028ac98d&libraries=services"></script>
	<script type="text/javascript">
	// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

	// 1. 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	navigator.geolocation.getCurrentPosition(function(position){
// 		alert('현재위치 실행');
		lat = position.coords.latitude;	// 위도
		lon = position.coords.longitude;// 경도
// 		alert(lat);
// 		alert(lon);
		map.setCenter(new kakao.maps.LatLng(lat, lon));
	});
	
	// 2. 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	setTimeout(function(){
		geocoder.coord2RegionCode(lon, lat, displayInfo);
	}, 50);
	
	// 3. 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
	function displayInfo(result, status) {
// 		alert('# displayCenterInfo');
		if (status === kakao.maps.services.Status.OK) {

			for (var i = 0; i < result.length; i++) {
				// 행정동의 region_type 값은 'H' 이므로
				if (result[i].region_type === 'H') {
					qwer = result[i].address_name;
// 					alert(qwer);
					break;
				}
			}
		}
//			alert(qwer);
//			alert(typeof qwer);
	}
	
	setTimeout(function(){
// 		alert(qwer);
		asdf = qwer.lastIndexOf('동');
// 		alert(asdf);
		keyword = qwer.substring(0, asdf+1) + ' 서점';
// 		alert(keyword);
	}, 150);

	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places(); 

	// 4. 키워드로 장소를 검색합니다
	setTimeout(function(){
		ps.keywordSearch(keyword, placesSearchCB); 
	}, 300);
	
	setTimeout(function(){
		myLoc();
	}, 450);

	// 키워드 검색 완료 시 호출되는 콜백함수 입니다
	function placesSearchCB (data, status, pagination) {
// 		alert('키워드검색 시작');
	    if (status === kakao.maps.services.Status.OK) {

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        var bounds = new kakao.maps.LatLngBounds();

	        for (var i=0; i<data.length; i++) {
	            displayMarker(data[i]);    
	            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
	        }       
// 			alert('마커 종료');

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
// 			alert('지도범위 재설정');
	        map.setBounds(bounds);
	    } 
// 		alert('키워드검색 종료');
	}

	// 5. 지도에 마커를 표시하는 함수입니다
	function displayMarker(place) {
	    
	    // 마커를 생성하고 지도에 표시합니다
	    var marker = new kakao.maps.Marker({
	        map: map,
	        position: new kakao.maps.LatLng(place.y, place.x) 
	    });

	    // 마커에 클릭이벤트를 등록합니다
	    kakao.maps.event.addListener(marker, 'click', function() {
	        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
	        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
	        infowindow.open(map, marker);
	    });
	}
	
	function myLoc() {
		var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/2009/map/icon/ico_mn_13.png', // 마커이미지의 주소입니다    
	    imageSize = new kakao.maps.Size(40, 44), // 마커이미지의 크기입니다
	    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	      
		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
		    markerPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치입니다
	
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition, 
		    image: markerImage // 마커이미지 설정 
		});
	
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		// 마커에 클릭이벤트를 등록합니다
	    kakao.maps.event.addListener(marker, 'click', function() {
	        // 마커를 클릭하면 '내 위치'가 인포윈도우에 표출됩니다
	        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + '내 위치' + '</div>');
	        infowindow.open(map, marker);
	    });
	}
	
	
	</script>
</body>
</html>