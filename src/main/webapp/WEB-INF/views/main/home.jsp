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
    	background: linear-gradient(to right, #B8E9FF, #18A8F1);
    	color: transparent;
    	-webkit-background-clip: text;
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
	      <a href="${appRoot }/main/tos"><img src="${appRoot }/resources/img/main-banner.png" class="d-block w-100"  id="carousel-size"></a>
	    </div>
	    
	    <hr />
	    
		<div class="text-center">
			<a class="navbar-brand at" href="${appRoot }/store/home">About Us</a>
		</div>
		<p class="text-center">트리플에 대해서 궁금하신가요 ?</p>
		
		<hr />
		
		<div class="board_bg text-center ">
		
			<h3 class="p-4">우리들의 여행 공간 </h3>
			
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
 
		
		<hr />

	
		<div class="text-center">
			<h4>트리플로 오는 길 ~</h4>
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