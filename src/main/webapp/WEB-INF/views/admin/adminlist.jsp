<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>



<title>고집 관리자페이지</title>
</head>
<style>

	#adminaddbtn {
		margin: 10px;
		padding: 5px;
	}
	
	td{
		text-align:center;
		valign : middle;
	}
	
	.btn-outline-secondary{
		background-color: #ececee;
	}
</style>
	
<script type="text/javascript">
	$(document).ready(function(){
		$("#signbtn").click(function() {
			
			// 사업자 번호 및 연락처 숫자만 입력하게 하기
			// 자바스크립트 정규표현식
			var CRNReg = /^[0-9]{10,13}$/g;
			var NumReg = /^[0-9]{8,11}$/g;
			var pwReg = /^[A-za-z0-9]{4,12}$/g;
		
			if($("#adminidbtn").val()==""){
				alert("아이디를 입력해주세요.");
				$("#id").focus();
				return false;
			}
			if($("#adminpw").val()==""){
				alert("비밀번호를 입력해주세요.");
				$("#pw").focus();
				return false;
			}
			
			if (!pwReg.test($("#adminpw").val())){
				alert("비밀번호는  4 ~ 12자 사이의 영문자 또는 숫자이어야 합니다.");
				$("#adminpw").focus();
				return false;
				
			} 
			
			if($("#adminpw2").val()==""){
				alert("비밀번호를 입력해주세요.");
				$("#pwchk").focus();
				return false;
			}								
			if($("#adminName").val()==""){
				alert("성명을 입력해주세요.");
				$("#adminName").focus();
				return false;
			}
			
			if($("#adminEmail").val()==""){
				alert("이메일을 입력해주세요.");
				$("#adminEmail").focus();
				return false;
			}
			if($("#adminPhone").val()==""){
				alert("연락처를 입력해주세요.");
				$("#adminPhone").focus();
				return false;
			}
			
			if (!NumReg.test($("#adminPhone").val())){
				alert("연락처를 다시 확인해주세요.");
				$("#adminPhone").focus();
				return false;
			}
		});
		
		var canUseId = false;
		var passwordConfirm = false;
		
		// 아이디 중복 확인 
		$("#id-dup-btn").click(function() {
			var idVal = $("#adminidbtn").val();
			var messageElem = $("#id-message");
			// 자바스크립트 정규표현식
			var idReg = /^[A-za-z]+[A-za-z0-9]{4,9}$/g;
			canUseId = false;
			toggleEnableSubmit();
			
			if (idVal == "") {
				// 아이디가 입력되지 않았을 때
				messageElem.text("아이디를 입력해주세요.");
			
				
			} else if(!idReg.test($("#adminidbtn").val())){
				messageElem.html("※ 다시 입력해주세요"+"<br>"+"아이디는 영문자로 시작하는 5 ~ 10자 영문자 또는 숫자이어야 합니다.");
				
			} else {
				// 아이디가 입력되어있을 때
				var data = {id : idVal};
				$.ajax({
					type: "get",
					url: "${appRoot }/main/dup",
					data: data,
					success: function (data) {
						if (data == "success") {
							console.log("사용 가능한 아이디");
							canUseId = true;
							messageElem.text("사용가능한 아이디 입니다.");			
						} else if (data == "exist") {
							console.log("사용 불가능한 아이디");
							messageElem.text("이미 있는 아이디 입니다.");
						}
						
						toggleEnableSubmit();
					}, 
					error: function() {
						console.log("아이디 중복 체크 실패");
					}
					
				});
			}
		})
		
		
		// 패스워드 확인
		$("#adminpw, #adminpw2").keyup(function() {
			var pw1 = $("#adminpw").val();
			var pw2 = $("#adminpw2").val();
			
			var messageElem = $("#pw-message");
			var pwReg = /^[A-za-z0-9]{4,12}$/g;
			passwordConfirm = false;
			
			if(!pwReg.test($("#adminpw").val())){
				messageElem.html("비밀번호는 4자 이상이여야 합니다.");
			}
			else if (pw1.length > 3){
				messageElem.html("사용 가능 합니다");
				
			}  
		
			if (pw1 != pw2) {
				$("#password-message").text("패스워드가 일치하지 않습니다.");	
			} else {
				if (pw1 == "") {
					$("#password-message").text("패스워드를 입력해주세요.");
				} else {
					passwordConfirm = true;
					$("#password-message").empty();
				}
				
			}
			// submit 버튼 disable/enalbe 토글
			toggleEnableSubmit();
		});
		
		//비밀번호보기 
		$('#eye').on("mousedown", function(){
		    $('#adminpw').attr('type',"text");
		}).on('mouseup mouseleave', function() {
		    $('#adminpw').attr('type',"password");
		});
		function toggleEnableSubmit() {
			if (passwordConfirm && canUseId) {
				$("#signbtn").removeAttr("disabled");
			} else {
				$("#signbtn").attr("disabled", "disabled");
			}
		}
			
		$("#adminaddModal").on("show.bs.modal", function() {
			$("#adminidbtn").val("");
			$("#adminpw").val("");
			$("#adminpw2").val("");
			$("#adminName").val("");
			$("#adminEmail").val("");
			$("#adminPhone").val("");
			$("#adminadd").val("");
			$("#signbtn").prop("disabled", true);
		
		});
		//로그아웃 동작 
	    $("#navbar-logout-link").click(function(e) {
	        e.preventDefault();
	        $("#navbar-logout-form").submit();
	   	});

	});
