<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<link rel="shortcut icon" type="image/x-icon" href="${appRoot }/resources/img/triple.png">
<title>Q&#38;A</title>
<style type="text/css">
.top_bg {
	width: 100%;
	height: 100px;
}

.list-group .list-group-item.active, .list-group .show>.list-group-item
	{
	background-color: #6d0d27;
}

.list-group {
	flex-direction: inherit;
}

.list-group-item {
	border: none;
}

.table {
	min-height: 500px;
}

.Q_title {
	cursor: pointer;
}

.answer {
	display: none;
}
</style>

<script type="text/javascript">
	$(document).ready(
			function() {

				$(".Q_title").click(
						function() {

							$(".answer").slideUp();

							$(".fa-chevron-down").css('transform', 'none');
							if (!$(this).next().is(":visible")) {

								$(this).next().slideDown();
								$(this).find(".fa-chevron-down:eq(0)").css(
										'transform', 'rotate(180deg)');
							}
						});

			})
</script>
</head>
<body>
	<div class="container">

		<nb:navbar />

		<div class="top_bg text-center ">

			<h3 class="p-4">Q&#38;A</h3>

		</div>


		<div class="">
			<div class="row row-cols-3 list-group text-center" id="list-tab"
				role="tablist">
				<a class="col list-group-item list-group-item-action active"
					id="list-home-list" data-toggle="list" href="#list-home" role="tab"
					aria-controls="home">회원정보 </a>
				<a class="col list-group-item list-group-item-action"
					id="list-profile-list" data-toggle="list" href="#list-profile"
					role="tab" aria-controls="profile">숙소관련</a>

			</div>
			<div class="tab-content" id="nav-tabContent">
				<div class="tab-pane fade show active" id="list-home"
					role="tabpanel" aria-labelledby="list-home-list">
					<table class="table">
						<tbody>
							<tr class="d-flex flex-column">
								<td>
									<h5 class="Q_title">
										Q 비밀번호 변경은 어떻게하나요?
										<i class="fas fa-chevron-down"></i>
									</h5>
									<p class="answer">로그인 후 우측 상단 마이페이지 클릭 후 마이페이지에서 비밀번호 변경이
										가능합니다.</p>
								</td>
								<td>
									<h5 class="Q_title">
										Q 회원탈퇴 후 재가입이 가능한가요?
										<i class="fas fa-chevron-down"></i>
									</h5>
									<p class="answer">재가입은 언제든지 가능합니다.</p>
								<td>
									<h5 class="Q_title">
										Q 회원정보를 수정하고 싶은데 어떻게 해야하나요?
										<i class="fas fa-chevron-down"></i>
									</h5>
									<p class="answer">로그인 후 우측 상단 마이페이지 클릭 후 마이페이지에서 회원 정보 수정이
										가능합니다.</p>
								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="tab-pane fade" id="list-profile" role="tabpanel"
					aria-labelledby="list-profile-list">
					<table class="table">
						<tbody>
							<tr class="d-flex flex-column">
								<td>
									<h5 class="Q_title">
										Q 숙소 예약은 어떻게 하나요?
										<i class="fas fa-chevron-down"></i>
									</h5>
									<p class="answer">
										죄송합니다. 현재 숙소 예약은 준비중에 있습니다.
										<br />
										빠른 시일 내로 보답해드리겠습니다.
									</p>
								</td>
							</tr>

						</tbody>
					</table>
				</div>
			</div>

			<footer>
				<nb:footer></nb:footer>
			</footer>

		</div>
</body>
</html>