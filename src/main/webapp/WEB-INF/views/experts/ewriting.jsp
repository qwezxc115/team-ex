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

<title>업체글쓰기 </title>
<style type="text/css">

	.top_bg{ 
		width: 100%;
	    height: 100px;
    }
    
    #img-preview{
   	max-width: 90%;
    }
    
</style>
<script src="${appRoot }/resources/js/addArea.js"></script>
<script type="text/javascript">

	$(document).ready(function(){

			$("#writingbtn").click(function() {
				
			//제목 입력 확인 
				if($("#input-title").val()==""){
					alert("제목을 입력해주세요 .");
					$("#input-title").focus();
					return false;
				}
			
			//지역 옵션 체크 확인 
				var region = $("[name=addRegion] :selected").val();
				var ci = $("[name=addCi] :selected").val();
				var gu = $("[name=addGu] :selected").val();
				if(region == ""){
					alert("지역을 선택해주세요  ");
					$("#addRegion").focus();
					return false;
				}
				if(ci == ""){
					alert("지역을 선택해주세요  ");
					$("#addCi").focus();
					return false;
				}
				if(gu == ""){
					alert("지역구을 선택해주세요  ");
					$("#addGu").focus();
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
		
			<h3 class="p-4">업체 - 글쓰기  </h3>
			
		</div>
		<br>
		
		<div class="row">
			<div class="col-12">
			
				<form action="${appRoot }/experts/ewriting" method="post"  enctype="multipart/form-data">
				
					<div class="form-group">
						<label for="input1">제목</label>
						<input id="input-title" class="form-control" name="title">
					</div>
					
					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea id="title-textarea" class="form-control" name="content" rows="10"></textarea>
					</div>
					
					<div class="form-group">
						<p>지역 </p> 
					    <select name="addRegion" id="addRegion"></select>
					    <select name="addCi" id="addCi"></select>
					    <select name="addGu" id="addGu"></select>
					</div>
					
					<div class="input-group is-invalid">
						<div class="custom-file">
							<input id="input3" multiple="multiple" class="custom-file-input" type="file" name="file" accept="image/*" aria-describedby="선택 ">
							<label class="custom-file-label" for="input3">파일</label>
						</div>
   					</div>
   					
					<div class="form-group mt-3" id="preview">
						<img id="img-preview" src="" alt="미리보기	">
					</div>
					
					<div class="form-group">
						<label for="input2">작성자</label>
						<input id="input2" type="hidden" value="${pinfo.user.userid }" readonly class="form-control" name="writer">
						<input value="${pinfo.user.userName }" readonly class="form-control">
					</div>		
					
					<div class="input-group justify-content-between">		
						<input id="writingbtn" class="btn btn-primary" type="submit" value="작성" />
						<a id="writing-not" class="btn btn-outline-secondary" href="${appRoot }/experts/home" > 작성취소  </a>
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