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
<meta charset="UTF-8">


<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<link rel="shortcut icon" type="image/x-icon"
	href="${appRoot }/resources/img/triple.png">
<title>소개</title>

<style>
.title-content {
	font-size: 4.0rem;
	background: linear-gradient(to right, #B8E9FF, #18A8F1);
	color: transparent;
	-webkit-background-clip: text;
}

.intro-content {
	font-size: 2.0rem;
}

.step-img {
	text-align: center;
}
</style>

</head>
<body>
	<div class="container">
		<nb:navbar />

		<div class="top_bg text-center ">
			<section class="text-center about-section-1">
				<div class="p-2">
					<h3 class="title-content">나만의 여행 경험을 모두와 공유하다.</h3>
				</div>

				<div class="intro-content">
					<img src="${appRoot }/resources/img/writer.jpg" class="w-50" />
					<br />
					트리플은 여러분의 여행 경험을 공유하는 플랫폼입니다.
					<br>
					여러분의 새롭고 다양한 경험을 모두에게 알려주세요.
					<br>
					트리플은 여러분들과 함께 최고의 여행을 준비하겠습니다.
					<br>
				</div>
			</section>

			<br />
			<br />

			<section class="text-center about-section-2">
				<ul class="row list-unstyled service-process-list">
					<li class="col-sm-6 col-md-3 service-process-step">
						<div class="step-img">
							<img src="${appRoot }/resources/img/write.png" class="w-50" />
						</div>
						<div class="step-description">
							<div class="main">1. 자유게시판 선택</div>
							<div class="sub">경험했던 여행을 작성합니다.</div>
						</div>
					</li>
					<li class="col-sm-6 col-md-3 service-process-step">
						<div class="step-img">
							<img src="${appRoot }/resources/img/category.png" class="w-50" />
						</div>
						<div class="step-description">
							<div class="main">2. 카테고리 선택</div>
							<div class="sub">글에 맞는 카테고리 메뉴를 선택합니다.</div>
						</div>
					</li>
					<li class="col-sm-6 col-md-3 service-process-step">
						<div class="step-img">
							<img src="${appRoot }/resources/img/picture.jpg" class="w-50" />
						</div>
						<div class="step-description">
							<div class="main">3. 사진 선택</div>
							<div class="sub">같이 올릴 사진을 선택합니다.</div>
						</div>
					</li>
					<li class="col-sm-6 col-md-3 service-process-step">
						<div class="step-img">
							<img src="${appRoot }/resources/img/select.png" class="w-50" />
						</div>
						<div class="step-description">
							<div class="main">4. 작성 선택</div>
							<div class="sub">작성을 눌러 게시글 작성을 마칩니다.</div>
						</div>
					</li>
				</ul>
			</section>

		</div>


		<footer>
			<nb:footer />
		</footer>
	</div>

</body>
</html>