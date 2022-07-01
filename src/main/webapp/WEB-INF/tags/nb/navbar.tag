<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<script>
	$(document).ready(function() {
		$("#navbar-logout-link").click(function(e) {
			e.preventDefault();
			$("#navbar-logout-form").submit();
		});

		$("#booking").click(function() {
			alert("Comming Soon");
			$("#input-title").focus();
			return false;
		});

		// nav scroll event
		var navOffset = $('.mainNav').offset(); // 위치 파악
		$(window).scroll(function() { // 스크롤 발생
			if ($(document).scrollTop() > navOffset.top) { // 스크롤 위치가 수직 위치보다 아래면
				$('.mainNav').addClass('navScrolled');
			} else {
				$('.mainNav').removeClass('navScrolled');
			}
		});

	})
</script>

<style>
.dropdown-menu {
	font-size: 1.3rem;
}

#hello {
	background: linear-gradient(to right, #B8E9FF, #18A8F1);
	color: transparent;
	-webkit-background-clip: text;
}

.navScrolled {
	background-color: white;
	position: fixed;
	z-index: 1;
	top: 0;
	left: 0;
	right: 0;
	-webkit-transition: all .3s ease 0s;
	transition: all .3s ease 0s;
}

.mainNav {
	-webkit-transition: all .3s ease 0s;
	transition: all .3s ease 0s;
}

</style>

<div class="mainNav">
	<nav class="navbar navbar-expand-sm navbar-light">
		<div class="container-fluid">
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<!-- 상단 로고 -->
			<div class="justify-content-start">
				<a class="navbar-brand" href="${appRoot}/main/home">
					<img alt="triple-logo" width="150"
						src="${appRoot }/resources/img/triple-logo.png">
				</a>
			</div>

			<!-- 센터 메뉴 -->
			<div class="justify-content-between">
				<ul class="navbar-nav mr-auto text-center">
					<li class="nav-item dropdown">
						<a class="nav-link" href="${appRoot }/main/intro" role="button"
							aria-expanded="false"> 소개 </a>
					</li>

					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#"
							id="navbarScrollingDropdown" role="button" data-toggle="dropdown"
							aria-expanded="false"> 커뮤니티 </a>
						<ul class="dropdown-menu"
							aria-labelledby="navbarScrollingDropdown">

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
						<a class="nav-link dropdown-toggle" data-toggle="dropdown"
							href="#" role="button" aria-expanded="false"> 고객센터 </a>
						<ul class="dropdown-menu"
							aria-labelledby="navbarScrollingDropdown">

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
			</div>

			<!-- 오른쪽 로그인 -->
			<div class="justify-content-end" id="navbarNav">
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
							<span id="hello">님 반갑습니다 !</span>
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

<hr class="m-1">