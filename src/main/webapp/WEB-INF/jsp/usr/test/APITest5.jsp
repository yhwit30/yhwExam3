<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="API TEST"></c:set>

<%@ include file="../common/head.jspf"%>





<script>
	
	async function getData() {
		const API_KEY = '%2BczOQiKpEnorU9I8TbELu0DP9c3DNrENiO4%2Fn2%2Fz5h4ecmec6LdcOy2WXWcHP%2F2TCPAQmHpPoCmhv%2FvFogSagQ%3D%3D';
		const url = 'http://apis.data.go.kr/B551011/KorService1/detailInfo1?serviceKey='+API_KEY+ '&pageNo=1&numOfRows=10&MobileApp=AppTest&MobileOS=ETC&contentId=2987549&contentTypeId=25&_type=json';
		const response = await fetch(url);
		const data = await response.json();
		console.log("data", data);
	}
	
	getData();
	

	
	
</script>

<%@ include file="../common/foot.jspf"%>