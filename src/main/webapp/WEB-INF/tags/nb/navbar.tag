<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<script>
	$(document).ready(function() {
		//로그아웃 동작 
		$("#navbar-logout-link").click(function(e) {
			e.preventDefault();
			$("#navbar-logout-form").submit();
		});

		$("#booking").click(function() {
			alert("Comming Soon");
			$("#input-title").focus();
			return false;
		});

	})
</script>

<style>
.dropdown-menu {
	font-size: 1.3rem;
}
</style>

<!-- 로그인  -->
<div class="d-flex justify-content-end">
	<nav class="navbar navbar-expand-sm navbar-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="#"></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav">
					<sec:authorize access="!isAuthenticated()">
						<li class="nav-item">
							<a class="nav-link" href="${appRoot }/main/login">로그인 </a>
						</li>
					</sec:authorize>

					<sec:authorize access="!isAuthenticated()">
						<li class="nav-item">
							<a class="nav-link" href="${appRoot }/main/tos" tabindex="-1"
								aria-disabled="true">회원가입 </a>
						</li>
					</sec:authorize>
					<sec:authorize access="!isAuthenticated()">

					</sec:authorize>



					<!-- 로그아웃, 마이페이지 로그인한 사용자만 보이게  -->
					<sec:authorize access="isAuthenticated()">

						<li class="nav-item p-2">
							<sec:authentication property="principal.user.userName" />
							<span style="color: #6d0d27;">님 반갑습니다 !</span>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="#" id="navbar-logout-link">로그아웃</a>
						</li>
					</sec:authorize>

					<sec:authorize access="isAuthenticated()">

						<li class="nav-item">
							<a class="nav-link" href="${appRoot }/mypage/home">마이페이지 </a>
						</li>
					</sec:authorize>

					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<li class="nav-item">
							<a class="nav-link" href="${appRoot }/admin/home" tabindex="-1"
								aria-disabled="true">관리자페이지 </a>
						</li>
					</sec:authorize>

				</ul>
			</div>
		</div>
	</nav>
</div>
<!-- 로그아웃  -->
<form action="${appRoot }/logout" method="post" id="navbar-logout-form">
</form>


<div class="navbar row justify-content-center p-0">
	<div class="col-md-3 text-center p-0">
		<a class="navbar-brand" href="${appRoot}/main/home">
			<img alt="triple-logo" width="250"
				src="${appRoot }/resources/img/triple-logo.png">
		</a>
	</div>
</div>

<!-- 메뉴바 -->
<div class="navbar row justify-content-center p-0">
	<nav class="navbar navbar-expand-sm navbar-light">
		<ul class="navbar-nav mr-auto text-center">

			<li class="nav-item dropdown">
				<a class="nav-link" href="${appRoot }/main/intro" role="button"
					aria-expanded="false"> 소개 </a>
			</li>

			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#"
					id="navbarScrollingDropdown" role="button" data-toggle="dropdown"
					aria-expanded="false"> 커뮤니티 </a>
				<ul class="dropdown-menu" aria-labelledby="navbarScrollingDropdown">

					<li>
						<a class="dropdown-item" href="${appRoot}/community/cbhome">자유게시판
						</a>
					</li>

					<li>
						<hr class="dropdown-divider">
					</li>
				</ul>
			</li>

			<li class="nav-item dropdown">
				<a id="booking" class="nav-link" href="#" role="button"
					aria-expanded="false"> 숙소 </a>

			</li>

			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#"
					role="button" aria-expanded="false"> 고객센터 </a>
				<ul class="dropdown-menu" aria-labelledby="navbarScrollingDropdown">

					<li>
						<a class="dropdown-item" href="${appRoot }/cs/notice">공지사항 </a>
					</li>
					<li>
						<a class="dropdown-item" href="${appRoot }/cs/questionAndAnswer">Q&A</a>
					</li>
					<li>
						<hr class="dropdown-divider">
					</li>

				</ul>

			</li>

		</ul>
	</nav>
</div>
<hr class="m-1">