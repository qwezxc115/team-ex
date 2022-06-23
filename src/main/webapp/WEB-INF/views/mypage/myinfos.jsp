<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>마이페이지 정보보기  </title>

<style type="text/css">
	
	html, body {
	    height: 100%;
	    min-height: 100%;
	}
	
	.container{
       height: 100%;
	}
	
	.nav-pills .nav-link.active, .nav-pills .show>.nav-link {background-color: #6d0d27;}
	.cl{ color:#6d0d27;}
	.cth{ padding:40px;heigth:100%;}
	.btncl{color: #6d0d27;}
	
	#pills-home-tab, #pills-profile-tab, #pills-experts-tab {background-color:transparent;color: #6d0d27;}
      
     
     
</style>

<script type="text/javascript">


$(document).ready(function(){
	
	
	
	//비밀번호수정클릭시 수정 모달 나오게 
	var modifyPasswordModal = $("#password-modify-modal")
	$("#pw-modify-btn1").click(function(){
		modifyPasswordModal.modal('show');
		
		
	})
	
	//비번수정 입력 확인 
	$("#password-modal-btn").click(function() {
		
		//비번입력 했는지 
			if($("#old-Password").val()==""){
				alert("기존 비밀번호을 입력해주세요 .");
				$("#old-Password").focus();
				return false;
			}
			if($("#user-pw").val()==""){
				alert("새 비밀번호을 입력해주세요 .");
				$("#user-pw").focus();
				return false;
			}
			if($("#newPassword-ck").val()==""){
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
	$("#info-remove-btn1").click(function(){
		var ans = confirm("회원을 탈퇴하시겠습니까 ? ");
		
		
		if(ans){
			
			PasswordModal.modal('show');
			
		}
	})
	
	//회원탈퇴 비번확인 
	$("#remove-btn").click(function() {
		
		//비번입력 했는지 
			if($("#input-Password").val()==""){
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
		    <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
		      <a class="nav-link active cl" id="v-pills-pwck-tab" data-toggle="pill" href="#v-pills-pwck" role="tab" aria-controls="v-pills-pwck" aria-selected="true">정보수정 </a>
		     	<div class="nav-link cl">
		     	
		     		<button type="button" class="btn btncl" id="pw-modify-btn1">비밀번호수정 </button>
				
					<button type="button" class="btn btncl" id="info-remove-btn1">회원 탈퇴</button>				
		     	</div>
		      
		      <a class="nav-link cl" id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="false">주문목록  </a>
		      
		      <a class="nav-link cl" id="v-pills-messages-tab" data-toggle="pill" href="#v-pills-messages" role="tab" aria-controls="v-pills-messages" aria-selected="false">내글관리 </a>
		      
		    </div>
		  </div>
		
		  
		  <div class="col-9">
		  
		    <div class="tab-content" id="v-pills-tabContent">
		    
		      <!--  비밀번화가 맞으면 보여줘야될 정보 컨텐츠 -->
		      <div class="jumbotron tab-pane fade show active " id="v-pills-pwck" role="tabpanel" aria-labelledby="v-pills-pwck-tab">
		      		<div class="cth">
			      		<c:if test="${param.status == 'success' }">
							<div id="alert1" class="alert alert-primary" role="alert">
								회원 정보를 수정하였습니다.
							</div>
					   </c:if>
					   <c:if test="${param.status == 'error' }">
							<div id="alert1" class="alert alert-danger" role="alert">
								회원 정보 수정을 할 수 없습니다.
							</div>
						</c:if>
					   
					   
			      		<p>회원정보 <br>
			      		<form method="post" action="${appRoot }/mypage/modify">
			      		
			      			<sec:authorize access="hasRole('ROLE_BUSINESS')">
                                  <div class="form-group">
                                    <label class="control-label" for="CompanyRegistrationNumber">사업자등록번호</label>
                                    <input readonly value="${uservo.companyRegistrationNumber }" 
                                    class="form-control" type="text" id="CompanyRegistrationNumber" name="CompanyRegistrationNumber"/>
                                </div>
                             </sec:authorize>
			      			 			  
				      		<div class="form-group">
			                    <label class="control-label" for="userid">아이디</label>
			                    <input readonly value="${uservo.userid }" class="form-control" type="text" id="userid" name="userid" />
			                </div>
			                <div class="form-group">
			                    <label class="control-label" for="userName">이름</label>
			                    <input readonly value="${uservo.userName }" class="form-control" type="text" id="userName" name="userName" />
			                </div>
			                <div class="form-group">
			                    <label class="control-label" for="userEmail">이메일</label>
			                    <input  value="${uservo.userEmail }" class="form-control" type="email"  id="userEmail" name="userEmail" />
			                </div>
			                <div class="form-group">
			                    <label class="control-label" for="userPhone">연락처</label>
			                    <input  value="${uservo.userPhone }" class="form-control" type="text" id="userPhone" name="userPhone" />
			                </div>
			                <div class="form-group">
			                    <label class="control-label" for="useradd">주소 </label>
			                    <input  value="${uservo.useradd }" class="form-control" type="text" id="useradd" name="useradd" />
			                </div>
			                 <div class="input-group justify-content-between">
		                    	<input class="btn btn-outline-secondary" type="submit" id="info-modify-btn" value="수정 " />
		                    	<a id="info-notmodify" class="btn btn-outline-secondary" href="${appRoot }/mypage/mypage" > 취소  </a>
		                    	
							</div>
		                </form>
	                </div>
		      </div>
		      
		      
		      
		      
		      
		      
		      
		      
		      
		      
		      
		      <!--  주문목록 관련 컨텐츠  -->
		      <div class="jumbotron tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
		      		주문목록 - 주문한 상품리스트 - 상품보기,택배조회(임의로 택배번호발급 - 최대한심플하게 )
		      </div>
		      
		      
		      <!--  내글  관련 컨텐츠  -->
		      <script type="text/javascript">
		      
			      $(document).ready(function(){
						
						$("#pills-home-tab").click(function(){
							
							$(".mksct").prop("checked", false);
							$(".mkselectAll").prop("checked", false);
							
							$(".rezselectAll").prop("checked", false);
							$(".rezsct").prop("checked", false);
						})
						
						$("#pills-profile-tab").click(function(){
							
							$(".cbsct").prop("checked", false);
							$(".cbselectAll").prop("checked", false);
							
							$(".rezselectAll").prop("checked", false);
							$(".rezsct").prop("checked", false);
							
						})
						
						$("#pill-experts-tab").click(function(){
							
							$(".cbsct").prop("checked", false);
							$(".cbselectAll").prop("checked", false);
							
							$(".mksct").prop("checked", false);
							$(".mkselectAll").prop("checked", false);
							
						})
						
						$("#remove-cb").click(function(e){
							e.preventDefault();
							if($(".cbsct:checked").length) {
								console.log("하나이상 체크됨...");
								removeAllForm1.submit()
							} else {
								alert("삭제 할 항목을 선택해 주세요. ");
							}
						})
						
						$("#remove-mk").click(function(e){
							e.preventDefault();
							if($(".mksct:checked").length) {
								console.log("하나이상 체크됨...");
								removeAllForm2.submit();
							} else {
								alert("삭제 할 항목을 선택해 주세요. ");
							}
						})
						$("#remove-rez").click(function(e){
							e.preventDefault();
							
							if($(".rezsct:checked").length) {
								console.log("하나이상 체크됨...");
								removeAllForm3.submit()
							} else {
								alert("삭제 할 항목을 선택해 주세요. ");
							}
						})
					})
				
					
			 </script>
			 
			<div class="jumbotron tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
				<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
					<li class="nav-item" role="presentation">
						<a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-cm" role="tab" aria-controls="pills-cm"
							aria-selected="true">자유게시판</a>
					</li>
					<li class="nav-item" role="presentation">
						<a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-market"
							role="tab" aria-controls="pills-market" aria-selected="false">중고마켓</a>
					</li>
					<li class="nav-item" role="presentation">
						<a class="nav-link" id="pills-experts-tab" data-toggle="pill" href="#pills-experts"
							role="tab" aria-controls="pills-experts" aria-selected="false">업체상담 </a>
					</li>
				</ul>

			
				<div class="tab-content" id="pills-tabContent">
					
					<div class="tab-pane fade show active" id="pills-cm" role="tabpanel" aria-labelledby="pills-cm-tab">
						<div  class="nav justify-content-end m-2" >
							<form id="removeAllForm1" action="${appRoot }/mypage/removeAll" method="post">
								<button id="remove-cb" class="btn btn-outline-danger" type="submit" >삭제 </button>
							</form>
						</div>
						<table class="table table-hover">
							<thead>
								<tr>
									<th><input type="checkbox" class="cbselectAll"/> #</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>수정일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list}" var="cboard" varStatus="status">
									<tr>
										<td>
											<input type="checkbox" name="removeBno" 
											value="${cboard.bno }" class="cbsct" 
											form="removeAllForm1"/> ${status.count }
										</td>
										
										<td>
										<c:url value="/community/cbreading" var="getUrl">
											<c:param name="bno" value="${cboard.bno }" />								
										</c:url> 
										<a href="${getUrl}"> ${cboard.title } </a>
										</td>
										
										<td>${cboard.writer }</td>
										
										<td>
											<fmt:formatDate pattern="yyyy-MM-dd" value="${cboard.regdate }" />
										</td>
										
										<td>
											<fmt:formatDate pattern="yyyy-MM-dd" value="${cboard.updateDate }" />
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<script type="text/javascript" >
					
						var selectAll = document.querySelector(".cbselectAll");
						selectAll.addEventListener('click', function() {
							var objs = document.querySelectorAll(".cbsct");
							for (var i = 0; i < objs.length; i++) {
								objs[i].checked = selectAll.checked;
							};
						}, false);
						var objs = document.querySelectorAll(".cbsct");
						for (var i = 0; i < objs.length; i++) {
							objs[i].addEventListener('click', function() {
								var selectAll = document.querySelector(".cbselectAll");
								for (var j = 0; j < objs.length; j++) {
									if (objs[j].checked === false) {
										selectAll.checked = false;
										return;
									};
								};
								selectAll.checked = true;
							}, false);
						}
					</script>	
							
							
					<div class="tab-pane fade show" id="pills-market" role="tabpanel" aria-labelledby="pills-market-tab">
						<div  class="nav justify-content-end m-2" >
							<form id="removeAllForm2" action="${appRoot }/mypage/removeAll2" method="post">
								<button id="remove-mk" class="btn btn-outline-warning" type="submit" >삭제 </button>
							</form>
						</div>
						<table class="table table-hover">
							<thead>
								<tr>
									<th><input type="checkbox" class="mkselectAll" /> #</th>
									<th>판매</th>
									<th>제목</th>
									<th>작성자</th>
									<th>게시 날짜</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${jlist}" var="jmarket" varStatus="status">
									<tr>
										<td>
											<input type="checkbox" name="removeMnoList" value="${jmarket.mno }" class="mksct" form="removeAllForm2"/> ${status.count }
										</td>
											
											
										<td>${jmarket.msold }</td>
										
										<td>
											<c:url value="/market/detail" var="getUrl">
												<c:param name="mno" value="${jmarket.mno }" />								
											</c:url> 
											<a href="${getUrl}"> ${jmarket.mtitle } </a>
										</td>
										
										<td>${jmarket.mwriter }</td>
										
										<td>
											<fmt:formatDate pattern="yyyy-MM-dd"
												value="${jmarket.mregdate }" />
										</td>
										
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					
					<script type="text/javascript">
							var mkselectAll = document.querySelector(".mkselectAll");
							mkselectAll.addEventListener('click', function() {
								var objs2 = document.querySelectorAll(".mksct");
								for (var i = 0; i < objs2.length; i++) {
									objs2[i].checked = mkselectAll.checked;
								};
							}, false);
							var objs2 = document.querySelectorAll(".mksct");
							for (var i = 0; i < objs2.length; i++) {
								objs2[i].addEventListener('click', function() {
									var mkselectAll = document.querySelector(".mkselectAll");
									for (var j = 0; j < objs2.length; j++) {
										if (objs2[j].checked === false) {
											mkselectAll.checked = false;
											return;
										};
									};
									mkselectAll.checked = true;
								}, false);
							}
					</script>
						
						
					<div class="tab-pane fade show" id="pills-experts" role="tabpanel" aria-labelledby="pills-experts-tab">
						<div  class="nav justify-content-end m-2" >
							<form  id="removeAllForm3" action="${appRoot }/mypage/removerezmsgAll" method="post">
								<button id="remove-rez" class="btn btn-outline-info" type="submit" >삭제 </button>
							</form>
						</div>
						<sec:authorize access="hasRole('ROLE_USER')">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>
										<input type="checkbox" class="rezselectAll" /> #
									</th>
									<th>내용 </th>
									<th>상담 업체</th>
									<th>상담신청 작성일 </th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${rezlist1}" var="ebrezvo" varStatus="status">
									<tr>
										<td>
											<input type="checkbox" name="removeRnoList" 
											value="${ebrezvo.rno }" class="rezsct" 
											form="removeAllForm3"/> ${status.count }
										</td>
										
										<td>
											<a type="button" class="nav-link active" data-toggle="modal" data-target="#rez-modal${status.count }">
												${ebrezvo.content}
											</a>
										</td>
										
										<td>${ebrezvo.readerName }</td>
										
										<td>
											<fmt:formatDate pattern="yyyy-MM-dd" value="${ebrezvo.regdate }" />  
										</td>
										
										
									</tr>
									
										<!-- 상담 내역 확인   -->
										<div class="modal fade" id="rez-modal${status.count }" aria-labelledby="exampleModalLabel" aria-hidden="true">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title">
															인테리어 예약 내역  
														</h5>
														<button type="button" class="close" data-dismiss="modal">
															<span>&times;</span>
														</button>
													</div>		
														<div class="modal-body">
														 	 <div class="card-body">
																<label for="input2">업체 </label>
																<input value="${ebrezvo.readerName }" readonly class="form-control"/>
															</div>	
														 	 <div class="card-body">
														 		    <label class="mt-1 mb-1" for="rezdate" >예약날짜  </label>
																	<input type="date" readonly class="form-control mt-1 mb-1"  name="rezdate" id="rezdate" value="${ebrezvo.rezdate }"/>
														 	 </div>
														 	 <div class="card-body">
														 		<label class="mt-1 mb-1" for="rezdate" >시간</label>
																<input type="time" readonly class="form-control mt-1 mb-1"  name="reztime" id="reztime" value="${ebrezvo.reztime }"/>
														 	 </div>
														 	 <hr>
														 	 <div class="card-body">
														 	 	 예약 내용
														 		 <textarea id="title-textarea" readonly class="form-control card-text" name="content" rows="4" ><c:out value="${ebrezvo.content}"/></textarea>
														 	 </div>
														 	 <div class="card-body">
																<label for="input2">작성자</label>
																<input id="input2" type="hidden" value="${pinfo.user.userid }" readonly class="form-control" name="writer">
																<input value="${pinfo.user.userName }" readonly class="form-control">
															</div>	
														</div>
														
												</div>
											</div>
										</div>	
										
										
								</c:forEach>
							</tbody>
						</table>
						</sec:authorize>
						
						<sec:authorize access="hasRole('ROLE_BUSINESS')">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>
											<input type="checkbox" class="rezAll" /> #
										</th>
										<th>내용  </th>
										<th>상담자 </th>
										<th>상담 신청일 </th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${rezlist}" var="ebrezvo" varStatus="status">
										<tr>
											<td>
												<input type="checkbox" name="removeRnoList" 
												value="${ebrezvo.rno }" class="sctrez" id="${ebrezvo.rno }"
												form="removeAllForm3"/> ${status.count }
											</td>
											
											<td>
												<a type="button" class="nav-link active" data-toggle="modal" data-target="#rez-modal${status.count }">
													${ebrezvo.content}
												</a>
											</td>
											
											<td>${ebrezvo.writerName  }</td>
											
											<td>
												<fmt:formatDate pattern="yyyy-MM-dd" value="${ebrezvo.regdate }" />  
											</td>
											
											
										</tr>
										
											<!-- 상담 내역 확인   -->
											<div class="modal fade" id="rez-modal${status.count }" aria-labelledby="exampleModalLabel" aria-hidden="true">
												<div class="modal-dialog">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title">
															  상담예약 신청 내역  
															</h5>
															<button type="button" class="close" data-dismiss="modal">
																<span>&times;</span>
															</button>
														</div>		
															<div class="modal-body">
																<div class="card-body">
																	<label for="input2">상담자 </label>
																	<input value="${ebrezvo.writerName }" readonly class="form-control"/>
																</div>	
															 	 <div class="card-body">
																	<label for="input2">업체 </label>
																	
																	<input id="input2" type="hidden" value="${pinfo.user.userid }" readonly class="form-control" name="writer">
																	<input value="${pinfo.user.userName }" readonly class="form-control">
																</div>	
															 	 <div class="card-body">
															 		    <label class="mt-1 mb-1" for="rezdate" >예약날짜  </label>
																		<input type="date" readonly class="form-control mt-1 mb-1"  name="rezdate" id="rezdate" value="${ebrezvo.rezdate }"/>
															 	 </div>
															 	 <div class="card-body">
															 		<label class="mt-1 mb-1" for="rezdate" >시간</label>
																	<input type="time" readonly class="form-control mt-1 mb-1"  name="reztime" id="reztime" value="${ebrezvo.reztime }"/>
															 	 </div>
															 	 <hr>
															 	 <div class="card-body">
															 	 	 예약 내용
															 		 <textarea id="title-textarea" readonly class="form-control card-text" name="content" rows="4" ><c:out value="${ebrezvo.content}"/></textarea>
															 	 </div>
															 	 
															</div>
															
													</div>
												</div>
											</div>	
											
											
									</c:forEach>
								</tbody>
							</table>
						</sec:authorize>
					</div>
					<script type="text/javascript">
					
						var rezselectAll = document.querySelector(".rezselectAll");
						rezselectAll.addEventListener('click', function() {
							var obrez = document.querySelectorAll(".rezsct");
							for (var i = 0; i < obrez.length; i++) {   
								obrez[i].checked = rezselectAll.checked;
							};
						}, false);
						var obrez = document.querySelectorAll(".rezsct");
						for (var i = 0; i < obrez.length; i++) {
							obrez[i].addEventListener('click', function() {
								var rezselectAll = document.querySelector(".rezselectAll");
								for (var j = 0; j < obrez.length; j++) {
									if (obrez[j].checked === false) {
										rezselectAll.checked = false;
										return;
									};
								};
								rezselectAll.checked = true;
							}, false);
						}
					</script>	
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
					<h5 class="modal-title">
						비밀번호를 입력해 주세요. 
					</h5>
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
				</div>		
				<form action="${appRoot}/mypage/removeuser" method="post" >
					<div class="modal-body">
						<div class="form-group">
							<label for="inputPassword">비밀번호 </label>
							<input name="inputPassword" type="password" class="form-control" id="input-Password">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">
							닫기
						</button>
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
					<h5 class="modal-title">
						비밀번호 수정하기   
					</h5>
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
				</div>		
				<form action="${appRoot}/mypage/modifypassword" method="post" >
					<div class="modal-body">
						
						<div class="form-group">
							<label for="oldPassword">기존 비밀번호 </label>
							<input name="oldPassword" type="password" class="form-control" id="old-Password">
						</div>
						<div class="form-group">
							<label for="userpw">새 비밀번호 </label>
							<input name="userpw" type="password" class="form-control" id="user-pw">
						</div>
						<div class="form-group">
							<label for="newPassword-ck">새 비밀번호 확인  </label>
							<input name="newPassword-ck" type="password" class="form-control" id="newPassword-ck">
							<small id="password-message" class="form-text text-danger"></small>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">
							닫기
						</button>
						<button type="submit" id="password-modal-btn" class="btn btn-danger">수정하기 </button>
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