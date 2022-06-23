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



<title>중고마켓 글쓰기</title>
</head>
<body>
<div class="container">
<nb:navbar/>
<nb:scroll/>

		<h1>중고마켓 상품등록</h1>
		<hr>


		<div class="row">
			<div class="col-12">
				<form action="${appRoot }/market/write" method="post" enctype="multipart/form-data">

					<div class="form-group">
						<label for="mdetail">나눔, 판매</label>

						<!-- 중복체크 방지 -->
						<div class="form-check">
							<input class="form-check-input" type="radio" name="msold" id="msold1"  value="판매" checked>
							<label class="form-check-label" for="msold1"> 판매 </label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" name="msold" id="msold2" value="나눔" >
							<label class="form-check-label" for="msold2"> 나눔 </label>
						</div>
					</div>
				
					<div class="form-group">
						<label for="mtitle">제목</label>
						<input id="mtitle" class="form-control" name="mtitle">
					</div>
					
					<div class="form-group">
						<label for="mwriter">작성자</label>
						<input id="mwriter" readonly class="form-control" name="mwriter" value="${pinfo.user.userid }">
						
					</div>


					<div class="form-group">
						<label for="mdetail">상품상태</label>

						<!-- 중복체크 방지 -->
						<div class="form-check">
							<input class="form-check-input" type="radio" name="mstate" id="mstate1" value="새 상품" checked>
							<label class="form-check-label" for="mstate1"> 새 상품 </label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" name="mstate" id="mstate2" value="중고 상품">
								<label class="form-check-label" for="mstate2"> 중고 상품 </label>
						</div>
					</div>
					

					
						<div class="form-group">
							<label for="mprice">상품가격</label>
							<input id="mprice" class="form-control" name="mprice">
						</div>
						
						<!-- 은비 파일 -->
						<div class="form-group">
						<label for="market_file">파일</label>
						<!-- type file로 지정, multiple 멀티플로 어셉트 이미지 -->
						<input id="market_file" class="form-control" type="file" name="market_file" multiple="multiple" accept="image/*" onchange="setThumbnail(event);">
						
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
							<label for="maddress">거래지역</label>
							<input id="maddress" class="form-control" name="maddress">
						</div>
						
						
						<div class="form-group">
							<label for="mdetail">상세 설명</label>
							<textarea id="mdetail" class="form-control" name="mdetail"></textarea>
						</div>
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