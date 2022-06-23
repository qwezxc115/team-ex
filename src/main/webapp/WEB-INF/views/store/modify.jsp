<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 날짜 형식 fmt tag 사용하기 위해 import함 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>Insert title here</title>

<script>
$(document).ready(function() {
	var modifyUrl = "${appRoot }/store/modify";
	var removeUrl = "${appRoot }/store/remove";
	$("#store-remove-btn1").click(function() {
		if (confirm("삭제 하시겠습니까?")) {
			$("#store-modify").attr("action", removeUrl);
			$("#store-modify").submit();
		}
	});

});

</script>

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



</head>
<body>
<div class="container">
<nb:navbar/>
<nb:scroll/>
	<h1>글 수정/삭제</h1>
		<hr> 	
	<div class="row">
		<div class="col-12">

		<div class="row">
			<div class="col-12">
				
				<form id="store-modify" action="${appRoot }/store/modify" method="post" enctype="multipart/form-data">
				<input type="hidden" name="pno" value="${store.pno}"/>
					<div class="form-group">
						<c:if test="${not empty store.fileName }">
			            <c:forEach items="${store.fileName }" var="store_file">
			               <div>
			                  <img class="rounded float-left" src="${imgRoot}${store.pno }/${store_file}">
			               </div>
			            </c:forEach>
			            </c:if>
					</div>
				
				
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
						<input id="title" class="form-control" name="title" value="${store.title }" required>
					</div>				
				
				
					<div class="form-group">
						<label for="price">판매가</label>
						<input id="price" class="form-control" name="price" value="${store.price }" required>
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
							<textarea rows="5" cols="50" id="detail" class="form-control" name="detail" >${store.detail }</textarea>
						</div>
						
					<div class="form-group">
						<label for="userid">작성자</label>
						<input id="userid" readonly class="form-control" name="userid" value="${pinfo.user.userid }">
						
					</div>
						
 						<div class="form-group">
						<label for="market_file">파일</label>
						<input id="market_file" class="form-control" type="file" name="market_file" multiple="multiple" accept="image/*" onchange="setThumbnail(event);">
						
						</div>
				
				<div class="form-group">
					<label for="regdate">게시일자</label>
					<span readonly class="form-control" id="regdate" name="regdate"><fmt:formatDate pattern="yyyy-MM-dd" value="${store.regdate }"/></span>
				</div>
				
				<div class="form-group">
					<label for="updatedate">마지막 수정일</label>
					<span readonly class="form-control" id="updatedate" name="updatedate"><fmt:formatDate pattern="yyyy-MM-dd" value="${store.updatedate }"/></span>
				</div>
				
				
						
				<i class="far fa-edit"></i><input type="submit" class="btn btncl" id="store_detail_modify" value="완료" ></input>
				<i class="fas fa-arrow-left"></i><button onclick="history.back()"class="btn btncl" >취소</button>
				<span style="float:right"><i class="far fa-trash-alt"></i><input id="store-remove-btn1" class="btn btncl" type="button" value="삭제" ></span>
				
			</form>
		</div>
	</div>
</div>

</div>
</div>

</body>
</html>


