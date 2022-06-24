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

<style type="text/css">
.row, .keyword, .productlist {
	margin-top: 20px;
}

hr {
	margin: 0px;
}

a {
	color: black;
}

a:hover {
	color: black;
	text-decoration: none;
}

#imgsize {
	max-width: 100%;
	height: 250px;
	padding: 5px;
}

#imgtop {
	max-width: 100%;
	height: 250px;
	padding: 5px;
}

.imgview {
	width: 100%;
	height: 250px;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		$(".category-btn").click(function(e) {
			e.preventDefault();
			var category = $(this).attr("href");
			$("#actionForm [name=category]").val(category);
			$("#actionForm").submit();
		});

		$(".page-link").click(function(e) {
			e.preventDefault();

			var pageNum = $(this).attr("href");
			$("#actionForm [name=pageNum]").val(pageNum);
			$("#actionForm").submit();

		})
	})
</script>

<link rel="shortcut icon" type="image/x-icon"
	href="${appRoot }/resources/img/triple.png">
<title>소개</title>

</head>
<body>
	<div class="container">
		<nb:navbar />
		<nb:scroll />
		

			<div class="col-10">
				<!-- 소개 -->
				<div class="productlist">
					<h1>제목</h1>

					<div class="row row-cols-md-4">
						<h2>내용1</h2>
					</div>

					<div>
						<h2>내용2</h2>
					</div>

				</div>
			</div>
		</div>

		<footer>
			<nb:footer />
		</footer>
	</div>

</body>
</html>