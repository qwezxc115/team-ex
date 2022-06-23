<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>업체 게시글 보기</title>
<style type="text/css">

	.top_bg{ 
		width: 100%;
	    height: 100px;
    }
    
    .row{
    	padding-bottom: 20px;
    }
    
</style>
<script type="text/javascript">

	$(document).ready(function(){
		

		//상담신청시 모달 나오게  
		var rezModal = $("#rez-modal")
		$("#rez-modal-btn").click(function(){
			
				rezModal.modal('show');
			
			
		})
			
	})
	
</script>
</head>
<body>
	<div class="container">
		<nb:navbar></nb:navbar>
		
		<div class="top_bg text-center ">
		
			<h3 class="p-4">업체 글보기 </h3>
			
		</div>
		<br>
		
		<div class="row">
		
			<div class="col-12">
				<form >
					<div class="d-flex justify-content-end">
						<button id="rez-modal-btn" type="button" class="btn btn-warning btn-lg">상담신청</button>
					</div>
					
					<div class="form-group">
						<label for="input1">제목</label>
						<input readonly="readonly" id="input1" class="form-control" name="title" value="${eboard.title }">
					</div>
					
					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea readonly="readonly" id="textarea1" class="form-control" 
						name="content" rows="10"><c:out value="${eboard.content }" /></textarea>
					</div>
					
										
					<div class="form-group">
						<p>지역 </p> 
					    <select name="addRegion" id="addRegion" >
					    	<option>${eboard.addRegion }</option>
					    </select>
					    <select name="addCi" id="addCi" >
					    	<option>${eboard.addCi }</option>
					    </select>
					    <select name="addGu" id="addGu">
					    	<option>${eboard.addGu }</option>
					    </select>
					</div>
					
					<c:if test="${not empty eboard.fileName }">
					
						<div class="form-group">
							<img class="img-fluid" 
							src="${imgRoot}experts/${eboard.eno }/${eboard.fileName}">
						</div>
						
					</c:if>
					
					<div class="form-group">
						<label for="input2">업체명 </label>
						<input readonly="readonly" id="input2" class="form-control" name="writer" value="${eboard.writerName }">
					</div>		
					
					<div class="form-group">
						<c:url value="/experts/emodify" var="emodifyUrl">
							<c:param name="eno" value="${eboard.eno }" />
							<c:param name="pageNum" value="${cri.pageNum }" />
							<c:param name="amount" value="${cri.amount }" />
						</c:url>
							
						<c:if test="${pinfo.user.userid eq eboard.writer }" >
							<a class="btn btn-secondary" href="${emodifyUrl}">수정/삭제</a>
						</c:if>
					</div>
				</form>
			</div>
		</div>
		
		
		
		<!-- 상담신청 모달  -->
		<script type="text/javascript">
		
			$("#rez-btn").click(function() {
				
					if($("#rezdate").val()==""){
						alert("예약날짜을 선택해주세요 .");
						$("#rezdate").focus();
						return false;
					}
					if($("#reztime").val()==""){
						alert("예약시간을 선택해주세요 .");
						$("#reztime").focus();
						return false;
					}
					
				});
		</script>
		
		<div class="modal fade" id="rez-modal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">
							인테리어 상담신청   
						</h5>
						<button type="button" class="close" data-dismiss="modal">
							<span>&times;</span>
						</button>
					</div>		
					<form action="${appRoot}/experts/rez" method="post" >
						<div class="modal-body">
							<div class="card-body">
							    <blockquote class="blockquote mb-0">
							      <p>원하는 날짜를 선택하시면 업체에서 확인 후  연락드립니다!</p>
							      <footer class="blockquote-footer">필요 한 경우 예약 전에 미리 연락이 갈수 있습니다.</footer>
							    </blockquote>
						 	 </div>
						 	 <div class="card-body">
								<label for="input2">업체 </label>
								<input value="${eboard.writerName }" readonly class="form-control"/>
								<input hidden value="${eboard.writer }" name="reader" />
								<input hidden value="${eboard.eno }" name="eno" />
							</div>	
						 	 <div class="card-body">
						 		    <label class="mt-1 mb-1" for="rezdate" >예약날짜  </label>
									<input type="date" class="form-control mt-1 mb-1"  name="rezdate" id="rezdate"/>
						 	 </div>
						 	 <div class="card-body">
						 		<label class="mt-1 mb-1" for="reztime" >시간 </label>
								<input type="time" class="form-control mt-1 mb-1"  name="reztime" id="reztime"/>
						 	 </div>
						 	 <hr>
						 	 <div class="card-body">
						 	 	 연락가능한 연락처 및 간단하게 상담 내용을 입력해주세요 
						 		 <textarea id="title-textarea" class="form-control card-text" name="content" rows="3"></textarea>
						 	 </div>
						 	 <div class="card-body">
								<label for="input2">작성자</label>
								<input id="input2" type="hidden" value="${pinfo.user.userid }" readonly class="form-control" name="writer">
								<input value="${pinfo.user.userName }" readonly class="form-control">
							</div>	
						</div>
						
						<div class="modal-footer">
							<button type="submit" id="rez-btn" class="btn btn-danger">상담 신청</button>
						</div>
						
					</form>
				</div>
			</div>
		</div>	
		
		
				
		<footer>
			<nb:footer></nb:footer>
		</footer>	
	</div>
</body>
</html>