<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>공지사항 글쓰기</title>

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
		
			<h3 class="p-4">공지사항 - 글쓰기  </h3>
			
		</div>
		<br>
		
		<div class="row">
		
			<div class="col-12">
			
				<form action="${appRoot }/cs/noticeWriting" method="post"  enctype="multipart/form-data">
				
					<div class="form-group">
						<label for="input-title">제목</label>
						<input id="input-title" class="form-control" name="ntitle">
					</div>
					
					<div class="form-group">
						<label for="ndetail-textarea">내용</label>
						<textarea id="ndetail-textarea" class="form-control" name="ndetail" rows="30"></textarea>
					</div>

					<!-- 은비 수정 8-16 -->
					<div class="input-group is-invalid">
						<div class="custom-file">
							<input id="input3" class="custom-file-input" type="file" name="notice_file" multiple="multiple" accept="image/*" aria-describedby="선택 ">
							<label class="custom-file-label" for="input3">파일</label>
						</div>
						
   					</div>
   					
					<div class="form-group mt-3" id="preview">
						<img id="img-preview" src="" alt="미리보기	">
					</div>
					
					<div class="form-group">
						<label for="input2">작성자</label>
						<input id="input2" type="hidden" value="${pinfo.user.userid }" readonly class="form-control" name="userid">
					</div>	
						
					<div class="input-group justify-content-between">		
						<input id="writingbtn" class="btn btn-primary" type="submit" value="작성" />
						<a id="writing-not" class="btn btn-outline-secondary" href="${appRoot }/cs/notice" > 작성취소  </a>
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