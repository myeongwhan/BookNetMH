<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
<link rel="stylesheet" href="../css/w3.css" />
<script type="text/javascript" src="../js/jquery-3.5.0.min.js"></script>
<style>
</style>
<script type="text/javascript">
$(function(){
	$.ajax({
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
	
</script>
</head>
<body>
	<div id="qwer">qwer</div>
</body>
</html>