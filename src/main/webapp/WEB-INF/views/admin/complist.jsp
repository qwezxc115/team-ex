<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>고집 관리자페이지</title>
</head>
<style>

	#compadd {
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
			
			if (!CRNReg.test($("#compnum").val())){
				alert("사업자번호는 -제외한 10 ~ 13숫자만 입력하여야 합니다.");
				$("#compnum").focus();
				return false;
			}
		
			if($("#compnum").val()==""){
				alert("사업자등록번호 입력해주세요.");
				$("#compnum").focus();
				return false;
			}
			if($("#userid1").val()==""){
				alert("아이디를 입력해주세요.");
				$("#id").focus();
				return false;
			}
			if($("#userpw").val()==""){
				alert("비밀번호를 입력해주세요.");
				$("#pw").focus();
				return false;
			}
			
			if (!pwReg.test($("#userpw").val())){
				alert("비밀번호는  4 ~ 12자 사이의 영문자 또는 숫자이어야 합니다.");
				$("#userpw").focus();
				return false;
				
			} 
			
			if($("#userpw2").val()==""){
				alert("비밀번호를 입력해주세요.");
				$("#pwchk").focus();
				return false;
			}								
			if($("#userName").val()==""){
				alert("성명을 입력해주세요.");
				$("#userName").focus();
				return false;
			}
			
			if($("#userEmail").val()==""){
				alert("이메일을 입력해주세요.");
				$("#userEmail").focus();
				return false;
			}
			if($("#userPhone").val()==""){
				alert("연락처를 입력해주세요.");
				$("#userPhone").focus();
				return false;
			}
			
			if (!NumReg.test($("#userPhone").val())){
				alert("연락처를 다시 확인해주세요.");
				$("#userPhone").focus();
				return false;
			}
		});

		var canUseId = false;
		var passwordConfirm = false;
		
		// 아이디 중복 확인 
		$("#id-dup-btn").click(function() {
			var idVal = $("#userid1").val();
			var messageElem = $("#id-message");
			// 자바스크립트 정규표현식
			var idReg = /^[A-za-z]+[A-za-z0-9]{4,9}$/g;
			canUseId = false;
			toggleEnableSubmit();
			
			if (idVal == "") {
				// 아이디가 입력되지 않았을 때
				messageElem.text("아이디를 입력해주세요.");
			
				
			} else if(!idReg.test($("#userid1").val())){
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
		$("#userpw, #userpw2").keyup(function() {
			var pw1 = $("#userpw").val();
			var pw2 = $("#userpw2").val();
			
			var messageElem = $("#pw-message");
			var pwReg = /^[A-za-z0-9]{4,12}$/g;
			passwordConfirm = false;
			
			if(!pwReg.test($("#userpw").val())){
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
		    $('#userpw').attr('type',"text");
		}).on('mouseup mouseleave', function() {
		    $('#userpw').attr('type',"password");
		});
		function toggleEnableSubmit() {
			if (passwordConfirm && canUseId) {
				$("#signbtn").removeAttr("disabled");
			} else {
				$("#signbtn").attr("disabled", "disabled");
			}
		}
			
		$("#compaddModal").on("show.bs.modal", function() {
			$("#compnum").val("");
			$("#userid1").val("");
			$("#userpw").val("");
			$("#userpw2").val("");
			$("#userName").val("");
			$("#userEmail").val("");
			$("#userPhone").val("");
			$("#useradd").val("");
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
		      <li class="nav-item">
		        <a class="nav-link" href="${appRoot }/admin/home">회원 목록 </a>
		      </li>
		      <li class="nav-item active">
		        <a class="nav-link" href="${appRoot }/admin/complist">업체 목록 <span class="sr-only">(current)</span></a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="${appRoot }/admin/productlist">상품 목록</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="${appRoot }/admin/otolist">문의내역 목록</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="${appRoot }/admin/adminlist">관리자 목록</a>
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
		
		<!-- 업체 목록 -->
		
		<div class="row-12">
			<h3> 업체 목록 </h3>
			<button id="compadd" type="button" class="btn btn-outline-secondary" style="float:right"
					data-toggle="modal" data-target="#compaddModal">업체 추가</button>
			
			<table class="table table-striped">
		        <thead>
		            <tr style="text-align :center">
		                <th style="width: 5%">#</th>
		                <th style="width: 10%">아이디</th>
		                <th style="width: 7%">이름</th>
		                <th style="width: 10%">연락처</th>
		                <th style="width: 15%">이메일</th>
		                <th style="width: 10%">사업자번호</th>
		                <th style="width: 30%">주소</th>
		                <th style="width: 20%">가입날짜</th>
		            </tr>
		        </thead>
		        <tbody>
		        	<c:forEach items="${Complist }" var="comp" varStatus="compstatus">
		        		<style>
		        			#overaddress${compstatus.count}{
								text-overflow: ellipsis;
								overflow: hidden;
								white-space: nowrap;
								max-width: 35px;
							}
		        		</style>
		        		<script>
							$(document).ready(function(){
								
								$("#call${compstatus.count }").on("show.bs.modal", function(){
									$("#compnum${compstatus.count }").val("${comp.companyRegistrationNumber }");
									$("#compName${compstatus.count }").val("${comp.userName }");
									$("#compEmail${compstatus.count }").val("${comp.userEmail }");	
									$("#compPhone${compstatus.count }").val("${comp.userPhone }");	
									$("#compadd${compstatus.count }").val("${comp.useradd }");	
									
								})
								
								$("#compupdbtn${compstatus.count }").click(function(){
									
									var NumReg = /^[0-9]{8,11}$/g;
									
									if($("#compName${compstatus.count }").val()==""){
										alert("성명을 입력해주세요.");
										$("#compName${compstatus.count }").focus();
										return false;
									}
									
									if($("#compEmail${compstatus.count }").val()==""){
										alert("이메일을 입력해주세요.");
										$("#compEmail${compstatus.count }").focus();
										return false;
									}
									if($("#compPhone${compstatus.count }").val()==""){
										alert("연락처를 입력해주세요.");
										$("#compPhone${compstatus.count }").focus();
										return false;
									}
									
									if (!NumReg.test($("#compPhone${compstatus.count }").val())){
										alert("연락처를 다시 확인해주세요.");
										$("#compPhone${compstatus.count }").focus();
										return false;
									}	
									
									alert("수정 완료됐습니다.")
								})
								
								$("#compdelbtn${compstatus.count }").click(function(){
									$("form").attr("action", "${appRoot}/admin/compdelete");
									alert("업체회원탈퇴가 완료됐습니다.")
								})
							});
						</script>
						<tr>
							<td>${compstatus.count }</td>
		                    <td>
		                   		<a type="button" class="nav-link active" id="cnbtn1" data-toggle="modal" data-target="#call${compstatus.count }">
		                   			${comp.userid }
								</a>
		                    </td>
							<td>${comp.userName }</td>
							<td>${comp.userPhone }</td>
							<td>${comp.userEmail }</td>
							<td>${comp.companyRegistrationNumber }</td>
							<td id="overaddress${compstatus.count}">${comp.useradd }</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${comp.regdate }" /></td>
						</tr>
						
						<!-- 회원 아이디 클릭시 나오는 상세조회 모달 -->
						<div class="modal fade" id="call${compstatus.count }" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="staticBackdropLabel">${comp.userid }님의 정보</h5>
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						    			    <span aria-hidden="true">&times;</span>
						        		</button>
						      		</div>
						      		<div class="modal-body">
						      			<form method="post" action="${appRoot }/admin/compupdate">
						      				<div class="form-group">
							                    <label class="control-label" for="compnum">사업자등록번호</label>
							                    <input readonly value="${comp.companyRegistrationNumber }" class="form-control" type="text" id="compnum${compstatus.count }" name="CompanyRegistrationNumber" />
							                </div>		  
								      		<div class="form-group">
							                    <label class="control-label" for="userid">아이디</label>
							                    <input readonly value="${comp.userid }" class="form-control" type="text" id="compid${compstatus.count }" name="userid" />
							                </div>
							                <div class="form-group">
							                    <label class="control-label" for="userName">이름</label>
							                    <input value="${comp.userName }" class="form-control" type="text" id="compName${compstatus.count }" name="userName" />
							                </div>
							                <div class="form-group">
							                    <label class="control-label" for="userEmail">이메일</label>
							                    <input value="${comp.userEmail }" class="form-control" type="email"  id="compEmail${compstatus.count }" name="userEmail" />
							                </div>
							                <div class="form-group">
							                    <label class="control-label" for="userPhone">연락처</label>
							                    <input value="${comp.userPhone }" class="form-control" type="text" id="compPhone${compstatus.count }" name="userPhone" />
							                </div>
							                <div class="form-group">
							                    <label class="control-label" for="useradd">주소 </label>
							                    <input value="${comp.useradd }" class="form-control" type="text" id="compadd${compstatus.count }" name="useradd" />
							                </div>
								      		<div class="modal-footer">
												<button id="compdelbtn${compstatus.count }" type="submit" class="btn btn-danger mr-auto">삭제</button>
												<button id="compupdbtn${compstatus.count }" type="submit" class="btn btn-primary">수정</button>
												<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
									      	</div>
						                </form>
						      		</div>
						    	</div>
							</div>
						</div>
		        	</c:forEach>
		        </tbody>
		    </table>
		</div>
		
		<!-- 업체추가 버튼 클릭시 나오는 모달 -->
		<div class="modal fade" id="compaddModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="compaddModaltitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="compaddModaltitle">업체회원 추가</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <form class="col-12" action="${appRoot }/admin/complist" method="post">
		        	<div class="form-group">
	                	<label class="control-label" for="compnum">사업자등록번호</label>
	                    <input class="form-control" type="text" id="compnum" name="CompanyRegistrationNumber" placeholder="- 제외한 숫자만 입력"/>
	                </div>
	                <div class="form-group">
	                    <label class="control-label" for="id">아이디</label>
	                    <div class="input-group"> <!-- 왜 userid와 username이 같으면 안되는지 -->
	                    <input class="form-control" type="text" id="userid1" name="userid" />
							<button class="btn btn-outline-secondary" type="button"id="id-dup-btn">
									중복 체크        
							</button>
						</div>
							<small id="id-message" class="form-text">아이디는 영문자로 시작하는 5자 이상의 영문자 또는 숫자이어야 합니다.</small>
	                </div>
	                <div class="form-group">
	                    <label class="control-label" for="pw">비밀번호</label>
						<div class="input-group-append">
	                    	<input class="form-control" type="password" id="userpw" name="userpw" autocomplete="false" placeholder="비밀번호를 입력해주세요."/>
							<button type="button" id="eye"><i class="fas fa-lock"></i></button>
						</div>
	                    <small id="pw-message" class="form-text"></small>
	                    
	                </div>
	                <div class="form-group">
	                    <label class="control-label" for="pwchk">비밀번호 재확인 </label>
	                    <input class="form-control" type="password" id="userpw2" name="pwchk" placeholder="비밀번호를 입력해주세요."/>
	                    <small id="password-message" class="form-text text-danger"></small>
	                </div>
	                <div class="form-group">
	                    <label class="control-label" for="userName">이름</label>
	                    <input class="form-control" type="text" id="userName" name="userName" />
	                </div>
	                <div class="form-group">
	                    <label class="control-label" for="userEmail">이메일</label>
	                    <input class="form-control" type="email"  id="userEmail" name="userEmail" placeholder="name@example.com"/>
	                </div>
	                <div class="form-group">
	                    <label class="control-label" for="userPhone">연락처</label>
	                    <input class="form-control" type="text" id="userPhone" name="userPhone" placeholder="-제외한 숫자만 입력" />
	                </div>
	                <div class="form-group">
	                    <label class="control-label" for="useradd">주소</label>
	                    <input class="form-control" type="text" id="useradd" name="useradd"/>
	                </div>
			      <div class="modal-footer">
			        <button type="submit" class="btn btn-primary" id="signbtn">회원 추가</button>
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