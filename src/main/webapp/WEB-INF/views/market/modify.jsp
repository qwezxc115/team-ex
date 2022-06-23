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
<style type="text/css">
#carouselExampleControls {
width : 540px;
}
#carouselExampleControls img{
max-width : 100%;
} 

</style> 




<title>Insert title here</title>

<script>
$(document).ready(function() {
	var modifyUrl = "${appRoot }/market/modify";
	var removeUrl = "${appRoot }/market/remove";
	$("#market-remove-btn1").click(function() {
		if (confirm("삭제 하시겠습니까?")) {
			$("#market-modify").attr("action", removeUrl);
			$("#market-modify").submit();
		}
	});
});
</script>
</head>
<body>
<div class="container">
<nb:navbar/>
<nb:scroll/>
	<h1>글 수정/삭제</h1>
		<hr> 	
	<div class="row m-2" >
		<div class="col-12">
			<form id="market-modify" action="${appRoot }/market/modify" method="post" enctype="multipart/form-data">
				<input hidden name="mno" value="${market.mno }" />
				
<%-- 			<div class="form-group">
			<c:if test="${not empty market.fileName }">
            <c:forEach items="${market.fileName }" var="market_file">
               <div>
                  <img class="rounded float-left" src="${imgRoot}market/${market.mno }/${market_file}">
               </div>
            </c:forEach>
            </c:if>
			</div>	 --%>
			
			
	<div class="form-group">
		<c:if test="${not empty market.fileName }">
			<div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
	  			<div class="carousel-inner">
	    
	         <c:forEach items="${market.fileName }" var="market_file" varStatus="status">
	
				<div class="carousel-item <c:if test='${status.first }' >active</c:if>">
					<img src="${imgRoot}market/${market.mno }/${market_file}">
				</div>
	
	
	        </c:forEach>
	          
	           <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
				 <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				 <span class="sr-only">Previous</span>
	           </a>
	           <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
				 <span class="carousel-control-next-icon" aria-hidden="true"></span>
				 <span class="sr-only">Next</span>
	           </a> 
	          
	           </div>
	       </div>
	    </c:if> 
	</div>
			
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
					<label for="mtitle">상품명</label>
					<input id="mtitle" class="form-control" name="mtitle" value="${market.mtitle }">
				</div>	
					
				<div class="form-group">
					<label for="mprice">가격</label>
					<input id="mprice" class="form-control" name="mprice" value="${market.mprice }">
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
					<label for="maddress">거래지역</label>
					<input id="maddress" class="form-control" name="maddress" value="${market.maddress }">
				</div>	
				
				<div class="form-group">
					<label for="mwriter">작성자</label>
					<input readonly id="mwriter" class="form-control" name="mwriter" value="${market.mwriter }">
				</div>	

				<div class="form-group">
					<label for="mregdate">게시 날짜</label>
					<span readonly class="form-control" id="mregdate" name="mregdate"><fmt:formatDate pattern="yyyy-MM-dd" value="${market.mregdate }"/></span>
				</div>
														
				<div class="form-group">
					<label for="input3">파일</label>
					<input id="input3" class="form-control" type="file" name="market_file" multiple="multiple"  accept="image/*">
				</div>
				
				<input hidden name="pageNum" value="${cri.pageNum }" />
				<input hidden name="amount" value="${cri.amount }" />		
				
				<hr>
				<h3>상품 정보</h3>
				<hr>
				
				
				<div class="form-group">
					<label for="mdetail">상세 설명</label>
					<textarea id="mdetail" class="form-control" name="mdetail">${market.mdetail }</textarea>
				</div>	

									
				<input class="btn btncl" id="market_detail_modify" type="submit" value="수정" /><i class="far fa-edit"></i>
				<input id="market-remove-btn1" class="btn btncl" type="button" value="삭제" /><i class="far fa-trash-alt"></i>
			</form>
		</div>
	</div>
	
<footer>
	<nb:footer/>
</footer>		
	
</div>
</body>
</html>


