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

<title>1:1문의 글쓰기 </title>
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
		
			<h3 class="p-4">1:1문의 - 글쓰기  </h3>
			
		</div>
		<br>
		
		<div class="row">
		
			<div class="col-12">
			
				<form action="${appRoot }/cs/otowriting" method="post"  enctype="multipart/form-data">
				
					<div class="form-group">
						<label for="input1">제목</label>
						<input id="input-title" class="form-control" name="otitle">
					</div>
					
					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea id="title-textarea" class="form-control" name="odetail" rows="10"></textarea>
					</div>

					<!-- 파일 하나 등록
					<div class="input-group is-invalid">
						<div class="otofile">
							<input id="input3" class="otofile-input" type="file" name="file" accept="image/*" aria-describedby="선택 ">
							<label class="custom-file-label" for="input3">파일</label>
						</div>
						
   					</div> -->
   					
   					<!-- <div class="form-group mt-3" id="preview">
						<img id="img-preview" src="" alt="미리보기	">
					</div> -->
   					
   					<!-- 다중 파일 등록 -->
   					<div class="form-group">
						<label for="otofile">파일</label>
						<!-- type file로 지정, multiple 멀티플로 어셉트 이미지 -->
						<input id="otofile" class="form-control" type="file" name="oto_file" multiple="multiple" accept="image/*" onchange="setThumbnail(event);">
					</div>
   					
   					<div>파일 미리보기</div>
						<div class="jumbotron jumbotron-fluid">
					
						<div class="container">
						  <div class="row row-cols-3 image_container" >
						
						    	<!-- 이미지 불러오는곳  -->
						  </div>
						</div>
						</div>
						
						
						
						<!-- 파일 미리보기 스크립트 -->

						<script> 
							function setThumbnail(event) { 
								for (var image of event.target.files) { 
									var reader = new FileReader(); 
									
									reader.onload = function(event) { 
										var newCol = document.createElement("div");
										newCol.classList.add("col")
										var img = document.createElement("img"); 
										
										img.setAttribute("src", event.target.result); 
										
										newCol.appendChild(img);
										
										document.querySelector("div.image_container").appendChild(newCol); 
									}; 
										
									
									console.log(image); 
									reader.readAsDataURL(image); 		
								} 
									
							} 
						</script>
					
					<div class="form-group">
						<label for="input2">작성자</label>
						<input id="input2" type="hidden" value="${pinfo.user.userid }" readonly class="form-control" name="userid">
						<input value="${pinfo.user.userName }" readonly class="form-control">
					</div>	
						
					<div class="input-group justify-content-between">		
						<input id="writingbtn" class="btn btn-primary" type="submit" value="작성" />
						<a id="writing-not" class="btn btn-outline-secondary" href="${appRoot }/cs/oneToOne" > 작성취소  </a>
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