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

<!-- script -->

<script>
</script>

<title>상세페이지</title>
</head>
<body>
<div class="container">
<nb:navbar/>
<nb:scroll/>

	<h3>상품 페이지</h3>
	<hr> 	
	

	<div class="row">
	

					
			<div class="form-group col-6">
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
			
			
			<div class="part-detail col-6">
		<form >		
				<div class="form-group">
					<label for="msold">판매/나눔</label>
					<input readonly id="msold" class="form-control" name="msold" value="${market.msold }">
				</div> 			
				
				<div class="form-group">
					<label for="mtitle">상품명</label>
					<input readonly id="mtitle" class="form-control" name="mtitle" value="${market.mtitle }">
				</div>	
					
				<div class="form-group">
					<label for="mprice">가격</label>
					<input readonly id="mprice" class="form-control" name="mprice" value="${market.mprice }">
					
				</div>	

				<div class="form-group">
					<label for="mstate">상품상태</label>
					<input readonly id="mstate" class="form-control" name="mstate" value="${market.mstate }">
				</div>	

				<div class="form-group">
					<label for="maddress">거래지역</label>
					<input readonly id="maddress" class="form-control" name="maddress" value="${market.maddress }">
				</div>	
				
				<div class="form-group">
					<label for="mwriter">작성자</label>
					<input readonly id="mwriter" class="form-control" name="mwriter" value="${market.mwriter }">
				</div>	

				<div class="form-group">
					<label for="mregdate">게시 날짜</label>
					<span readonly class="form-control" id="mregdate" name="mregdate"><fmt:formatDate pattern="yyyy-MM-dd" value="${market.mregdate }"/></span>
				</div>
								
				<!-- <button type="button" class="btn btncl" id="market_heart"><i class="far fa-heart"></i> 찜하기 </button>
				<i class="fas fa-heart"></i> 검은하트 -->
				
				<button type="button" class="btn btncl" id="market_dm" data-toggle="modal" data-target="#callsec"><i class="far fa-envelope"></i> 쪽지 보내기 </button>
				
			</form>		
		</div>
<script>
$(function() {
	$("#callsec").on("show.bs.modal", function() {
		$("#contentTh").val("");
		$("#sendbtnTh").prop("disabled", true);
		
		$("#contentTh").keyup(function(){
			$("#sendbtnTh").prop("disabled", false);	
		})
	})
});
</script>

			
	<!-- 쪽지 보내기 모달 -->
    <div class="modal fade" id="callsec" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">쪽지 전송하기</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="${appRoot }/message/mgsend" method="post">
						<div class="form-group">
							<label for="writer" class="col-form-label">보내는 사람</label>
							<input type="text" readonly class="form-control" id="writerTh" value="${pinfo.user.userid}" name="writer">
						</div>
	
						<div class="form-group">
							<label for="reader" class="col-form-label">받는 사람</label>
							<input type="text" readonly class="form-control" id="readerTh" value="${market.mwriter}" name="reader">
						</div>
	
						<div class="form-group">
							<label for="content" class="col-form-label">내용</label>
							<textarea class="form-control"  id="contentTh" name="content"></textarea>
						</div>
					 
						<div class="modal-footer">
							<button type="button" class="btn btn-light" data-dismiss="modal">Close</button>
							<button id="sendbtnTh" type="submit" class="btn btn-secondary" >보내기</button>
						</div>		
					</form>					
				</div>
			</div>
		</div>
	</div>								
			
			
		</div>	
		
		<form>
				<hr>
				<h3>상품 정보</h3>
				<hr>
				
				
				<div class="form-group">
					<label for="mdetail">상세 설명</label>
					<textarea readonly="readonly" id="mdetail" class="form-control" name="mdetail" >${market.mdetail }</textarea>
				</div>								
		</form>		
		<div>
			<c:url value="/market/modify" var="modifyUrl">
							<c:param name="mno" value="${market.mno }" />
							<c:param name="pageNum" value="${cri.pageNum }" />
							<c:param name="amount" value="${cri.amount }" />
		
						</c:url>
		
			<c:if test="${pinfo.user.userid eq market.mwriter }" >				
				<a class="btn btncl" href="${modifyUrl }"><i class="far fa-edit"></i>수정</a>
			</c:if>	
		</div>
				
<footer>
	<nb:footer/>
</footer>
	
</div>


</body>
</html>