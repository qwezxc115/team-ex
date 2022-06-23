<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>에러페이지-500  </title>
</head>
<body>
	<div class="container">
		
		<div class="justify-content-center m-3 p-2 text-center">
			<h5>서버내부 오류 : 500  </h5>
			<img alt="gohomeerror"  src="${appRoot }/resources/img/error.png"/>
			<hr>
			<h3> 죄송합니다. 현재서비스의 상태가 원활하지 않습니다.  </h3>
			<p>서버가 요청사항을 수행할 수 없습니다 다시 확인하시고 사용해주십시오. 
			<p>이 오류가 계속 발생 할 경우 고객센터 관리자에게 문의해주세요.
			<p>감사합니다.
			<br>
			<a href="${appRoot }/main/home" class="btn btn-primary">메인으로 </a>
		</div>
	</div>
</body>
</html>