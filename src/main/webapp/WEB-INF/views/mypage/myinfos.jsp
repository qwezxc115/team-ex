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
<title>마이페이지 정보보기</title>

<style type="text/css">
html, body {
	height: 100%;
	min-height: 100%;
}

.container {
	height: 100%;
}

.nav-pills .nav-link.active, .nav-pills .show>.nav-link {
	background: linear-gradient(to right, #B8E9FF, #18A8F1);
	border: none;
}

.cl {
	background: linear-gradient(to right, #B8E9FF, #18A8F1);
	color: transparent;
	-webkit-background-clip: text;
}

.cth {
	padding: 40px;
	heigth: 100%;
}

.btncl {
	background: linear-gradient(to right, #B8E9FF, #18A8F1);
	color: transparent;
	-webkit-background-clip: text;
	font-size: 1.2rem;
}

#pills-home-tab, #pills-profile-tab, #pills-experts-tab {
	background-color: transparent;
	color: #6d0d27;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {

		//비밀번호수정클릭시 수정 모달 나오게 
		var modifyPasswordModal = $("#password-modify-modal")
		$("#pw-modify-btn1").click(function() {
			modifyPasswordModal.modal('show');

		})

		//비번수정 입력 확인 
		$("#password-modal-btn").click(function() {

			//비번입력 했는지 
			if ($("#old-Password").val() == "") {
				alert("기존 비밀번호을 입력해주세요 .");
				$("#old-Password").focus();
				return false;
			}
			if ($("#user-pw").val() == "") {
				alert("새 비밀번호을 입력해주세요 .");
				$("#user-pw").focus();
				return false;
			}
			if ($("#newPassword-ck").val() == "") {
				alert("새 비밀번호 확인을 입력해주세요 .");
				$("#newPassword-ck").focus();
				return false;
			}

		});
		//패스워드 일치 확인 
		$("#newPassword-ck").keyup(function() {
			var pw1 = $("#user-pw").val();
			var pw2 = $("#newPassword-ck").val();
			var modifyBtn = $("#password-modal-btn");

			if ((pw1 != pw2)) {
				modifyBtn.attr("disabled", "disabled");
				$("#password-message").text("패스워드가 일치하지 않습니다.");
			} else {
				if (pw1 == "") {
					modifyBtn.attr("disabled", "disabled");
					$("#password-message").text("패스워드를 입력해주세요.");
				} else {
					modifyBtn.removeAttr("disabled");
					$("#password-message").empty();
				}
			}
		});

		var PasswordModal = $("#password-modal");
		//회원탈퇴클릭시 탈퇴확인 비번 모달 나오게 
		$("#info-remove-btn1").click(function() {
			var ans = confirm("회원을 탈퇴하시겠습니까 ? ");

			if (ans) {

				PasswordModal.modal('show');

			}
		})

		//회원탈퇴 비번확인 
		$("#remove-btn").click(function() {

			//비번입력 했는지 
			if ($("#input-Password").val() == "") {
				alert("비밀번호을 입력해주세요 .");
				$("#input-title").focus();
				return false;
			}

		});

	})
</script>
</head>
<body>
	<div class="container">
		<nb:navbar></nb:navbar>

		<div class="row">
			<div class="col-3">
				<div class="nav flex-column nav-pills" id="v-pills-tab"
					role="tablist" aria-orientation="vertical">
					<a class="nav-link active cl" id="v-pills-pwck-tab"
						data-toggle="pill" href="#v-pills-pwck" role="tab"
						aria-controls="v-pills-pwck" aria-selected="true">정보수정 </a>
					<div class="nav-link cl">

						<button type="button" class="btn btncl" id="pw-modify-btn1">비밀번호
							수정</button>
							
						<br />
						
						<button type="button" class="btn btncl" id="info-remove-btn1">회원
							탈퇴</button>
					</div>
				</div>
			</div>


			<div class="col-9">

				<div class="tab-content" id="v-pills-tabContent">

					<!--  비밀번호가 맞으면 보여줘야될 정보 컨텐츠 -->
					<div class="jumbotron tab-pane fade show active " id="v-pills-pwck"
						role="tabpanel" aria-labelledby="v-pills-pwck-tab">
						<div class="cth">
							<c:if test="${param.status == 'success' }">
								<div id="alert1" class="alert alert-primary" role="alert">
									회원 정보를 수정하였습니다.</div>
							</c:if>
							<c:if test="${param.status == 'error' }">
								<div id="alert1" class="alert alert-danger" role="alert">
									회원 정보 수정을 할 수 없습니다.</div>
							</c:if>


							<p>
								회원정보
								<br>
							<form method="post" action="${appRoot }/mypage/modify">

								<div class="form-group">
									<label class="control-label" for="userid">아이디</label>
									<input readonly value="${uservo.userid }" class="form-control"
										type="text" id="userid" name="userid" />
								</div>
								<div class="form-group">
									<label class="control-label" for="userName">이름</label>
									<input readonly value="${uservo.userName }"
										class="form-control" type="text" id="userName" name="userName" />
								</div>
								<div class="form-group">
									<label class="control-label" for="userEmail">이메일</label>
									<input value="${uservo.userEmail }" class="form-control"
										type="email" id="userEmail" name="userEmail" />
								</div>
								<div class="form-group">
									<label class="control-label" for="userPhone">연락처</label>
									<input value="${uservo.userPhone }" class="form-control"
										type="text" id="userPhone" name="userPhone" />
								</div>
								<div class="form-group">
									<label class="control-label" for="useradd">주소 </label>
									<input value="${uservo.useradd }" class="form-control"
										type="text" id="useradd" name="useradd" />
								</div>
								<div class="input-group justify-content-between">
									<input class="btn btn-outline-secondary" type="submit"
										id="info-modify-btn" value="수정 " />
									<a id="info-notmodify" class="btn btn-outline-secondary"
										href="${appRoot }/mypage/home"> 취소 </a>

								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>

		<footer>
			<nb:footer></nb:footer>
		</footer>
	</div>


	<!-- 회원탈퇴시  기존패스워드 확인 후 탈퇴하기   (모달 !)  -->
	<div class="modal fade" id="password-modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">비밀번호를 입력해 주세요.</h5>
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
				</div>
				<form action="${appRoot}/mypage/removeuser" method="post">
					<div class="modal-body">
						<div class="form-group">
							<label for="inputPassword">비밀번호 </label>
							<input name="inputPassword" type="password" class="form-control"
								id="input-Password">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">닫기</button>
						<button type="submit" id="remove-btn" class="btn btn-danger">확인</button>
					</div>
				</form>
			</div>
		</div>
	</div>



	<!--비밀번호변경    (모달 !)  -->
	<div class="modal fade" id="password-modify-modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">비밀번호 수정하기</h5>
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
				</div>
				<form action="${appRoot}/mypage/modifypassword" method="post">
					<div class="modal-body">

						<div class="form-group">
							<label for="oldPassword">기존 비밀번호 </label>
							<input name="oldPassword" type="password" class="form-control"
								id="old-Password">
						</div>
						<div class="form-group">
							<label for="userpw">새 비밀번호 </label>
							<input name="userpw" type="password" class="form-control"
								id="user-pw">
						</div>
						<div class="form-group">
							<label for="newPassword-ck">새 비밀번호 확인 </label>
							<input name="newPassword-ck" type="password" class="form-control"
								id="newPassword-ck">
							<small id="password-message" class="form-text text-danger"></small>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">닫기</button>
						<button type="submit" id="password-modal-btn"
							class="btn btn-danger">수정하기</button>
					</div>
				</form>
			</div>
		</div>


	</div>


	<c:if test="${not empty qqq}">

		<script type="text/javascript">
			alert("${qqq}");
		</script>

	</c:if>

</body>
</html>