</script>
<body>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
	<div class = "container">
	
		<!-- 상단 메뉴바 -->
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
		  <a class="navbar-brand" href="${appRoot}/main/home">
			<img alt="gohome-logo" width="100" src="${appRoot }/resources/img/gohomelogo22.png">
		  </a>
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		  </button>
		
		  <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
		    <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
		      <li class="nav-item ">
		        <a class="nav-link" href="${appRoot }/admin/home">회원 목록 </a>
		      </li>
		      <li class="nav-item ">
		        <a class="nav-link" href="${appRoot }/admin/complist">업체 목록</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="${appRoot }/admin/productlist">상품 목록</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="${appRoot }/admin/otolist">문의내역 목록</a>
		      </li>
		      <li class="nav-item active">
		        <a class="nav-link" href="${appRoot }/admin/adminlist">관리자 목록 <span class="sr-only">(current)</span> </a>
		      </li>
		    </ul>
		    <ul  class="navbar-nav">
				<li class="nav-item p-2">
					<span style="color:#6d0d27;"><b>현재 관리자로 로그인 중입니다</b></span>
		      	</li>
				<li class="nav-item">
       				<a class="nav-link" href="#" id="navbar-logout-link">로그아웃</a>
     			</li>
			</ul>
			<form action="${appRoot }/logout" method="post" id="navbar-logout-form"> </form>
		  </div>
		</nav>
		<hr style="border: solid 1px;">
		
		
		<!--  관리자 목록 -->	
		<div class="row-12">
			<h3> 관리자 목록 </h3>
			<button id="adminaddbtn" type="button" class="btn btn-outline-secondary" style="float:right"
					data-toggle="modal" data-target="#adminaddModal">관리자계정 추가</button>
			<table class="table table-striped">
		        <thead>
		            <tr style="text-align :center">
		                <th style="width: 5%">#</th>
		                <th style="width: 10%">아이디</th>
		                <th style="width: 7%">이름</th>
		                <th style="width: 13%">연락처</th>
		                <th style="width: 15%">이메일</th>
		                <th style="width: 35%">사업부서</th>
		                <th style="width: 15%">가입날짜</th>
		            </tr>
		        </thead>
		        <tbody>
		        	<c:forEach items="${Adminlist }" var="admin" varStatus="adminstatus">
		        		<script>
							$(document).ready(function(){
								
								$("#call${adminstatus.count }").on("show.bs.modal", function(){
									$("#userName${adminstatus.count }").val("${admin.userName }");
									$("#userEmail${adminstatus.count }").val("${admin.userEmail }");	
									$("#userPhone${adminstatus.count }").val("${admin.userPhone }");	
									$("#useradd${adminstatus.count }").val("${admin.useradd }");	
									
								})
								
								
								$("#updbtn${adminstatus.count }").click(function(){
									var NumReg = /^[0-9]{8,11}$/g;
									
									if($("#userName${adminstatus.count }").val()==""){
										alert("성명을 입력해주세요.");
										$("#userName${adminstatus.count }").focus();
										return false;
									}
									
									if($("#userEmail${adminstatus.count }").val()==""){
										alert("이메일을 입력해주세요.");
										$("#userEmail${adminstatus.count }").focus();
										return false;
									}
									if($("#userPhone${adminstatus.count }").val()==""){
										alert("연락처를 입력해주세요.");
										$("#userPhone${adminstatus.count }").focus();
										return false;
									}
									
									if (!NumReg.test($("#userPhone${adminstatus.count }").val())){
										alert("연락처를 다시 확인해주세요.");
										$("#userPhone${adminstatus.count }").focus();
										return false;
									}	
									
									alert("수정 완료됐습니다.")
								})
								
								$("#delbtn${adminstatus.count }").click(function(){
									$("form").attr("action", "${appRoot}/admin/admindelete");
									alert("관리자계정을 삭제 완료됐습니다.")
								})
							});
							
					</script>
						<tr>
							<td>${adminstatus.count }</td>
		                    <td>
		                   		<a type="button" class="nav-link active" id="cnbtn1" data-toggle="modal" data-target="#call${adminstatus.count }">
		                   			${admin.userid }
								</a>
		                    </td>
							<td>${admin.userName }</td>
							<td>${admin.userPhone }</td>
							<td>${admin.userEmail }</td>
							<td>${admin.useradd }</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${admin.regdate }" /></td>
						</tr>
						
						<!-- 관리자 아이디 클릭시 나오는 상세조회 모달 -->
		
						<div class="modal fade" id="call${adminstatus.count }" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="staticBackdropLabel">${admin.userid }님의 정보</h5>
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						    			    <span aria-hidden="true">&times;</span>
						        		</button>
						      		</div>
						      		<div class="modal-body">
						      			<form method="post" action="${appRoot }/admin/adminupdate">		  
								      		<div class="form-group">
							                    <label class="control-label" for="userid">아이디</label>
							                    <input readonly value="${admin.userid }" class="form-control" type="text" id="userid${adminstatus.count }" name="userid" />
							                </div>
							                <div class="form-group">
							                    <label class="control-label" for="userName">이름</label>
							                    <input value="${admin.userName }" class="form-control" type="text" id="userName${adminstatus.count }" name="userName" />
							                </div>
							                <div class="form-group">
							                    <label class="control-label" for="userEmail">이메일</label>
							                    <input value="${admin.userEmail }" class="form-control" type="email"  id="userEmail${adminstatus.count }" name="userEmail" />
							                </div>
							                <div class="form-group">
							                    <label class="control-label" for="userPhone">연락처</label>
							                    <input value="${admin.userPhone }" class="form-control" type="text" id="userPhone${adminstatus.count }" name="userPhone" />
							                </div>
							                <div class="form-group">
							                    <label class="control-label" for="useradd">주소 </label>
							                    <input value="${admin.useradd }" class="form-control" type="text" id="useradd${adminstatus.count }" name="useradd" />
							                </div>
								      		<div class="modal-footer">
												<button id="delbtn${adminstatus.count }" type="submit" class="btn btn-danger mr-auto">삭제</button>
												<button id="updbtn${adminstatus.count }" type="submit" class="btn btn-primary">수정</button>
												<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
									      	</div>
						                </form>
						      		</div>
						    	</div>
							</div>
						</div>
						
						<section class="modal modal-section type-alert">
				            <div class="enroll_box">
				                <p class="menu_msg"></p>
				            </div>
				            <div class="enroll_btn">
				                <button class="btn pink_btn modal_close">확인</button>
				            </div>
				        </section>
		        	</c:forEach>
		        </tbody>
		    </table>
		</div>
		
		<!-- 관리자계정 추가 버튼 클릭시 나오는 모달 -->
		<div class="modal fade" id="adminaddModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="adminaddModaltitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="adminaddModaltitle">관리자계정 추가</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <form class="col-12" action="${appRoot }/admin/adminlist" method="post">
	                <div class="form-group">
	                    <label class="control-label" for="id">아이디</label>
	                    <div class="input-group"> <!-- 왜 userid와 username이 같으면 안되는지 -->
	                    <input class="form-control" type="text" id="adminidbtn" name="userid" />
							<button class="btn btn-outline-secondary" type="button"id="id-dup-btn">
									중복 체크        
							</button>
						</div>
							<small id="id-message" class="form-text">아이디는 영문자로 시작하는 5자 이상의 영문자 또는 숫자이어야 합니다.</small>
	                </div>
	                <div class="form-group">
	                    <label class="control-label" for="pw">비밀번호</label>
						<div class="input-group-append">
	                    	<input class="form-control" type="password" id="adminpw" name="userpw" autocomplete="false" placeholder="비밀번호를 입력해주세요."/>
							<button type="button" id="eye"><i class="fas fa-lock"></i></button>
						</div>
	                    <small id="pw-message" class="form-text"></small>
	                    
	                </div>
	                <div class="form-group">
	                    <label class="control-label" for="pwchk">비밀번호 재확인 </label>
	                    <input class="form-control" type="password" id="adminpw2" name="pwchk" placeholder="비밀번호를 입력해주세요."/>
	                    <small id="password-message" class="form-text text-danger"></small>
	                </div>
	                <div class="form-group">
	                    <label class="control-label" for="userName">이름</label>
	                    <input class="form-control" type="text" id="adminName" name="userName" />
	                </div>
	                <div class="form-group">
	                    <label class="control-label" for="userEmail">이메일</label>
	                    <input class="form-control" type="email"  id="adminEmail" name="userEmail" placeholder="name@example.com"/>
	                </div>
	                <div class="form-group">
	                    <label class="control-label" for="userPhone">연락처</label>
	                    <input class="form-control" type="text" id="adminPhone" name="userPhone" placeholder="-제외한 숫자만 입력" />
	                </div>
	                <div class="form-group">
	                    <label class="control-label" for="useradd">사업부서</label>
	                    <input class="form-control" type="text" id="adminadd" name="useradd"/>
	                </div>
			      <div class="modal-footer">
			        <button type="submit" class="btn btn-primary" id="signbtn">관리자계정 추가</button>
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			      </div>
	          	  </form>
		      </div>
		    </div>
		  </div>
		</div>
		
		
		
		
		
		
		
		
		
		
	</div>
	</sec:authorize>
	<script>
	$(document).ready(function(){
		$("#returnbtn").click(function(){
			location.href="${appRoot }/main/home"; 
		})	
	})
	</script>
	<sec:authorize access="!hasRole('ROLE_ADMIN')">
	<div class = "container">
		<nb:navbar></nb:navbar>
		<h1 style="text-align:center"> 이곳은 고집 관리자페이지 입니다.</h1>
		<h3 style="text-align:center"> 접근 권한이 없습니다.</h3>
			<div style="text-align:center">
				<button id=returnbtn type="button" style="width:400px; height:100px; margin:0 auto;"><span style="font-size:30px">고홈 돌아가기</span></button>
			</div>
	</div>
	</sec:authorize>
</body>
</html>