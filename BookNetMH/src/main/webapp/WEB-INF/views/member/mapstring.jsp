<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
<link rel="stylesheet" href="../css/w3.css"/>
<script type="text/javascript" src="../js/jquery-3.5.0.min.js"></script>
<style>
</style>
<script type="text/javascript">
	var qwer = '무슨시 구로구 뭐하는동';
	var asdf = qwer.indexOf('구');	// 4
	var zxcv = qwer.lastIndexOf('구');	// 6
	var asdfasdf = qwer.substring(0, zxcv+1);
	alert(asdfasdf);
	alert(typeof asdfasdf);
</script>
</head>
<body>
	<div id="qwer"></div>
</body>
</html>