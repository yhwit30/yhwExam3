<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="API TEST2"></c:set>

<%@ include file="../common/head.jspf"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>네이버 지역 검색</title>

</head>
<body>
	
	
	<!-- 질문 -->
<div class="flex justify-center items-center gap-4 mt-20">
	<p>질문 :</p>
	<input type="text" placeholder="Type here" class="input input-bordered w-full max-w-xs " />
	<button class="btn btn-info">Success</button>
</div>
	
	<div>
	
	${result }
	
	</div>
	
</body>
</html>

<%@ include file="../common/foot.jspf"%>