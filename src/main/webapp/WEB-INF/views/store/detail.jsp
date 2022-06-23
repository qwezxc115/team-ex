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

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>



<style type = "text/css">
.part-img img {
	max-width :100%;
	padding : 20px;
}
.part-detail{
	font-size: 
	
}

.carousel-item img {
	width :500px;
	height: 500px;
}


</style>

<script>
$(document).ready(function() {
	$("#wish1").click(function() {
		if (confirm("찜목록에 담아두시겠습니까?")) {
			$("#orderform").attr("action", "${appRoot }/store/detail");
			$("#orderform").submit();
		}
	});	
	
	$("#cart1").click(function() {
		if (confirm("장바구니에 담으시겠습니까?")) {
			$("#orderform").attr("action", "${appRoot }/store/cart");
			$("#orderform").submit();
		}
	});
	
	
	$("#buyBtn").click(function() {
		if (confirm("바로 구매하시겠습니까?")) {
			$("#orderform").attr("action", "${appRoot }/store/directorder");
			$("#orderform").submit();
		}
	});
	


});

</script>

<title>상세페이지</title>
</head>
<body>
<div class="container">
<nb:navbar/>
<nb:scroll/>

	<h3>상품 페이지</h3>
	<hr> 	
	
<form id="orderform" action="${appRoot }/store/cart" method="post">		
<input type = "hidden" name="pno" value = "${store.pno }">
	<div class="row">
	

					
			<div class="form-group col-6">
			<c:if test="${not empty store.fileName }">
			<div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
			  <div class="carousel-inner">
			    
	           <c:forEach items="${store.fileName }" var="store_file" varStatus="status">
	           
	           <div class="carousel-item <c:if test='${status.first }' >active</c:if>">
					<img src="${imgRoot}store/${store.pno }/${store_file}">
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

		<div class="part-detail col-6">
			
				<div class="form-group">
					<label for="title">상품명</label>
					<span>${store.title }</span>
				</div>	
					
				<div class="form-group">
					<label for="price">판매가</label>
					<span><fmt:formatNumber value="${store.price}" pattern="#,###원"/></span>
				</div>	

					
				<div class="form-group">
					<label for="delivery">배송</label>
					<span>${store.delivery }</span>
				</div>	

				<div class="form-group">
				<p>수량
				<select name = "cartstock" id = "cartstock">
					<c:forEach begin="1" end="10" var ="i">
						<option value="${i }">${i }</option>
					</c:forEach>
				</select>
				</p>	
				</div>	
				
				<div class="form-group">
				<button type="button"  class="btn btncl" id = "wish1" ><i class="fas fa-heart"></i> 찜하기 </button>
				
				<button type="button" id ="cart1" class="btn btncl"><i class="fas fa-shopping-cart"></i> 장바구니 </button>

				<button type="button" id ="buyBtn" class="btn btncl"><i class="fas fa-credit-card"></i> 구매하기 </button>
				</div>	
		
				<hr>
	

				<div class="form-group">
					<label for="detail">상품 소개</label>
					<textarea rows="10" cols="50" id="detail" class="form-control" name="detail" readonly>${store.detail }</textarea>
				</div>	
			
				<!-- 등록성공시 모달 나오게   -->
				<c:if test="${not empty result }" >
					<script>
					$(document).ready(function() {
						
						if (history.state == null) {
							$("#board-modal1").modal('show');
							history.replaceState({}, null);
						}
						 else {
								
								console.log("너 전에 여기 왔었어!!!!");
							}
					});
					</script>

					<div id="board-modal1" class="modal" tabindex="-1">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					         <h5 class="modal-title">${messageTitle } </h5> 
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
					        <p>${messageBody } </p>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					      </div>
					    </div>
					  </div>
					</div>
				</c:if>

				
		</div>

</div>
</form>
		<i class="fas fa-arrow-left"></i><button onclick="history.back()"class="btn btncl" >HOME</button>	
		<div>
			<c:url value="/store/modify" var="modifyUrl">
				<c:param name="pno" value="${store.pno }" />
				<c:param name="pageNum" value="${cri.pageNum }" />
				<c:param name="amount" value="${cri.amount }" />
			</c:url>
		</div>
			<c:if test="${pinfo.user.userid eq store.userid }" >				
				<i class="far fa-edit"></i><a class="btn btncl" href="${modifyUrl }">수정</a>
			</c:if>
	
	<footer>
		<nb:footer/>
	</footer>
	
			

</div>


</body>
</html>