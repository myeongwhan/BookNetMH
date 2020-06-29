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
<div id="map" style="width:100%;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4e007890c1de552b09210e1d028ac98d"></script>
<script>

let lat = 1,
	lon = 2;

navigator.geolocation.getCurrentPosition(function(position){
		lat = position.coords.latitude;	// 위도
		lon = position.coords.longitude;// 경도
		alert(lat);
		alert(lon);
	map.setCenter(new kakao.maps.LatLng(lat, lon));

});

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 


	alert(lat);
	alert(lon);

</script>
</body>
</html>