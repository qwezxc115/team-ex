<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb"%>

<%
request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<link rel="shortcut icon" type="image/x-icon" href="${appRoot }/resources/img/triple.png">
<title>트리플</title>

<style type="text/css">
	
	.ba_bg{ 
		width: 100%;
	    height: 100px;
	   	
    }
    
   	.board_bg{ 
		width: 100%;
	    height: 100px;
	    background:no-repeat  url("${appRoot }/resources/img/main_board.png");
	    background-size:contain ;
	   	
    }
    .card_s{
    		max-width: 100%;
    }
    
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

    .at{
    	font-size:30px;
    	color: #6d0d27;
    }
    
    .st{
    	color: #6d0d27;
    }
   
</style>
<!-- timeago -->
<script src="${appRoot }/resources/js/date.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		/* for문 대신에 each 함수 사용해서 timeBefore js에 값 보내주는 스크립트 */
		$(".card-time-before").each(function(i, e) {
			timeBefore(e);
		})
	})
</script>

</head>
<body>
	<div class="container">
		<nb:navbar></nb:navbar>

		<div class=".ba_bg" >
	      <a href="${appRoot }/main/tos"><img src="${appRoot }/resources/img/store_01.png" class="d-block w-100"  id="carousel-size"></a>
	    </div>
	    
		<div class="text-center">
			<a class="navbar-brand at" href="${appRoot }/store/home">스토어</a>
		</div>
		<p class="text-center">요즘 뜨는 상품 ! 이 상품들 어때요  ~?</p>
		<div class="row row-cols-md-4">
			<!-- 상품 -->
			<c:forEach items="${storelist }" var="store">
				<c:url value="/store/detail" var="getUrl">
					<c:param name="pno" value="${store.pno }" />
				</c:url>

				<a class="nav-link" href="${getUrl}">
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
		
		<div class="board_bg text-center ">
		
			<h3 class="p-4">우리들의 소통 공간 </h3>
			
		</div>
		<div class="row row-cols-2 m-0">
			<div class="col border">
				<div class="text-center">
				<a class="navbar-brand st" href="${appRoot }/community/cbhome">자유게시판</a>
				</div>
				<table class="table table-hover">
					<thead>
						<tr>
							<th style="width: 5%">#</th>
							<th style="width: 25%">제목</th>
							<th style="width: 25%">작성자</th>
							<th style="width: 25%">작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${cboardList }" var="cboard">
							<tr>
								<td>${cboard.bno }</td>
								<td><c:url value="/community/cbreading" var="getUrl">
										<c:param name="bno" value="${cboard.bno }" />
									</c:url> <a href="${getUrl}"> ${cboard.title } </a></td>
								<td>${cboard.writer }</td>
								<td>
									<fmt:formatDate pattern="yyyy-MM-dd" value="${cboard.regdate }"/>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			
			<div class="col border ">
				<div class="text-center">
					<a class="navbar-brand st"  href="${appRoot }/cs/notice">공지사항</a>
				</div>
				<table class="table table-striped">
					<thead>
						<tr>
							<th style="width: 5%">#</th>
							<th style="width: 25%">제목</th>
							<th style="width: 25%">작성자</th>
							<th style="width: 25%">작성일</th>
						</tr>
					</thead>
		
					<tbody>
						<c:forEach items="${noticelist }" var="notice">
							<c:url value="/cs/noticeReading" var="getUrl">
								<c:param name="nno" value="${notice.nno }" />
							</c:url>
							<tr>
								<%-- 				<td>${notice.count }</td> --%>
								<td>${notice.nno }</td>
								<td><a href="${getUrl}">${notice.ntitle }</a></td>
								<td>${notice.userid }</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${notice.nregdate }" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<br>
		
		<div class=".ba_bg" >
	      <a href="${appRoot }/market/home"><img src="${appRoot }/resources/img/market_01.png" class="d-block w-100"  id="carousel-size"></a>
	    </div>
	    
	    <br>
		<div class="text-center">
		<a class="navbar-brand at" href="${appRoot }/market/home">중고마켓</a>
		</div>
		<p class="text-center">버리기 애매한 물건들!  이제 고집 중고마켓으로 오세요 ~ </p>
		<div class="container">
			<div >
				<div class="row row-cols-md-4">
					<!-- 상품 -->
					<c:forEach items="${marketlist }" var="market">
						<c:url value="/market/detail" var="getUrl">
							<c:param name="mno" value="${market.mno }" />
						</c:url>
						<a class="nav-link" href="${getUrl}">
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
			</div>
		</div>

	
		<div class="text-center">
			<h4>고집으로 오는 길 ~</h4>
		<div class="google-map">
			<iframe
				src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3165.352718627358!2d127.02827121611186!3d37.49959833571472!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca15796fe3091%3A0xaa658b05561b79ab!2z7ISc7Jq47Yq567OE7IucIOqwleuCqOq1rCDsl63sgrzrj5kg7YWM7Zek656A66GcN-q4uCA3!5e0!3m2!1sko!2skr!4v1629262397606!5m2!1sko!2skr"
				width="100%" height="450" style="border: 0;"></iframe>

		</div>
		</div>



		<footer>
			<nb:footer></nb:footer>
		</footer>
	</div>





	<c:if test="${not empty qweasd}">
		<script type="text/javascript">
			alert("${qweasd}");
		</script>
	</c:if>
</body>
</html>