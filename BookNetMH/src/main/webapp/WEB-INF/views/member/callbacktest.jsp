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
	var qwer = 1000;
	
	var qwer2 = 200;
	
	function asdf(qw, er, callback) {
		var sum = qw + er;
		var num = qwer;
		callback(sum+num);
	}
	
	function zxcv(result) {
		qwer = result;
		alert(result);
		alert(qwer);
	}
	
	function asdf2() {
		qwer2 = 400;
	}
	
	asdf(110, 1, zxcv);
	
	asdf2();
	
	alert(qwer2);
	alert('전역' + qwer);
	
	
</script>
</head>
<body>
	<div id="qwer">qwer</div>
</body>
</html>