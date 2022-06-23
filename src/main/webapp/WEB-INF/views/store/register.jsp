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

<style type = "text/css">
.image_container img {
	max-width :100%;
	padding : 20px;
}

</style>


<script>
/* 판매가, 재고수량 숫자만 입력 가능한 스크립트 */
$(document).ready(function(){
var regExp = /[^0-9]/gi;

$("#price").keyup(function(){ 
	numCheck($(this)); 
	});

$("#stock").keyup(function(){ 
	numCheck($(this)); 
	});

function numCheck(selector) {
 var tempVal = selector.val();
 selector.val(tempVal.replace(regExp, ""));
}
});
</script>

<title>상품등록</title>
</head>
<body>
<div class="container">
<nb:navbar/>
<nb:scroll/>

		<h1>스토어 상품 등록</h1>
		<hr>


		<div class="row">
			<div class="col-12">
				<form action="${appRoot }/store/register" method="post" enctype="multipart/form-data">

				<div class="form-group">
				<label class="" for="category">카테고리
					  <select name="category" >
					      <option value="가구">가구</option>
					      <option value="수납">수납</option>
					      <option value="조명">조명</option>
					      <option value="가전">가전</option>
					      <option value="장식/소품">장식/소품</option>
					  </select>
					</label>
					</div>		
							
					<div class="form-group">
						<label for="title">상품명</label>
						<input id="title" class="form-control" name="title" required>
					</div>				
				
				
					<div class="form-group">
						<label for="price">판매가</label>
						<input id="price" class="form-control" name="price" required>
					</div>

					<div class="form-group">
						<label for="delivery">배송</label>
						<div>
						<div class="form-check-inline">
							<input class="form-control-input" type="radio" name="delivery" id="delivery1" value="무료배송" checked>
							<label class="form-check-label" for="delivery1">무료배송 </label>
						</div>
						<div class="form-check-inline">
							<input class="form-check-input" type="radio" name="delivery" id="delivery2" value="일반배송">
							<label class="form-check-label" for="delivery2">일반배송 </label>
						</div>
						</div>
					</div>
					
						<div class="form-group">
							<label for="detail">상품 소개</label>
							<textarea rows="5" cols="50" id="detail" class="form-control" name="detail"></textarea>
						</div>
						
						
						
					<div class="form-group">
						<label for="userid">작성자</label>
						<input id="userid" readonly class="form-control" name="userid" value="${pinfo.user.userid }">
						
					</div>
						
 						<div class="form-group">
						<label for="store_file">파일</label>
						<input id="store_file" class="form-control" type="file" name="store_file" multiple="multiple" accept="image/*" onchange="setThumbnail(event);">
						
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


						
					<input class="btn btn-primary" type="submit" value="작성" />
				</form>
			</div>
		</div>
		<footer>
			<nb:footer/>
		</footer>
	</div>
</body>
</html>