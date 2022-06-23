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

<title>자유게시판 글쓰기 </title>
<style type="text/css">

	.top_bg{ 
		width: 100%;
	    height: 100px;
    }
    
    #img-preview{
   	max-width: 90%;
    }
    
</style>
<script type="text/javascript">

	$(document).ready(function(){

			$("#writingbtn").click(function() {
			//제목입력확인 
				if($("#input-title").val()==""){
					alert("제목을 입력해주세요 .");
					$("#input-title").focus();
					return false;
				}
			//카테고리 체크 확인 
					var Category = $('#cbcategory1');
					if($(':radio[name="cbcategory"]:checked').length < 1){
					    alert('카테고리를 선택해주세요');                        
					    Category.focus();
					    event.preventDefault();
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
		
			<h3 class="p-4">자유게시판 - 글쓰기  </h3>
			
		</div>
		<br>
		
		<div class="row">
		
			<div class="col-12">
			
				<form action="${appRoot }/community/cbwriting" method="post"  enctype="multipart/form-data">
				
					<div class="form-group">
						<label for="input1">제목</label>
						<input id="input-title" class="form-control" name="title">
					</div>
					
					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea id="title-textarea" class="form-control" name="content" rows="10"></textarea>
					</div>
					
					<div class="form-group">
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" id="cbcategory1" name="cbcategory" value="f" class="custom-control-input">
							<label class="custom-control-label" for="cbcategory1">자유  </label>
						</div>
						
						<div class="custom-control custom-radio custom-control-inline">
						 	<input type="radio" id="cbcategory2" name="cbcategory" value="r" class="custom-control-input">
						 	<label class="custom-control-label" for="cbcategory2"> 후기 </label>
						</div>
						
						<div class="custom-control custom-radio custom-control-inline">
						 	<input type="radio" id="cbcategory3" name="cbcategory" value="t" class="custom-control-input">
						 	<label class="custom-control-label" for="cbcategory3"> 팁   </label>
						</div>
						
					</div>
					
					<div class="input-group is-invalid">
						<div class="custom-file">
							<input id="input3" class="custom-file-input" type="file" name="file" accept="image/*" aria-describedby="선택 ">
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
						<a id="writing-not" class="btn btn-outline-secondary" href="${appRoot }/community/cbhome" > 작성취소  </a>
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