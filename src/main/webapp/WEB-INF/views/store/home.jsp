<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>


<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<style type="text/css">
.row, .keyword, .productlist{
margin-top: 20px;
}

hr {
margin : 0px;
}
 
a { 
color : black;
} 
a:hover { 
color : black;
text-decoration:none ;
} 

/* .card {
height : 300px;
}

.card-body {
padding : 10px;
}

.card-text {
font-size: 20px;
margin : 0px;
}

.card-title{
font-size : 22px;
}

#card-detail, #card-address{
padding : 10px;

}

.card-img-top {
width: 160px;


}

.card-img-top img{
	max-width :100%;

}
 */

	#imgsize{
    	max-width:100%;
    	height: 250px;
    	padding:5px;
    }
    #imgtop{
    	max-width:100%;
    	height: 250px;
    	padding:5px;
    }
    .imgview{
    	width: 100%;
    	height: 250px;
    }

</style> 
 
<script type="text/javascript">

	$(document).ready(function() {
		$(".category-btn").click(function(e) {
			e.preventDefault();
			var category = $(this).attr("href");
			$("#actionForm [name=category]").val(category);
			$("#actionForm").submit();
		});
		
		$(".page-link").click(function(e) {
			e.preventDefault();
			
			var pageNum = $(this).attr("href");
			$("#actionForm [name=pageNum]").val(pageNum);
			$("#actionForm").submit();
	
		})
	})

</script>

<title>스토어 </title>

</head>
<body>
<div class="container">	
<nb:navbar/>
<nb:scroll />			
		<div class="row">
		  <div class="col-2">
<ul class="nav flex-column">
  <li class="nav-item">
    <a class="nav-link btn-light" href="${appRoot }/store/home">카테고리</a>
  </li>
  <li class="nav-item">
    <a class="nav-link btn-outline-secondary category-btn" href="가구">가구</a>
  </li>
  <li class="nav-item">
    <a class="nav-link btn-outline-secondary category-btn" href="수납">수납</a>
  </li>
    <li class="nav-item">
    <a class="nav-link btn-outline-secondary category-btn" href="조명">조명</a>
  </li>
    <li class="nav-item">
    <a class="nav-link btn-outline-secondary category-btn" href="가전">가전</a>
  </li>
    <li class="nav-item">
    <a class="nav-link btn-outline-secondary category-btn"  href="장식/소품">장식/소품</a>
  </li>
</ul>
<%--
			<select class="form-select1" aria-label="Default select example">
					  <option >카테고리 </option>
					  <option ${cri.category == 'A' ? 'selected' : '' } value="A">가구 </option>
					  <option ${cri.category == 'B' ? 'selected' : '' } value="B">수납 </option>
					  <option ${cri.category == 'C' ? 'selected' : '' } value="C">조명 </option>
					  <option ${cri.category == 'D' ? 'selected' : '' } value="D">가전 </option>
					  <option ${cri.category == 'E' ? 'selected' : '' } value="E">장식/소품 </option>

			</select>
 --%>



</div>

<div class="col-10">
		  
<!-- 배너 : 슬라이드 -->	
<div id="carouselExampleInterval" class="carousel slide" data-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active" data-interval="3000">
      <a href="${appRoot }/main/tos"><img src="${appRoot }/resources/img/store_01.png" class="d-block w-100"  id="carousel-size"></a>
    </div>
    <div class="carousel-item" data-interval="3000">
      <a href="${appRoot }/main/home"><img src="${appRoot }/resources/img/store_02.png" class="d-block w-100"  id="carousel-size"></a>
    </div>
  </div>
  <a class="carousel-control-prev" href="#carouselExampleInterval" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleInterval" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>	
		
		
<!-- 상품 목록 -->	
<div class="productlist">
<h4>오늘의 상품 추천 </h4>

<div class="row row-cols-md-4">		  	
<!-- 상품 -->
	<c:forEach items="${list }" var="store">
		 <c:url value="/store/detail" var="getUrl">
		<c:param name="pno" value="${store.pno }" />
		<c:param name="pageNum" value="${pageMaker.cri.pageNum }" />
		<c:param name="amount" value="${pageMaker.cri.amount }" />
		</c:url>	   



		<a href="${getUrl}">	
			<div class="col mb-3">
				<div class="card card_s text-center">
					<div id="imgsize" class="text-center" >
			 			<img class="imgview" src="${imgRoot}store/${store.pno }/${store.fileName[0]}" class="card-img-top" >
					</div>
	
					<div class="card-body text-center">
						<input type="hidden" class="card-text" value="${store.pno }" />
						<div class="card-title">상품명 : ${store.title }</div>
					</div>
	
					<div class="form-group " id="card-detail">
						<div class="card-text" style="text-align: center">
							가격 :
							<fmt:formatNumber pattern="#,###원" value="${store.price }" />
						</div>
					</div>
					<hr class="m-0">
					<div class="card-add text-center p-2" >${store.delivery }</div>
				</div>
			</div>
	 	</a> 
	 </c:forEach>
</div>

<!--  pagenation -->
<div>
<nav aria-label="Page navigation example">
  <ul id="list-pagenation1" class="pagination justify-content-center">
    <c:if test="${pageMaker.prev }">
	    <li class="page-item">
	      <a class="page-link" href="${pageMaker.startPage - 1 }">Previous</a>
	    </li>
  	</c:if>
	
	<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
	   <%-- href value 	
	   href="${appRoot }/board/list?pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}"	 
	   --%>
	    <li class="page-item"><a class="page-link"  href="${num }">${num }</a></li>
	</c:forEach>

	<c:if test="${pageMaker.next }">
	    <li class="page-item">
	      <a class="page-link" href="${pageMaker.endPage + 1 }">Next</a>
	    </li>
	</c:if>
  </ul>
</nav>

<div style="display: none;">
	<form id="actionForm" action="${appRoot }/store/home" method="get">
		<input name="pageNum" value="${pageMaker.cri.pageNum }" /> 
		<input name="category" value="" />
		<input name="amount" value="${pageMaker.cri.amount }" />
	</form>
</div>


</div>

</div>
</div>	
</div>

<footer>
	<nb:footer/>
</footer>
</div>

</body>
</html>