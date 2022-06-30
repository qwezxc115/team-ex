<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb"%>


<%
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<link rel="shortcut icon" type="image/x-icon"
	href="${appRoot }/resources/img/triple.png">
<title>소개</title>

</head>
<body>
	<div class="container">
		<nb:navbar />

		<div class="col-10">
			<!-- 소개 -->
			<div>
				<h1>제목</h1>

				<div class="row row-cols-md-4">
					<h2>내용1</h2>
				</div>

				<div>
					<h2>내용2</h2>
				</div>

			</div>
		</div>
		<footer>
			<nb:footer />
		</footer>
	</div>

</body>
</html>