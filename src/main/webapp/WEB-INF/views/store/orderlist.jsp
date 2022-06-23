<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>

<!DOCTYPE html>
<html>
<head>
<style>
.jumbotron {
text-align : center;

}

</style>




<%@ include file = "/WEB-INF/subModules/bootstrapHeader.jsp" %>


<title>주문완료 페이지</title>
</head>
<body>
<div class= "container">
<nb:navbar/>
<nb:scroll />

<div class="jumbotron">
	<h1 class="display-4">주문 완료</h1>
	<hr class="my-4">
    <p>${user.userName }님의 주문이 완료되었습니다</p>
    <p>잔여 포인트: ${user.userpoint} 포인트</p>
<button onclick="location.href='${appRoot}/store/home'" class="btn btn-primary" id="storeBtn">스토어 홈으로 돌아가기</button>

</div>

	<footer>
		<nb:footer/>
	</footer>

</div>
</body>
</html>