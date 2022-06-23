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

./* card {
height : 400px;
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

} */

/* .card-img-top {
width: 240px;


}

.card-img-top img{
max-width :100%;


}
 */

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



<!-- timeago -->
<script src="${appRoot }/resources/js/date.js"></script>
     
<script>
$(document).ready(function() {
	$("#list-pagenation1 a").click(function(e) {
		// 기본 액션 중지 (hyperlink 역할 안함)
		e.preventDefault();
		
		//console.log("a요소 클릭됨");
		
		var actionForm = $("#actionForm");
		
		// form의 pageNum input의 값을 a 요소의 href값으로 변경
		actionForm.find("[name=pageNum]").val($(this).attr("href"));
		
		// submit
		actionForm.submit();
	});
	/* for문 대신에 each 함수 사용해서 timeBefore js에 값 보내주는 스크립트 */
	$(".card-time-before").each(function(i, e) {
		timeBefore(e);
	})
	
});
</script>        


<title>중고마켓 </title>

</head>
<body>
<div class="container">	
<nb:navbar/>
<nb:scroll />			  
		  
<!-- 배너 : 슬라이드 -->
<!-- 배너 링크 고정이 아닌 이벤트 페이지 번호로 이동할 수 있게끔 수정할 것 -->		
<div id="carouselExampleInterval" class="carousel slide" data-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active" data-interval="3000">
      <a href="${appRoot }/market/home"><img src="${appRoot }/resources/img/market_01.png" class="d-block w-100"  id="carousel-size"></a>
    </div>
  </div>
</div>	
	
	
	
	
		
<!-- 상품 목록 -->	
<div class="d-flex justify-content-between p-2 m-3">

	<h3>오늘의 상품 추천 </h3>
	
	<sec:authorize access="isAuthenticated()">
	  
	 <a class="btn  btn-info" href="${appRoot }/market/write"><i class="fas fa-pen"></i> 글쓰기 </a>
	 
	</sec:authorize>	
</div>
<div class="row row-cols-md-4">		  	
<!-- 상품 -->
<c:forEach items="${list }" var="market">
<c:url value="/market/detail" var="getUrl">
<c:param name="mno" value="${market.mno }" />
<c:param name="pageNum" value="${pageMaker.cri.pageNum }" />
<c:param name="amount" value="${pageMaker.cri.amount }" />
</c:url>	  
<a href="${getUrl}">	
	<div class="col mb-4">
		<div class="card text-center" >
		
			<div id="imgtop" >
 				<img class="imgview" src="${imgRoot}market/${market.mno }/${market.fileName[0]}" class="card-img-top" >
			</div>
			
			<div class="card-body" style="text-align: center">
				<input type="hidden" class="card-text" value="${market.mno }" />
				<div class="card-title">상품명 : ${market.mtitle }</div>
			</div>

			<div class="form-group" id="card-detail"
				style="text-align: center">
				<span class="card-text">가격 :
				 <fmt:formatNumber pattern="#,###원" value="${market.mprice }" />
				</span> 
			</div>
			<p class="card-time-before" >${market.mregdate.time }</p>
			<hr class="m-0">
			<div class="card-add text-center p-2" >거래지역 :${market.maddress }</div>
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
	<form id="actionForm" action="${appRoot }/market/main" method="get">
		<input name="pageNum" value="${pageMaker.cri.pageNum }" /> 
		<input name="amount" value="${pageMaker.cri.amount }" />
	</form>
</div>


</div>

<footer>
	<nb:footer/>
</footer>

</div>

</body>
</html>