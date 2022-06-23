<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>

<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>업체글 수정 </title>
<style type="text/css">

	.top_bg{ 
			width: 100%;
	   		 height: 100px;
    	}
    
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		var modifyUrl = "${appRoot }/experts/emodify";
		var removeUrl = "${appRoot }/experts/eremove";
		$("#removebtn").click(function() {
			if (confirm("삭제 하시겠습니까?")) {
				$("#modify-form").attr("action", removeUrl);
				$("#modify-form").submit();
			}
		});

			$("#writingbtn").click(function() {
				
			//제목 입력 확인 
				if($("#input-title").val()==""){
					alert("제목을 입력해주세요 .");
					$("#input-title").focus();
					return false;
				}
				
			});
			
			
			
		$("#input3").change(function() {
				const file = this.files[0];
				
				if (file) {
					$("#img-preview").attr("src", URL.createObjectURL(file));
				}
				
				$(this).next().text(file.name)
			})
	});
</script>
</head>
<body>
	<div class="container">
		<nb:navbar></nb:navbar>
		
		<div class="top_bg text-center ">
		
			<h3 class="p-4"> 업체 글 수정하기    </h3>
			
		</div>
		<br>
		
		<div class="row">
		
			<div class="col-12">
				<form id="modify-form"action="${appRoot }/experts/emodify"  method="post" enctype="multipart/form-data" >
					<input hidden name="eno" value="${eboard.eno }" />
					
					<div class="form-group">
						<label for="input1">제목</label>
						<input  id="input1" class="form-control" name="title" value="${eboard.title }">
					</div>
					
					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea  id="textarea1" class="form-control" 
						name="content" rows="10"><c:out value="${eboard.content }" /></textarea>
					</div>
					<div class="form-group" >
						<p>지역 </p> 
					    <select  id="addRegion" >
					    	<option>${eboard.addRegion }</option>
					    </select>
					    <select id="addCi" >
					    	<option>${eboard.addCi }</option>
					    </select>
					    <select  id="addGu">
					    	<option>${eboard.addGu }</option>
					    </select>
					</div>
					<c:if test="${not empty eboard.fileName }">
					
						<div class="form-group">
							<p>첨부파일 
							<img class="img-fluid" 
							src="${imgRoot}experts/${eboard.eno }/${eboard.fileName}">
							<p>파일 수정 
						</div>
					</c:if>
					
					<div class="input-group is-invalid">
						<div class="custom-file">
							<input id="input3" multiple="multiple" class="custom-file-input" type="file" name="file" accept="image/*" aria-describedby="선택 ">
							<label class="custom-file-label" for="input3">파일</label>
						</div>
   					</div>
					
					<div class="form-group mt-3">
						<img id="img-preview" src="" alt="미리보기	">
					</div>
					
					<div class="form-group">
						<label for="input2">작성자</label>
						<input readonly="readonly" id="input2" class="form-control" name="writer" value="${eboard.writer }">
					</div>	
						
					<input hidden name="pageNum" value="${cri.pageNum }" />
					<input hidden name="amount" value="${cri.amount }" />	
						
					<div class="input-group justify-content-between">
						<input class="btn btn-warning" type="submit" value="수정" />
						<input id="removebtn" class="btn btn-danger" type="button" value="삭제" />
					</div>
				</form>
			</div>
		</div>
		
				
		<footer>
			<nb:footer></nb:footer>
		</footer>
	</div>
	

	
</body>
</html>