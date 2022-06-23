<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>에러페이지-400 </title>
</head>
<body>
	<div class="container">
		<div class="justify-content-center m-3 p-2 text-center">
			<h5>오류원인 : 404 </h5>
			<img alt="gohomeerror"  src="${appRoot }/resources/img/error.png"/>
			<hr>
			<h3>죄송합니다. 현재 찾을 수 없는 페이지를 요청 하셨습니다. </h3>
			<p>존재 하지않은 주소를 입력하셨거나. 요청하신 페이지의 경로가 잘못 찾을 수 없습니다.
			<p>궁금한 점이 있으시면 언제든 고객센터를 통해 문의해 주시길 바랍니다.
			<b>감사합니다. </b>
			<br>
			<br>
			<a href="${appRoot }/main/home" class="btn btn-primary">메인으로 </a>
		</div>
	</div>
</body>
</html>